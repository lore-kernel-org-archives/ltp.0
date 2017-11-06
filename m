From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Nov 2017 16:00:58 +0100
Subject: [LTP] [PATCH] Fix buffer overflow in print_result() function
In-Reply-To: <20171103161322.15792-1-vkabatov@redhat.com>
References: <20171103161322.15792-1-vkabatov@redhat.com>
Message-ID: <20171106150058.GA1662@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tst_test.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c8baf2a43..09691031e 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -180,7 +180,7 @@ static void print_result(const char *file, const int lineno, int ttype,
>  {
>  	char buf[1024];
>  	char *str = buf;
> -	int ret, size = sizeof(buf);
> +	int ret, overflowed = 0, size = sizeof(buf);
>  	const char *str_errno = NULL;
>  	const char *res;
>  
> @@ -227,17 +227,31 @@ static void print_result(const char *file, const int lineno, int ttype,
>  	size -= ret;
>  
>  	ret = vsnprintf(str, size, fmt, va);
> +	if (ret >= size) {
> +		overflowed = 1;
> +		goto finish;
> +	}
>  	str += ret;
>  	size -= ret;
>  
>  	if (str_errno) {
>  		ret = snprintf(str, size, ": %s", str_errno);
> +		if (ret >= size) {
> +			overflowed = 1;
> +			goto finish;
> +		}
>  		str += ret;
>  		size -= ret;
>  	}

We can simplify this a bit I guess.

We may as well pass size-2 to the snprintf() functions here, then add
MIN(ret, size-2) to the str. Then we don't have to use the overflowed
variable since the str would point to the end of the composed string
and there would be always at least two bytes in the buffer so that the
last one can be just sprintf() or strcpy().

> -	snprintf(str, size, "\n");
> +finish:
> +	/* Keep space for newline and \0 if the buffer was filled */
> +	if (overflowed) {
> +		str += size - 2;
> +		size = 2;
> +	}
>  
> +	snprintf(str, size, "\n");
>  	fputs(buf, stderr);

What about printing TWARN message here in a case that the message was
shortened, something as tst_res_(file, lineno, TWARN, "Previous message was too long!"),
we would have to keep the overflow flag for that thought...

>  }
>  
> -- 
> 2.13.6
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

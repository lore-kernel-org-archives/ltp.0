From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Nov 2017 15:55:47 +0100
Subject: [LTP] [PATCH v2] Fix buffer overflow in print_result() function
In-Reply-To: <20171107161042.12825-1-vkabatov@redhat.com>
References: <20171107161042.12825-1-vkabatov@redhat.com>
Message-ID: <20171108145547.GA8343@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c8baf2a43..b43fb35f7 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -227,13 +227,18 @@ static void print_result(const char *file, const int lineno, int ttype,
>  	size -= ret;
>  
>  	ret = vsnprintf(str, size, fmt, va);
> -	str += ret;
> -	size -= ret;
> -
> -	if (str_errno) {
> +	str += MIN(ret, size - 2);
> +	size -= MIN(ret, size - 2);
> +	if (ret >= size - 2) {

We modify the size before this condition, so the warning was triggered
even for string that were half of the size of the buffer.

So I've changed the code to save the size-2 into a variable before we
modify it so that we can use it in the condition.

> +		tst_res_(file, lineno, TWARN,
> +				"Next message is too long and truncated:");
> +	} else if (str_errno) {
>  		ret = snprintf(str, size, ": %s", str_errno);
> -		str += ret;
> -		size -= ret;
> +		str += MIN(ret, size - 2);
> +		size -= MIN(ret, size - 2);
> +		if (ret >= size - 2)
> +			tst_res_(file, lineno, TWARN,
> +				"Next message is too long and truncated:");

And here as well.

I've also added a testcase and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

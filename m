From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 27 Oct 2020 18:10:13 +0800
Subject: [LTP] [PATCH 05/19] Unify error handling in lib/safe_macros.c
In-Reply-To: <20201026164756.30556-6-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-6-mdoucha@suse.cz>
Message-ID: <5F97F205.8020602@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin
> - Properly format caller file:line location
> - Pedantically check invalid syscall return values
>
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   lib/safe_macros.c | 602 +++++++++++++++++++++++++++++-----------------
>   1 file changed, 384 insertions(+), 218 deletions(-)
>
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 4f48d7529..f5e80fc48 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c

>
>
>   	return rval;
> @@ -255,10 +288,16 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
>   	ssize_t rval;
>
>   	rval = read(fildes, buf, nbyte);
> +
>   	if (rval == -1 || (len_strict&&  (size_t)rval != nbyte)) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn,
> -			 "%s:%d: read(%d,%p,%zu) failed, returned %zd",
> -			 file, lineno, fildes, buf, nbyte, rval);
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"read(%d,%p,%zu) failed, returned %zd", fildes, buf,
> +			nbyte, rval);
> +	}
> +	if (rval<  0) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"Invalid read(%d,%p,%zu) return value %zd", fildes,
> +			buf, nbyte, rval);
>   	}
Here has problem.. Maybe we can  use simple
if (rval < 0 || (len_strict&&  (size_t)rval != nbyte)) to replace.
>
>   	return rval;

>   	return rval;
> @@ -452,10 +530,14 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
>   	ssize_t rval;
>
>   	rval = write(fildes, buf, nbyte);
> +
>   	if (rval == -1 || (len_strict&&  (size_t)rval != nbyte)) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn,
> -			 "%s:%d: write(%d,%p,%zu) failed",
> -		         file, lineno, fildes, buf, rval);
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"write(%d,%p,%zu) failed", fildes, buf, nbyte);
> +	} else if (rval<  0) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"Invalid write(%d,%p,%zu) return value %zd", fildes,
> +			buf, nbyte, rval);
>   	}
I prefer to use "if (rval < 0 || (len_strict&&  (size_t)rval != nbyte)"
>

>   	}
>
> @@ -530,20 +612,19 @@ long safe_sysconf(const char *file, const int lineno,
>   		  void (cleanup_fn) (void), int name)
>   {
>   	long rval;
> -	errno = 0;
>
> +	errno = 0;
It looks no change.
>   	rval = sysconf(name);
>
>   	if (rval == -1) {
>   		if (errno) {
> -			tst_brkm(TBROK | TERRNO, cleanup_fn,
> -				 "%s:%d: sysconf(%d) failed",
> -				 file, lineno, name);
> +			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +				"sysconf(%d) failed", name);
>   		} else {
> -			tst_resm(TINFO, "%s:%d: sysconf(%d): "
> -				 "queried option is not available"
> -				 " or there is no definite limit",
> -				 file, lineno, name);
> +			tst_resm_(file, lineno, TINFO, "sysconf(%d): "
> +				"queried option is not available"
> +				" or there is no definite limit",
> +				name);
>   		}





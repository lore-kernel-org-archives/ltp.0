From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 15:40:05 +0100
Subject: [LTP] [PATCH 4/5] SAFE_MACROS: Add SAFE_PRCTL()
In-Reply-To: <1480507955-12652-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1480507955-12652-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161205144005.GG22344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int safe_prctl(const char *file, const int lineno, int opt, ...);
> +#define SAFE_PRCTL(opt, ...) \
> +	safe_prctl(__FILE__, __LINE__, (opt), ##__VA_ARGS__)
> +
>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 1c89b8c..c8c5383 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -807,3 +807,23 @@ int safe_system(const char *file, const int lineno, const char *cmd)
>  
>  	return rval;
>  }
> +
> +int safe_prctl(const char *file, const int lineno, int opt, ...)
> +{
> +	va_list ap;
> +	int rval;
> +	unsigned long arg;
> +
> +	va_start(ap, opt);
> +	arg = va_arg(ap, unsigned long);
> +	va_end(ap);

This is broken by design. The prctl() can have up to four long arguments
but here we use only the first one unconditionally.


I'm not sure how we can fix this easily. Either we can count number of
arguments passed to the SAFE_PRCTL() by hacky preprocessor counting[1]
and pass it as a first agument.

Or we can switch on the opt to figure out the number of expected arguments,
which is ugly as well, but we can at least start small by adding only
opts that we use.

[1]
https://groups.google.com/forum/?_escaped_fragment_=topic/comp.std.c/d-6Mj5Lko_s#!topic/comp.std.c/d-6Mj5Lko_s

> +	rval = prctl(opt, arg);
> +	if (rval < 0) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			 "%s:%d prctl(%i, %lu) failed",
> +			 file, lineno, opt, arg);
> +	}
> +
> +	return rval;
> +}
> -- 
> 1.8.4.2
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

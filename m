From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Sep 2016 14:56:25 +0200
Subject: [LTP] [PATCH] safe_macros: make safe_pread() and safe_pwrite()
	inline
In-Reply-To: <1474977533-31114-1-git-send-email-nyushchenko@dev.rtsoft.ru>
References: <1364999776.1787180.1473072872777.JavaMail.zimbra@redhat.com>
 <1474977533-31114-1-git-send-email-nyushchenko@dev.rtsoft.ru>
Message-ID: <20160927125625.GE12308@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 3cf154e..ff4ef49 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -97,6 +97,26 @@ static inline int safe_dup(const char *file, const int lineno,
>  #define SAFE_READ(len_strict, fildes, buf, nbyte) \
>  	safe_read(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
>  
> +/*
> + * inline function that uses off_t since sizeof(off_t) depends on compile flags
> + */
> +static inline ssize_t safe_pread(const char *file, const int lineno,
> +		void (*cleanup_fn)(void), char len_strict,
> +		int fildes, void *buf, size_t nbyte, off_t offset)
> +{
> +	ssize_t rval;
> +
> +	rval = pread(fildes, buf, nbyte, offset);
> +
> +	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: pread(%d,%p,%zu,%lld) failed, returned %zd",
> +			 file, lineno, fildes, buf, nbyte, (long long)offset,
> +			 rval);
> +	}
> +
> +	return rval;
> +}
>  #define SAFE_PREAD(len_strict, fildes, buf, nbyte, offset) \
>  	safe_pread(__FILE__, __LINE__, NULL, (len_strict), (fildes), \
>  	           (buf), (nbyte), (offset))
> @@ -170,6 +190,25 @@ static inline pid_t safe_getpgid(const char *file, const int lineno,
>  #define SAFE_WRITE(len_strict, fildes, buf, nbyte) \
>  	safe_write(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
>  
> +/*
> + * inline function that uses off_t since sizeof(off_t) depends on compile flags
> + */

We already have a comment in this file explaining why there are a few
inline functions so I would omit these.

> +static inline ssize_t safe_pwrite(const char *file, const int lineno,
> +		void (*cleanup_fn)(void), char len_strict,
> +		int fildes, const void *buf, size_t nbyte, off_t offset)
> +{
> +	ssize_t rval;
> +
> +	rval = pwrite(fildes, buf, nbyte, offset);
> +	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: pwrite(%d,%p,%zu,%lld) failed, returned %zd",
> +			 file, lineno, fildes, buf, nbyte, (long long)offset,
> +			 rval);
> +	}
> +
> +	return rval;
> +}
>  #define SAFE_PWRITE(len_strict, fildes, buf, nbyte, offset) \
>  	safe_pwrite(__FILE__, __LINE__, NULL, (len_strict), (fildes), \
>  	            (buf), (nbyte), (offset))

These newlib inline function should omit the cleanup_fn parameter and
use tst_brk_() instead.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

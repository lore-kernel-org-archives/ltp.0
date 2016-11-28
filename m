From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Nov 2016 16:45:25 +0100
Subject: [LTP] [PATCH] safe_macros: make safe_pread() and safe_pwrite()
	inline
In-Reply-To: <1480149001-4844-1-git-send-email-nyushchenko@dev.rtsoft.ru>
References: <20160927125625.GE12308@rei.suse.cz>
 <1480149001-4844-1-git-send-email-nyushchenko@dev.rtsoft.ru>
Message-ID: <20161128154525.GA24540@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
> index 8ed2eb4..e3be1f2 100644
> --- a/include/old/safe_macros.h
> +++ b/include/old/safe_macros.h
> @@ -70,6 +70,26 @@
>  	safe_read(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
>  	    (buf), (nbyte))
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
>  #define SAFE_PREAD(cleanup_fn, len_strict, fildes, buf, nbyte, offset)   \
>  	safe_pread(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
>  	    (buf), (nbyte), (offset))
> @@ -112,6 +132,25 @@
>  	safe_write(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
>  	    (buf), (nbyte))
>  

I've removed this part (SAFE_PREAD in old library headers), since the
old library is deprecated and there are more users for this function.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

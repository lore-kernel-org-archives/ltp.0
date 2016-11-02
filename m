From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 16:37:44 +0100
Subject: [LTP] [PATCH v3 1/5] safe_macros: add safe_setxattr(),
In-Reply-To: <1478084391-30192-2-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1478084391-30192-2-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161102153744.GD28344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define SAFE_SETXATTR(path, name, value, size, flags) \
> +	safe_setxattr(__FILE__, __LINE__, NULL, (path), (name), (value), (size), \
> +				(flags))
> +
> +#define SAFE_LSETXATTR(path, name, value, size, flags) \
> +	safe_lsetxattr(__FILE__, __LINE__, NULL, (path), (name), (value), (size), \
> +				(flags))
> +
> +#define SAFE_FSETXATTR(fd, name, value, size, flags) \
> +	safe_fsetxattr(__FILE__, __LINE__, NULL, (fd), (name), (value), (size), \
> +				(flags))

You are missing the function prototype for the safe_*setxattr()
functions. And since these functions will not be exported to the old
library you should add them here instead of the safe_macros_fn.h header.
And, for the same reason, you don't have to pass NULL as a cleanup
callback to these functions. You can just pass NULL to the tst_brkm() in
the safe_macros.c.

>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 5a05c84..e1d01b9 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -794,3 +794,69 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
>  	errno = err;
>  	return rval;
>  }
> +
> +int safe_setxattr(const char *file, const int lineno, void (cleanup_fn)(void),
> +				const char *path, const char *name, const void *value,
> +				size_t size, int flags)
> +{
> +	int rval;
> +
> +	rval = setxattr(path, name, value, size, flags);
> +
> +	if (rval) {
> +		if (errno == ENOTSUP) {
> +			tst_brkm(TCONF, cleanup_fn,
> +				 "%s:%d: no xattr support in fs or mounted "
> +				 "without user_xattr option", file, lineno);
> +		}
> +
> +		tst_brkm(TBROK | TERRNO, cleanup_fn, "%s:%d: setxattr() failed",
> +			     file, lineno);
> +	}
> +
> +	return rval;
> +}
> +
> +int safe_lsetxattr(const char *file, const int lineno, void (cleanup_fn)(void),
> +				const char *path, const char *name, const void *value,
> +				size_t size, int flags)
> +{
> +	int rval;
> +
> +	rval = lsetxattr(path, name, value, size, flags);
> +
> +	if (rval) {
> +		if (errno == ENOTSUP) {
> +			tst_brkm(TCONF, cleanup_fn,
> +				 "%s:%d: no xattr support in fs or mounted "
> +				 "without user_xattr option", file, lineno);
> +		}
> +
> +		tst_brkm(TBROK | TERRNO, cleanup_fn, "%s:%d: lsetxattr() failed",
> +			     file, lineno);
> +	}
> +
> +	return rval;
> +}
> +
> +int safe_fsetxattr(const char *file, const int lineno, void (cleanup_fn)(void),
> +				int fd, const char *name, const void *value, size_t size,
> +				int flags)
> +{
> +	int rval;
> +
> +	rval = fsetxattr(fd, name, value, size, flags);
> +
> +	if (rval) {
> +		if (errno == ENOTSUP) {
> +			tst_brkm(TCONF, cleanup_fn,
> +				 "%s:%d: no xattr support in fs or mounted "
> +				 "without user_xattr option", file, lineno);
> +		}
> +
> +		tst_brkm(TBROK | TERRNO, cleanup_fn, "%s:%d: fsetxattr() failed",
> +			     file, lineno);
> +	}
> +
> +	return rval;
> +}

Otherwise these safe macros looks like a good idea to me.

-- 
Cyril Hrubis
chrubis@suse.cz

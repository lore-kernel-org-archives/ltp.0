From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Oct 2018 16:20:47 +0200
Subject: [LTP] [PATCH v2 2/5] tst_safe_macros: add SAFE_GETGRGID()
In-Reply-To: <20180910141901.20541-2-cfamullaconrad@suse.de>
References: <20180910141901.20541-1-cfamullaconrad@suse.de>
 <20180910141901.20541-2-cfamullaconrad@suse.de>
Message-ID: <20181002142047.GK24796@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid);
> +#define SAFE_GETGRGID(gid) \
> +	safe_getgrgid(__FILE__, __LINE__, (gid))
> +
>  int safe_setxattr(const char *file, const int lineno, const char *path,
>              const char *name, const void *value, size_t size, int flags);
>  #define SAFE_SETXATTR(path, name, value, size, flags) \
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index 17384f32c..2e041c460 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -153,6 +153,19 @@ struct group *safe_getgrnam(const char *file, const int lineno,
>  	return rval;
>  }
>  
> +struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid)
> +{
> +	struct group *rval;

Looking at manual pages we should zero the errno here, since we print it
in the tst_brk_() in a case of NULL.

> +	rval = getgrgid(gid);
> +	if (rval == NULL) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"getgrgid(%li) failed", (long)gid);
> +	}

I also wonder if it's okay to break the test in case that the entry
wasn't found (the return value would be NULL and errno would be
untouched) but I guess that it's OK for most of the cases.

> +	return rval;
> +}
> +
>  int safe_chroot(const char *file, const int lineno, const char *path)
>  {
>  	int rval;
> -- 
> 2.16.4
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

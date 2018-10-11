From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Oct 2018 15:34:23 +0200
Subject: [LTP] [PATCH v3 4/5] tst_safe_macros: add
	SAFE_GETGRNAM_FALLBACK()
In-Reply-To: <20181008071651.16384-3-cfamullaconrad@suse.de>
References: <20181008071651.16384-1-cfamullaconrad@suse.de>
 <20181008071651.16384-3-cfamullaconrad@suse.de>
Message-ID: <20181011133423.GC30924@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +struct group *safe_getgrnam_fallback(const char *file, const int lineno,
> +				     const char *name, const char *fallback)
> +{
> +	struct group *rval;
> +

I've added a missing errno = 0; here and pushed.

Thanks.

> +	rval = getgrnam(name);
> +	if (rval == NULL) {
> +		tst_res_(file, lineno, TINFO,
> +			 "getgrnam(%s) failed - try fallback %s",
> +			 name, fallback);
> +		rval = safe_getgrnam(file, lineno, fallback);
> +	}
> +
> +	return rval;
> +}
> +
>  struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid)
>  {
>  	struct group *rval;
> -- 
> 2.16.4
> 

-- 
Cyril Hrubis
chrubis@suse.cz

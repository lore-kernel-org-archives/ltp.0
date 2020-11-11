From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2020 13:58:31 +0100
Subject: [LTP] [PATCH 05/19] Unify error handling in lib/safe_macros.c
In-Reply-To: <20201026164756.30556-6-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-6-mdoucha@suse.cz>
Message-ID: <20201111125831.GC5870@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -255,10 +288,16 @@ ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
>  	ssize_t rval;
>  
>  	rval = read(fildes, buf, nbyte);
> +
>  	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn,
> -			 "%s:%d: read(%d,%p,%zu) failed, returned %zd",
> -			 file, lineno, fildes, buf, nbyte, rval);
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"read(%d,%p,%zu) failed, returned %zd", fildes, buf,
> +			nbyte, rval);
> +	}
> +	if (rval < 0) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"Invalid read(%d,%p,%zu) return value %zd", fildes,
> +			buf, nbyte, rval);
>  	}

Shouldn't this be else if as well? Since otherwise we may generate two
warning messages if in cleanup() read() returns -1.

-- 
Cyril Hrubis
chrubis@suse.cz

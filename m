From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Jun 2017 18:18:22 +0200
Subject: [LTP] [PATCH 3/3] syscalls/lseek10: cleanup && convert to new
	API
In-Reply-To: <1498025539-24441-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1498025539-24441-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1498025539-24441-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170628161822.GB27262@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define SAFE_MKNOD(pathname, mode, dev) \
> +	safe_mknod(__FILE__, __LINE__, (pathname), (mode), (dev))
> +
>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 3ef9266..7ca1849 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -908,3 +908,17 @@ pid_t safe_setsid(const char *file, const int lineno)
>  
>  	return rval;
>  }
> +
> +int safe_mknod(const char *file, const int lineno, const char *pathname,
> +	mode_t mode, dev_t dev)
> +{
> +	int rval;
> +
> +	rval = mknod(pathname, mode, dev);
> +	if (rval == -1) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			 "%s:%d: mknod() failed", file, lineno);

I've changed this line to include the parameters passed to the
safe_mknod() to be included in the error message as well and pushed the
whole patchset, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

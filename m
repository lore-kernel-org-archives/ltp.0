From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Dec 2020 16:55:19 +0100
Subject: [LTP] [PATCH v5 07/10] fanotify: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <20201201174214.24625-8-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
 <20201201174214.24625-8-pvorel@suse.cz>
Message-ID: <20201202155519.GG12342@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static inline int safe_fanotify_mark(const char *file, const int lineno,
> +			int fd, unsigned int flags, uint64_t mask,
> +			int dfd, const char *pathname)
> +{
> +	int rval;
> +
> +	rval = fanotify_mark(fd, flags, mask, dfd, pathname);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO, "fanotify_mark() failed");

I would be a bit more verbose here, i.e. print the mask, pathname and
file descriptors as well.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

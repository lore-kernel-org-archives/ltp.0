From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 11:30:45 +0100
Subject: [LTP] [PATCH v3 4/5] fanotify: Check FAN_REPORT_{FID,
 NAME} support
In-Reply-To: <20201113164944.26101-5-pvorel@suse.cz>
References: <20201113164944.26101-1-pvorel@suse.cz>
 <20201113164944.26101-5-pvorel@suse.cz>
Message-ID: <20201119103045.GE2785@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int safe_fanotify_init(const char *file, const int lineno,
> +	unsigned int flags, unsigned int event_f_flags)
> +{
> +	int rval;
> +
> +#ifdef HAVE_SYS_FANOTIFY_H
> +	rval = fanotify_init(flags, event_f_flags);
> +
> +	if (rval == -1) {
> +		if (errno == ENOSYS) {
> +			tst_brk(TCONF, "%s:%d: fanotify is not configured in this kernel",
> +				file, lineno);
> +		}
> +
> +		if (errno == EINVAL) {
> +			if (flags & FAN_REPORT_FID) {
> +				tst_brk(TCONF, "%s:%d: FAN_REPORT_FID not supported by kernel?",
> +					file, lineno);
> +			}
> +
> +			if (flags & FAN_REPORT_NAME) {
> +				tst_brk(TCONF, "%s:%d: FAN_REPORT_NAME not supported by kernel?",
> +					file, lineno);
> +			}

If we happen to have both in flags it will report only the first one
here. So maybe we should use tst_res(TINFO, "") followed by
tst_brk(TCONF, "Unsupported configuration, see above"); or something
like that.

> +		}
> +
> +		tst_brk(TBROK | TERRNO, "%s:%d: fanotify_init() failed",
> +			file, lineno);
> +	}
> +#else
> +	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
> +#endif /* HAVE_SYS_FANOTIFY_H */
> +
> +	return rval;
> +}
> +
> +#define SAFE_FANOTIFY_INIT(fan, mode)  \
> +	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
> +
>  static inline int safe_fanotify_mark(const char *file, const int lineno,
>  			int fd, unsigned int flags, uint64_t mask,
>  			int dfd, const char *pathname)
> -- 
> 2.29.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

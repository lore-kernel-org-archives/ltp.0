From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Dec 2020 16:46:04 +0100
Subject: [LTP] [PATCH v5 04/10] fanotify: Add helper for FAN_REPORT_FID
 support on fs
In-Reply-To: <20201201174214.24625-5-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
 <20201201174214.24625-5-pvorel@suse.cz>
Message-ID: <20201202154604.GD12342@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * @return  0: fanotify supported both in kernel and on tested filesystem
> + * @return -1: FAN_REPORT_FID not supported in kernel
> + * @return -2: FAN_REPORT_FID not supported on tested filesystem
> + */
> +static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
> +{
> +	int fd;
> +	int rval = 0;
> +
> +	fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> +
> +	if (fd < 0) {
> +		if (errno == ENOSYS)
> +			tst_brk(TCONF, "fanotify not configured in kernel");
> +
> +		if (errno == EINVAL)
> +			return -1;
> +
> +		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
> +	}
> +
> +	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
> +		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
> +			rval = -2;
> +		} else {
> +			tst_brk(TBROK | TERRNO,
> +				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, \".\") failed", fd);
                                                                                   ^
										   fname?
> +		}
> +	}
> +
> +	SAFE_CLOSE(fd);
> +
> +	return rval;
> +}
> +
> +typedef void (*tst_res_func_t)(const char *file, const int lineno,
> +		int ttype, const char *fmt, ...);
> +
> +static inline void fanotify_fan_report_fid_err_msg(const char *file,
> +	const int lineno, tst_res_func_t res_func, int fail)
> +{
> +	if (fail == -1)
> +		res_func(file, lineno, TCONF,
> +			 "FAN_REPORT_FID not supported in kernel?");
> +
> +	if (fail == -2)
> +		res_func(file, lineno, TCONF,
> +			 "FAN_REPORT_FID not supported on %s filesystem",
> +			 tst_device->fs_type);
> +}

Maybe this would be just easier to read as a macro:

#define FANOTIFY_FAN_REPORT_FID_ERR_MSG(res_func, fail) do { \
	if (fail == -1) \
		res_func(TCONF, "FAN_REPORT_FID not supported in kernel?"); \
	if (fail == -2) \
		res_func(TCONF, ...); \
	} while (0)

> +#define FANOTIFY_FAN_REPORT_FID_ERR_MSG(fail) \
> +	fanotify_fan_report_fid_err_msg(__FILE__, __LINE__, tst_res_, (fail))
> +
> +static inline void require_fanotify_fan_report_fid_supported_on_fs(const char *file,
> +	const int lineno, const char *fname)
> +{
> +	int rval;
> +
> +	rval = fanotify_fan_report_fid_supported_on_fs(fname);
> +	if (rval)
> +		fanotify_fan_report_fid_err_msg(file, lineno, tst_brk_, rval);

We don't have to do the if here, just pass the rval, it will not trigger
tst_brk() if we pass zero.


The rest is good.

-- 
Cyril Hrubis
chrubis@suse.cz

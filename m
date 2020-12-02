From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Dec 2020 19:04:11 +0100
Subject: [LTP] [PATCH v5 04/10] fanotify: Add helper for FAN_REPORT_FID
 support on fs
In-Reply-To: <20201202154604.GD12342@yuki.lan>
References: <20201201174214.24625-1-pvorel@suse.cz>
 <20201201174214.24625-5-pvorel@suse.cz>
 <20201202154604.GD12342@yuki.lan>
Message-ID: <X8fXG3ix4oq2Gab6@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir, Cyril,

> > +	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
> > +		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
> > +			rval = -2;
> > +		} else {
> > +			tst_brk(TBROK | TERRNO,
> > +				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, \".\") failed", fd);
>                                                                                    ^
> 										   fname?
...

> Maybe this would be just easier to read as a macro:

> #define FANOTIFY_FAN_REPORT_FID_ERR_MSG(res_func, fail) do { \
> 	if (fail == -1) \
> 		res_func(TCONF, "FAN_REPORT_FID not supported in kernel?"); \
> 	if (fail == -2) \
> 		res_func(TCONF, ...); \
> 	} while (0)

...
> > +static inline void require_fanotify_fan_report_fid_supported_on_fs(const char *file,
> > +	const int lineno, const char *fname)
> > +{
> > +	int rval;
> > +
> > +	rval = fanotify_fan_report_fid_supported_on_fs(fname);
> > +	if (rval)
> > +		fanotify_fan_report_fid_err_msg(file, lineno, tst_brk_, rval);

> We don't have to do the if here, just pass the rval, it will not trigger
> tst_brk() if we pass zero.


> The rest is good.

Both your comments fixed, patchset merged.

Thank you both for your patient review,

Amir, I'm sorry it took me that long.
Looking forward to your patchset :).

Kind regards,
Petr

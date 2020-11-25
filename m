From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Nov 2020 19:24:03 +0100
Subject: [LTP] [PATCH v3 3/5] fanotify: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <20201125141624.GA32471@pevik>
References: <20201113164944.26101-1-pvorel@suse.cz>
 <20201113164944.26101-4-pvorel@suse.cz>
 <20201119102740.GD2785@yuki.lan>
 <CAOQ4uxigsk5e7GHgDHydd03D1bAih1SJv36dB4209mpE_dU6PQ@mail.gmail.com>
 <20201125141624.GA32471@pevik>
Message-ID: <20201125182403.GB7323@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > > > +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> > > > @@ -101,19 +101,8 @@ static void test_fanotify(unsigned int n)
> > > >                       "failed", tc->init_flags);
> > > >       }

> > > > -     if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> > > > -                       FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> > > > -                       AT_FDCWD, fname) < 0) {
> > > > -             if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
> > > > -                     tst_res(TCONF,
> > > > -                             "FAN_MARK_FILESYSTEM not supported in kernel?");
> > > > -                     return;
> > > > -             }

> > > Here we had tst_res(TCONF, ...) followed by a return but we will can
> > > tst_brk() after the change. I guess that we may skip part of the test on
> > > older kernels with that change.


> > That's not good. I missed that in my review.
> > There are many tests where only the FAN_MARK_FILESYSTEM
> > test cases are expected to result in TCONF, but the rest of the test
> > cases should run.

> I'm not sure if I understand you. Is my approach correct here?
OK, I got that, I cannot use SAFE_FANOTIFY_MARK() in test_fanotify() in fanotify01.c
and in setup_marks() in fanotify13.c.

But FAN_REPORT_FID in is on both files already checked after fanotify_init()
call. Not sure if it must be check also for fanotify_mark(), because it's
only in FANOTIFY_INIT_FLAGS (via FANOTIFY_FID_BITS). FANOTIFY_MARK_FLAGS has
other flags.

If yes, I'll probably need to create fanotify_supported_by_kernel(...), which
check for all not supported flags and will be used in those 2 places and in
safe_fanotify_init(). Something like this:

typedef void (*tst_res_func_t)(const char *file, const int lineno,
		int ttype, const char *fmt, ...);

int fanotify_flags_supported_by_kernel(const char *file, const int lineno,
	unsigned int flags, int strict)
{
	tst_res_func_t res_func = tst_res_;
	int unsupported = 0;

	if (strict)
		res_func = tst_brk_;

	if (errno == EINVAL) {
		if (flags & FAN_REPORT_TID) {
			tst_res_(file, lineno, TINFO,
					 "FAN_REPORT_TID not supported by kernel?");
			unsupported = 1;
		}

		if (flags & FAN_REPORT_FID) {
			tst_res_(file, lineno, TINFO,
					 "FAN_REPORT_FID not supported by kernel?");
			unsupported = 1;
		}

		if (flags & FAN_REPORT_DIR_FID) {
			tst_res_(file, lineno, TINFO,
					 "FAN_REPORT_DIR_FID not supported by kernel?");
			unsupported = 1;
		}

		if (flags & FAN_REPORT_NAME) {
			tst_res_(file, lineno, TINFO,
					 "FAN_REPORT_NAME not supported by kernel?");
			unsupported = 1;
		}

		if (unsupported)
			res_func(file, lineno, TCONF, "Unsupported configuration, see above");
		else
			tst_brk_(file, lineno, TBROK, "Unknown failure");

		return -1;
	}

	return 0;
}

These are flags for fanotify_init(). Flags for fanotify_mark() are currently
handled by fanotify_exec_events_supported_by_kernel() (used for FAN_OPEN_EXEC
and FAN_OPEN_EXEC_PERM), using different approach. Testing fanotify_mark() flags
support in advance in setup makes tests faster, I'm just not happy we use
different approach. Any tip for improving this or improving readability is
welcome.

Kind regards,
Petr

> > In most of these tests the FAN_MARK_FILESYSTEM test cases are
> > last because they were added later. This is not the case with fanotify01
> > and fanotify15 and we do not want to reply on the ordering anyway.

> > Thanks,
> > Amir.

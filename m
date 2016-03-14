From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 13:51:53 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
 <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
Message-ID: <20160314125153.GB600@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >   - We may add them later, but I would like to get this merged ideally
> >     before we do another release and doing this would take some time
> 
> I think we have this problem already. tst_brk() will call tst_vbrk_(),
> which calls cleanup_ipc(), which is using SAFE_* macros. It looks like
> we'll get infinite loop if any of those fail.

Hrm, and we also call tst_release_device() with calls SAFE_OPEN() in
do_cleanup().

So either we:

1. fix all cleanup codepaths not to call tst_brk/tst_brkm
or
2. make tst_brk usable in cleanups.

For short term I would go for the 1. then try for 2. in longterm.

> > * All relevant parts of test-writing-guidelines should be now rewritten
> > 
> >   - There are couple of functions that still take cleanup as fist
> >     parameter and that are not exported to the new library but that
> >     should be all that is missing
> 
> "Child processes started via exec*, or any other processes must initialize the
> checkpoint by calling 'TST_CHECKPOINT_INIT()' before usage."
> This doesn't sound correct for newlib. We now have "tst_checkpoint_open()".

Ah, right. I was thinking of calling it tst_reinit() or similar so that
we can initialize the struct results in it if needed as well.

> ---
> 
> 'To make sure cleanup() was called only once LTP has a helper
> "TST_DECLARE_ONCE_FN"'
> TST_DECLARE_ONCE_FN is declared in test.h, it doesn't look like newlib
> can use it at the moment.

Right. Should be moved to a common header.

> ---
> 
> I'm not sure it is enough to make cleanup() call only once. It looks like
> we still can get into situation where we call "do_cleanup();cleanup_ipc();"
> more than once (if we hit tst_brk in multiple threads with newlib)

Right this macro is purely for guarding the user supplied callback.

Unfortunately the pthread_once() does not compile to a stub without
-pthread, otherwise we could just use it on the do_cleanup() in library
and get rid of that part in the testcase.

I guess that we can emulate it with mutexes as well and guard the
library cleanup hence the user supplied cleanup would end up thread safe
as well without any additional work.

> ---
> 
> Can we remove "SAFE_CLOSE(ipc_fd);" from cleanup_ipc()? This fd
> is already closed in setup_ipc().

Not if the SAFE_FTRUNCATE() or SAFE_MMAP() in setup_ipc() fails.

> ---
> 
> Should "struct tst_test *tst_test" be initialized to NULL?
> Some tst_res.c oldlib functions are using it, but it is initialized only
> if you use newlib, at tst_run_tcases().

It's a global variable so if you don't call tst_run_tcases() it is.

> > 
> > 
> > Anything else that should be done before we can merge it?
> 
> I only made a compile test on some old/recent RHEL distros
> and ran some newlib testcases by hand. This worked OK.
> 
> Have you tried running all of the (oldlib) tests on
> various arches/releases to see if we haven't regressed?

Not yet, will do a couple runs once we consider it finished enough.

> I could run it against various RHEL majors, it
> would take couple days.

I will do that as preparations for next LTP release since I do numerous
runs for several SLES and openSUSE versions at that point anyway.

-- 
Cyril Hrubis
chrubis@suse.cz

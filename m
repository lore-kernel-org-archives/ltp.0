From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Feb 2019 13:18:35 +0100
Subject: [LTP] [PATCH] syscalls/ustat: Move the syscall to lapi
In-Reply-To: <93f34d76-f1ba-c6a9-fa02-a4ffc0ec8426@google.com>
References: <20190221112201.18324-1-chrubis@suse.cz>
 <87r2c12udf.fsf@rpws.prws.suse.cz> <20190221143021.GC17813@rei.lan>
 <87pnrk2rw6.fsf@rpws.prws.suse.cz> <20190222150006.GA23713@rei>
 <93f34d76-f1ba-c6a9-fa02-a4ffc0ec8426@google.com>
Message-ID: <20190225121835.GB25739@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>> Good point. So it all depends on what we want to focus on, if we are
> >>> after kernel, we should call the syscall directly, if we look at system
> >>> functionality we should go after the libc one by default.
> >>>
> >>> I guess that ideally we should test both, not sure how to achiveve that
> >>> reasonably easily...
> 
> This seems to me a great feature to have as well - it would address the 
> concern that was just recently raised about having to choose between 
> focusing on testing at the libc level or the kernel syscall level.
> >> Possibly we could create a config option which forcibly sets (almost)
> >> all the HAVE_* macros to zero. This will probably result in a lot of
> >> tests being skipped as well, but it might be good enough.
> > 
> > I don't think that this will actully get past linking, I suppose we
> > would end up with two confilicting syscall wrappers in most of the
> > cases.
> 
> Perhaps something like how the compat_16 syscalls are handled? Test libc 
> wrappers by default if the host has them, and for syscalls that can 
> easily be called directly, add an extra bit in the test's Makefile that 
> causes a "<testname>_direct" version of the test to be built using a 
> direct syscall?

Either that or we can add a parameter to switch between them on runtime.
I will look into this later on.

Maybe we can even add a .raw_syscal bit into the tst_test structure and
add an infrastructure to choose what to call on runtime, e.g.
tst_ustat() will call either libc or syscall based on some global flag
and the test library would execute the run function twice, for each
possiblity. The tst_ustat() function could be in fact generated based
just on the function signature, so we can add a script to generate these
as well.

I've created an issue, so that we can track the discussion and progress
on GitHub as well:

https://github.com/linux-test-project/ltp/issues/506

-- 
Cyril Hrubis
chrubis@suse.cz

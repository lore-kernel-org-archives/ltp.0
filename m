From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jul 2021 16:06:52 +0200
Subject: [LTP] [PATCH 00/16] syscalls/sched_*: convert to new API and
 handle ENOSYS errno
In-Reply-To: <f9767568-466f-73d2-7d73-aa880fde6a63@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
 <YPbNQ4AebDiUMxVz@yuki>
 <f9767568-466f-73d2-7d73-aa880fde6a63@bell-sw.com>
Message-ID: <YPbYfPWly+3kW7y5@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> The patch-set introduced new tst_sched_* wrappers to handle ENOSYS
> >> error that can be returned by libc (musl [1]). In that particular
> >> case the wrapper uses syscall directly to test the kernel anyway.
> > 
> > Can't we use the test_variants to test both the kernel and libc calls
> > instead?
> 
> With glibc it seems it would be just a redundant work to call both
> variants, wouldn't it?

I do not think so, since the libc wrappers may be more complex than just
a syscall(__NR_foo, ...). At least recently the libc variants are
switching between foo and foo_time64 syscall variants and convert the
timespecs accordingly.

> BTW, sched_rr_get_interval* tests already using tst_variants, adding
> more variants will double them too, right?

That's true and this makes things slightly more complicated. But as
these test just calls a few syscalls and check return values I doubt
that doubling the test matrix would be measureable in the test runtime.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Jan 2021 15:27:58 +0100
Subject: [LTP] Holidays and LTP release
In-Reply-To: <YAGgEcFEN8/ElosC@yuki.lan>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <20210113095724.214c904a@kmaincent-XPS-13-7390>
 <CA+G9fYv1UFr+7ePC7tLjCY4JPsoQdBdf-6Jpr40zmsoYRWVrdQ@mail.gmail.com>
 <YABW1ZcnfFbjUoBq@yuki.lan>
 <CA+G9fYs2bv98uFgrH+WEYzDagFPy0PWruk=Em9GdMXmnQQUTCw@mail.gmail.com>
 <YAGgEcFEN8/ElosC@yuki.lan>
Message-ID: <YAGmbrmtAtyI8zQ4@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > > getrlimit03.c:168: TPASS: __NR_prlimit64(0) and __NR_ugetrlimit(0)
> > > > gave consistent results
> > > > tst_test.c:1313: TBROK: Test killed by SIGILL!
> > >
> > > Can we have a backtrace here? It's impossible to say what happened here
> > > without further debugging.
> > 
> > I do not have backtrace log for this now.
> > Let me share strace output log in this link,
> > # strace -f ./getrlimit03
> > https://lkft.validation.linaro.org/scheduler/job/2145166#L2569
> 
> Thanks.
> 
> I've managed to reproduce as well but I have no idea what happens there,
> it looks like something gets corrupted and the processor attempts to
> execute invalid code.
> 
> Maybe we pass wrong size of the rlim structure somewhere and kernel
> writes over a stack.

This is really strange it looks like glibc has wrong syscall number for
getrlimit.

On 32bit ARM I do have in /usr/include/asm-generic/unistd.h

#define __NR_getrlimit 163

While the getrlimit should be 191. It looks like x86-64 syscall
definitions are installed on the system for some strange reason, even
the header says that it's for x86-64.

-- 
Cyril Hrubis
chrubis@suse.cz

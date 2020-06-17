From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jun 2020 15:17:42 +0200
Subject: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <20200616132705.GW2531@hirez.programming.kicks-ass.net>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net>
Message-ID: <20200617131742.GD8389@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > >> FYI, we noticed the following commit (built with gcc-9):
> > >> 
> > >> commit: 2bbc68f8373c0631ebf137f376fbea00e8086be7 ("x86/entry: Convert Debug exception to IDTENTRY_DB")
> > >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > Is the head of linux.git exposing the same problem or is this an
> > > intermittent failure, which only affects bisectability?
> > 
> > It sure looks deterministic:
> > 
> > ptrace08.c:62: BROK: Cannot find address of kernel symbol "do_debug"
> 
> ROFL

It's nice to have a good laugh, however I would really appreciate if any
of you would help me to fix the test.

The test in question is a regression test for:

commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Mar 26 15:39:07 2018 -1000

    perf/hwbp: Simplify the perf-hwbp code, fix documentation

    Annoyingly, modify_user_hw_breakpoint() unnecessarily complicates the
    modification of a breakpoint - simplify it and remove the pointless
    local variables.

And as far as I can tell it uses ptrace() with PTRACE_POKEUSER in order to
trigger it. But I'm kind of lost on how exactly we trigger the kernel
crash.

What is does is to write:

	(void*)1 to u_debugreg[0]
	(void*)1 to u_debugreg[7]
	do_debug addr to u_debugreg[0]

Looking at the kernel code the write to register 7 enables the breakpoints and
what we attempt here is to change an invalid address to a valid one after we
enabled the breakpoint but that's as far I can go.

So does anyone has an idea how to trigger the bug without the do_debug function
address? Would any valid kernel function address suffice?

-- 
Cyril Hrubis
chrubis@suse.cz

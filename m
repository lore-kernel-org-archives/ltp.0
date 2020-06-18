From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 18 Jun 2020 22:02:30 +0200
Subject: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <20200617131742.GD8389@yuki.lan>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net>
 <20200617131742.GD8389@yuki.lan>
Message-ID: <87r1ucb0rt.fsf@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:
> What is does is to write:
>
> 	(void*)1 to u_debugreg[0]
> 	(void*)1 to u_debugreg[7]
> 	do_debug addr to u_debugreg[0]
>
> Looking at the kernel code the write to register 7 enables the breakpoints and
> what we attempt here is to change an invalid address to a valid one after we
> enabled the breakpoint but that's as far I can go.
>
> So does anyone has an idea how to trigger the bug without the do_debug function
> address? Would any valid kernel function address suffice?

According to https://www.openwall.com/lists/oss-security/2018/05/01/3
the trigger is to set the breakpoint to do_debug() and then execute
INT1, aka. ICEBP which ends up in do_debug() ....

In principle each kernel address is ok, but do_debug() is interesting
due to the recursion issue because user space can reach it by executing
INT1.

So you might check for exc_debug() if do_debug() is not available and
make the whole thing fail gracefully with a usefu error message.

Thanks,

        tglx

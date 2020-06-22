From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 22 Jun 2020 15:46:32 +0530
Subject: [LTP] [LKP] Re:  [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <87r1ucb0rt.fsf@nanos.tec.linutronix.de>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net>
 <20200617131742.GD8389@yuki.lan>
 <87r1ucb0rt.fsf@nanos.tec.linutronix.de>
Message-ID: <CA+G9fYu18y4iWOkTCDWi9dUj+FosStVTH-6swN7wE4GePZa=Ng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 19 Jun 2020 at 01:32, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Cyril Hrubis <chrubis@suse.cz> writes:
> > What is does is to write:
> >
> >       (void*)1 to u_debugreg[0]
> >       (void*)1 to u_debugreg[7]
> >       do_debug addr to u_debugreg[0]
> >
> > Looking at the kernel code the write to register 7 enables the breakpoints and
> > what we attempt here is to change an invalid address to a valid one after we
> > enabled the breakpoint but that's as far I can go.
> >
> > So does anyone has an idea how to trigger the bug without the do_debug function
> > address? Would any valid kernel function address suffice?
>
> According to https://www.openwall.com/lists/oss-security/2018/05/01/3
> the trigger is to set the breakpoint to do_debug() and then execute
> INT1, aka. ICEBP which ends up in do_debug() ....
>
> In principle each kernel address is ok, but do_debug() is interesting
> due to the recursion issue because user space can reach it by executing
> INT1.
>
> So you might check for exc_debug() if do_debug() is not available and
> make the whole thing fail gracefully with a usefu error message.

My two cents,
LTP test case ptrace08 fails on x86_64 and i386.

ptrace08.c:62: BROK: Cannot find address of kernel symbol \"do_debug\"

This error is coming from test case setup
KERNEL_SYM = do_debug

if (strcmp(symname, KERNEL_SYM))
tst_brk(TBROK, "Cannot find address of kernel symbol \"%s\"",
KERNEL_SYM);

Test case got pass when DEBUG_INFO config enabled

CONFIG_DEBUG_INFO=y

ptrace08.c:68: INFO: Kernel symbol \"do_debug\" found at 0xd8898410

Full test log,
https://lkft.validation.linaro.org/scheduler/job/1483117#L1325

ref:
https://bugs.linaro.org/show_bug.cgi?id=5651#c1

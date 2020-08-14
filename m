From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 14 Aug 2020 09:42:11 -0700
Subject: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
In-Reply-To: <20200814145823.GA13646@yuki.lan>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net>
 <20200617131742.GD8389@yuki.lan>
 <CALCETrVX=wxRrv0qw-Enbyg5CEQsy5TigbNt7sSs=MDO6uAnMw@mail.gmail.com>
 <20200812093114.GA13676@yuki.lan> <20200814145823.GA13646@yuki.lan>
Message-ID: <CALCETrUZO7ifrQPKks=LuUoTcPcM7nE_TjaCXWpwMm8TOZLzDg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 14, 2020 at 7:58 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > do_debug is a bit of a red herring here.  ptrace should not be able to
> > > put a breakpoint on a kernel address, period.  I would just pick a
> > > fixed address that's in the kernel text range or even just in the
> > > pre-KASLR text range and make sure it gets rejected.  Maybe try a few
> > > different addresses for good measure.
> >
> > I've looked at the code and it seems like this would be a bit more
> > complicated since the breakpoint is set by an accident in a race and the
> > call still fails. Which is why the test triggers the breakpoint and
> > causes infinite loop in the kernel...
> >
> > I guess that we could instead read back the address with
> > PTRACE_PEEKUSER, so something as:
> >
> >
> > break_addr = ptrace(PTRACE_PEEKUSER, child_pid,
> >                     (void *)offsetof(struct user, u_debugreg[0]),
> >                     NULL);
> >
> > if (break_addr == kernel_addr)
> >       tst_res(TFAIL, "ptrace() set break on a kernel address");
>
> So this works actually nicely, even better than the original code.
>
> Any hints on how to select a fixed address in the kernel range as you
> pointed out in one of the previous emails? I guess that this would end
> up as a per-architecture mess of ifdefs if we wanted to hardcode it.
>

It's fundamentally architecture dependent.  Sane architectures like
s390x don't even have this concept.

--Andy

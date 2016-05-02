From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 2 May 2016 05:10:08 -0400 (EDT)
Subject: [LTP] LTP pre-release testing and freeze
In-Reply-To: <20160428122625.GA25587@rei>
References: <20160420143031.GB4004@rei>
 <1728203866.1199576.1461839113790.JavaMail.zimbra@redhat.com>
 <20160428122625.GA25587@rei>
Message-ID: <1274865023.2004095.1462180208523.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 28 April, 2016 2:26:25 PM
> Subject: Re: [LTP] LTP pre-release testing and freeze
> 
> Hi!
> > Looks good from my side. I ran the usual set we use as smoke test
> > (syscalls, selection of mem/io/etc.) on
> >   RHEL6.2 through RHEL6.8 (i386, x86_64, ppc64, s390x)
> >   RHEL7.0 through RHEL7.2 (x86_64, ppc64, ppc64le, s390x, aarch64)
> > and ran mostly into known bugs in kernel / glibc.
> > 
> > Other than known issues, there were couple failures to note:
> > 
> > epoll_wait02
> > There is a tolerance, but it goes only one way (oversleep).
> > I occasionally see it waking up a ms earlier and then testcase
> > reports it as failure. This was new addition, so there are
> > no historical data for comparison.
> 
> That may be bug, since AFAIC all POSIX timers are not allowed to wake up
> earlier. The epoll_wait() is Linux specific, but the manual talks only
> about possible overrun as well.

I think it happened so far only on ppc/s390 guests, so my suspicion was
that high steal time could be a factor. I'll look into how much reproducible
this is with RHEL.

> 
> > personality01
> > PER_LINUX32 is masked on powerpc as PER_LINUX, so this
> > always fails.
> > 
> > arch/powerpc/kernel/syscalls.c:
> > long ppc64_personality(unsigned long personality)
> > {
> >         long ret;
> > 
> >         if (personality(current->personality) == PER_LINUX32
> >             && personality(personality) == PER_LINUX)
> >                 personality = (personality & ~PER_MASK) | PER_LINUX32;
> >         ret = sys_personality(personality);
> >         if (personality(ret) == PER_LINUX32)
> >                 ret = (ret & ~PER_MASK) | PER_LINUX;
> >         return ret;
> > }
> 
> So the fist if () makes sure that process cannot excape PER_LINUX32
> while the second hides PER_LINUX32 completly. I've missed the second
> part when I was rewriting the testcase. Looking at kernel sources
> sparc64 and s390 seems to do the same but the code assumes that
> PER_LINUX == 0.
> 
> SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
> {
>         unsigned int ret;
> 
>         if (personality(current->personality) == PER_LINUX32 &&
>             personality(personality) == PER_LINUX)
>                 personality |= PER_LINUX32;
>         ret = sys_personality(personality);
>         if (personality(ret) == PER_LINUX32)
>                 ret &= ~PER_LINUX32;
> 
>         return ret;
> }
> 
> Does the test fail on s390x as well?

Yes, it does.

personality01    0  TINFO  :  Child process returned TPASS
personality01    1  TFAIL  :  personality01.c:80: PER_LINUX32: wrong personality read back 0 expected 8

> 
> It seems that mapping PER_LINUX32 to PER_LINUX is a common practice on
> 64 bit, maybe we should just skip that personality on anything than
> x86_64.

Agreed. I can send a patch.

Regards,
Jan


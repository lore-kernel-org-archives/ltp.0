From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 Jul 2020 10:02:18 +0200
Subject: [LTP] [PATCH V7 14/19] syscalls/select6: Add support for time64
 tests
In-Reply-To: <20200728072357.22lyy2b4auyqqmvs@vireshk-mac-ubuntu>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <883a188e83c201b23074bf0ac974b41d89d818c7.1593152309.git.viresh.kumar@linaro.org>
 <20200727094030.GB7863@yuki.lan>
 <20200728072357.22lyy2b4auyqqmvs@vireshk-mac-ubuntu>
Message-ID: <CAK8P3a24BOOnKoiEQbbihp_m34NZXfQgb=Xcrg+TmLHTLO9Cbg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 28, 2020 at 9:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-07-20, 11:40, Cyril Hrubis wrote:
> > > @@ -38,7 +39,7 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
> > >     }
> > >     case 2: {
> > >             int ret;
> > > -           struct timespec ts = {
> > > +           struct __kernel_old_timespec ts = {
> > >                     .tv_sec = timeout->tv_sec,
> > >                     .tv_nsec = timeout->tv_usec * 1000,
> > >             };
> >
> > I'm a bit lost here, should we actually pass the __kernel_old_timespec
> > to all the tst_syscall() fuctions here?
>
> select, pselect6, pselect6_time64, and newselect, all have different
> requirements, some take timespec and others take timeval.
>
> Though after looking again at kernel sources I feel pselect6 may need
> __kernel_timespec instead of __kernel_old_timespec, which is different than what
> we did with other syscalls.
>
> Arnd, can you confirm this please ?

On the kernel side, there is '__NR_pselect6', which refers to the syscall
that takes a 'struct __kernel_old_timespec'., while 32-bit architectures
have another syscall with the number __NR_pselect6_time64 that
takes a 'struct __kernel_timespec'.

The kernel implementation internally uses sys_pselect6_time32()
for the entry point that takes a 32-bit time_t (__NR_pselect6 on
32-bit architectures), and sys_pselect6() for the entry point
that passes a 64-bit time_t (__NR_pselect6 on 64-bit architectures
or __NR_pselect6_time64 on 32-bit architectures).

> > I guess that the only function that would take the argument as struct
> > timeval is the select() glibc function, or do I miss something?
>
> select in kernel also takes old timeval.

Correct, though most modern architectures do not implement this
and only provide pselect6 (and pselect6_time64).

> > > @@ -72,11 +88,14 @@ static void select_info(void)
> > >             tst_res(TINFO, "Testing SYS_pselect6 syscall");
> > >     break;
> > >     case 3:
> > > +           tst_res(TINFO, "Testing SYS_pselect6 time64 syscall");
> > > +   break;
> > > +   case 4:
> > >             tst_res(TINFO, "Testing SYS__newselect syscall");
> > >     break;
> > >     }
> > >  }
> > >
> > > -#define TEST_VARIANTS 4
> > > +#define TEST_VARIANTS 5
> >
> > Also lastly but not least we should clean up the rest of the select
> > tests and add support for the different variants there as well.
>
> Maybe not. IIUC only pselect6 got changed to adapt to different timespec
> structures and the other ones aren't.
>
> Arnd: Can you confirm this as well ?

Yes, this is correct. __NR__newselect (sys_select) and __NR_select
(sys_old_select or sys_select) are both considered obsolete and only
provided on older architectures for backwards compatibility with old libc
versions.

       Arnd

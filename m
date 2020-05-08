From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 8 May 2020 11:24:19 +0200
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <20200508085657.ousiwqakcq7zegpo@vireshk-i7>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAK8P3a1x+uK_WgVn9O8LVcLoZH=oJ_jQcePwcwzqpyhewApX9w@mail.gmail.com>
 <20200508085657.ousiwqakcq7zegpo@vireshk-i7>
Message-ID: <CAK8P3a0PCX_KzKLVD7ZT10xxpOXapUh8o5hhE5OOzyPjxf=GAw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 8, 2020 at 10:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-05-20, 09:18, Arnd Bergmann wrote:
> > On Fri, May 8, 2020 at 6:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > > +
> > > +static inline int sys_semtimedop(int semid, struct sembuf *sops, size_t nsops,
> > > +               void *timeout)
> > > +{
> > > +       return tst_syscall(__NR_semtimedop, semid, sops, nsops, timeout);
> > > +}
> > > +
> > > +static inline int sys_semtimedop_time64(int semid, struct sembuf *sops,
> > > +                                       size_t nsops, void *timeout)
> > > +{
> > > +       return tst_syscall(__NR_semtimedop_time64, semid, sops, nsops, timeout);
> > > +}
> > > +
> > > +struct test_variants {
> > > +       int (*semop)(int semid, struct sembuf *sops, size_t nsops);
> > > +       int (*semtimedop)(int semid, struct sembuf *sops, size_t nsops, void *timeout);
> > > +       enum tst_ts_type type;
> > > +       char *desc;
> > > +} variants[] = {
> > > +       { .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},
> > > +#if defined(TST_ABI32)
> > > +       { .semtimedop = sys_semtimedop, .type = TST_LIBC_TIMESPEC, .desc = "semtimedop: syscall with libc spec"},
> > > +       { .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with kernel spec32"},
> > > +#endif
> > > +
> > > +#if defined(TST_ABI64)
> > > +       { .semtimedop = sys_semtimedop, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall with kernel spec64"},
> > > +#endif
> >
> >
> > It feels like this is more complicated than it need to be. The line
> >
> > semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc =
> > "semtimedop: syscall with kernel spec32"},
> >
> > should apply to any kernel that has "__NR_semtimedop !=
> > __LTP__NR_INVALID_SYSCALL",
> > regardless of any other macros set, and then you don't need the separate line
> >
> > { .semtimedop = sys_semtimedop, .type = TST_KERN_TIMESPEC, .desc =
> > "semtimedop: syscall with kernel spec64"},
>
> > which is not what the ABI is meant to be anyway (sys_semtimedop takes
> > a __kernel_old_timespec,
> > not a __kernel_timespec).
>
> There is some misunderstanding here, surely from my side. The sys_
> helpers here are the direct syscalls called from userspace with help
> of tst_syscall().
>
> AFAIU, on 32 bit systems we need to call __NR_semtimedop with the 32
> bit and 64 bit timespec (both), and on 64 bit systems which don't
> implement __NR_semtimedop_time64, we need to call __NR_semtimedop with
> the 64 bit timespec only.
>
> What you are telling now is very different from that and so I don't
> get it.

__NR_semtimedop can only be called with the 'old' timespec, which
may have either 32 or 64 members depending on the architecture.
On x32 it uses 64-bit members, and on riscv32 it does not exist at all.

I think you already have a correct __kernel_old_timespec definition,
so what I'd expect to see here is code that passes __kernel_old_timespec
into __NR_semtimedop whenever __NR_semtimedop is defined.

Passing the libc timespec into __kernel_old_timespec is a bug, as
the libc may be using either the old or the new (always 64-bit)
definition.

> >  { .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},
> >
> > should apply to both 32 and 64 bit machines
>
> Yes and so it is called without ifdef hackery. Isn't that correct ?

My mistake, I confused the lines. What I meant is that there should
be an unconditional test of the libc 'semtimedop' with the libc 'timespec'
definition.

     Arnd

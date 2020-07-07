From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jul 2020 11:03:01 +0200
Subject: [LTP] [PATCH V4 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <CAEemH2cN735haDmyqbNa_LwDgumFqAspYfJaKRpsOg0Rij9tEA@mail.gmail.com>
References: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
 <9562fdf4debd759439ee7f468008177003db9513.1592457867.git.viresh.kumar@linaro.org>
 <CAEemH2cu_o2eCHQB1_Bo0aQiR2WK6knbBtD83-5_77gZZbA-Ow@mail.gmail.com>
 <20200703125927.GA11556@yuki.lan>
 <CAEemH2cN735haDmyqbNa_LwDgumFqAspYfJaKRpsOg0Rij9tEA@mail.gmail.com>
Message-ID: <20200707090301.GA3512@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
> > index bc0bef273..c0727a34c 100644
> > --- a/lib/tst_clocks.c
> > +++ b/lib/tst_clocks.c
> > @@ -14,11 +14,11 @@
> >
> >  typedef int (*mysyscall)(clockid_t clk_id, void *ts);
> >
> > -int syscall_supported_by_kernel(mysyscall func)
> > +int syscall_supported_by_kernel(long sysnr)
> >  {
> >         int ret;
> >
> > -       ret = func(0, NULL);
> > +       ret = syscall(sysnr, func(0, NULL);
> >
> 
> This line should be: ret = syscall(sysnr, 0, NULL);

This is obvious typo, sorry.

> >         if (ret == -1 && errno == ENOSYS)
> >                 return 0;
> >
> > @@ -32,13 +32,13 @@ int tst_clock_getres(clockid_t clk_id, struct timespec
> > *res)
> >         int ret;
> >
> >  #if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
> > -       if (!func && syscall_supported_by_kernel(sys_clock_getres64)) {
> > +       if (!func && syscall_supported_by_kernel(__NR_clock_getres64)) {
> 
> 
> if (!func && syscall_supported_by_kernel(__NR_clock_getres_time64 )) {

Huh, how come the syscall is called clock_getres_time64 while the rest
has only 64 appended such as clock_gettime64 and clock_settime64?

That's really strange...

-- 
Cyril Hrubis
chrubis@suse.cz

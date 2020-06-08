From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 8 Jun 2020 12:21:13 +0200
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
References: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
 <CAK8P3a0b2BbZq_yYBKJHUfZgzCYUtdidpzJEj-HzuBKf1Q_nnQ@mail.gmail.com>
 <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
Message-ID: <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 8, 2020 at 12:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-06-20, 14:19, Arnd Bergmann wrote:
> > On Fri, Jun 5, 2020 at 9:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > > +static struct test_variants {
> > > +       int (*gettime)(clockid_t clk_id, void *ts);
> > > +       enum tst_ts_type type;
> > > +       char *desc;
> > > +} variants[] = {
> > > +       { .gettime = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
> > > +
> > > +#if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
> > > +       { .gettime = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
> > > +#endif
> > > +
> > > +#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
> > > +       { .gettime = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
> > > +#endif
> > > +};
> >
> > Would it be possible to add a direct call to the two vdso
> > implementations here as well?
>
> Which two vdso calls are you talking about here ?

I mean clock_gettime() and clock_gettime() as implemented in the vdso,
see https://github.com/nlynch-mentor/vdsotest/tree/master/src for how
to call them.

>  static void run(unsigned int i)
>  {
> -       struct tst_ts ts_start, ts_end;
> +       struct tst_ts ts;
>         long long start, end, diff;
>         struct test_variants *tv;
>         int count = 10000;
>         unsigned int j;
>
> -       while (--count) {
> -               /* Store reference time in start */
> -               if (clks[i] == CLOCK_REALTIME) {
> -                       struct timeval tval;
> -
> -                       /* Compare CLOCK_REALTIME with gettimeofday() as well */
> -                       if (gettimeofday(&tval, NULL) < 0)
> -                               tst_brk(TBROK | TERRNO, "gettimeofday() failed");
> -
> -                       start = tst_timeval_to_ms(tval);
> -               } else {
> -                       tv = &variants[0];
> -                       ts_start.type = tv->type;
> -                       tv->gettime(clks[i], tst_ts_get(&ts_start));
> -                       start = tst_ts_to_ms(ts_start);
> -               }
> +       /* Store reference time in start */
> +       if (clks[i] == CLOCK_REALTIME) {
> +               struct timeval tval;
>
> +               /* Compare CLOCK_REALTIME with gettimeofday() as well */
> +               if (gettimeofday(&tval, NULL) < 0)
> +                       tst_brk(TBROK | TERRNO, "gettimeofday() failed");
> +
> +               start = tst_timeval_to_us(tval) * 1000;
> +       } else {
> +               tv = &variants[0];
> +               ts.type = tv->type;
> +               tv->gettime(clks[i], tst_ts_get(&ts));
> +               start = tst_ts_to_ns(ts);
> +       }

So now you only call gettimeofday() once instead of in each loop, right?
This won't test for spurious failures any more, but I suppose it would catch
any case where gettimeofday() and clock_gettime() are out of sync by
a lot. The only case you don't catch is where clock_gettime() sometimes
returns a value that is slightly earlier than gettimeofday().

> +       while (--count) {
>                 for (j = 0; j < ARRAY_SIZE(variants); j++) {
>                         tv = &variants[j];
> -                       ts_end.type = tv->type;
> +                       ts.type = tv->type;
>
> -                       tv->gettime(clks[i], tst_ts_get(&ts_end));
> -                       end = tst_ts_to_ms(ts_end);
> +                       tv->gettime(clks[i], tst_ts_get(&ts));
> +                       end = tst_ts_to_ns(ts);
>
>                         diff = end - start;
>                         if (diff < 0) {
> -                               tst_res(TFAIL, "%s: Time travelled backwards: %lld",
> -                                               tst_clock_name(clks[i]), diff);
> +                               tst_res(TFAIL, "%s: Time travelled backwards: %lld ns",
> +                                       tst_clock_name(clks[i]), diff);
>                                 return;
>                         }
>
> +                       diff /= 1000000;
> +

Right, this seems reasonable. I noticed that tst_ts_to_ns() might overflow
for bad timestamp values, but those would also likely cause jumps, so
you don't have to add an extra check.

     Arnd

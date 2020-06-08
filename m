From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 8 Jun 2020 16:51:09 +0200
Subject: [LTP] [PATCH] syscalls/clock_gettime: Add test to check bug
 during successive readings
In-Reply-To: <20200608112000.sjrbvmqjciifgyub@vireshk-i7>
References: <e15907ed42f0276f09c4120b9255db5764d4e9b6.1591343286.git.viresh.kumar@linaro.org>
 <CAK8P3a0b2BbZq_yYBKJHUfZgzCYUtdidpzJEj-HzuBKf1Q_nnQ@mail.gmail.com>
 <20200608100900.c4fi7pw7euie6tnt@vireshk-i7>
 <CAK8P3a004cavRhyWx+uXYYteBi1LviahAv11+9JyGadN-vo8og@mail.gmail.com>
 <20200608112000.sjrbvmqjciifgyub@vireshk-i7>
Message-ID: <CAK8P3a0PqtFWTZr9hvSy5Y0ZZOSNgfzw0x1DTTyuzfsfROpAvw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 8, 2020 at 1:20 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-06-20, 12:21, Arnd Bergmann wrote:
> > So now you only call gettimeofday() once instead of in each loop, right?
> > This won't test for spurious failures any more, but I suppose it would catch
> > any case where gettimeofday() and clock_gettime() are out of sync by
> > a lot. The only case you don't catch is where clock_gettime() sometimes
> > returns a value that is slightly earlier than gettimeofday().
>
> Okay, I missed the fact that we need to call gettimeofday() for every iteration
> and here is the new diff which has tried to simplify the overall code. But this
> has a problem now as it always reports this error:
>
> clock_gettime04.c:88: FAIL: CLOCK_REALTIME: Time travelled backwards (2): -148 ns
>
> I guess the problem is that gettimeofday() gets the value in usec resolution and
> clock_gettime() gets it in nsec and so some nsec always get lost with
> gettimeofday() and so the errors ? How should we take care of this ? Take diff
> in usec instead of nsec ?

You already have a special case for gettimeofday(), so just round down
the 'start' value to the previous microsecond when you are in that
case. For all other cases, I think we want to check the exact nanoseconds,
in particular to ensure that the calculation is done the same way in the
vdso vs the kernel.

> +static void run(unsigned int i)
> +{
> +       struct tst_ts ts;
> +       long long start, end = 0, diff;
> +       struct test_variants *tv;
> +       int count = 10000;
> +       unsigned int j;
> +
> +       do {
> +               for (j = 0; j < ARRAY_SIZE(variants); j++) {
> +                       /* Refresh time in start */
> +                       start = end;
> +
> +                       tv = &variants[j];
> +                       ts.type = tv->type;
> +
> +                       /* Do gettimeofday() test only for CLOCK_REALTIME */
> +                       if (tv->gettime == my_gettimeofday && clks[i] != CLOCK_REALTIME)
> +                               continue;
> +
> +                       tv->gettime(clks[i], tst_ts_get(&ts));
> +                       end = tst_ts_to_ns(ts);
> +
> +                       /* Skip comparison on first traversal */
> +                       if (count == 10000 && !j)
> +                               continue;
> +
> +                       diff = end - start;

I think on the first iteration, 'start' is wrong here as well, and needs to
be initialized once, as you did in the earlier versions.

       Arnd

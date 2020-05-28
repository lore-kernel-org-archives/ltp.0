From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 28 May 2020 14:41:48 +0530
Subject: [LTP] [PATCH V2] syscalls: clock_settime: Add test around y2038
 vulnerability
In-Reply-To: <CAK8P3a11aWYdBtgV=T91_BOVR_hX-OZTAVhr806nbTFtCE+3MQ@mail.gmail.com>
References: <70417fdc55c750e8b13d7124e66a7e8a59182e75.1590494889.git.viresh.kumar@linaro.org>
 <86a36c7d5919a966e077cb76f0d8710f31bcc60a.1590649002.git.viresh.kumar@linaro.org>
 <CAK8P3a11aWYdBtgV=T91_BOVR_hX-OZTAVhr806nbTFtCE+3MQ@mail.gmail.com>
Message-ID: <20200528091148.3afrkdjqzjer4vqh@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28-05-20, 10:27, Arnd Bergmann wrote:
> On Thu, May 28, 2020 at 8:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > This adds a test around the y2038 vulnerability, it sets the system time
> > to just before y2038 time (i.e. max value that can be stored in s32),
> > and adds a timer to expire just after crossing it.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2:
> > - Fix the y2038 bug in the test itself, changes in the setup() routine.
> >   :)
> 
> So I assume this version works as expected?
> I don't see any more problems with it.

Absolutely perfectly. I don't know what the problem with timer was
earlier, maybe it was related to a different way I was trying to
capture the signal with (i.e. SAFE_SIGNAL(SIGALRM, sighandler)).

But this (and the earlier patch as well, perhaps I tested even an
earlier version then) works just fine.

> > +       ret = tv->clock_settime(CLOCK_REALTIME, tst_ts_get(&ts));
> > +       if (ret == -1)
> > +               tst_brk(TBROK | TERRNO, "clock_settime() failed");

But I noticed that even this version may not be good enough, as I am
still doing the same thing in setup(), i.e. setting time to just
before y2038 to test if it is y2038 safe or not. I believe even that
isn't fine ?

> > +
> > +       tst_its_set_time(&its, time + EXPIREDELTA, 0, 0, 0);
> > +
> > +       TEST(tv->timer_settime(timer, TIMER_ABSTIME, tst_its_get(&its), NULL));
> > +       if (TST_RET == -1)
> > +               tst_brk(TBROK | TTERRNO, "timer_settime() failed");
> > +
> > +       if (sigwait(&set, &sig) == -1)
> > +               tst_brk(TBROK, "sigwait() failed");
> 
> Should you maybe check the time after the expiration to ensure the
> timer ran for the expected length?
> 
> I suppose you can read the time in CLOCK_MONOTONIC to check
> for the elapsed time regardless of what the kernel might think the
> CLOCK_REALTIME is after this.

This should be enough I believe.

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index 9e316378b1cc..876651a5d537 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -13,7 +13,7 @@
 
 #define EXPIREDELTA 3
 
-static struct tst_ts ts;
+static struct tst_ts ts, end;
 static struct tst_its its;
 
 static struct test_variants {
@@ -37,7 +37,6 @@ static void setup(void)
 {
        struct test_variants *tv = &variants[tst_variant];
        unsigned long long time = 0x7FFFFFFF; /* Time just before y2038 */
-       struct tst_ts end;
        int ret;
 
        tst_res(TINFO, "Testing variant: %s", tv->desc);
@@ -72,6 +71,7 @@ static void run(void)
                .sigev_notify = SIGEV_SIGNAL,
                .sigev_signo = SIGABRT,
        };
+       struct tst_ts diff;
        timer_t timer;
        sigset_t set;
        int sig, ret;
@@ -105,7 +105,16 @@ static void run(void)
        if (sigwait(&set, &sig) == -1)
                tst_brk(TBROK, "sigwait() failed");
 
+       ret = tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(&end));
+       if (ret == -1)
+               tst_brk(TBROK | TERRNO, "clock_gettime() failed");
+
        if (sig == SIGABRT) {
+               diff = tst_ts_diff(end, ts);
+
+               if (tst_ts_get_sec(diff) != EXPIREDELTA)
+                       tst_res(TINFO, "Test slept longer than it should have, expected:%d, actual:%lld",
+                               EXPIREDELTA, tst_ts_get_sec(diff));
                tst_res(TPASS, "clock_settime(): Y2038 test passed");
                return;
        }

-- 
viresh

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 25 Jun 2020 15:20:06 +0530
Subject: [LTP] [PATCH V6 01/17] syscalls/timer_gettime: Add support for
 time64 tests
In-Reply-To: <20200624142327.GA5181@yuki.lan>
References: <a4a628a637a6eeeed4249656836bd217f5cbb9ac.1590144577.git.viresh.kumar@linaro.org>
 <9621b4f97b539f2e080b00491eb9ba4973878028.1591760262.git.viresh.kumar@linaro.org>
 <20200624142327.GA5181@yuki.lan>
Message-ID: <20200625095006.d6ndameqblecadp4@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24-06-20, 16:23, Cyril Hrubis wrote:
> > +static void verify(void)
> > +{
> > +	struct test_variants *tv = &variants[tst_variant];
> > +	struct tst_its spec = {.type = tv->type, };
> > +
> > +	TEST(tv->func(timer, tst_its_get(&spec)));
> > +	if (TST_RET == 0) {
> > +		tst_res(TPASS, "timer_gettime() Passed");
> > +	} else {
> > +		tst_res(TFAIL | TTERRNO, "timer_gettime() Failed");
> >  	}
> 
> Looking at manuals it seems that:
> 
> * Newly created timer is disarmed
> 
> * For disarmed timers the clock_gettime() should get itimer with zeroes
> 
> So we check here that the returned itimer has zeroes for both oneshoot
> and interval timers here.

I am not sure what oneshoot/interval timers you are talking about :)

This is what I came to, is this sufficient ?

diff --git a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
index ea7cc6b59f7e..4a949486a920 100644
--- a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
+++ b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
@@ -55,7 +55,19 @@ static void verify(void)
 
        TEST(tv->func(timer, tst_its_get(&spec)));
        if (TST_RET == 0) {
-               tst_res(TPASS, "timer_gettime() Passed");
+               if ((spec.type == TST_KERN_OLD_TIMESPEC &&
+                       (spec.ts.kern_old_its.it_interval.tv_sec ||
+                        spec.ts.kern_old_its.it_interval.tv_nsec ||
+                        spec.ts.kern_old_its.it_value.tv_sec ||
+                        spec.ts.kern_old_its.it_value.tv_nsec)) ||
+                   (spec.type == TST_KERN_TIMESPEC &&
+                       (spec.ts.kern_its.it_interval.tv_sec ||
+                        spec.ts.kern_its.it_interval.tv_nsec ||
+                        spec.ts.kern_its.it_value.tv_sec ||
+                        spec.ts.kern_its.it_value.tv_nsec)))
+                       tst_res(TFAIL, "timespec should have been zeroed");
+               else
+                       tst_res(TPASS, "timer_gettime() Passed");
        } else {
                tst_res(TFAIL | TTERRNO, "timer_gettime() Failed");
        }

-- 
viresh

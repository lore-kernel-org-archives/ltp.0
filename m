From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 3 Jul 2020 17:01:11 +0800
Subject: [LTP] [PATCH] syscalls/sched_rr_get_interval: Validate the
 timeslice
In-Reply-To: <20200703081852.7mxbhkfz6vgjfwak@vireshk-i7>
References: <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <0744cfd7d2f14d8e8c6d8e74420b35ef273a7737.1593761725.git.viresh.kumar@linaro.org>
 <902db9f8-22d9-b641-746b-6ec61b8eaa21@cn.fujitsu.com>
 <20200703075136.enu2ovlfo25cwyca@vireshk-i7>
 <2ced43d0-4bf0-982a-fd7e-3628716890c4@cn.fujitsu.com>
 <20200703081852.7mxbhkfz6vgjfwak@vireshk-i7>
Message-ID: <5487571b-cef7-9907-29f8-885f430d9c08@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh


> Yeah I got that you were talking about this, but I am not sure of what
> regression test you are asking for and if we should be adding a test
> towards it at all as this is a kernel bug and we should keep showing
> the error for such kernels, isn't it ?

Yes, we only add a linux tag and comment as below:
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -5,6 +5,10 @@
   *
   * Gets round-robin time quantum by calling sched_rr_get_interval() and
   * checks that the value is sane.
+ *
+ * It is also a regression test for kernel
+ * commit 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR
+ * timeslice tuning knob in milliseconds").
   */

  #include <sched.h>
@@ -53,7 +57,6 @@ static void run(void)
                 tst_res(TFAIL | TTERRNO, "Test Failed, sched_rr_get_interval() returned %ld",
                         TST_RET);
         }
-
         if (!tst_ts_valid(&tp)) {
                 tst_res(TPASS, "Time quantum %llis %llins",
                         tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
@@ -61,7 +64,7 @@ static void run(void)
                 tst_res(TFAIL, "Invalid time quantum %llis %llins",
                         tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
         }
-
+       TST_ASSERT_INT("/proc/sys/kernel/sched_rr_timeslice_ms", tst_ts_to_ms(tp));
  }

  static struct tst_test test = {
@@ -69,4 +72,8 @@ static struct tst_test test = {
         .test_variants = ARRAY_SIZE(variants),
         .setup = setup,
         .needs_root = 1,
+       .tags = (const struct tst_tag[]) {
+               {"linux-git", "975e155ed873"},
+               {}
+       }
  };

so run this case without this kernel patch and config_hz=250 fail as below:
sched_rr_get_interval01.c:40: INFO: Testing variant: syscall with old kernel spec
sched_rr_get_interval01.c:55: PASS: sched_rr_get_interval() passed
sched_rr_get_interval01.c:62: PASS: Time quantum 0s 100000000ns
sched_rr_get_interval01.c:67: FAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 25

HINT: You _MAY_ be missing kernel fixes, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=975e155ed873



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200703/9290fa68/attachment-0001.htm>

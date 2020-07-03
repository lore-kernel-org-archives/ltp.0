From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 3 Jul 2020 08:45:32 +0530
Subject: [LTP] [PATCH V7 05/19] syscalls/sched_rr_get_interval: Add
 support for time64 tests
In-Reply-To: <20200702130654.GC9101@yuki.lan>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <20200702130654.GC9101@yuki.lan>
Message-ID: <20200703031532.bjkwhkpfobdsxj4p@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02-07-20, 15:06, Cyril Hrubis wrote:
> Btw, we may as well add a check that the value is consistent with
> /proc/sys/kernel/sched_rr_timeslice_ms.

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 31d7b5d56a52..0641b6651502 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -44,6 +44,7 @@ static void setup(void)
 static void run(void)
 {
        struct test_variants *tv = &variants[tst_variant];
+       unsigned long long timeslice_ms;
 
        TEST(tv->func(0, tst_ts_get(&tp)));
 
@@ -54,6 +55,8 @@ static void run(void)
                        TST_RET);
        }
 
+       SAFE_FILE_SCANF("/proc/sys/kernel/sched_rr_timeslice_ms", "%llu", &timeslice_ms);
+
        if (!tst_ts_valid(&tp)) {
                tst_res(TPASS, "Time quantum %llis %llins",
                        tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
@@ -62,6 +65,7 @@ static void run(void)
                        tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
        }
 
+       tst_res(TINFO, "%llu: %llu", timeslice_ms, tst_ts_to_ms(tp));
 }
 
 static struct tst_test test = {



and it is coming as:

sched_rr_get_interval01.c:68: INFO: 25: 100

They aren't consistent here. Perhaps because first one is system wide
while other one is per process ?

-- 
viresh

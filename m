From: zhao gongyi <zhaogongyi@huawei.com>
Date: Thu, 4 Feb 2021 17:21:14 +0800
Subject: [LTP] [PATCH] bugfix for lib/tst_capability.c
 sched_setaffinity/sched_setaffinity01.c timerfd/timerfd04.c
Message-ID: <20210204092114.8726-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use TERRNO because we're not using the TEST() macro.

Signed-off-by: zhao gongyi <zhaogongyi@huawei.com>
---
 lib/tst_capability.c                                        | 2 +-
 .../kernel/syscalls/sched_setaffinity/sched_setaffinity01.c | 6 +++---
 testcases/kernel/syscalls/timerfd/timerfd04.c               | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_capability.c b/lib/tst_capability.c
index 1fa0e49c5..cb0502e2e 100644
--- a/lib/tst_capability.c
+++ b/lib/tst_capability.c
@@ -57,7 +57,7 @@ void tst_cap_action(struct tst_cap *cap)
 	uint32_t mask = CAP_TO_MASK(cap->id);

 	if (tst_capget(&hdr, cur))
-		tst_brk(TBROK | TTERRNO, "tst_capget()");
+		tst_brk(TBROK | TERRNO, "tst_capget()");

 	memcpy(new, cur, sizeof(new));

diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
index d9d6530e2..a56ae1f50 100644
--- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
+++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
@@ -95,16 +95,16 @@ static void setup(void)

 	mask = CPU_ALLOC(ncpus);
 	if (!mask)
-		tst_brk(TBROK | TTERRNO, "CPU_ALLOC() failed");
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");

 	mask_size = CPU_ALLOC_SIZE(ncpus);

 	if (sched_getaffinity(0, mask_size, mask) < 0)
-		tst_brk(TBROK | TTERRNO, "sched_getaffinity() failed");
+		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");

 	emask = CPU_ALLOC(ncpus + 1);
 	if (!emask)
-		tst_brk(TBROK | TTERRNO, "CPU_ALLOC() failed");
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");

 	emask_size = CPU_ALLOC_SIZE(ncpus + 1);
 	CPU_ZERO_S(emask_size, emask);
diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
index 798d95e60..4af91d6f8 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd04.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
@@ -64,7 +64,7 @@ static void verify_timerfd(unsigned int n)
 	                 tc->clk_off, tc->off);

 	if (tv->clock_gettime(tc->clk_id, tst_ts_get(&start))) {
-		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+		tst_res(TFAIL | TERRNO, "clock_gettime(2) failed for clock %s",
 			tst_clock_name(tc->clk_id));
 		return;
 	}
@@ -95,7 +95,7 @@ static void verify_timerfd(unsigned int n)
 	SAFE_WAIT(NULL);

 	if (tv->clock_gettime(CLOCK_MONOTONIC, tst_ts_get(&end))) {
-		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
+		tst_res(TFAIL | TERRNO, "clock_gettime(2) failed for clock %s",
 			tst_clock_name(CLOCK_MONOTONIC));
 		return;
 	}
--
2.17.1


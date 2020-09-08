From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:23 +0530
Subject: [LTP] [PATCH 10/16] syscalls: sched_rr_get_interval: Reuse struct
 time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <26a1aa0c61d71ae5a2ce738ee08d1e3ba4c663c8.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../sched_rr_get_interval01.c                 | 21 ++++++++-----------
 .../sched_rr_get_interval02.c                 | 21 ++++++++-----------
 .../sched_rr_get_interval03.c                 | 21 ++++++++-----------
 3 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 0466be36bec0..9d9ddf32eec1 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -12,6 +12,7 @@
  */
 
 #include <sched.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 
 #define PROC_SCHED_RR_TIMESLICE_MS	"/proc/sys/kernel/sched_rr_timeslice_ms"
@@ -19,30 +20,26 @@ static int proc_flag;
 
 struct tst_ts tp;
 
-static struct test_variants {
-	int (*func)(pid_t pid, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .func = libc_sched_rr_get_interval, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .sched_rr_get_interval = libc_sched_rr_get_interval, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_sched_rr_get_interval != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_sched_rr_get_interval, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .sched_rr_get_interval = sys_sched_rr_get_interval, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_sched_rr_get_interval_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_sched_rr_get_interval64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .sched_rr_get_interval = sys_sched_rr_get_interval64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct sched_param p = { 1 };
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	tp.type = tv->type;
+	tp.type = tv->ts_type;
 
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
@@ -52,9 +49,9 @@ static void setup(void)
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
-	TEST(tv->func(0, tst_ts_get(&tp)));
+	TEST(tv->sched_rr_get_interval(0, tst_ts_get(&tp)));
 
 	if (!TST_RET) {
 		tst_res(TPASS, "sched_rr_get_interval() passed");
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 5b38e5bff0d3..0e98fec5608f 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -9,34 +9,31 @@
  */
 
 #include <sched.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 
 static struct tst_ts tp;
 
-static struct test_variants {
-	int (*func)(pid_t pid, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .func = libc_sched_rr_get_interval, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .sched_rr_get_interval = libc_sched_rr_get_interval, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_sched_rr_get_interval != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_sched_rr_get_interval, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .sched_rr_get_interval = sys_sched_rr_get_interval, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_sched_rr_get_interval_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_sched_rr_get_interval64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .sched_rr_get_interval = sys_sched_rr_get_interval64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct sched_param p = { 1 };
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	tp.type = tv->type;
+	tp.type = tv->ts_type;
 
 	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1)
 		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
@@ -44,12 +41,12 @@ static void setup(void)
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_ts_set_sec(&tp, 99);
 	tst_ts_set_nsec(&tp, 99);
 
-	TEST(tv->func(0, tst_ts_get(&tp)));
+	TEST(tv->sched_rr_get_interval(0, tst_ts_get(&tp)));
 
 	if (!TST_RET && tst_ts_valid(&tp) == -1) {
 		tst_res(TPASS, "sched_rr_get_interval() passed");
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index d7bbe268689c..6a64ca2c6b94 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -13,6 +13,7 @@
  */
 
 #include <sched.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 
 static pid_t unused_pid;
@@ -32,31 +33,27 @@ struct test_cases_t {
 	{ &zero_pid, NULL, EFAULT}
 };
 
-static struct test_variants {
-	int (*func)(pid_t pid, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .func = libc_sched_rr_get_interval, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .sched_rr_get_interval = libc_sched_rr_get_interval, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_sched_rr_get_interval != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_sched_rr_get_interval, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .sched_rr_get_interval = sys_sched_rr_get_interval, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_sched_rr_get_interval_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_sched_rr_get_interval64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .sched_rr_get_interval = sys_sched_rr_get_interval64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct sched_param p = { 1 };
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
 	bad_addr = tst_get_bad_addr(NULL);
-	tp.type = tv->type;
+	tp.type = tv->ts_type;
 
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
@@ -66,7 +63,7 @@ static void setup(void)
 
 static void run(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct test_cases_t *tc = &test_cases[i];
 	struct timerspec *ts;
 
@@ -75,7 +72,7 @@ static void run(unsigned int i)
 	else
 		ts = tst_ts_get(tc->tp);
 
-	TEST(tv->func(*tc->pid, ts));
+	TEST(tv->sched_rr_get_interval(*tc->pid, ts));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "sched_rr_get_interval() passed unexcpectedly");
-- 
2.25.0.rc1.19.g042ed3e048af


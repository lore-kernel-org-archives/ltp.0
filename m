From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:27 +0530
Subject: [LTP] [PATCH 14/16] syscalls: timerfd: Reuse struct time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <e19e515d1ed0a1c88aaba0f9c926725e999f6efb.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/timerfd/timerfd01.c | 27 ++++++++-----------
 testcases/kernel/syscalls/timerfd/timerfd04.c | 20 ++++++--------
 .../syscalls/timerfd/timerfd_gettime01.c      |  8 +++---
 .../syscalls/timerfd/timerfd_settime01.c      | 17 +++++-------
 .../syscalls/timerfd/timerfd_settime02.c      | 15 +++++------
 5 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 039d962ca228..cede40dafb2b 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -17,6 +17,7 @@
 
 #define _GNU_SOURCE
 #include <poll.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_timerfd.h"
 
@@ -28,28 +29,22 @@ static struct tcase {
 	{CLOCK_REALTIME, "CLOCK REALTIME"},
 };
 
-static struct test_variants {
-	int (*cgettime)(clockid_t clk_id, void *ts);
-	int (*tfd_gettime)(int fd, void *its);
-	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timerfd_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .cgettime = sys_clock_gettime, .tfd_gettime = sys_timerfd_gettime, .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .tfd_gettime = sys_timerfd_gettime, .tfd_settime = sys_timerfd_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timerfd_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .cgettime = sys_clock_gettime64, .tfd_gettime = sys_timerfd_gettime64, .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .tfd_gettime = sys_timerfd_gettime64, .tfd_settime = sys_timerfd_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static unsigned long long getustime(int clockid)
 {
-	struct test_variants *tv = &variants[tst_variant];
-	struct tst_ts tp = {.type = tv->type, };
+	struct time64_variants *tv = &variants[tst_variant];
+	struct tst_ts tp = {.type = tv->ts_type, };
 
-	if (tv->cgettime((clockid_t) clockid, tst_ts_get(&tp))) {
+	if (tv->clock_gettime((clockid_t) clockid, tst_ts_get(&tp))) {
 		tst_res(TFAIL | TERRNO, "clock_gettime() failed");
 		return 0;
 	}
@@ -60,7 +55,7 @@ static unsigned long long getustime(int clockid)
 static void settime(int tfd, struct tst_its *tmr, int tflags,
                     unsigned long long tvalue, int tinterval)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_its_set_value_from_us(tmr, tvalue);
 	tst_its_set_interval_from_us(tmr, tinterval);
@@ -97,11 +92,11 @@ static void waittmr(int tfd, unsigned int exp_ticks)
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	int tfd;
 	unsigned long long tnow;
 	uint64_t uticks;
-	struct tst_its tmr = {.type = tv->type, };
+	struct tst_its tmr = {.type = tv->ts_type, };
 	struct tcase *clks = &tcases[n];
 
 	tst_res(TINFO, "testing %s", clks->name);
@@ -122,7 +117,7 @@ static void run(unsigned int n)
 	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 50 * 1000, 50 * 1000);
 
 	memset(&tmr, 0, sizeof(tmr));
-	tmr.type = tv->type;
+	tmr.type = tv->ts_type;
 
 	if (tv->tfd_gettime(tfd, tst_its_get(&tmr)))
 		tst_res(TFAIL | TERRNO, "timerfd_gettime() failed");
diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
index b6409574a219..798d95e607ed 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd04.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
@@ -15,6 +15,7 @@
  */
 
 #include <stdlib.h>
+#include "time64_variants.h"
 #include "tst_safe_clocks.h"
 #include "tst_safe_timerfd.h"
 #include "tst_timer.h"
@@ -34,18 +35,13 @@ static struct tcase {
 	{CLOCK_BOOTTIME, CLOCK_BOOTTIME, -10},
 };
 
-static struct test_variants {
-	int (*cgettime)(clockid_t clk_id, void *ts);
-	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timerfd_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .cgettime = sys_clock_gettime, .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .tfd_settime = sys_timerfd_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timerfd_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .cgettime = sys_clock_gettime64, .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .tfd_settime = sys_timerfd_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -56,18 +52,18 @@ static void setup(void)
 
 static void verify_timerfd(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct tst_ts start, end;
 	struct tst_its it;
 	struct tcase *tc = &tcases[n];
 
-	start.type = end.type = it.type = tv->type;
+	start.type = end.type = it.type = tv->ts_type;
 	SAFE_UNSHARE(CLONE_NEWTIME);
 
 	SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0",
 	                 tc->clk_off, tc->off);
 
-	if (tv->cgettime(tc->clk_id, tst_ts_get(&start))) {
+	if (tv->clock_gettime(tc->clk_id, tst_ts_get(&start))) {
 		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
 			tst_clock_name(tc->clk_id));
 		return;
@@ -98,7 +94,7 @@ static void verify_timerfd(unsigned int n)
 
 	SAFE_WAIT(NULL);
 
-	if (tv->cgettime(CLOCK_MONOTONIC, tst_ts_get(&end))) {
+	if (tv->clock_gettime(CLOCK_MONOTONIC, tst_ts_get(&end))) {
 		tst_res(TFAIL | TTERRNO, "clock_gettime(2) failed for clock %s",
 			tst_clock_name(CLOCK_MONOTONIC));
 		return;
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
index 49f5aa59a96b..aba77c05d796 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
@@ -12,6 +12,7 @@
 
 #define _GNU_SOURCE
 
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_timerfd.h"
 
@@ -32,10 +33,7 @@ static struct test_case_t {
 	{&fd, NULL, EINVAL},
 };
 
-static struct test_variants {
-	int (*tfd_gettime)(int fd, void *its);
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timerfd_gettime != __LTP__NR_INVALID_SYSCALL)
 	{ .tfd_gettime = sys_timerfd_gettime, .desc = "syscall with old kernel spec"},
 #endif
@@ -70,7 +68,7 @@ static void cleanup(void)
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct test_case_t *test = &test_cases[n];
 	void *its;
 
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
index 781c0fdb1cb7..36577e2c4c0b 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
@@ -13,6 +13,7 @@
 
 #define _GNU_SOURCE
 
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "lapi/timerfd.h"
 
@@ -35,27 +36,23 @@ static struct test_case_t {
 
 static struct tst_its new_value;
 
-static struct test_variants {
-	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timerfd_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .tfd_settime = sys_timerfd_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timerfd_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .tfd_settime = sys_timerfd_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	bad_addr = tst_get_bad_addr(NULL);
-	new_value.type = tv->type;
+	new_value.type = tv->ts_type;
 
 	clockfd = timerfd_create(CLOCK_REALTIME, 0);
 	if (clockfd == -1) {
@@ -77,7 +74,7 @@ static void cleanup(void)
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct test_case_t *test = &test_cases[n];
 	void *its;
 
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index ab978bde5820..bd92ee964644 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -15,6 +15,7 @@
  *  timerfd: Protect the might cancel mechanism proper
  */
 #include <unistd.h>
+#include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_safe_timerfd.h"
 #include "tst_fuzzy_sync.h"
@@ -29,26 +30,22 @@ static int fd = -1;
 static struct tst_its its;
 static struct tst_fzsync_pair fzsync_pair;
 
-static struct test_variants {
-	int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timerfd_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .tfd_settime = sys_timerfd_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .tfd_settime = sys_timerfd_settime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timerfd_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .tfd_settime = sys_timerfd_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .tfd_settime = sys_timerfd_settime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
-	its.type = tv->type;
+	its.type = tv->ts_type;
 
 	fd = SAFE_TIMERFD_CREATE(CLOCK_REALTIME, 0);
 
-- 
2.25.0.rc1.19.g042ed3e048af


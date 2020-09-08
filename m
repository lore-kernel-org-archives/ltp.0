From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:26 +0530
Subject: [LTP] [PATCH 13/16] syscalls: timer_gettime: Reuse struct
 time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <af2446739a820f76a71b8c0c99f0c4dedb77dcbc.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/timer_gettime/timer_gettime01.c  | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
index 02d5b416d1a2..7ac83546224c 100644
--- a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
+++ b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
@@ -12,19 +12,16 @@
 #include <stdio.h>
 #include <errno.h>
 
+#include "time64_variants.h"
 #include "tst_timer.h"
 
-static struct test_variants {
-	int (*func)(kernel_timer_t timer, void *its);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_timer_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_timer_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .timer_gettime = sys_timer_gettime, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_timer_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_timer_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .timer_gettime = sys_timer_gettime64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -50,10 +47,10 @@ static void setup(void)
 
 static void verify(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
-	struct tst_its spec = {.type = tv->type, };
+	struct time64_variants *tv = &variants[tst_variant];
+	struct tst_its spec = {.type = tv->ts_type, };
 
-	TEST(tv->func(timer, tst_its_get(&spec)));
+	TEST(tv->timer_gettime(timer, tst_its_get(&spec)));
 	if (TST_RET == 0) {
 		if (tst_its_get_interval_sec(spec) ||
 		    tst_its_get_interval_nsec(spec) ||
@@ -66,13 +63,13 @@ static void verify(void)
 		tst_res(TFAIL | TTERRNO, "timer_gettime() Failed");
 	}
 
-	TEST(tv->func((kernel_timer_t)-1, tst_its_get(&spec)));
+	TEST(tv->timer_gettime((kernel_timer_t)-1, tst_its_get(&spec)));
 	if (TST_RET == -1 && TST_ERR == EINVAL)
 		tst_res(TPASS, "timer_gettime(-1) Failed: EINVAL");
 	else
 		tst_res(TFAIL | TTERRNO, "timer_gettime(-1) = %li", TST_RET);
 
-	TEST(tv->func(timer, NULL));
+	TEST(tv->timer_gettime(timer, NULL));
 	if (TST_RET == -1 && TST_ERR == EFAULT)
 		tst_res(TPASS, "timer_gettime(NULL) Failed: EFAULT");
 	else
-- 
2.25.0.rc1.19.g042ed3e048af


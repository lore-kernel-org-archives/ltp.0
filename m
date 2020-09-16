From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 16 Sep 2020 16:07:55 +0530
Subject: [LTP] [PATCH V2 10/17] syscalls: rt_sigtimedwait: Reuse struct
 time64_variants
In-Reply-To: <cover.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <016bd26b87099af073ace4815cf3d625e9b9b3e8.1600252542.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/rt_sigtimedwait/rt_sigtimedwait01.c  | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c b/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
index db4901a40ea1..813f75b9ed82 100644
--- a/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
+++ b/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /* Copyright (c) Jiri Palecek<jpalecek@web.de>, 2009 */
 
+#include "time64_variants.h"
 #include "libsigwait.h"
 
 static int my_rt_sigtimedwait(const sigset_t * set, siginfo_t * info,
@@ -40,26 +41,22 @@ struct sigwait_test_desc tests[] = {
 	{ test_masked_matching_rt, -1},
 };
 
-static struct test_variants {
-	swi_func swi;
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_rt_sigtimedwait != __LTP__NR_INVALID_SYSCALL)
-	{ .swi = my_rt_sigtimedwait, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .sigwait = my_rt_sigtimedwait, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_rt_sigtimedwait_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .swi = my_rt_sigtimedwait_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .sigwait = my_rt_sigtimedwait_time64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void run(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct sigwait_test_desc *tc = &tests[i];
 
-	tc->tf(tv->swi, tc->signo, tv->type);
+	tc->tf(tv->sigwait, tc->signo, tv->ts_type);
 }
 
 static void setup(void)
-- 
2.25.0.rc1.19.g042ed3e048af


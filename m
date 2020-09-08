From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:18 +0530
Subject: [LTP] [PATCH 05/16] syscalls: io_pgetevents: Reuse struct
 time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <938c530af0353358609b847350cd2e184452ecbd.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/io_pgetevents/io_pgetevents01.c   | 16 ++++++----------
 .../syscalls/io_pgetevents/io_pgetevents02.c   | 18 +++++++-----------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
index adeca3f3cf79..2a1aad8d9f96 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -5,6 +5,7 @@
  * Description:
  * Basic io_pgetevents() test to receive 1 event successfully.
  */
+#include "time64_variants.h"
 #include "tst_test.h"
 #include "tst_timer.h"
 #include "lapi/io_pgetevents.h"
@@ -12,18 +13,13 @@
 #ifdef HAVE_LIBAIO
 static int fd;
 
-static struct test_variants {
-	int (*io_pgetevents)(io_context_t ctx, long min_nr, long max_nr,
-		struct io_event *events, void *timeout, sigset_t *sigmask);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_io_pgetevents != __LTP__NR_INVALID_SYSCALL)
-	{ .io_pgetevents = sys_io_pgetevents, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .io_pgetevents = sys_io_pgetevents, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_io_pgetevents_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .io_pgetevents = sys_io_pgetevents_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .io_pgetevents = sys_io_pgetevents_time64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
@@ -40,11 +36,11 @@ static void cleanup(void)
 
 static void run(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct io_event events[1];
 	struct iocb cb, *cbs[1];
 	io_context_t ctx = 0;
-	struct tst_ts to = tst_ts_from_ns(tv->type, 10000);
+	struct tst_ts to = tst_ts_from_ns(tv->ts_type, 10000);
 	sigset_t sigmask;
 	char data[4096];
 	int ret;
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
index 885722fcad09..28afdb4a02d7 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -5,6 +5,7 @@
  * Description:
  * Basic io_pgetevents() test to check various failures.
  */
+#include "time64_variants.h"
 #include "tst_test.h"
 #include "tst_timer.h"
 #include "lapi/io_pgetevents.h"
@@ -36,31 +37,26 @@ static struct tcase {
 	{"invalid sigmask", &ctx, 1, 1, events, &to, NULL, EFAULT},
 };
 
-static struct test_variants {
-	int (*io_pgetevents)(io_context_t ctx, long min_nr, long max_nr,
-		struct io_event *events, void *timeout, sigset_t *sigmask);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
+static struct time64_variants variants[] = {
 #if (__NR_io_pgetevents != __LTP__NR_INVALID_SYSCALL)
-	{ .io_pgetevents = sys_io_pgetevents, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .io_pgetevents = sys_io_pgetevents, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_io_pgetevents_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .io_pgetevents = sys_io_pgetevents_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .io_pgetevents = sys_io_pgetevents_time64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct iocb cb, *cbs[1];
 	char data[4096];
 	int ret;
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	bad_addr = tst_get_bad_addr(NULL);
-	to = tst_ts_from_ns(tv->type, 10000);
+	to = tst_ts_from_ns(tv->ts_type, 10000);
 
 	cbs[0] = &cb;
 
@@ -93,7 +89,7 @@ static void cleanup(void)
 
 static void run(unsigned int n)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
 	struct timespec *to;
 	sigset_t *sigmask;
-- 
2.25.0.rc1.19.g042ed3e048af


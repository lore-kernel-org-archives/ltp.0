From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 18 May 2020 13:44:59 +0530
Subject: [LTP] [PATCH V3 07/17] syscalls/io_pgetevents: Add support for
 time64 tests
In-Reply-To: <cover.1589789487.git.viresh.kumar@linaro.org>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
Message-ID: <afc7bf671bb6cd76d6d072706ca598ad97ada83e.1589789487.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing io_pgetevents()
syscall tests.

While at it, also pass mode to SAFE_OPEN() to avoid any errors when the
tests are run for multiple variants together.

Also get rid of an extra copy of local fd variable, which is incorrect.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/io_pgetevents.h                  | 15 ++++--
 .../syscalls/io_pgetevents/io_pgetevents01.c  | 33 +++++++++++-
 .../syscalls/io_pgetevents/io_pgetevents02.c  | 51 +++++++++++++++----
 3 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/include/lapi/io_pgetevents.h b/include/lapi/io_pgetevents.h
index 3c9d5b2d7618..5bb9a60c352a 100644
--- a/include/lapi/io_pgetevents.h
+++ b/include/lapi/io_pgetevents.h
@@ -16,15 +16,20 @@
 #ifdef HAVE_LIBAIO
 #include <libaio.h>
 
-#ifndef HAVE_IO_PGETEVENTS
-int io_pgetevents(io_context_t ctx, long min_nr, long max_nr,
-		 struct io_event *events, struct timespec *timeout,
-		 sigset_t *sigmask)
+static inline int sys_io_pgetevents(io_context_t ctx, long min_nr, long max_nr,
+		struct io_event *events, void *timeout, sigset_t *sigmask)
 {
 	return tst_syscall(__NR_io_pgetevents, ctx, min_nr, max_nr, events,
 			   timeout, sigmask);
 }
-#endif /* HAVE_IO_PGETEVENTS */
+
+static inline int sys_io_pgetevents_time64(io_context_t ctx, long min_nr, long max_nr,
+		struct io_event *events, void *timeout, sigset_t *sigmask)
+{
+	return tst_syscall(__NR_io_pgetevents_time64, ctx, min_nr, max_nr,
+			   events, timeout, sigmask);
+}
+
 #endif /* HAVE_LIBAIO */
 
 #endif /* IO_PGETEVENTS_H */
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
index e6077e47984d..fea380e52f4d 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -6,11 +6,32 @@
  * Basic io_pgetevents() test to receive 1 event successfully.
  */
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "lapi/io_pgetevents.h"
 
 #ifdef HAVE_LIBAIO
 static int fd;
 
+static struct test_variants {
+	int (*io_pgetevents)(io_context_t ctx, long min_nr, long max_nr,
+		struct io_event *events, void *timeout, sigset_t *sigmask);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_io_pgetevents != __LTP__NR_INVALID_SYSCALL)
+	{ .io_pgetevents = sys_io_pgetevents, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_io_pgetevents_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .io_pgetevents = sys_io_pgetevents_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+}
+
 static void cleanup(void)
 {
 	if (fd > 0)
@@ -19,12 +40,18 @@ static void cleanup(void)
 
 static void run(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct io_event events[1];
 	struct iocb cb, *cbs[1];
 	io_context_t ctx = 0;
+	struct tst_ts to;
 	sigset_t sigmask;
 	char data[4096];
-	int ret, fd;
+	int ret;
+
+	to.type = tv->type;
+	tst_ts_set_sec(&to, 0);
+	tst_ts_set_nsec(&to, 10000);
 
 	cbs[0] = &cb;
 	sigemptyset(&sigmask);
@@ -41,7 +68,7 @@ static void run(void)
 		tst_brk(TBROK | TERRNO, "io_submit() failed");
 
 	/* get the reply */
-	ret = io_pgetevents(ctx, 1, 1, events, NULL, &sigmask);
+	ret = tv->io_pgetevents(ctx, 1, 1, events, tst_ts_get(&to), &sigmask);
 
 	if (ret == 1)
 		tst_res(TPASS, "io_pgetevents() works as expected");
@@ -55,8 +82,10 @@ static void run(void)
 static struct tst_test test = {
 	.min_kver = "4.18",
 	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
 	.needs_tmpdir = 1,
 	.cleanup = cleanup,
+	.setup = setup,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
index 62a8afba3bf1..a15b3d0dda92 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -6,6 +6,7 @@
  * Basic io_pgetevents() test to check various failures.
  */
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "lapi/io_pgetevents.h"
 
 #ifdef HAVE_LIBAIO
@@ -14,30 +15,55 @@ static struct io_event events[1];
 static io_context_t ctx, invalid_ctx = 0;
 static int fd, ctx_initialized;
 
+static struct tst_ts to;
+static void *bad_addr;
+
 static struct tcase {
 	char *name;
 	io_context_t *ctx;
 	long min_nr;
 	long max_nr;
 	struct io_event *events;
-	struct timespec *timeout;
+	struct tst_ts *timeout;
 	sigset_t *sigmask;
 	int exp_errno;
 } tcases[] = {
-	{"invalid ctx", &invalid_ctx, 1, 1, events, NULL, &sigmask, EINVAL},
-	{"invalid min_nr", &ctx, -1, 1, events, NULL, &sigmask, EINVAL},
-	{"invalid max_nr", &ctx, 1, -1, events, NULL, &sigmask, EINVAL},
-	{"invalid events", &ctx, 1, 1, NULL, NULL, &sigmask, EFAULT},
-	{"invalid timeout", &ctx, 1, 1, events, (void *)(0xDEAD), &sigmask, EFAULT},
-	{"invalid sigmask", &ctx, 1, 1, events, NULL, (void *)(0xDEAD), EFAULT},
+	{"invalid ctx", &invalid_ctx, 1, 1, events, &to, &sigmask, EINVAL},
+	{"invalid min_nr", &ctx, -1, 1, events, &to, &sigmask, EINVAL},
+	{"invalid max_nr", &ctx, 1, -1, events, &to, &sigmask, EINVAL},
+	{"invalid events", &ctx, 1, 1, NULL, &to, &sigmask, EFAULT},
+	{"invalid timeout", &ctx, 1, 1, events, NULL, &sigmask, EFAULT},
+	{"invalid sigmask", &ctx, 1, 1, events, &to, NULL, EFAULT},
+};
+
+static struct test_variants {
+	int (*io_pgetevents)(io_context_t ctx, long min_nr, long max_nr,
+		struct io_event *events, void *timeout, sigset_t *sigmask);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_io_pgetevents != __LTP__NR_INVALID_SYSCALL)
+	{ .io_pgetevents = sys_io_pgetevents, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_io_pgetevents_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .io_pgetevents = sys_io_pgetevents_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
 };
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct iocb cb, *cbs[1];
 	char data[4096];
 	int ret;
 
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	bad_addr = tst_get_bad_addr(NULL);
+	to.type = tv->type;
+	tst_ts_set_sec(&to, 0);
+	tst_ts_set_nsec(&to, 10000);
+
 	cbs[0] = &cb;
 
 	sigemptyset(&sigmask);
@@ -69,10 +95,16 @@ static void cleanup(void)
 
 static void run(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
+	struct timespec *to;
+	sigset_t *sigmask;
+
+	sigmask = tc->sigmask ? tc->sigmask : bad_addr;
+	to = tc->timeout ? tc->timeout : bad_addr;
 
-	TEST(io_pgetevents(*tc->ctx, tc->min_nr, tc->max_nr, tc->events,
-			   tc->timeout, tc->sigmask));
+	TEST(tv->io_pgetevents(*tc->ctx, tc->min_nr, tc->max_nr, tc->events, to,
+			       sigmask));
 
 	if (TST_RET == 1) {
 		tst_res(TFAIL, "%s: io_pgetevents() passed unexpectedly",
@@ -95,6 +127,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 };
-- 
2.25.0.rc1.19.g042ed3e048af


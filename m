From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed,  5 Aug 2020 20:01:53 +0530
Subject: [LTP] [PATCH V8 2/2] syscalls/utimensat: Add support for time64
 tests
In-Reply-To: <ebc888947b095fd6a359ad749e50217d0b38954e.1596637728.git.viresh.kumar@linaro.org>
References: <ebc888947b095fd6a359ad749e50217d0b38954e.1596637728.git.viresh.kumar@linaro.org>
Message-ID: <eed1e927d5502e99cb702f66e63649decfbad903.1596637728.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing utimensat() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V8: Resolved rebase conflicts

 testcases/kernel/syscalls/utimensat/utimensat01.c | 71 +++++++++++++++++++----
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 6e14e1f150db..fbdc6a1ce1ed 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -16,8 +16,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include "lapi/fs.h"
-#include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "tst_timer.h"
 
 #define UTIME_NOW	((1l << 30) - 1l)
 #define UTIME_OMIT	((1l << 30) - 2l)
@@ -100,13 +99,67 @@ struct test_case {
 };
 
 static inline int sys_utimensat(int dirfd, const char *pathname,
-				const struct timespec times[2], int flags)
+				void *times, int flags)
 {
 	return tst_syscall(__NR_utimensat, dirfd, pathname, times, flags);
 }
 
+static inline int sys_utimensat_time64(int dirfd, const char *pathname,
+				       void *times, int flags)
+{
+	return tst_syscall(__NR_utimensat_time64, dirfd, pathname, times, flags);
+}
+
+static struct test_variants {
+	int (*utimensat)(int dirfd, const char *pathname, void *times,
+			 int flags);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if (__NR_utimensat != __LTP__NR_INVALID_SYSCALL)
+	{ .utimensat = sys_utimensat, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_utimensat_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .utimensat = sys_utimensat_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+union tst_multi {
+	struct timespec libc_ts[2];
+	struct __kernel_old_timespec kern_old_ts[2];
+	struct __kernel_timespec kern_ts[2];
+} ts;
+
+static void tst_multi_set_time(enum tst_ts_type type, struct mytime *mytime)
+{
+	switch (type) {
+	case TST_LIBC_TIMESPEC:
+		ts.libc_ts[0].tv_sec = mytime->access_tv_sec;
+		ts.libc_ts[0].tv_nsec = mytime->access_tv_nsec;
+		ts.libc_ts[1].tv_sec = mytime->mod_tv_sec;
+		ts.libc_ts[1].tv_nsec = mytime->mod_tv_nsec;
+		break;
+	case TST_KERN_OLD_TIMESPEC:
+		ts.kern_old_ts[0].tv_sec = mytime->access_tv_sec;
+		ts.kern_old_ts[0].tv_nsec = mytime->access_tv_nsec;
+		ts.kern_old_ts[1].tv_sec = mytime->mod_tv_sec;
+		ts.kern_old_ts[1].tv_nsec = mytime->mod_tv_nsec;
+		break;
+	case TST_KERN_TIMESPEC:
+		ts.kern_ts[0].tv_sec = mytime->access_tv_sec;
+		ts.kern_ts[0].tv_nsec = mytime->access_tv_nsec;
+		ts.kern_ts[1].tv_sec = mytime->mod_tv_sec;
+		ts.kern_ts[1].tv_nsec = mytime->mod_tv_nsec;
+		break;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", type);
+	}
+}
+
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	bad_addr = tst_get_bad_addr(NULL);
 	SAFE_MKDIR(TEST_DIR, 0700);
 }
@@ -165,8 +218,8 @@ static void reset_time(char *pathname, int dfd, int flags)
 
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	struct timespec ts[2];
 	void *tsp = NULL;
 	char *pathname = NULL;
 	int dfd = AT_FDCWD, fd = 0, atime_change, mtime_change;
@@ -179,11 +232,8 @@ static void run(unsigned int i)
 		dfd = SAFE_OPEN(TEST_DIR, tc->oflags);
 
 	if (mytime) {
-		ts[0].tv_sec = mytime->access_tv_sec;
-		ts[0].tv_nsec = mytime->access_tv_nsec;
-		ts[1].tv_sec = mytime->mod_tv_sec;
-		ts[1].tv_nsec = mytime->mod_tv_nsec;
-		tsp = ts;
+		tst_multi_set_time(tv->type, mytime);
+		tsp = &ts.libc_ts;
 	} else if (tc->exp_err == EFAULT) {
 		tsp = bad_addr;
 	}
@@ -198,7 +248,7 @@ static void run(unsigned int i)
 		pathname = bad_addr;
 	}
 
-	TEST(sys_utimensat(dfd, pathname, tsp, tc->flags));
+	TEST(tv->utimensat(dfd, pathname, tsp, tc->flags));
 	if (tc->pathname)
 		change_attr(tc, fd, 0);
 
@@ -241,6 +291,7 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcase),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-- 
2.14.1


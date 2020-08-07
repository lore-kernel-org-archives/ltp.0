From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  7 Aug 2020 16:54:29 +0530
Subject: [LTP] [PATCH V9 2/2] syscalls/utimensat: Add support for time64
 tests
In-Reply-To: <af2744945213682a2e378a275bd73ad174e2896a.1596799223.git.viresh.kumar@linaro.org>
References: <af2744945213682a2e378a275bd73ad174e2896a.1596799223.git.viresh.kumar@linaro.org>
Message-ID: <fdd9bf7a6f362ffd665064a243495e6a73f87c96.1596799223.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing utimensat() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/utimensat/utimensat01.c | 74 +++++++++++++++++++----
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 617565e52676..d5b9954505a2 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -99,13 +99,67 @@ struct test_case {
 };
 
 static inline int sys_utimensat(int dirfd, const char *pathname,
-			const struct __kernel_old_timespec times[2], int flags)
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
@@ -146,11 +200,11 @@ static void change_attr(struct test_case *tc, int fd, int set)
 
 static void reset_time(char *pathname, int dfd, int flags, int i)
 {
-	struct __kernel_old_timespec ts[2];
+	struct test_variants *tv = &variants[tst_variant];
 	struct stat sb;
 
-	memset(ts, 0, sizeof(ts));
-	sys_utimensat(dfd, pathname, ts, flags);
+	memset(&ts, 0, sizeof(ts));
+	tv->utimensat(dfd, pathname, &ts, flags);
 
 	TEST(stat(pathname, &sb));
 	if (TST_RET) {
@@ -163,8 +217,8 @@ static void reset_time(char *pathname, int dfd, int flags, int i)
 
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	struct __kernel_old_timespec ts[2];
 	int dfd = AT_FDCWD, fd = 0, atime_change, mtime_change;
 	struct mytime *mytime = tc->mytime;
 	char *pathname = NULL;
@@ -187,16 +241,13 @@ static void run(unsigned int i)
 	}
 
 	if (mytime) {
-		ts[0].tv_sec = mytime->access_tv_sec;
-		ts[0].tv_nsec = mytime->access_tv_nsec;
-		ts[1].tv_sec = mytime->mod_tv_sec;
-		ts[1].tv_nsec = mytime->mod_tv_nsec;
-		tsp = ts;
+		tst_multi_set_time(tv->type, mytime);
+		tsp = &ts;
 	} else if (tc->exp_err == EFAULT) {
 		tsp = bad_addr;
 	}
 
-	TEST(sys_utimensat(dfd, pathname, tsp, tc->flags));
+	TEST(tv->utimensat(dfd, pathname, tsp, tc->flags));
 	if (tc->pathname)
 		change_attr(tc, fd, 0);
 
@@ -245,6 +296,7 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcase),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-- 
2.14.1


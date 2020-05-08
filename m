From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  8 May 2020 09:54:02 +0530
Subject: [LTP] [PATCH V2 17/17] syscalls/utimensat: Add support for time64
 tests
In-Reply-To: <cover.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <02701de2ad65c3980e3d9136d0579af24d09c32e.1588911607.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing utimensat() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/utimensat/utimensat01.c   | 80 ++++++++++++++++---
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 2a029ecb17e9..f29cfe5009eb 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -15,8 +15,8 @@
 #include <fcntl.h>
 #include <string.h>
 #include <sys/stat.h>
-#include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "tst_timer.h"
+#include "lapi/abisize.h"
 
 #define UTIME_NOW	((1l << 30) - 1l)
 #define UTIME_OMIT	((1l << 30) - 2l)
@@ -98,13 +98,73 @@ struct test_case {
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
+#if defined(TST_ABI32)
+	{ .utimensat = sys_utimensat, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .utimensat = sys_utimensat, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .utimensat = sys_utimensat, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_utimensat_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .utimensat = sys_utimensat_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+union tst_multi {
+	struct timespec libc_ts[2];
+	struct __kernel_old_timespec kern_old_ts[2];
+	struct __kernel_timespec kern_ts[2];
+} ts;
+
+static void tst_multi_set_time(enum tst_ts_type type, long access_tv_sec,
+			long access_tv_nsec, long mod_tv_sec, long mod_tv_nsec)
+{
+	switch (type) {
+	case TST_LIBC_TIMESPEC:
+		ts.libc_ts[0].tv_sec = access_tv_sec;
+		ts.libc_ts[0].tv_nsec = access_tv_nsec;
+		ts.libc_ts[1].tv_sec = mod_tv_sec;
+		ts.libc_ts[1].tv_nsec = mod_tv_nsec;
+		break;
+	case TST_KERN_OLD_TIMESPEC:
+		ts.kern_old_ts[0].tv_sec = access_tv_sec;
+		ts.kern_old_ts[0].tv_nsec = access_tv_nsec;
+		ts.kern_old_ts[1].tv_sec = mod_tv_sec;
+		ts.kern_old_ts[1].tv_nsec = mod_tv_nsec;
+		break;
+	case TST_KERN_TIMESPEC:
+		ts.kern_ts[0].tv_sec = access_tv_sec;
+		ts.kern_ts[0].tv_nsec = access_tv_nsec;
+		ts.kern_ts[1].tv_sec = mod_tv_sec;
+		ts.kern_ts[1].tv_nsec = mod_tv_nsec;
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
 }
 
@@ -134,8 +194,8 @@ static int run_command(char *command, char *option, char *file)
 
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	struct timespec ts[2];
 	void *tsp = NULL;
 	char *pathname = NULL;
 	int fd = AT_FDCWD;
@@ -151,11 +211,10 @@ static void run(unsigned int i)
 	if (tc->mytime) {
 		struct mytime *mytime = *tc->mytime;
 
-		ts[0].tv_sec = mytime->access_tv_sec;
-		ts[0].tv_nsec = mytime->access_tv_nsec;
-		ts[1].tv_sec = mytime->mod_tv_sec;
-		ts[1].tv_nsec = mytime->mod_tv_nsec;
-		tsp = ts;
+		tst_multi_set_time(tv->type, mytime->access_tv_sec,
+				   mytime->access_tv_nsec, mytime->mod_tv_sec,
+				   mytime->mod_tv_nsec);
+		tsp = &ts.libc_ts;
 	} else if (tc->exp_err == EFAULT) {
 		tsp = bad_addr;
 	}
@@ -169,7 +228,7 @@ static void run(unsigned int i)
 		pathname = bad_addr;
 	}
 
-	TEST(sys_utimensat(fd, pathname, tsp, tc->flags));
+	TEST(tv->utimensat(fd, pathname, tsp, tc->flags));
 	if (TST_RET) {
 		if (!tc->exp_err) {
 			tst_res(TFAIL | TTERRNO, "%2d: utimensat() failed", i);
@@ -199,6 +258,7 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcase),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-- 
2.25.0.rc1.19.g042ed3e048af


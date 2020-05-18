From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 18 May 2020 13:45:09 +0530
Subject: [LTP] [PATCH V3 17/17] syscalls/utimensat: Add support for time64
 tests
In-Reply-To: <cover.1589789487.git.viresh.kumar@linaro.org>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
Message-ID: <14f4cba342914bfba88bf0413b593965f9feff50.1589789487.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing utimensat() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |  2 +-
 testcases/kernel/syscalls/utimensat/Makefile  |  4 -
 .../kernel/syscalls/utimensat/utimensat01.c   | 74 ++++++++++++++++---
 3 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 4a19075cd131..e1271f9e34aa 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1600,7 +1600,7 @@ utime06 utime06
 utimes01 utimes01
 
 # Introduced from Kernel 2.6.22 onwards
-utimensat01 utimensat_tests.sh
+utimensat01 utimensat01
 
 vfork01 vfork01
 vfork02 vfork02
diff --git a/testcases/kernel/syscalls/utimensat/Makefile b/testcases/kernel/syscalls/utimensat/Makefile
index 69cab8dbc057..044619fb8724 100644
--- a/testcases/kernel/syscalls/utimensat/Makefile
+++ b/testcases/kernel/syscalls/utimensat/Makefile
@@ -5,8 +5,4 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-vpath %.c $(srcdir):$(top_srcdir)/lib
-
-INSTALL_TARGETS		:= utimensat_tests.sh
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 97a43713454f..0139d6ddfedf 100644
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
@@ -98,13 +97,68 @@ struct test_case {
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
 
@@ -144,8 +198,8 @@ static void change_attr(struct test_case *tc, int fd, int set)
 
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	struct timespec ts[2];
 	void *tsp = NULL;
 	char *pathname = NULL;
 	int dfd = AT_FDCWD, fd = 0;
@@ -160,11 +214,10 @@ static void run(unsigned int i)
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
@@ -178,7 +231,7 @@ static void run(unsigned int i)
 		pathname = bad_addr;
 	}
 
-	TEST(sys_utimensat(dfd, pathname, tsp, tc->flags));
+	TEST(tv->utimensat(dfd, pathname, tsp, tc->flags));
 	if (tc->pathname)
 		change_attr(tc, fd, 0);
 
@@ -210,6 +263,7 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcase),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-- 
2.25.0.rc1.19.g042ed3e048af


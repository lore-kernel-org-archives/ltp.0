From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  5 May 2020 14:42:08 +0530
Subject: [LTP] [PATCH 8/8] syscalls/ppoll: Add support for time64 tests
In-Reply-To: <7e037dacaeb0c7f3bfd73cd11d80f3e1567dc052.1588669892.git.viresh.kumar@linaro.org>
References: <7e037dacaeb0c7f3bfd73cd11d80f3e1567dc052.1588669892.git.viresh.kumar@linaro.org>
Message-ID: <3e96a3fa8df22b49edabdbce30ac72e744d6c1d4.1588669892.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing ppoll() syscall
tests.

Note that the O_EXCL flag is removed from SAFE_OPEN() calls as it made
the tests failed when run for the second variant as the file existed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/ppoll/ppoll01.c | 76 ++++++++++++++++++-----
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 2fadd0653948..eb8a14534e2e 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -21,6 +21,8 @@
 #include "ltp_signal.h"
 #include "tst_sig_proc.h"
 #include "tst_test.h"
+#include "tst_timer.h"
+#include "lapi/abisize.h"
 
 /* Older versions of glibc don't publish this constant's value. */
 #ifndef POLLRDHUP
@@ -38,7 +40,7 @@ struct test_case {
 	unsigned int nfds;	   /* nfds ppoll parameter */
 	sigset_t *sigmask;	   /* sigmask ppoll parameter */
 	sigset_t *sigmask_cur;	   /* sigmask set for current process */
-	struct timespec *ts;	   /* ts ppoll parameter */
+	struct tst_ts *ts;	   /* ts ppoll parameter */
 	struct pollfd *fds;	   /* fds ppoll parameter */
 	int sigint_count;	   /* if > 0, spawn process to send SIGINT */
 				   /* 'count' times to current process */
@@ -60,14 +62,7 @@ static int fd1 = -1;
 static sigset_t sigmask_empty, sigmask_sigint;
 static struct pollfd fds_good[1], fds_already_closed[1];
 
-static struct timespec ts_short = {
-	.tv_sec = 0,
-	.tv_nsec = 200000000,
-};
-static struct timespec ts_long = {
-	.tv_sec = 2,
-	.tv_nsec = 0,
-};
+static struct tst_ts ts_short, ts_long;
 
 /* Test cases
  *
@@ -160,14 +155,57 @@ static struct test_case tcase[] = {
 	},
 };
 
+static inline int libc_ppoll(struct pollfd *fds, nfds_t nfds, void *tmo_p,
+			     const sigset_t *sigmask, size_t sigsetsize)
+{
+	return ppoll(fds, nfds, tmo_p, sigmask);
+}
+
+static inline int sys_ppoll(struct pollfd *fds, nfds_t nfds, void *tmo_p,
+			    const sigset_t *sigmask, size_t sigsetsize)
+{
+	return tst_syscall(__NR_ppoll, fds, nfds, tmo_p, sigmask, sigsetsize);
+}
+
+static inline int sys_ppoll_time64(struct pollfd *fds, nfds_t nfds, void *tmo_p,
+				   const sigset_t *sigmask, size_t sigsetsize)
+{
+	return tst_syscall(__NR_ppoll_time64, fds, nfds, tmo_p, sigmask,
+			   sigsetsize);
+}
+
+static struct test_variants {
+	int (*ppoll)(struct pollfd *fds, nfds_t nfds, void *tmo_p,
+		     const sigset_t *sigmask, size_t sigsetsize);
+
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .ppoll = libc_ppoll, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .ppoll = sys_ppoll, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .ppoll = sys_ppoll, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .ppoll = sys_ppoll, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_ppoll_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .ppoll = sys_ppoll_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
 static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 }
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int fd2;
 
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	SAFE_SIGNAL(SIGINT, sighandler);
 
 	if (sigemptyset(&sigmask_empty) == -1)
@@ -177,18 +215,22 @@ static void setup(void)
 	if (sigaddset(&sigmask_sigint, SIGINT) == -1)
 		tst_brk(TBROK | TERRNO, "sigaddset");
 
-	fd1 = SAFE_OPEN("testfile1", O_CREAT | O_EXCL | O_RDWR,
-		S_IRUSR | S_IWUSR);
+	fd1 = SAFE_OPEN("testfile1", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
 	fds_good[0].fd = fd1;
 	fds_good[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
 	fds_good[0].revents = 0;
 
-	fd2 = SAFE_OPEN("testfile2", O_CREAT | O_EXCL | O_RDWR,
-		S_IRUSR | S_IWUSR);
+	fd2 = SAFE_OPEN("testfile2", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
 	fds_already_closed[0].fd = fd2;
 	fds_already_closed[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
 	fds_already_closed[0].revents = 0;
 	SAFE_CLOSE(fd2);
+
+	ts_short.type = ts_long.type = tv->type;
+	tst_ts_set_sec(&ts_short, 0);
+	tst_ts_set_nsec(&ts_short, 200000000);
+	tst_ts_set_sec(&ts_long, 2);
+	tst_ts_set_nsec(&ts_long, 0);
 }
 
 static void cleanup(void)
@@ -199,10 +241,11 @@ static void cleanup(void)
 
 static void do_test(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	pid_t pid = 0;
 	int sys_ret, sys_errno = 0, dummy;
 	struct test_case *tc = &tcase[i];
-	struct timespec ts, *tsp = NULL;
+	struct tst_ts ts, *tsp = NULL;
 
 	if (tc->ts) {
 		memcpy(&ts, tc->ts, sizeof(ts));
@@ -223,8 +266,8 @@ static void do_test(unsigned int i)
 
 	/* test */
 	errno = 0;
-	sys_ret = tst_syscall(__NR_ppoll, tc->fds, tc->nfds, tsp,
-		tc->sigmask, SIGSETSIZE);
+	sys_ret = tv->ppoll(tc->fds, tc->nfds, tst_ts_get(tsp), tc->sigmask,
+			    SIGSETSIZE);
 	sys_errno = errno;
 
 	/* cleanup */
@@ -261,6 +304,7 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
-- 
2.25.0.rc1.19.g042ed3e048af


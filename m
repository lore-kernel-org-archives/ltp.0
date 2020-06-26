From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 26 Jun 2020 11:52:23 +0530
Subject: [LTP] [PATCH V7 10/19] syscalls/rt_sigtimedwait: Add support for
 time64 tests
In-Reply-To: <cover.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <f4afe366039ddd138377666ee56139b22329c19c.1593152309.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing rt_sigtimedwait()
syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/sigwaitinfo/sigwaitinfo01.c      | 112 +++++++++++++-----
 1 file changed, 80 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 1b976a271d28..05e62999ca6c 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -2,6 +2,7 @@
 /* Copyright (c) Jiri Palecek<jpalecek@web.de>, 2009 */
 
 #include "tst_test.h"
+#include "tst_timer.h"
 #include <errno.h>
 #include <stdlib.h>
 #include <signal.h>
@@ -54,12 +55,12 @@ static void empty_handler(int sig)
 }
 
 typedef int (*swi_func) (const sigset_t * set, siginfo_t * info,
-			 struct timespec * timeout);
-typedef void (*test_func) (swi_func, int);
+			 void * timeout);
+typedef void (*test_func) (swi_func, int, enum tst_ts_type type);
 
 #ifdef TEST_SIGWAIT
 static int my_sigwait(const sigset_t * set, siginfo_t * info,
-		      struct timespec *timeout)
+		      void *timeout)
 {
 	int ret;
 	int err = sigwait(set, &ret);
@@ -73,7 +74,7 @@ static int my_sigwait(const sigset_t * set, siginfo_t * info,
 
 #ifdef TEST_SIGWAITINFO
 static int my_sigwaitinfo(const sigset_t * set, siginfo_t * info,
-			  struct timespec *timeout)
+			  void *timeout)
 {
 	return sigwaitinfo(set, info);
 }
@@ -81,7 +82,7 @@ static int my_sigwaitinfo(const sigset_t * set, siginfo_t * info,
 
 #ifdef TEST_SIGTIMEDWAIT
 static int my_sigtimedwait(const sigset_t * set, siginfo_t * info,
-			   struct timespec *timeout)
+			   void *timeout)
 {
 	return sigtimedwait(set, info, timeout);
 }
@@ -89,14 +90,23 @@ static int my_sigtimedwait(const sigset_t * set, siginfo_t * info,
 
 #ifdef TEST_RT_SIGTIMEDWAIT
 static int my_rt_sigtimedwait(const sigset_t * set, siginfo_t * info,
-			      struct timespec *timeout)
+			      void *timeout)
 {
 	/* _NSIG is always the right number of bits of signal map for all arches */
 	return tst_syscall(__NR_rt_sigtimedwait, set, info, timeout, _NSIG/8);
 }
+
+#if (__NR_rt_sigtimedwait_time64 != __LTP__NR_INVALID_SYSCALL)
+static int my_rt_sigtimedwait_time64(const sigset_t * set, siginfo_t * info,
+				     void *timeout)
+{
+	/* _NSIG is always the right number of bits of signal map for all arches */
+	return tst_syscall(__NR_rt_sigtimedwait_time64, set, info, timeout, _NSIG/8);
+}
+#endif
 #endif
 
-void test_empty_set(swi_func sigwaitinfo, int signo)
+void test_empty_set(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 {
 	sigset_t sigs;
 	siginfo_t si;
@@ -113,19 +123,23 @@ void test_empty_set(swi_func sigwaitinfo, int signo)
 	SAFE_WAIT(NULL);
 }
 
-void test_timeout(swi_func sigwaitinfo, int signo)
+void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 {
 	sigset_t sigs;
 	siginfo_t si;
 	pid_t child;
-	struct timespec ts = {.tv_sec = 1 };
+	struct tst_ts ts;
+
+	ts.type = type;
+	tst_ts_set_sec(&ts, 1);
+	tst_ts_set_nsec(&ts, 0);
 
 	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
 
-	TEST(sigwaitinfo(&sigs, &si, &ts));
+	TEST(sigwaitinfo(&sigs, &si, tst_ts_get(&ts)));
 	REPORT_SUCCESS(-1, EAGAIN);
 
 	SAFE_KILL(child, SIGTERM);
@@ -135,7 +149,8 @@ void test_timeout(swi_func sigwaitinfo, int signo)
 /* Note: sigwait-ing for a signal that is not blocked is unspecified
  * by POSIX; but works for non-ignored signals under Linux
  */
-void test_unmasked_matching(swi_func sigwaitinfo, int signo)
+void test_unmasked_matching(swi_func sigwaitinfo, int signo,
+			    enum tst_ts_type type)
 {
 	sigset_t sigs;
 	siginfo_t si;
@@ -156,7 +171,8 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo)
 	SAFE_WAIT(NULL);
 }
 
-void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo)
+void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
+				   enum tst_ts_type type)
 {
 	sigset_t sigs;
 	pid_t child;
@@ -173,7 +189,8 @@ void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo)
 	SAFE_WAIT(NULL);
 }
 
-void test_masked_matching(swi_func sigwaitinfo, int signo)
+void test_masked_matching(swi_func sigwaitinfo, int signo,
+			  enum tst_ts_type type)
 {
 	sigset_t sigs, oldmask;
 	siginfo_t si;
@@ -211,7 +228,8 @@ void test_masked_matching(swi_func sigwaitinfo, int signo)
 	SAFE_WAIT(NULL);
 }
 
-void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
+void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
+			     enum tst_ts_type type)
 {
 	sigset_t sigs, oldmask;
 	siginfo_t si;
@@ -262,7 +280,8 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 			 "sigwaitinfo failed to restore the original mask");
 }
 
-void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo)
+void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
+				 enum tst_ts_type type)
 {
 	sigset_t sigs, oldmask;
 	pid_t child;
@@ -297,7 +316,7 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo)
 	SAFE_WAIT(NULL);
 }
 
-void test_bad_address(swi_func sigwaitinfo, int signo)
+void test_bad_address(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 {
 	sigset_t sigs, oldmask;
 	pid_t child;
@@ -326,7 +345,7 @@ void test_bad_address(swi_func sigwaitinfo, int signo)
 	SAFE_WAIT(NULL);
 }
 
-void test_bad_address2(swi_func sigwaitinfo, int signo)
+void test_bad_address2(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 {
 	pid_t pid;
 	int status;
@@ -372,7 +391,7 @@ void test_bad_address2(swi_func sigwaitinfo, int signo)
 	}
 }
 
-void test_bad_address3(swi_func sigwaitinfo, int signo)
+void test_bad_address3(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 {
 	sigset_t sigs;
 	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
@@ -388,28 +407,28 @@ struct test_desc {
 } tests[] = {
 #ifdef TEST_RT_SIGTIMEDWAIT
 	{
-	test_empty_set, my_rt_sigtimedwait, SIGUSR1}, {
-	test_unmasked_matching, my_rt_sigtimedwait, SIGUSR1}, {
-	test_masked_matching, my_rt_sigtimedwait, SIGUSR1}, {
-	test_unmasked_matching_noinfo, my_rt_sigtimedwait, SIGUSR1}, {
-	test_masked_matching_noinfo, my_rt_sigtimedwait, SIGUSR1}, {
-	test_bad_address, my_rt_sigtimedwait, SIGUSR1}, {
-	test_bad_address2, my_rt_sigtimedwait, SIGUSR1}, {
-	test_bad_address3, my_rt_sigtimedwait, SIGUSR1}, {
-	test_timeout, my_rt_sigtimedwait, 0},
+	test_empty_set, NULL, SIGUSR1}, {
+	test_unmasked_matching, NULL, SIGUSR1}, {
+	test_masked_matching, NULL, SIGUSR1}, {
+	test_unmasked_matching_noinfo, NULL, SIGUSR1}, {
+	test_masked_matching_noinfo, NULL, SIGUSR1}, {
+	test_bad_address, NULL, SIGUSR1}, {
+	test_bad_address2, NULL, SIGUSR1}, {
+	test_bad_address3, NULL, SIGUSR1}, {
+	test_timeout, NULL, 0},
 	    /* Special cases */
 	    /* 1: sigwaitinfo does respond to ignored signal */
 	{
-	test_masked_matching, my_rt_sigtimedwait, SIGUSR2},
+	test_masked_matching, NULL, SIGUSR2},
 	    /* 2: An ignored signal doesn't cause sigwaitinfo to return EINTR */
 	{
-	test_timeout, my_rt_sigtimedwait, SIGUSR2},
+	test_timeout, NULL, SIGUSR2},
 	    /* 3: The handler is not called when the signal is waited for by sigwaitinfo */
 	{
-	test_masked_matching, my_rt_sigtimedwait, SIGTERM},
+	test_masked_matching, NULL, SIGTERM},
 	    /* 4: Simultaneous realtime signals are delivered in the order of increasing signal number */
 	{
-	test_masked_matching_rt, my_rt_sigtimedwait, -1},
+	test_masked_matching_rt, NULL, -1},
 #endif
 #if defined TEST_SIGWAIT
 	{
@@ -440,15 +459,43 @@ struct test_desc {
 #endif
 };
 
+static struct test_variants {
+	swi_func swi;
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#ifdef TEST_RT_SIGTIMEDWAIT
+
+#if (__NR_rt_sigtimedwait != __LTP__NR_INVALID_SYSCALL)
+	{ .swi = my_rt_sigtimedwait, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_rt_sigtimedwait_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .swi = my_rt_sigtimedwait_time64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+
+#else /* !TEST_RT_SIGTIMEDWAIT */
+
+	{ .swi = NULL, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+
+#endif /* TEST_RT_SIGTIMEDWAIT */
+};
+
 static void run(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct test_desc *tc = &tests[i];
+	swi_func swi;
 
-	tc->tf(tc->swi, tc->signo);
+	swi = tv->swi ? tv->swi : tc->swi;
+
+	tc->tf(swi, tc->signo, tv->type);
 }
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+
 	signal(SIGUSR1, empty_handler);
 	signal(SIGALRM, empty_handler);
 	signal(SIGUSR2, SIG_IGN);
@@ -464,6 +511,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test= run,
 	.tcnt = ARRAY_SIZE(tests),
+	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
-- 
2.25.0.rc1.19.g042ed3e048af


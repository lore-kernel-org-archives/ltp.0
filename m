From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 26 Jun 2020 11:52:22 +0530
Subject: [LTP] [PATCH V7 09/19] syscalls/sigwaitinfo: Migrate to new test
 framework
In-Reply-To: <cover.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <18d8603306f51f243faca04cf63bcaf2c7168d56.1593152309.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This migrates the sigwaitinfo tests to use the new test framework.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/sigwaitinfo/sigwaitinfo01.c      | 209 +++++++-----------
 1 file changed, 84 insertions(+), 125 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 6a30c27f6f2f..1b976a271d28 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -1,93 +1,58 @@
-/*
- * Copyright (c) Jiri Palecek<jpalecek@web.de>, 2009
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-#include "test.h"
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Jiri Palecek<jpalecek@web.de>, 2009 */
+
+#include "tst_test.h"
 #include <errno.h>
+#include <stdlib.h>
 #include <signal.h>
-#include "../utils/include_j_h.h"
-#include "../utils/common_j_h.c"
 #include <limits.h>
 #include "lapi/syscalls.h"
+#include "tst_sig_proc.h"
 
 #define SUCCEED_OR_DIE(syscall, message, ...)				 \
 	(errno = 0,							 \
 		({int ret=syscall(__VA_ARGS__);				 \
 			if (ret==-1)					 \
-				tst_brkm(TBROK|TERRNO, cleanup, message);\
+				tst_brk(TBROK|TERRNO, message);\
 			ret;}))
 
-/* Report success iff TEST_RETURN and TEST_ERRNO are equal to
+/* Report success iff TST_RET and TST_ERR are equal to
 	 exp_return and exp_errno, resp., and cond is true. If cond is not
 	 true, report condition_errmsg
 */
-static void report_success_cond(const char *func, const char *file, int line,
+static void report_success_cond(const char *func, int line,
 				long exp_return, int exp_errno, int condition,
 				char *condition_errmsg)
 {
-	if (exp_return == TEST_RETURN
-	    && (exp_return != -1 || exp_errno == TEST_ERRNO))
+	if (exp_return == TST_RET
+	    && (exp_return != -1 || exp_errno == TST_ERR))
 		if (condition)
-			tst_resm(TPASS, "Test passed");
+			tst_res(TPASS, "%s (%d): Test passed", func, line);
 		else
-			tst_resm(TFAIL, "%s (%s: %d): %s", func, file, line,
+			tst_res(TFAIL, "%s (%d): %s", func, line,
 				 condition_errmsg);
-	else if (TEST_RETURN != -1)
-		tst_resm(TFAIL,
-			 "%s (%s: %d): Unexpected return value; expected %ld, got %ld",
-			 func, file, line, exp_return, TEST_RETURN);
+	else if (TST_RET != -1)
+		tst_res(TFAIL,
+			 "%s (%d): Unexpected return value; expected %ld, got %ld",
+			 func, line, exp_return, TST_RET);
 	else
-		tst_resm(TFAIL | TTERRNO, "%s (%s: %d): Unexpected failure",
-			 func, file, line);
+		tst_res(TFAIL | TTERRNO, "%s (%d): Unexpected failure",
+			 func, line);
 }
 
 #define REPORT_SUCCESS_COND(exp_return, exp_errno, condition, condition_errmsg)	\
-	report_success_cond(__FUNCTION__, __FILE__, __LINE__, exp_return, exp_errno, condition, condition_errmsg);
+	report_success_cond(__FUNCTION__, __LINE__, exp_return, exp_errno, condition, condition_errmsg);
 
-/* Report success iff TEST_RETURN and TEST_ERRNO are equal to
+/* Report success iff TST_RET and TST_ERR are equal to
 	 exp_return and exp_errno, resp.
 */
 #define REPORT_SUCCESS(exp_return, exp_errno)					\
 	REPORT_SUCCESS_COND(exp_return, exp_errno, 1, "");
 
-static void cleanup(void);
-
 static void empty_handler(int sig)
 {
 }
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	signal(SIGUSR1, empty_handler);
-	signal(SIGALRM, empty_handler);
-	signal(SIGUSR2, SIG_IGN);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
-
 typedef int (*swi_func) (const sigset_t * set, siginfo_t * info,
 			 struct timespec * timeout);
 typedef void (*test_func) (swi_func, int);
@@ -110,7 +75,6 @@ static int my_sigwait(const sigset_t * set, siginfo_t * info,
 static int my_sigwaitinfo(const sigset_t * set, siginfo_t * info,
 			  struct timespec *timeout)
 {
-
 	return sigwaitinfo(set, info);
 }
 #endif
@@ -119,7 +83,6 @@ static int my_sigwaitinfo(const sigset_t * set, siginfo_t * info,
 static int my_sigtimedwait(const sigset_t * set, siginfo_t * info,
 			   struct timespec *timeout)
 {
-
 	return sigtimedwait(set, info, timeout);
 }
 #endif
@@ -129,7 +92,7 @@ static int my_rt_sigtimedwait(const sigset_t * set, siginfo_t * info,
 			      struct timespec *timeout)
 {
 	/* _NSIG is always the right number of bits of signal map for all arches */
-	return ltp_syscall(__NR_rt_sigtimedwait, set, info, timeout, _NSIG/8);
+	return tst_syscall(__NR_rt_sigtimedwait, set, info, timeout, _NSIG/8);
 }
 #endif
 
@@ -141,12 +104,13 @@ void test_empty_set(swi_func sigwaitinfo, int signo)
 
 	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
 	/* Run a child that will wake us up */
-	child = create_sig_proc(100000, signo, UINT_MAX);
+	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS(-1, EINTR);
 
-	kill(child, SIGTERM);
+	SAFE_KILL(child, SIGTERM);
+	SAFE_WAIT(NULL);
 }
 
 void test_timeout(swi_func sigwaitinfo, int signo)
@@ -159,12 +123,13 @@ void test_timeout(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(100000, signo, UINT_MAX);
+	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, &ts));
 	REPORT_SUCCESS(-1, EAGAIN);
 
-	kill(child, SIGTERM);
+	SAFE_KILL(child, SIGTERM);
+	SAFE_WAIT(NULL);
 }
 
 /* Note: sigwait-ing for a signal that is not blocked is unspecified
@@ -180,14 +145,15 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(100000, signo, UINT_MAX);
+	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child
 			    && si.si_code == SI_USER
 			    && si.si_signo == signo, "Struct siginfo mismatch");
 
-	kill(child, SIGTERM);
+	SAFE_KILL(child, SIGTERM);
+	SAFE_WAIT(NULL);
 }
 
 void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo)
@@ -198,12 +164,13 @@ void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
 	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
 	/* Run a child that will wake us up */
-	child = create_sig_proc(100000, signo, UINT_MAX);
+	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
 	REPORT_SUCCESS(signo, 0);
 
-	kill(child, SIGTERM);
+	SAFE_KILL(child, SIGTERM);
+	SAFE_WAIT(NULL);
 }
 
 void test_masked_matching(swi_func sigwaitinfo, int signo)
@@ -224,7 +191,7 @@ void test_masked_matching(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigdelset, "sigaddset failed", &sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(0, signo, 1);
+	child = create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child
@@ -234,13 +201,14 @@ void test_masked_matching(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
 		       SIG_SETMASK, &oldmask, &oldmask);
 
-	tst_count--;
-
 	if (sigismember(&oldmask, signo))
-		tst_resm(TPASS, "sigwaitinfo restored the original mask");
+		tst_res(TPASS, "sigwaitinfo restored the original mask");
 	else
-		tst_resm(TFAIL,
+		tst_res(TFAIL,
 			 "sigwaitinfo failed to restore the original mask");
+
+	SAFE_KILL(child, SIGTERM);
+	SAFE_WAIT(NULL);
 }
 
 void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
@@ -265,12 +233,12 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigdelset, "sigdelset failed", &sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child[0] = create_sig_proc(0, signo, 1);
-	child[1] = create_sig_proc(0, signo + 1, 1);
+	child[0] = create_sig_proc(signo, 1, 0);
+	child[1] = create_sig_proc(signo + 1, 1, 0);
 
 	/* Ensure that the signals have been sent */
-	waitpid(child[0], &status, 0);
-	waitpid(child[1], &status, 0);
+	SAFE_WAITPID(child[0], &status, 0);
+	SAFE_WAITPID(child[1], &status, 0);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child[0]
@@ -278,7 +246,6 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 			    && si.si_signo == signo, "Struct siginfo mismatch");
 
 	/* eat the other signal */
-	tst_count--;
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS_COND(signo + 1, 0, si.si_pid == child[1]
 			    && si.si_code == SI_USER
@@ -288,12 +255,10 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
 		       SIG_SETMASK, &oldmask, &oldmask);
 
-	tst_count--;
-
 	if (sigismember(&oldmask, signo))
-		tst_resm(TPASS, "sigwaitinfo restored the original mask");
+		tst_res(TPASS, "sigwaitinfo restored the original mask");
 	else
-		tst_resm(TFAIL,
+		tst_res(TFAIL,
 			 "sigwaitinfo failed to restore the original mask");
 }
 
@@ -314,7 +279,7 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigdelset, "sigaddset failed", &sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(0, signo, 1);
+	child = create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
 	REPORT_SUCCESS(signo, 0);
@@ -322,14 +287,14 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
 		       SIG_SETMASK, &oldmask, &oldmask);
 
-	tst_count--;
-
 	if (sigismember(&oldmask, signo))
-		tst_resm(TPASS, "sigwaitinfo restored the original mask");
+		tst_res(TPASS, "sigwaitinfo restored the original mask");
 	else
-		tst_resm(TFAIL,
+		tst_res(TFAIL,
 			 "sigwaitinfo failed to restore the original mask");
 
+	SAFE_KILL(child, SIGTERM);
+	SAFE_WAIT(NULL);
 }
 
 void test_bad_address(swi_func sigwaitinfo, int signo)
@@ -349,7 +314,7 @@ void test_bad_address(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigdelset, "sigaddset failed", &sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(0, signo, 1);
+	child = create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, (void *)1, NULL));
 	REPORT_SUCCESS(-1, EFAULT);
@@ -357,7 +322,8 @@ void test_bad_address(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigprocmask, "sigprocmask failed", SIG_SETMASK, &oldmask,
 		       &oldmask);
 
-	kill(child, SIGTERM);
+	SAFE_KILL(child, SIGTERM);
+	SAFE_WAIT(NULL);
 }
 
 void test_bad_address2(swi_func sigwaitinfo, int signo)
@@ -367,7 +333,7 @@ void test_bad_address2(swi_func sigwaitinfo, int signo)
 
 	switch (pid = fork()) {
 	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
+		tst_brk(TBROK | TERRNO, "fork() failed");
 	case 0:
 		signal(SIGSEGV, SIG_DFL);
 
@@ -377,31 +343,31 @@ void test_bad_address2(swi_func sigwaitinfo, int signo)
 		 */
 		TEST(sigwaitinfo((void *)1, NULL, NULL));
 
-		if (TEST_RETURN == -1 && TEST_ERRNO == EFAULT)
+		if (TST_RET == -1 && TST_ERR == EFAULT)
 			_exit(0);
 
-		tst_resm(TINFO | TTERRNO, "swi_func returned: %ld",
-			TEST_RETURN);
+		tst_res(TINFO | TTERRNO, "swi_func returned: %ld",
+			TST_RET);
 		_exit(1);
 		break;
 	default:
 		break;
 	}
 
-	SUCCEED_OR_DIE(waitpid, "waitpid failed", pid, &status, 0);
+	SAFE_WAITPID(pid, &status, 0);
 
 	if ((WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
 		|| (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
-		tst_resm(TPASS, "Test passed");
+		tst_res(TPASS, "Test passed");
 		return;
 	}
 
 	if (WIFEXITED(status)) {
-		tst_resm(TFAIL, "Unrecognised child exit code: %d",
+		tst_res(TFAIL, "Unrecognised child exit code: %d",
 			WEXITSTATUS(status));
 	}
 	if (WIFSIGNALED(status)) {
-		tst_resm(TFAIL, "Unrecognised child termsig: %d",
+		tst_res(TFAIL, "Unrecognised child termsig: %d",
 			WTERMSIG(status));
 	}
 }
@@ -474,38 +440,31 @@ struct test_desc {
 #endif
 };
 
-#if defined TEST_SIGWAITINFO
-const char *TCID = "sigwaitinfo01";
-#elif defined TEST_RT_SIGTIMEDWAIT
-const char *TCID = "rt_sigtimedwait01";
-#elif defined TEST_SIGTIMEDWAIT
-const char *TCID = "sigtimedwait01";
-#elif defined TEST_SIGWAIT
-const char *TCID = "sigwait01";
-#endif
-
-int TST_TOTAL = ARRAY_SIZE(tests);
-
-int main(int argc, char **argv)
+static void run(unsigned int i)
 {
-	unsigned i;
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	struct test_desc *tc = &tests[i];
 
-	setup();
+	tc->tf(tc->swi, tc->signo);
+}
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
+static void setup(void)
+{
+	signal(SIGUSR1, empty_handler);
+	signal(SIGALRM, empty_handler);
+	signal(SIGUSR2, SIG_IGN);
 
-		for (i = 0; i < ARRAY_SIZE(tests); i++) {
-			alarm(10);	/* arrange a 10 second timeout */
-			tst_resm(TINFO, "%p, %d", tests[i].swi, tests[i].signo);
-			tests[i].tf(tests[i].swi, tests[i].signo);
-		}
-		alarm(0);
-	}
+	alarm(10);	/* arrange a 10 second timeout */
+}
 
-	cleanup();
-	tst_exit();
+static void cleanup(void)
+{
+	alarm(0);
 }
+
+static struct tst_test test = {
+	.test= run,
+	.tcnt = ARRAY_SIZE(tests),
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af


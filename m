From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  4 Aug 2020 13:27:53 +0530
Subject: [LTP] [PATCH V3 2/2] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
References: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
Message-ID: <b2e187039b9377537b2589b1bceeb7ea50500e27.1596527830.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is rather making the code difficult to read, get rid of it and its
associated functions.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3: Improved print messages.

 libs/libltpsigwait/sigwait.c | 133 +++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 55 deletions(-)

diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index fd32efd8aa9f..2be949929fb1 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -9,39 +9,6 @@
 #include "libsigwait.h"
 #include "tst_sig_proc.h"
 
-/* Report success iff TST_RET and TST_ERR are equal to
-	 exp_return and exp_errno, resp., and cond is true. If cond is not
-	 true, report condition_errmsg
-*/
-static void report_success_cond(const char *func, int line,
-				long exp_return, int exp_errno, int condition,
-				char *condition_errmsg)
-{
-	if (exp_return == TST_RET
-	    && (exp_return != -1 || exp_errno == TST_ERR))
-		if (condition)
-			tst_res(TPASS, "%s (%d): Test passed", func, line);
-		else
-			tst_res(TFAIL, "%s (%d): %s", func, line,
-				 condition_errmsg);
-	else if (TST_RET != -1)
-		tst_res(TFAIL,
-			 "%s (%d): Unexpected return value; expected %ld, got %ld",
-			 func, line, exp_return, TST_RET);
-	else
-		tst_res(TFAIL | TTERRNO, "%s (%d): Unexpected failure",
-			 func, line);
-}
-
-#define REPORT_SUCCESS_COND(exp_return, exp_errno, condition, condition_errmsg)	\
-	report_success_cond(__FUNCTION__, __LINE__, exp_return, exp_errno, condition, condition_errmsg);
-
-/* Report success iff TST_RET and TST_ERR are equal to
-	 exp_return and exp_errno, resp.
-*/
-#define REPORT_SUCCESS(exp_return, exp_errno)					\
-	REPORT_SUCCESS_COND(exp_return, exp_errno, 1, "");
-
 void test_empty_set(swi_func sigwaitinfo, int signo,
 		    enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
@@ -55,7 +22,14 @@ void test_empty_set(swi_func sigwaitinfo, int signo,
 	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
-	REPORT_SUCCESS(-1, EINTR);
+	if (TST_RET == -1) {
+		if (TST_ERR == EINTR)
+			tst_res(TPASS, "Wait interrupted by expected signal");
+		else
+			tst_res(TFAIL | TTERRNO, "Expected error number EINTR, got");
+	} else {
+		tst_res(TFAIL, "Expected return value -1, got: %ld", TST_RET);
+	}
 
 	SAFE_KILL(child, SIGTERM);
 	SAFE_WAIT(NULL);
@@ -78,7 +52,14 @@ void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, tst_ts_get(&ts)));
-	REPORT_SUCCESS(-1, EAGAIN);
+	if (TST_RET == -1) {
+		if (TST_ERR == EAGAIN)
+			tst_res(TPASS, "Wait interrupted by timeout");
+		else
+			tst_res(TFAIL | TTERRNO, "Expected error number EAGAIN, got");
+	} else {
+		tst_res(TFAIL, "Expected return value -1, got: %ld", TST_RET);
+	}
 
 	SAFE_KILL(child, SIGTERM);
 	SAFE_WAIT(NULL);
@@ -101,9 +82,15 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo,
 	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
-	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child
-			    && si.si_code == SI_USER
-			    && si.si_signo == signo, "Struct siginfo mismatch");
+	if (TST_RET == signo) {
+		if (si.si_pid == child && si.si_code == SI_USER &&
+		    si.si_signo == signo)
+			tst_res(TPASS, "struct siginfo is correct");
+		else
+			tst_res(TFAIL, "struct siginfo mismatch");
+	} else {
+		tst_res(TFAIL | TTERRNO, "sigwaitinfo() failed");
+	}
 
 	SAFE_KILL(child, SIGTERM);
 	SAFE_WAIT(NULL);
@@ -122,7 +109,10 @@ void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	child = create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
-	REPORT_SUCCESS(signo, 0);
+	if (TST_RET == signo)
+		tst_res(TPASS, "Wait interrupted by expected signal");
+	else
+		tst_res(TFAIL | TTERRNO, "sigwaitinfo() failed");
 
 	SAFE_KILL(child, SIGTERM);
 	SAFE_WAIT(NULL);
@@ -152,9 +142,15 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 	child = create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
-	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child
-			    && si.si_code == SI_USER
-			    && si.si_signo == signo, "Struct siginfo mismatch");
+	if (TST_RET == signo) {
+		if (si.si_pid == child && si.si_code == SI_USER &&
+		    si.si_signo == signo)
+			tst_res(TPASS, "struct siginfo is correct");
+		else
+			tst_res(TFAIL, "struct siginfo mismatch");
+	} else {
+		tst_res(TFAIL | TTERRNO, "sigwaitinfo() failed");
+	}
 
 	TEST(sigprocmask(SIG_SETMASK, &oldmask, &sigs));
 	if (TST_RET == -1)
@@ -203,16 +199,27 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
 	SAFE_WAITPID(child[1], &status, 0);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
-	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child[0]
-			    && si.si_code == SI_USER
-			    && si.si_signo == signo, "Struct siginfo mismatch");
+	if (TST_RET == signo) {
+		if (si.si_pid == child[0] && si.si_code == SI_USER &&
+		    si.si_signo == signo)
+			tst_res(TPASS, "struct siginfo is correct");
+		else
+			tst_res(TFAIL, "struct siginfo mismatch");
+	} else {
+		tst_res(TFAIL | TTERRNO, "sigwaitinfo() failed");
+	}
 
 	/* eat the other signal */
 	TEST(sigwaitinfo(&sigs, &si, NULL));
-	REPORT_SUCCESS_COND(signo + 1, 0, si.si_pid == child[1]
-			    && si.si_code == SI_USER
-			    && si.si_signo == signo + 1,
-			    "Struct siginfo mismatch");
+	if (TST_RET == signo + 1) {
+		if (si.si_pid == child[1] && si.si_code == SI_USER &&
+		    si.si_signo == signo + 1)
+			tst_res(TPASS, "struct siginfo is correct");
+		else
+			tst_res(TFAIL, "struct siginfo mismatch");
+	} else {
+		tst_res(TFAIL | TTERRNO, "sigwaitinfo() failed");
+	}
 
 	TEST(sigprocmask(SIG_SETMASK, &oldmask, &sigs));
 	if (TST_RET == -1)
@@ -248,7 +255,10 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	child = create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
-	REPORT_SUCCESS(signo, 0);
+	if (TST_RET == signo)
+		tst_res(TPASS, "Wait interrupted by expected signal");
+	else
+		tst_res(TFAIL | TTERRNO, "sigwaitinfo() failed");
 
 	TEST(sigprocmask(SIG_SETMASK, &oldmask, &sigs));
 	if (TST_RET == -1)
@@ -287,7 +297,14 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	child = create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, (void *)1, NULL));
-	REPORT_SUCCESS(-1, EFAULT);
+	if (TST_RET == -1) {
+		if (TST_ERR == EFAULT)
+			tst_res(TPASS, "Fault occurred while accessing the buffers");
+		else
+			tst_res(TFAIL | TTERRNO, "Expected error number EFAULT, got");
+	} else {
+		tst_res(TFAIL, "Expected return value -1, got: %ld", TST_RET);
+	}
 
 	TEST(sigprocmask(SIG_SETMASK, &oldmask, NULL));
 	if (TST_RET == -1)
@@ -316,8 +333,7 @@ void test_bad_address2(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 		if (TST_RET == -1 && TST_ERR == EFAULT)
 			_exit(0);
 
-		tst_res(TINFO | TTERRNO, "swi_func returned: %ld",
-			TST_RET);
+		tst_res(TINFO | TTERRNO, "swi_func returned: %ld", TST_RET);
 		_exit(1);
 	}
 
@@ -325,7 +341,7 @@ void test_bad_address2(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 
 	if ((WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
 		|| (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
-		tst_res(TPASS, "Test passed");
+		tst_res(TPASS, "Child exited with expected code");
 		return;
 	}
 
@@ -346,7 +362,14 @@ void test_bad_address3(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 
 	SAFE_SIGEMPTYSET(&sigs);
 	TEST(sigwaitinfo(&sigs, NULL, (void *)1));
-	REPORT_SUCCESS(-1, EFAULT);
+	if (TST_RET == -1) {
+		if (TST_ERR == EFAULT)
+			tst_res(TPASS, "Fault occurred while accessing the buffers");
+		else
+			tst_res(TFAIL | TTERRNO, "Expected error number EFAULT, got");
+	} else {
+		tst_res(TFAIL, "Expected return value -1, got: %ld", TST_RET);
+	}
 }
 
 static void empty_handler(int sig LTP_ATTRIBUTE_UNUSED)
-- 
2.14.1


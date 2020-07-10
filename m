From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 10 Jul 2020 13:31:47 +0530
Subject: [LTP] [RFC 2/3] syscalls: sigwaitinfo: Remove SUCCEED_OR_DIE() macro
In-Reply-To: <cover.1594367611.git.viresh.kumar@linaro.org>
References: <cover.1594367611.git.viresh.kumar@linaro.org>
Message-ID: <2c5220136e60352f6af9b0dcb49bdcc8f6d9c2ae.1594367611.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The macro makes it less readable and there isn't a great deal of code it
is trying to remove. Get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/sigwaitinfo/sigwaitinfo01.c      | 156 ++++++++++++------
 1 file changed, 109 insertions(+), 47 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 86fce4427a6d..5e1baf9df774 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -10,13 +10,6 @@
 #include "lapi/syscalls.h"
 #include "tst_sig_proc.h"
 
-#define SUCCEED_OR_DIE(syscall, message, ...)				 \
-	(errno = 0,							 \
-		({int ret=syscall(__VA_ARGS__);				 \
-			if (ret==-1)					 \
-				tst_brk(TBROK|TERRNO, message);\
-			ret;}))
-
 /* Report success iff TST_RET and TST_ERR are equal to
 	 exp_return and exp_errno, resp., and cond is true. If cond is not
 	 true, report condition_errmsg
@@ -113,7 +106,10 @@ void test_empty_set(swi_func sigwaitinfo, int signo,
 	siginfo_t si;
 	pid_t child;
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
 
@@ -135,7 +131,9 @@ void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 	tst_ts_set_sec(&ts, 1);
 	tst_ts_set_nsec(&ts, 0);
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
@@ -157,8 +155,13 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo,
 	siginfo_t si;
 	pid_t child;
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+
+	TEST(sigaddset(&sigs, signo));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
@@ -178,8 +181,14 @@ void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	sigset_t sigs;
 	pid_t child;
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+
+	TEST(sigaddset(&sigs, signo));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
 
@@ -197,16 +206,27 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 	siginfo_t si;
 	pid_t child;
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+
+	TEST(sigaddset(&sigs, signo));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+
 	/* let's not get interrupted by our dying child */
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, SIGCHLD);
+	TEST(sigaddset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
 
-	SUCCEED_OR_DIE(sigprocmask, "sigprocmask failed", SIG_SETMASK, &sigs,
-		       &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	SUCCEED_OR_DIE(sigdelset, "sigaddset failed", &sigs, SIGCHLD);
+	TEST(sigdelset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, 1, 0);
@@ -216,8 +236,9 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 			    && si.si_code == SI_USER
 			    && si.si_signo == signo, "Struct siginfo mismatch");
 
-	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
-		       SIG_SETMASK, &oldmask, &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
 	if (sigismember(&oldmask, signo))
 		tst_res(TPASS, "sigwaitinfo restored the original mask");
@@ -239,17 +260,31 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
 
 	signo = SIGRTMIN + 1;
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo + 1);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+
+	TEST(sigaddset(&sigs, signo));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+
+	TEST(sigaddset(&sigs, signo + 1));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+
 	/* let's not get interrupted by our dying child */
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, SIGCHLD);
+	TEST(sigaddset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
 
-	SUCCEED_OR_DIE(sigprocmask, "sigprocmask failed", SIG_SETMASK, &sigs,
-		       &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	SUCCEED_OR_DIE(sigdelset, "sigdelset failed", &sigs, SIGCHLD);
+	TEST(sigdelset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
 
 	/* Run a child that will wake us up */
 	child[0] = create_sig_proc(signo, 1, 0);
@@ -271,8 +306,9 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
 			    && si.si_signo == signo + 1,
 			    "Struct siginfo mismatch");
 
-	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
-		       SIG_SETMASK, &oldmask, &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
 	if (sigismember(&oldmask, signo))
 		tst_res(TPASS, "sigwaitinfo restored the original mask");
@@ -287,16 +323,27 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	sigset_t sigs, oldmask;
 	pid_t child;
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+
+	TEST(sigaddset(&sigs, signo));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+
 	/* let's not get interrupted by our dying child */
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, SIGCHLD);
+	TEST(sigaddset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
 
-	SUCCEED_OR_DIE(sigprocmask, "sigprocmask failed", SIG_SETMASK, &sigs,
-		       &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	SUCCEED_OR_DIE(sigdelset, "sigaddset failed", &sigs, SIGCHLD);
+	TEST(sigdelset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, 1, 0);
@@ -304,8 +351,9 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
 	REPORT_SUCCESS(signo, 0);
 
-	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
-		       SIG_SETMASK, &oldmask, &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
 	if (sigismember(&oldmask, signo))
 		tst_res(TPASS, "sigwaitinfo restored the original mask");
@@ -323,16 +371,27 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	sigset_t sigs, oldmask;
 	pid_t child;
 
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, signo);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+
+	TEST(sigaddset(&sigs, signo));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+
 	/* let's not get interrupted by our dying child */
-	SUCCEED_OR_DIE(sigaddset, "sigaddset failed", &sigs, SIGCHLD);
+	TEST(sigaddset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
 
-	SUCCEED_OR_DIE(sigprocmask, "sigprocmask failed", SIG_SETMASK, &sigs,
-		       &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	SUCCEED_OR_DIE(sigdelset, "sigaddset failed", &sigs, SIGCHLD);
+	TEST(sigdelset(&sigs, SIGCHLD));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, 1, 0);
@@ -340,8 +399,9 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	TEST(sigwaitinfo(&sigs, (void *)1, NULL));
 	REPORT_SUCCESS(-1, EFAULT);
 
-	SUCCEED_OR_DIE(sigprocmask, "sigprocmask failed", SIG_SETMASK, &oldmask,
-		       &oldmask);
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	SAFE_KILL(child, SIGTERM);
 	SAFE_WAIT(NULL);
@@ -398,7 +458,9 @@ void test_bad_address3(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 		       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs;
-	SUCCEED_OR_DIE(sigemptyset, "sigemptyset failed", &sigs);
+	TEST(sigemptyset(&sigs));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
 
 	TEST(sigwaitinfo(&sigs, NULL, (void *)1));
 	REPORT_SUCCESS(-1, EFAULT);
-- 
2.25.0.rc1.19.g042ed3e048af


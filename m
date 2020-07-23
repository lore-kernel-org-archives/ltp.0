From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 23 Jul 2020 19:12:06 +0530
Subject: [LTP] [PATCH 2/4] libs: sigwait: Add SAFE_SIG*() macros
In-Reply-To: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
Message-ID: <8b0c584c86d4f45212ccf418e9840a53b6e62a09.1595511710.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add them to simplify code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_safe_macros.h    |  43 ++++++++++++++++++
 libs/libltpsigwait/sigwait.c | 103 ++++++++++---------------------------------
 2 files changed, 67 insertions(+), 79 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index c39d8768b1fb..3fce473cc380 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -431,6 +431,49 @@ int safe_sigaction(const char *file, const int lineno,
 #define SAFE_SIGACTION(signum, act, oldact) \
 	safe_sigaction(__FILE__, __LINE__, (signum), (act), (oldact))
 
+static inline void safe_sigaddset(const char *file, const int lineno,
+				  sigset_t *sigs, int signo)
+{
+	int rval;
+
+	rval = sigaddset(sigs, signo);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO, "sigaddset(%d) failed",
+			 signo);
+	}
+}
+
+#define SAFE_SIGADDSET(sigs, signo) \
+	safe_sigaddset(__FILE__, __LINE__, (sigs), (signo))
+
+static inline void safe_sigdelset(const char *file, const int lineno,
+				  sigset_t *sigs, int signo)
+{
+	int rval;
+
+	rval = sigdelset(sigs, signo);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO, "sigdelset(%d) failed",
+			 signo);
+	}
+}
+
+#define SAFE_SIGDELSET(sigs, signo) \
+	safe_sigdelset(__FILE__, __LINE__, (sigs), (signo))
+
+static inline void safe_sigemptyset(const char *file, const int lineno,
+				    sigset_t *sigs)
+{
+	int rval;
+
+	rval = sigemptyset(sigs);
+	if (rval == -1)
+		tst_brk_(file, lineno, TBROK | TERRNO, "sigemptyset() failed");
+}
+
+#define SAFE_SIGEMPTYSET(sigs) \
+	safe_sigemptyset(__FILE__, __LINE__, (sigs))
+
 #define SAFE_EXECLP(file, arg, ...) do {                   \
 	execlp((file), (arg), ##__VA_ARGS__);              \
 	tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,       \
diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index bb8d2dd05a30..0a658625a984 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -49,9 +49,7 @@ void test_empty_set(swi_func sigwaitinfo, int signo,
 	siginfo_t si;
 	pid_t child;
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
@@ -74,9 +72,7 @@ void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 	tst_ts_set_sec(&ts, 1);
 	tst_ts_set_nsec(&ts, 0);
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
@@ -98,13 +94,8 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo,
 	siginfo_t si;
 	pid_t child;
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
-
-	TEST(sigaddset(&sigs, signo));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
+	SAFE_SIGADDSET(&sigs, signo);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
@@ -124,13 +115,8 @@ void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	sigset_t sigs;
 	pid_t child;
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
-
-	TEST(sigaddset(&sigs, signo));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
+	SAFE_SIGADDSET(&sigs, signo);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, INT_MAX, 100000);
@@ -149,27 +135,18 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 	siginfo_t si;
 	pid_t child;
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
-
-	TEST(sigaddset(&sigs, signo));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
+	SAFE_SIGADDSET(&sigs, signo);
 
 	/* let's not get interrupted by our dying child */
-	TEST(sigaddset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGADDSET(&sigs, SIGCHLD);
 
 	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	TEST(sigdelset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
+	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, 1, 0);
@@ -203,31 +180,19 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
 
 	signo = SIGRTMIN + 1;
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
-
-	TEST(sigaddset(&sigs, signo));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
-
-	TEST(sigaddset(&sigs, signo + 1));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
+	SAFE_SIGADDSET(&sigs, signo);
+	SAFE_SIGADDSET(&sigs, signo + 1);
 
 	/* let's not get interrupted by our dying child */
-	TEST(sigaddset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGADDSET(&sigs, SIGCHLD);
 
 	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	TEST(sigdelset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
+	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
 	child[0] = create_sig_proc(signo, 1, 0);
@@ -266,27 +231,18 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	sigset_t sigs, oldmask;
 	pid_t child;
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
-
-	TEST(sigaddset(&sigs, signo));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
+	SAFE_SIGADDSET(&sigs, signo);
 
 	/* let's not get interrupted by our dying child */
-	TEST(sigaddset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGADDSET(&sigs, SIGCHLD);
 
 	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	TEST(sigdelset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
+	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, 1, 0);
@@ -314,27 +270,18 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	sigset_t sigs, oldmask;
 	pid_t child;
 
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
-
-	TEST(sigaddset(&sigs, signo));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGEMPTYSET(&sigs);
+	SAFE_SIGADDSET(&sigs, signo);
 
 	/* let's not get interrupted by our dying child */
-	TEST(sigaddset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigaddset() failed");
+	SAFE_SIGADDSET(&sigs, SIGCHLD);
 
 	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
 	/* don't wait on a SIGCHLD */
-	TEST(sigdelset(&sigs, SIGCHLD));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigdelset() failed");
+	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
 	child = create_sig_proc(signo, 1, 0);
@@ -396,10 +343,8 @@ void test_bad_address3(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 		       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
 {
 	sigset_t sigs;
-	TEST(sigemptyset(&sigs));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigemptyset() failed");
 
+	SAFE_SIGEMPTYSET(&sigs);
 	TEST(sigwaitinfo(&sigs, NULL, (void *)1));
 	REPORT_SUCCESS(-1, EFAULT);
 }
-- 
2.14.1


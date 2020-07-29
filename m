From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jul 2020 18:25:36 +0530
Subject: [LTP] [PATCH V3 1/2] libs: sigwait: Fix compilation warning around
 sigprocmask()
In-Reply-To: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
References: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
Message-ID: <82754cb787a5af12d61fb71364d40909d5503204.1596027282.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newer gcc generates following warnings currently:

sigwait.c: In function ?test_masked_matching?:
sigwait.c:157:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
  157 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));

Fix these by replacing the third argument with sigs or removing it if
not required.

Also improve a comment while at it.

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3:
- Fix function arguments.
- Fix print message.

 libs/libltpsigwait/sigwait.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index dbd33a61f2b1..fd32efd8aa9f 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -156,11 +156,11 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 			    && si.si_code == SI_USER
 			    && si.si_signo == signo, "Struct siginfo mismatch");
 
-	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, &sigs));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
-	if (sigismember(&oldmask, signo))
+	if (sigismember(&sigs, signo))
 		tst_res(TPASS, "sigwaitinfo restored the original mask");
 	else
 		tst_res(TFAIL,
@@ -214,11 +214,11 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
 			    && si.si_signo == signo + 1,
 			    "Struct siginfo mismatch");
 
-	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, &sigs));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
-	if (sigismember(&oldmask, signo))
+	if (sigismember(&sigs, signo))
 		tst_res(TPASS, "sigwaitinfo restored the original mask");
 	else
 		tst_res(TFAIL,
@@ -250,11 +250,11 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
 	REPORT_SUCCESS(signo, 0);
 
-	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, &sigs));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
-	if (sigismember(&oldmask, signo))
+	if (sigismember(&sigs, signo))
 		tst_res(TPASS, "sigwaitinfo restored the original mask");
 	else
 		tst_res(TFAIL,
@@ -289,9 +289,9 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	TEST(sigwaitinfo(&sigs, (void *)1, NULL));
 	REPORT_SUCCESS(-1, EFAULT);
 
-	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	TEST(sigprocmask(SIG_SETMASK, &oldmask, NULL));
 	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
+		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
 	SAFE_KILL(child, SIGTERM);
 	SAFE_WAIT(NULL);
-- 
2.14.1


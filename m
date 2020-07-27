From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 27 Jul 2020 15:10:25 +0530
Subject: [LTP] [PATCH V2 1/2] libs: sigwait: Fix compilation warning around
 sigprocmask()
Message-ID: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newer gcc generates following warnings currently:

sigwait.c: In function ?test_masked_matching?:
sigwait.c:157:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
  157 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));

Fix these by using different pointers for new and old masks.

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: New patch

 libs/libltpsigwait/sigwait.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index dbd33a61f2b1..0a34e6cc3deb 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -156,11 +156,11 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 			    && si.si_code == SI_USER
 			    && si.si_signo == signo, "Struct siginfo mismatch");
 
-	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
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
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
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
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "restoring original signal mask failed");
 
-	if (sigismember(&oldmask, signo))
+	if (sigismember(&sigs, signo))
 		tst_res(TPASS, "sigwaitinfo restored the original mask");
 	else
 		tst_res(TFAIL,
@@ -289,7 +289,7 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	TEST(sigwaitinfo(&sigs, (void *)1, NULL));
 	REPORT_SUCCESS(-1, EFAULT);
 
-	TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
+	TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "sigprocmask() failed");
 
-- 
2.14.1


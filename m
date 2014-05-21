Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wn3ho-0002nx-Cx
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:25:04 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wn3hm-0005mI-IY
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:25:04 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4LAOuuV022161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:56 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s4LAOtK4025666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:56 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4LAOta9006369
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:55 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 21 May 2014 14:24:46 +0400
Message-Id: <1400667887-5188-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140520144246.GA30023@rei.suse.cz>
References: <20140520144246.GA30023@rei.suse.cz>
Subject: [LTP] [PATCH 2/3] rt_sigaction, rt_sigprocmask01,
	rt_sigsuspend: use rt_sigaction wrapper
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

These testcases use many pieces of duplicated code to test
syscall(__NR_rt_sigaction). Thus it's not beautiful to add support
for other architectures there.

To overcome this I implemented a wrapper for the rt_sigaction syscall,
and made the test cases use it.

And struct kernel_sigaction is not specific only for x86_64.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---

ltp_rt_sigaction is tightly couples with stuff in ltp_signal.h,
therefore I put it there.


 include/ltp_signal.h                               |   70 ++++++++++++++++++--
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   15 +----
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |    8 +--
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    4 +-
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   13 +---
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   13 +----
 6 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/include/ltp_signal.h b/include/ltp_signal.h
index e6fb2e0..31bb0b0 100644
--- a/include/ltp_signal.h
+++ b/include/ltp_signal.h
@@ -55,6 +55,15 @@
 
 #ifdef LTP_RT_SIG_TEST
 
+#define INVAL_SA_PTR ((void *)-1)
+
+struct kernel_sigaction {
+	__sighandler_t k_sa_handler;
+	unsigned long sa_flags;
+	void (*sa_restorer) (void);
+	sigset_t sa_mask;
+};
+
 #ifdef __x86_64__
 
 /*
@@ -77,13 +86,6 @@
 #define HAVE_SA_RESTORER
 #define SA_RESTORER	0x04000000
 
-struct kernel_sigaction {
-	__sighandler_t k_sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer) (void);
-	sigset_t sa_mask;
-};
-
 void (*restore_rt)(void);
 
 static void handler_h(int signal)
@@ -120,6 +122,60 @@ static inline int sig_initial(int sig)
 
 #endif /* __x86_64__ */
 
+/* This is a wrapper for __NR_rt_sigaction syscall.
+ * act/oact values of INVAL_SA_PTR is used to pass
+ * an invalid pointer to syscall(__NR_rt_sigaction)
+ *
+ * Based on glibc/sysdeps/unix/sysv/linux/{...}/sigaction.c
+ */
+
+static int ltp_rt_sigaction(int signum, const struct sigaction *act,
+			struct sigaction *oact, size_t sigsetsize)
+{
+	int ret;
+	struct kernel_sigaction kact, koact;
+	struct kernel_sigaction *kact_p = NULL;
+	struct kernel_sigaction *koact_p = NULL;
+
+	if (act == INVAL_SA_PTR) {
+		kact_p = INVAL_SA_PTR;
+	} else if (act) {
+		kact.k_sa_handler = act->sa_handler;
+		memcpy(&kact.sa_mask, &act->sa_mask, sizeof(sigset_t));
+		kact.sa_flags = act->sa_flags;
+		kact.sa_restorer = NULL;
+
+		kact_p = &kact;
+	}
+
+	if (oact == INVAL_SA_PTR)
+		koact_p = INVAL_SA_PTR;
+	else if (oact)
+		koact_p = &koact;
+
+#ifdef __x86_64__
+	sig_initial(signum);
+	kact.sa_flags |= SA_RESTORER;
+	kact.sa_restorer = restore_rt;
+#endif
+
+	ret = ltp_syscall(__NR_rt_sigaction, signum,
+			kact_p, koact_p,
+			sigsetsize);
+
+	if (ret >= 0) {
+		if (oact && (oact != INVAL_SA_PTR)) {
+			oact->sa_handler = koact.k_sa_handler;
+			memcpy(&oact->sa_mask, &koact.sa_mask,
+				sizeof(sigset_t));
+			oact->sa_flags = koact.sa_flags;
+			oact->sa_restorer = koact.sa_restorer;
+		}
+	}
+
+	return ret;
+}
+
 #endif /* LTP_RT_SIG_TEST */
 
 #endif
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 5ca3ba4..ac05c64 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -73,20 +73,14 @@ static void handler(int sig)
 
 static int set_handler(int sig, int sig_to_mask, int mask_flags)
 {
-#ifdef __x86_64__
-	struct kernel_sigaction sa, oldaction;
-	mask_flags |= SA_RESTORER;
-	sa.sa_restorer = restore_rt;
-	sa.k_sa_handler = (void *)handler;
-#else
 	struct sigaction sa, oldaction;
+
 	sa.sa_handler = (void *)handler;
-#endif
 	sa.sa_flags = mask_flags;
 	sigemptyset(&sa.sa_mask);
 	sigaddset(&sa.sa_mask, sig);
 
-	return ltp_syscall(__NR_rt_sigaction, sig, &sa, &oldaction, SIGSETSIZE);
+	return ltp_rt_sigaction(sig, &sa, &oldaction, SIGSETSIZE);
 }
 
 int main(int ac, char **av)
@@ -109,11 +103,6 @@ int main(int ac, char **av)
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (signal = SIGRTMIN; signal <= SIGRTMAX; signal++) {
-
-#ifdef __x86_64__
-				sig_initial(signal);
-#endif
-
 				for (flag = 0;
 				     flag <
 				     (sizeof(test_flags) /
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index 5822a79..1b2d22a 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -32,13 +32,12 @@
 #include <sys/syscall.h>
 #include <string.h>
 
+#define LTP_RT_SIG_TEST
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 #include "ltp_signal.h"
 
-#define INVAL_STRUCT -1
-
 char *TCID = "rt_sigaction02";
 static int testno;
 int TST_TOTAL = 1;
@@ -100,9 +99,8 @@ int main(int ac, char **av)
 					 * An invalid act or oact value was specified                   *
 					 */
 
-					TEST(ltp_syscall
-					     (__NR_rt_sigaction, signal,
-					      INVAL_STRUCT, NULL, SIGSETSIZE));
+					TEST(ltp_rt_sigaction(signal,
+						INVAL_SA_PTR, NULL, SIGSETSIZE));
 					if ((TEST_RETURN == -1)
 					    && (TEST_ERRNO ==
 						test_cases[0].exp_errno)) {
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 8920138..f974567 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -32,6 +32,7 @@
 #include <sys/syscall.h>
 #include <string.h>
 
+#define LTP_RT_SIG_TEST
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
@@ -92,8 +93,7 @@ static int set_handler(int sig, int sig_to_mask, int mask_flags)
 	 * sigsetsize was not equivalent to the size of a sigset_t type *
 	 */
 
-	return ltp_syscall(__NR_rt_sigaction, sig, &sa, &oldaction,
-			INVAL_SIGSETSIZE);
+	return ltp_rt_sigaction(sig, &sa, &oldaction, INVAL_SIGSETSIZE);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index f13edbf..2b131c2 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -76,18 +76,11 @@ void sig_handler(int sig)
 
 int main(int ac, char **av)
 {
-#if __x86_64
-	struct kernel_sigaction act, oact;
-	sig_initial(TEST_SIG);
-	act.sa_flags |= SA_RESTORER;
-	act.sa_restorer = restore_rt;
-	act.k_sa_handler = sig_handler;
-#else
 	struct sigaction act, oact;
 	memset(&act, 0, sizeof(act));
 	memset(&oact, 0, sizeof(oact));
 	act.sa_handler = sig_handler;
-#endif
+
 	sigset_t set, oset;
 	int lc;
 	char *msg;
@@ -111,8 +104,8 @@ int main(int ac, char **av)
 					 "sigaddset call failed");
 
 			/* call rt_sigaction() */
-			TEST(ltp_syscall(__NR_rt_sigaction, TEST_SIG, &act,
-				&oact, SIGSETSIZE));
+			TEST(ltp_rt_sigaction(TEST_SIG, &act, &oact,
+						SIGSETSIZE));
 			if (TEST_RETURN < 0)
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigaction call failed");
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index 6ee41d0..5c77648 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -70,23 +70,12 @@ int main(int ac, char **av)
 
 		if (sigemptyset(&set) < 0)
 			tst_brkm(TFAIL | TERRNO, cleanup, "sigemptyset failed");
-#ifdef __x86_64__
-		struct kernel_sigaction act, oact;
-		sig_initial(SIGALRM);
-		memset(&act, 0, sizeof(act));
-		memset(&oact, 0, sizeof(oact));
-		act.sa_flags |= SA_RESTORER;
-		act.sa_restorer = restore_rt;
-		act.k_sa_handler = sig_handler;
-#else
 		struct sigaction act, oact;
 		memset(&act, 0, sizeof(act));
 		memset(&oact, 0, sizeof(oact));
 		act.sa_handler = sig_handler;
-#endif
 
-		TEST(ltp_syscall(__NR_rt_sigaction, SIGALRM, &act, &oact,
-			     SIGSETSIZE));
+		TEST(ltp_rt_sigaction(SIGALRM, &act, &oact, SIGSETSIZE));
 		if (TEST_RETURN == -1)
 			tst_brkm(TFAIL | TTERRNO, cleanup,
 				 "rt_sigaction failed");
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

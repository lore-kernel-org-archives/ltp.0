Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wmj6H-0006HU-0p
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 12:24:57 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wmj6F-0002pM-VZ
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 12:24:56 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4KCOn2M028793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 20 May 2014 12:24:50 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4KCOmLv009308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 20 May 2014 12:24:49 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4KCOmXL014327
	for <ltp-list@lists.sourceforge.net>; Tue, 20 May 2014 12:24:48 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 20 May 2014 16:24:43 +0400
Message-Id: <1400588683-16001-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140513113904.GA12144@rei>
References: <20140513113904.GA12144@rei>
Subject: [LTP] [RFC PATCH] A draft of the rt_sigaction syscall wrapper.
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Hi!

I think that instead of an addition of "the common syscall preparation" to a define,
it would be better to implement a wrapper to the rt_sigaction syscall.

Like this one. 

Its basis is a combination of glibc implementations of sigaction() for different
platforms. But it also accepts '-1' for act, oact to check EFAULT errno code 
(glibc implementation doesn't handle such a situtation).

How do you think where the best place is to put this wrapper implementation?

Thank you.

 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   86 ++++++++++++++++---
 1 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 8f18394..8516396 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -60,6 +60,76 @@ char *TCID = "rt_sigaction01";
 int testno;
 int TST_TOTAL = 1;
 
+#define INVAL_SA_PTR ((void *)-1)
+
+/* This is a wrapper for __NR_rt_sigaction syscall.
+ * act/oact values of INVAL_SA_PTR is used to pass
+ * an invalid pointer to syscall(__NR_rt_sigaction).
+ *
+ * Based on glibc/sysdeps/unix/sysv/linux/{...}/sigaction.c
+ */
+static int ltp_rt_sigaction(int signum, const struct sigaction *act,
+                       struct sigaction *oact, size_t sigsetsize)
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
+#ifdef __sparc__
+# ifdef __arch64__
+	unsigned long stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+# else
+	unsigned long stub = ((unsigned long) &__sigreturn_stub) - 8;
+# endif
+#endif
+
+#ifdef __x86_64__
+	sig_initial(signum);
+	kact.sa_flags |= SA_RESTORER;
+	kact.sa_restorer = restore_rt;
+#endif
+
+#ifdef __sparc__
+	ret = ltp_syscall(__NR_rt_sigaction, signum,
+			kact_p , koact_p,
+			stub, sigsetsize);
+#else
+	ret = ltp_syscall(__NR_rt_sigaction, signum,
+			kact_p, koact_p,
+			sigsetsize);
+#endif
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
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
@@ -127,21 +197,14 @@ void handler(int sig)
 
 int set_handler(int sig, int sig_to_mask, int mask_flags)
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
-
+	return ltp_rt_sigaction(sig, &sa, &oldaction, SIGSETSIZE);
 }
 
 int main(int ac, char **av)
@@ -163,11 +226,6 @@ int main(int ac, char **av)
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {	//signal for 34 to 65
-
-#ifdef __x86_64__
-				sig_initial(signal);
-#endif
-
 				for (flag = 0;
 				     flag <
 				     (sizeof(test_flags) /
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

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wn3ho-0007oP-1X
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:25:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wn3hn-0001my-5c
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:25:03 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4LAOvqk009025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:57 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4LAOuSp004233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:57 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4LAOu2n015218
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:24:56 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 21 May 2014 14:24:47 +0400
Message-Id: <1400667887-5188-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140520144246.GA30023@rei.suse.cz>
References: <20140520144246.GA30023@rei.suse.cz>
Subject: [LTP] [PATCH 3/3] ltp_rt_sigaction: added SPARC support
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

Based on patches by Jose E. Marchesi <jose.marchesi@oracle.com>.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/ltp_signal.h |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/include/ltp_signal.h b/include/ltp_signal.h
index 31bb0b0..a60ee7c 100644
--- a/include/ltp_signal.h
+++ b/include/ltp_signal.h
@@ -122,6 +122,46 @@ static inline int sig_initial(int sig)
 
 #endif /* __x86_64__ */
 
+#ifdef __sparc__
+#if defined __arch64__ || defined __sparcv9
+
+/*
+ * From glibc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c
+ */
+
+static void __rt_sigreturn_stub(void)
+{
+	__asm__ ("mov %0, %%g1\n\t"
+		"ta  0x6d\n\t"
+		: /* no outputs */
+		: "i" (__NR_rt_sigreturn));
+}
+
+#else /* sparc32 */
+
+/*
+ * From glibc/sysdeps/unix/sysv/linux/sparc/sparc32/sigaction.c
+ */
+
+static void __rt_sigreturn_stub(void)
+{
+	__asm__ ("mov %0, %%g1\n\t"
+		"ta  0x10\n\t"
+		: /* no outputs */
+		: "i" (__NR_rt_sigreturn));
+}
+
+static void __sigreturn_stub(void)
+{
+	__asm__ ("mov %0, %%g1\n\t"
+		"ta  0x10\n\t"
+		: /* no outputs */
+		: "i" (__NR_sigreturn));
+}
+
+#endif
+#endif /* __sparc__ */
+
 /* This is a wrapper for __NR_rt_sigaction syscall.
  * act/oact values of INVAL_SA_PTR is used to pass
  * an invalid pointer to syscall(__NR_rt_sigaction)
@@ -159,9 +199,28 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 	kact.sa_restorer = restore_rt;
 #endif
 
+#ifdef __sparc__
+	unsigned long stub = 0;
+# if defined __arch64__ || defined __sparcv9
+	stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+# else /* sparc32 */
+	if ((kact.sa_flags & SA_SIGINFO) != 0)
+		stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+	else
+		stub = ((unsigned long) &__sigreturn_stub) - 8;
+# endif
+#endif
+
+
+#ifdef __sparc__
+	ret = ltp_syscall(__NR_rt_sigaction, signum,
+			kact_p, koact_p,
+			stub, sigsetsize);
+#else
 	ret = ltp_syscall(__NR_rt_sigaction, signum,
 			kact_p, koact_p,
 			sigsetsize);
+#endif
 
 	if (ret >= 0) {
 		if (oact && (oact != INVAL_SA_PTR)) {
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

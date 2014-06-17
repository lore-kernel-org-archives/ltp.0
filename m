Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WwpNb-0000vK-EW
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 09:08:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WwpNZ-0003X1-OQ
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 09:08:35 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s5H98R41026740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 09:08:28 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5H98QIZ023126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 09:08:27 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5H98QCW000647
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 09:08:26 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 17 Jun 2014 13:08:18 +0400
Message-Id: <1402996098-12697-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140520144246.GA30023@rei.suse.cz>
References: <20140520144246.GA30023@rei.suse.cz>
Subject: [LTP] [PATCH V2 3/3] ltp_rt_sigaction.h: added SPARC support
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

syscall(__NR_rt_sigaction) on SPARC requires more arguments, than
it does in x86_64 environment.

Therefore to make ltp_rt_sigaction() work on SPARC, we modify it
the same way as it's done in glibc, i.e. by hiding the additional
argument - the stub - inside the wrapper.

Based on patches by Jose E. Marchesi <jose.marchesi@oracle.com>.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * Added indentions to ifdefs
 * Added a more detailed description message

 include/lapi/rt_sigaction.h |   59 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index efe7f69..9ea5e0f 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -97,6 +97,46 @@ static inline int sig_initial(int sig)
 
 #endif /* __x86_64__ */
 
+#ifdef __sparc__
+# if defined __arch64__ || defined __sparcv9
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
+# else /* sparc32 */
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
+# endif
+#endif /* __sparc__ */
+
 /* This is a wrapper for __NR_rt_sigaction syscall.
  * act/oact values of INVAL_SA_PTR is used to pass
  * an invalid pointer to syscall(__NR_rt_sigaction)
@@ -134,9 +174,28 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
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
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

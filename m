Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WwpNZ-0000vF-TV
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 09:08:33 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WwpNX-0005RE-Uz
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 09:08:33 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s5H98Puf026691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 09:08:26 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5H98P5j011890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 09:08:25 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5H98PCw023007
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 09:08:25 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 17 Jun 2014 13:08:17 +0400
Message-Id: <1402996098-12697-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140520144246.GA30023@rei.suse.cz>
References: <20140520144246.GA30023@rei.suse.cz>
Subject: [LTP] [PATCH V2 2/3] rt_sigaction, rt_sigprocmask01,
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

To overcome this I:
 * moved everything inside '#ifdef LTP_RT_SIG_TEST' to a separate
   header file - 'include/lapi/rt_sigaction.h'
   So if we need to test the rt_sigaction syscall, we include 'lapi/sigaction.h',
   otherwise - include 'ltp_signal.h'.

 * moved struct kernel_sigaction out of '#ifdef __x86_64__', because
   it is not specific only for x86_64

 * implemented a wrapper for the rt_sigaction syscall and put it
   into 'include/lapi/rt_sigaction.h'

 * modified the above test cases to use this wrapper

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * Splitted include/ltp_signal.h into two headers


 include/lapi/rt_sigaction.h                        |  154 ++++++++++++++++++++
 include/ltp_signal.h                               |   69 ---------
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   18 +--
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |    9 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    5 +-
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   16 +--
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   16 +--
 7 files changed, 168 insertions(+), 119 deletions(-)
 create mode 100644 include/lapi/rt_sigaction.h

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
new file mode 100644
index 0000000..efe7f69
--- /dev/null
+++ b/include/lapi/rt_sigaction.h
@@ -0,0 +1,154 @@
+/*
+ * Copyright (c) 2009 Cisco Systems, Inc.  All Rights Reserved.
+ * Copyright (c) 2009 FUJITSU LIMITED.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Author: Liu Bo <liubo2009@cn.fujitsu.com>
+ * Author: Garrett Cooper <yanegomi@gmail.com>
+ *
+ */
+
+#ifndef LTP_RT_SIGACTION_H
+#define LTP_RT_SIGACTION_H
+
+#include "ltp_signal.h"
+
+#define INVAL_SA_PTR ((void *)-1)
+
+struct kernel_sigaction {
+	__sighandler_t k_sa_handler;
+	unsigned long sa_flags;
+	void (*sa_restorer) (void);
+	sigset_t sa_mask;
+};
+
+#ifdef __x86_64__
+
+/*
+ * From asm/signal.h -- this value isn't exported anywhere outside of glibc and
+ * asm/signal.h and is only required for the rt_sig* function family because
+ * sigaction(2), et all, appends this if necessary to
+ * (struct sigaction).sa_flags. HEH.
+ *
+ * I do #undef though, just in case...
+ *
+ * Also, from .../arch/x86/kernel/signal.c:448 for v2.6.30 (something or
+ * other):
+ *
+ * x86-64 should always use SA_RESTORER.
+ *
+ * -- thus SA_RESTORER must always be defined along with
+ * (struct sigaction).sa_restorer for this architecture.
+ */
+#undef SA_RESTORER
+#define HAVE_SA_RESTORER
+#define SA_RESTORER     0x04000000
+
+void (*restore_rt)(void);
+
+static void handler_h(int signal)
+{
+	return;
+}
+
+/* Setup an initial signal handler for signal number = sig for x86_64. */
+static inline int sig_initial(int sig)
+{
+	int ret_code = -1;
+	struct sigaction act, oact;
+
+	act.sa_handler = handler_h;
+	act.sa_flags = 0;
+	/* Clear out the signal set. */
+	if (sigemptyset(&act.sa_mask) < 0) {
+		/* Add the signal to the mask set. */
+	} else if (sigaddset(&act.sa_mask, sig) < 0) {
+		/* Set act.sa_restorer via syscall(2) */
+	} else if (sigaction(sig, &act, &oact) < 0) {
+		/* Copy oact.sa_restorer via syscall(2) */
+	} else if (sigaction(sig, &act, &oact) < 0) {
+		/* And voila -- we just tricked the kernel into giving us our
+		 * restorer function! */
+	} else {
+		restore_rt = oact.sa_restorer;
+		ret_code = 0;
+	}
+
+	return ret_code;
+}
+
+#endif /* __x86_64__ */
+
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
+#endif /* LTP_RT_SIGACTION_H */
diff --git a/include/ltp_signal.h b/include/ltp_signal.h
index e6fb2e0..294007b 100644
--- a/include/ltp_signal.h
+++ b/include/ltp_signal.h
@@ -53,73 +53,4 @@
 #define SIGSETSIZE (_NSIG / 8)
 #endif
 
-#ifdef LTP_RT_SIG_TEST
-
-#ifdef __x86_64__
-
-/*
- * From asm/signal.h -- this value isn't exported anywhere outside of glibc and
- * asm/signal.h and is only required for the rt_sig* function family because
- * sigaction(2), et all, appends this if necessary to
- * (struct sigaction).sa_flags. HEH.
- *
- * I do #undef though, just in case...
- *
- * Also, from .../arch/x86/kernel/signal.c:448 for v2.6.30 (something or
- * other):
- *
- * x86-64 should always use SA_RESTORER.
- *
- * -- thus SA_RESTORER must always be defined along with
- * (struct sigaction).sa_restorer for this architecture.
- */
-#undef SA_RESTORER
-#define HAVE_SA_RESTORER
-#define SA_RESTORER	0x04000000
-
-struct kernel_sigaction {
-	__sighandler_t k_sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer) (void);
-	sigset_t sa_mask;
-};
-
-void (*restore_rt)(void);
-
-static void handler_h(int signal)
-{
-	return;
-}
-
-/* Setup an initial signal handler for signal number = sig for x86_64. */
-static inline int sig_initial(int sig)
-{
-	int ret_code = -1;
-	struct sigaction act, oact;
-
-	act.sa_handler = handler_h;
-	act.sa_flags = 0;
-	/* Clear out the signal set. */
-	if (sigemptyset(&act.sa_mask) < 0) {
-		/* Add the signal to the mask set. */
-	} else if (sigaddset(&act.sa_mask, sig) < 0) {
-		/* Set act.sa_restorer via syscall(2) */
-	} else if (sigaction(sig, &act, &oact) < 0) {
-		/* Copy oact.sa_restorer via syscall(2) */
-	} else if (sigaction(sig, &act, &oact) < 0) {
-		/* And voila -- we just tricked the kernel into giving us our
-		 * restorer function! */
-	} else {
-		restore_rt = oact.sa_restorer;
-		ret_code = 0;
-	}
-
-	return ret_code;
-
-}
-
-#endif /* __x86_64__ */
-
-#endif /* LTP_RT_SIG_TEST */
-
 #endif
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index fb698f8..396f798 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -36,11 +36,10 @@
 #include <sys/syscall.h>
 #include <string.h>
 
-#define LTP_RT_SIG_TEST
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-#include "ltp_signal.h"
+#include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigaction01";
 static int testno;
@@ -73,20 +72,14 @@ static void handler(int sig)
 
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
@@ -109,11 +102,6 @@ int main(int ac, char **av)
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
index 8cf0f14..5989657 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -35,9 +35,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-#include "ltp_signal.h"
-
-#define INVAL_STRUCT -1
+#include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigaction02";
 static int testno;
@@ -100,9 +98,8 @@ int main(int ac, char **av)
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
index 9ae8d0e..1b1554a 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -35,7 +35,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-#include "ltp_signal.h"
+#include "lapi/rt_sigaction.h"
 
 #define INVAL_SIGSETSIZE -1
 
@@ -92,8 +92,7 @@ static int set_handler(int sig, int sig_to_mask, int mask_flags)
 	 * sigsetsize was not equivalent to the size of a sigset_t type *
 	 */
 
-	return ltp_syscall(__NR_rt_sigaction, sig, &sa, &oldaction,
-			INVAL_SIGSETSIZE);
+	return ltp_rt_sigaction(sig, &sa, &oldaction, INVAL_SIGSETSIZE);
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index bdfa6dd..035ecdb 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -46,8 +46,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-#define LTP_RT_SIG_TEST
-#include "ltp_signal.h"
+#include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigprocmask01";
 static int testno;
@@ -76,18 +75,11 @@ void sig_handler(int sig)
 
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
 	const char *msg;
@@ -111,8 +103,8 @@ int main(int ac, char **av)
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
index f0fc96f..edcb4a8 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -30,8 +30,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-#define LTP_RT_SIG_TEST
-#include "ltp_signal.h"
+#include "lapi/rt_sigaction.h"
 
 char *TCID = "rt_sigsuspend01";
 int TST_TOTAL = 1;
@@ -70,23 +69,12 @@ int main(int ac, char **av)
 
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
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WiKIE-0003NP-89
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:06 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WiKIC-0003d4-KO
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:05 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4896vqN028299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:58 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4896vWV019153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:57 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4896vlU019139
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:57 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  8 May 2014 13:06:44 +0400
Message-Id: <1399540004-14742-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 4/4] rt_sigaction*, rt_sigprocmask01,
	rt_sigsuspend01: SPARC support
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

Added SPARC support for tests:
 * rt_sigaction01, rt_sigaction02, rt_sigaction03
 * rt_sigprocmask01
 * rt_sigsuspend01

Author: Jose E. Marchesi <jose.marchesi@oracle.com>
Co-author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/ltp_signal.h                               |   39 +++++++++++++++++++-
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   32 ++++++++++++++---
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |   13 ++++++-
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |   28 ++++++++++++++
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   24 +++++++++++-
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   24 ++++++++++--
 6 files changed, 147 insertions(+), 13 deletions(-)

diff --git a/include/ltp_signal.h b/include/ltp_signal.h
index e6fb2e0..c050894 100644
--- a/include/ltp_signal.h
+++ b/include/ltp_signal.h
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2009 Cisco Systems, Inc.  All Rights Reserved.
  * Copyright (c) 2009 FUJITSU LIMITED.  All Rights Reserved.
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -77,6 +78,42 @@
 #define HAVE_SA_RESTORER
 #define SA_RESTORER	0x04000000
 
+#endif /* __x86_64__ */
+
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
+#if defined __x86_64__ || defined __sparc__
+
 struct kernel_sigaction {
 	__sighandler_t k_sa_handler;
 	unsigned long sa_flags;
@@ -118,7 +155,7 @@ static inline int sig_initial(int sig)
 
 }
 
-#endif /* __x86_64__ */
+#endif /* __x86_64__ || __sparc__*/
 
 #endif /* LTP_RT_SIG_TEST */
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 8f18394..2f8020e 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -1,5 +1,6 @@
 /******************************************************************************/
 /* Copyright (c) Crackerjack Project., 2007                                   */
+/* Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.      */
 /*                                                                            */
 /* This program is free software;  you can redistribute it and/or modify      */
 /* it under the terms of the GNU General Public License as published by       */
@@ -127,21 +128,42 @@ void handler(int sig)
 
 int set_handler(int sig, int sig_to_mask, int mask_flags)
 {
-#ifdef __x86_64__
+#ifdef __sparc__
+	struct sigaction sa;
+	struct kernel_sigaction kact, koact;
+# ifdef __arch64__
+	unsigned long stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+# else
+	unsigned long stub = ((unsigned long) &__sigreturn_stub) - 8;
+# endif
+
+	sigemptyset(&sa.sa_mask);
+	sigaddset(&sa.sa_mask, sig);
+
+	kact.k_sa_handler = (void *) handler;
+	kact.sa_flags = 0;
+	kact.sa_restorer = NULL;
+	memcpy(&kact.sa_mask, &sa.sa_mask, sizeof(sigset_t));
+
+	return ltp_syscall(__NR_rt_sigaction, sig, &kact,
+			&koact, stub, SIGSETSIZE);
+#else
+
+# ifdef __x86_64__
 	struct kernel_sigaction sa, oldaction;
 	mask_flags |= SA_RESTORER;
 	sa.sa_restorer = restore_rt;
 	sa.k_sa_handler = (void *)handler;
-#else
+# else
 	struct sigaction sa, oldaction;
 	sa.sa_handler = (void *)handler;
-#endif
+# endif
 	sa.sa_flags = mask_flags;
 	sigemptyset(&sa.sa_mask);
 	sigaddset(&sa.sa_mask, sig);
 
 	return ltp_syscall(__NR_rt_sigaction, sig, &sa, &oldaction, SIGSETSIZE);
-
+#endif
 }
 
 int main(int ac, char **av)
@@ -164,7 +186,7 @@ int main(int ac, char **av)
 
 			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {	//signal for 34 to 65
 
-#ifdef __x86_64__
+#if defined __x86_64__ || defined __sparc__
 				sig_initial(signal);
 #endif
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index 61137df..c272344 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -1,5 +1,6 @@
 /******************************************************************************/
 /* Copyright (c) Crackerjack Project., 2007                                   */
+/* Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.      */
 /*                                                                            */
 /* This program is free software;  you can redistribute it and/or modify      */
 /* it under the terms of the GNU General Public License as published by       */
@@ -46,6 +47,7 @@
 #include <sys/syscall.h>
 #include <string.h>
 
+#define LTP_RT_SIG_TEST
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
@@ -151,10 +153,19 @@ int main(int ac, char **av)
 					 * EFAULT:                                                      *
 					 * An invalid act or oact value was specified                   *
 					 */
-
+#ifdef __sparc__
+# ifdef __arch64__
+					unsigned long stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+# else
+					unsigned long stub = ((unsigned long) &__sigreturn_stub) - 8;
+# endif
+					TEST(ltp_syscall(__NR_rt_sigaction, signal,
+							INVAL_STRUCT, NULL, stub, SIGSETSIZE));
+#else
 					TEST(ltp_syscall
 					     (__NR_rt_sigaction, signal,
 					      INVAL_STRUCT, NULL, SIGSETSIZE));
+#endif
 					if ((TEST_RETURN == -1)
 					    && (TEST_ERRNO ==
 						test_cases[0].exp_errno)) {
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 12c3b84..9a65d63 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -1,5 +1,6 @@
 /******************************************************************************/
 /* Copyright (c) Crackerjack Project., 2007                                   */
+/* Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.      */
 /*                                                                            */
 /* This program is free software;  you can redistribute it and/or modify      */
 /* it under the terms of the GNU General Public License as published by       */
@@ -46,6 +47,7 @@
 #include <sys/syscall.h>
 #include <string.h>
 
+#define LTP_RT_SIG_TEST
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
@@ -133,6 +135,31 @@ void handler(int sig)
 
 int set_handler(int sig, int sig_to_mask, int mask_flags)
 {
+#ifdef __sparc__
+	struct sigaction sa;
+	struct kernel_sigaction kact, koact;
+# ifdef __arch64__
+	unsigned long stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+# else
+	unsigned long stub = ((unsigned long) &__sigreturn_stub) - 8;
+# endif
+
+	sigemptyset(&sa.sa_mask);
+	sigaddset(&sa.sa_mask, sig_to_mask);
+
+	kact.k_sa_handler = (void *) handler;
+	kact.sa_flags = 0;
+	kact.sa_restorer = NULL;
+	memcpy(&kact.sa_mask, &sa.sa_mask, sizeof(sigset_t));
+
+	TEST(ltp_syscall(__NR_rt_sigaction,
+			sig, &kact, &koact, stub, INVAL_SIGSETSIZE));
+	if (TEST_RETURN == 0)
+		return 0;
+	else
+		return TEST_RETURN;
+
+#else
 	struct sigaction sa, oldaction;
 
 	sa.sa_sigaction = (void *)handler;
@@ -154,6 +181,7 @@ int set_handler(int sig, int sig_to_mask, int mask_flags)
 	} else {
 		return TEST_RETURN;
 	}
+#endif
 }
 
 int main(int ac, char **av)
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 1dbed72..582098c 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -1,5 +1,6 @@
 /******************************************************************************/
 /* Copyright (c) Crackerjack Project., 2007                                   */
+/* Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.      */
 /*                                                                            */
 /* This program is free software;  you can redistribute it and/or modify      */
 /* it under the terms of the GNU General Public License as published by       */
@@ -130,17 +131,30 @@ void sig_handler(int sig)
 
 int main(int ac, char **av)
 {
-#if __x86_64
+#ifdef __sparc__
+	struct kernel_sigaction kact, koact;
+# ifdef __arch64__
+	unsigned long stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+# else
+	unsigned long stub = ((unsigned long) &__sigreturn_stub) - 8;
+# endif
+	sig_initial(TEST_SIG);
+	kact.sa_flags = 0;
+	kact.k_sa_handler = (void *) sig_handler;
+	kact.sa_restorer = NULL;
+#else
+# ifdef __x86_64__
 	struct kernel_sigaction act, oact;
 	sig_initial(TEST_SIG);
 	act.sa_flags |= SA_RESTORER;
 	act.sa_restorer = restore_rt;
 	act.k_sa_handler = sig_handler;
-#else
+# else
 	struct sigaction act, oact;
 	memset(&act, 0, sizeof(act));
 	memset(&oact, 0, sizeof(oact));
 	act.sa_handler = sig_handler;
+# endif
 #endif
 	sigset_t set, oset;
 	int lc;
@@ -166,8 +180,14 @@ int main(int ac, char **av)
 			}
 
 			/* call rt_sigaction() */
+#ifdef __sparc__
+			TEST(ltp_syscall(__NR_rt_sigaction, TEST_SIG,
+					&kact, &koact, stub,
+					SIGSETSIZE));
+#else
 			TEST(ltp_syscall(__NR_rt_sigaction, TEST_SIG, &act,
 				&oact, SIGSETSIZE));
+#endif
 			if (TEST_RETURN < 0) {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "rt_sigaction call failed");
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index d14cdf8..4b73940 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -1,5 +1,6 @@
 /********************************************************************************/
 /* Copyright (c) Crackerjack Project., 2007				   	*/
+/* Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.        */
 /*									    	*/
 /* This program is free software;  you can redistribute it and/or modify      	*/
 /* it under the terms of the GNU General Public License as published by       	*/
@@ -128,7 +129,22 @@ int main(int ac, char **av)
 		if (sigemptyset(&set) < 0) {
 			tst_brkm(TFAIL | TERRNO, cleanup, "sigemptyset failed");
 		}
-#ifdef __x86_64__
+#ifdef __sparc__
+		struct kernel_sigaction act, oact;
+# ifdef __arch64__
+		unsigned long stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
+# else
+		unsigned long stub = ((unsigned long) &__sigreturn_stub) - 8;
+# endif
+		sig_initial(SIGALRM);
+		act.k_sa_handler = (void *)sig_handler;
+		act.sa_flags = 0;
+		act.sa_restorer = NULL;
+
+		TEST(ltp_syscall(__NR_rt_sigaction, SIGALRM, &act, &oact,
+				stub, SIGSETSIZE));
+#else
+# ifdef __x86_64__
 		struct kernel_sigaction act, oact;
 		sig_initial(SIGALRM);
 		memset(&act, 0, sizeof(act));
@@ -136,15 +152,15 @@ int main(int ac, char **av)
 		act.sa_flags |= SA_RESTORER;
 		act.sa_restorer = restore_rt;
 		act.k_sa_handler = sig_handler;
-#else
+# else
 		struct sigaction act, oact;
 		memset(&act, 0, sizeof(act));
 		memset(&oact, 0, sizeof(oact));
 		act.sa_handler = sig_handler;
-#endif
-
+# endif
 		TEST(ltp_syscall(__NR_rt_sigaction, SIGALRM, &act, &oact,
 			     SIGSETSIZE));
+#endif
 		if (TEST_RETURN == -1) {
 			tst_brkm(TFAIL | TTERRNO, cleanup,
 				 "rt_sigaction failed");
-- 
1.7.1


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

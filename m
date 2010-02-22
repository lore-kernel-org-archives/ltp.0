Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NjUQY-0002DQ-Ac
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 09:18:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjUQS-0007Ox-1p
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 09:18:06 +0000
Message-ID: <4B824C61.9050401@cn.fujitsu.com>
Date: Mon, 22 Feb 2010 17:20:33 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

- rt_sigaction01
On arch x86_64, if we directly get to call syscall 
rt_sigaction, there will be "segment fault".
1) One reason is that we must supply the flag of 
"SA_RESTORER" and the correct pointer to the fuction 
"restorer", according to the kernel code.
2) The other reason is that default syscall rt_sigaction 
use kernel "sigaction" structure, which is different 
with normal "sigaction" structure.

So, 
1) We manage to find the address of the function 
"restorer" by using glibc function "sigaction", 
which might be something tricky. Then we add these 
arguments to make test run correctly.
2) We also use kernel "sigaction" structure to fit 
realtime syscall __NR_rt_sigaction.

- rt_sigprocmask01
First, there exsits the same problem as rt_sigaction01.
Second, this testcase uses a unchanged signal number 33, 
which may diff among different archs and lead to error
"unknown signal".

So, we use a macro TEST_SIG which refers to SIGRTMIN+1 
to replace 33.

- rt_sigsuspend01
There exists the same problem as rt_sigaction01.

This patch fixed these failure.

Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

---
 include/rt_signal.h                                |   60 +++++++++++++++++
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   69 ++++++++++++--------
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   32 +++++++---
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   13 ++++-
 4 files changed, 136 insertions(+), 38 deletions(-)
 create mode 100644 include/rt_signal.h

diff --git a/include/rt_signal.h b/include/rt_signal.h
new file mode 100644
index 0000000..ea1e7e3
--- /dev/null
+++ b/include/rt_signal.h
@@ -0,0 +1,60 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Liu Bo <liubo2009@cn.fujitsu.com>                                  */
+/*                                                                            */
+/******************************************************************************/
+
+#ifndef __LTP_SIGNAL_H
+#define __LTP_SIGNAL_H
+
+/* We do not globally define the SA_RESTORER flag so do it here.  */
+#define HAVE_SA_RESTORER
+#define SA_RESTORER 0x04000000
+
+struct kernel_sigaction {
+	__sighandler_t k_sa_handler;
+	unsigned long sa_flags;
+	void (*sa_restorer) (void);
+	sigset_t sa_mask;
+};
+
+void (*restore_rt) (void);
+
+void
+handler_h(void)
+{
+	return;
+}
+
+/* initial restore_rt for x86_64 */
+void
+sig_initial(int sig)
+{
+	struct sigaction act, oact;
+
+	act.sa_handler = (void *)handler_h;
+	sigemptyset(&act.sa_mask);
+	sigaddset(&act.sa_mask, sig);
+	/* copy act.sa_restorer to kernel */
+	sigaction(sig, &act, &oact);
+	/* copy oact.sa_restorer from kernel */
+	sigaction(sig, &act, &oact);
+	restore_rt = oact.sa_restorer;
+}
+#endif
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index ffc5fa2..c8f5d5f 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -55,6 +55,10 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
+#ifdef __x86_64__
+#include "rt_signal.h"
+#endif
+
 /*
  * For all but __mips__:
  *
@@ -101,13 +105,14 @@ int  TST_TOTAL = 1;                   /* total number of tests in this file.   *
 /*              On success - Exits calling tst_exit(). With '0' return code.  */
 /*                                                                            */
 /******************************************************************************/
-extern void cleanup() {
-        /* Remove tmp dir and all files in it */
-        TEST_CLEANUP;
-        tst_rmdir();
+extern void cleanup() 
+{
+	/* Remove tmp dir and all files in it */
+	TEST_CLEANUP;
+	tst_rmdir();
 
-        /* Exit with appropriate return code. */
-        tst_exit();
+	/* Exit with appropriate return code. */
+	tst_exit();
 }
 
 /* Local  Functions */
@@ -128,11 +133,12 @@ extern void cleanup() {
 /*              On success - returns 0.                                       */
 /*                                                                            */
 /******************************************************************************/
-void setup() {
-        /* Capture signals if any */
-        /* Create temporary directories */
-        TEST_PAUSE;
-        tst_tmpdir();
+void setup() 
+{
+	/* Capture signals if any */
+	/* Create temporary directories */
+	TEST_PAUSE;
+	tst_tmpdir();
 }
 
 int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND, SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
@@ -144,22 +150,23 @@ handler(int sig)
         tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
         return;
 }
-
 int
-set_handler(int sig, int sig_to_mask, int mask_flags)
+set_handler(int sig, int mask_flags)
 {
-        struct sigaction sa, oldaction;
-
-                sa.sa_sigaction = (void *)handler;
-                sa.sa_flags = mask_flags;
-                sigemptyset(&sa.sa_mask);
-                sigaddset(&sa.sa_mask, sig_to_mask);
-                TEST(syscall(__NR_rt_sigaction,sig, &sa, &oldaction,SIGSETSIZE));
-        if (TEST_RETURN == 0) {
-                return 0;
-        } else {
-                        return TEST_RETURN;
-        }
+#ifdef __x86_64__
+	struct kernel_sigaction sa, oldaction;
+	mask_flags |= SA_RESTORER;
+	sa.sa_restorer = restore_rt;
+	sa.k_sa_handler = (void *)handler;
+#else
+	struct sigaction sa, oldaction;
+	sa.sa_handler = (void *)handler;
+#endif
+	sa.sa_flags = mask_flags;
+	sigemptyset(&sa.sa_mask);
+	sigaddset(&sa.sa_mask, sig);
+	TEST(syscall(__NR_rt_sigaction,sig, &sa, &oldaction,SIGSETSIZE));
+	return TEST_RETURN;
 }
 
 
@@ -167,6 +174,7 @@ int main(int ac, char **av) {
 	int signal, flag;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
+	int fc;			/* flag counter */
 	
         /* parse standard options */
         if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
@@ -179,11 +187,16 @@ int main(int ac, char **av) {
         /* Check looping state if -i option given */
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
-                for (testno = 0; testno < TST_TOTAL; ++testno) {
+		fc = sizeof (test_flags) / sizeof (test_flags[0]);
+
+		for (testno = 0; testno < TST_TOTAL; ++testno) {
                 
 			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal for 34 to 65 
-			 	for(flag=0; flag<5;flag++) {
-	                        	 TEST(set_handler(signal, 0, test_flags[flag]));
+#ifdef __x86_64__
+				sig_initial(signal);
+#endif
+				for(flag=0; flag<fc;flag++) {
+	                        	 TEST(set_handler(signal, test_flags[flag]));
 						 if (TEST_RETURN == 0) {
         					tst_resm(TINFO,"signal: %d ", signal);
         					tst_resm(TPASS, "rt_sigaction call succeeded: result = %ld ",TEST_RETURN );
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 6398a28..5b292b2 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -62,6 +62,12 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
+#ifdef __x86_64__
+#include "rt_signal.h"
+#endif
+
+#define TEST_SIG SIGRTMIN+1
+
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
@@ -131,7 +137,16 @@ void sig_handler(int sig)
 }
 
 int main(int ac, char **av) {
-	struct sigaction act, oact;
+#ifdef __x86_64__
+	struct kernel_sigaction act, oact;
+	sig_initial(TEST_SIG);
+	act.sa_flags |= SA_RESTORER;
+        act.sa_restorer = restore_rt;
+        act.k_sa_handler = sig_handler;
+#else
+        struct sigaction act, oact;
+        act.sa_handler = sig_handler;
+#endif
         sigset_t set, oset;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
@@ -154,22 +169,21 @@ int main(int ac, char **av) {
                         	cleanup();
 				tst_exit();
 			}
-			TEST(sigaddset(&set, 33));
+			TEST(sigaddset(&set, TEST_SIG));
 			if(TEST_RETURN == -1){
 				tst_resm(TFAIL,"Call to sigaddset() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         	cleanup();
 				tst_exit();
 			}
-			
+				
 			/* call rt_sigaction() */
-			act.sa_handler = sig_handler;
-                        TEST(syscall(__NR_rt_sigaction, 33, &act, &oact, 8));
+                        TEST(syscall(__NR_rt_sigaction, TEST_SIG, &act, &oact, 8));
 			if(TEST_RETURN != 0){
 				tst_resm(TFAIL,"Call to rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         	cleanup();
 				tst_exit();
 			}
-			/* call rt_sigprocmask() to block signal#33 */
+			/* call rt_sigprocmask() to block signal#SIGRTMIN */
                         TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set, &oset, 8));
 			if(TEST_RETURN == -1){
 				tst_resm(TFAIL,"Call to rt_sigprocmask()**** Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
@@ -178,7 +192,7 @@ int main(int ac, char **av) {
 			}
 			
 			else {
-				TEST(kill(getpid(), 33));
+				TEST(kill(getpid(), TEST_SIG));
 				if(TEST_RETURN != 0){
 					tst_resm(TFAIL,"Call to kill() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         		cleanup();
@@ -198,13 +212,13 @@ int main(int ac, char **av) {
                         			cleanup();
 						tst_exit();
 					}
-					TEST(sigismember(&oset, 33));
+					TEST(sigismember(&oset, TEST_SIG));
 					if(TEST_RETURN == 0 ){
 						tst_resm(TFAIL,"call sigismember() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         			cleanup();
 						tst_exit();
 					}
-					/* call rt_sigprocmask() to unblock signal#33 */
+					/* call rt_sigprocmask() to unblock signal#SIGRTMIN */
 					TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, 8));
 					if(TEST_RETURN == -1){
 						tst_resm(TFAIL,"Call to rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index 416a7c9..84f2967 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -47,6 +47,10 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
+#ifdef __x86_64__
+#include "rt_signal.h"
+#endif
+
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
@@ -139,9 +143,16 @@ int main(int ac, char **av) {
 				cleanup();
 				tst_exit();
 			}
+#ifdef __x86_64__
+		        struct kernel_sigaction act, oact;
+			sig_initial(SIGALRM);
+			act.sa_flags |= SA_RESTORER;
+			act.sa_restorer = restore_rt;
+			act.k_sa_handler = sig_handler;			
+#else
 			struct sigaction act, oact;
 		        act.sa_handler = sig_handler;
-			
+#endif
 			TEST(syscall(__NR_rt_sigaction, SIGALRM, &act, &oact, 8));
 			if(TEST_RETURN == -1){
 		        	tst_resm(TFAIL,"rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
-- 
1.6.2.2




------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

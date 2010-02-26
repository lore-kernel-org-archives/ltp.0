Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NkpsC-0006cE-4W
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 02:24:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nkps8-0005hU-M0
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 02:24:12 +0000
Message-ID: <4B87173E.2040609@cn.fujitsu.com>
Date: Fri, 26 Feb 2010 08:35:10 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B82143D.5050006@cn.fujitsu.com>	
	<364299f41002212356g2a4ceb09o3d271e31b388fe51@mail.gmail.com>	
	<4B8249A7.3040401@cn.fujitsu.com>	
	<364299f41002221005l7df3ceafhaeb6a49b17ee0fed@mail.gmail.com>	
	<4B832856.3050305@cn.fujitsu.com> <4B862614.5020401@cn.fujitsu.com>
	<364299f41002250200xd1d81d5g6d96521df9235e4f@mail.gmail.com>
In-Reply-To: <364299f41002250200xd1d81d5g6d96521df9235e4f@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------070403020103010803070308"
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070403020103010803070308
Content-Type: multipart/alternative;
	boundary="------------010908010903060403080606"


--------------010908010903060403080606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 02/25/2010 06:00 PM, Garrett Cooper wrote:
> On Wed, Feb 24, 2010 at 11:26 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
>   
>> Hi Garrett,
>>
>>     I figured that this patch has not been merged into ltp-cvs.
>>     Is there some else problems about this patch?
>>
>> Thanks,
>> Liubo
>>     
>
>     I tried looking at it this weekend and got sidetracked (hint:
> please provide me with a complete patchable diff, preferably as a file
> attachment).
> Thanks!
> -Garrett
>
>
>   
Sure, see attachment.

Thanks,
Liubo


--------------010908010903060403080606
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 02/25/2010 06:00 PM, Garrett Cooper wrote:
<blockquote
 cite="mid:364299f41002250200xd1d81d5g6d96521df9235e4f@mail.gmail.com"
 type="cite">
  <pre wrap="">On Wed, Feb 24, 2010 at 11:26 PM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi Garrett,

&nbsp;&nbsp;&nbsp; I figured that this patch has not been merged into ltp-cvs.
&nbsp;&nbsp;&nbsp; Is there some else problems about this patch?

Thanks,
Liubo
    </pre>
  </blockquote>
  <pre wrap=""><!---->
    I tried looking at it this weekend and got sidetracked (hint:
please provide me with a complete patchable diff, preferably as a file
attachment).
Thanks!
-Garrett


  </pre>
</blockquote>
Sure, see attachment.<br>
<br>
Thanks,<br>
Liubo<br>
<br>
</body>
</html>

--------------010908010903060403080606--

--------------070403020103010803070308
Content-Type: text/plain;
 name="0001-rt_sig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-rt_sig.patch"

From 4c61e30a2006726346550d8627465e1b2e4050cf Mon Sep 17 00:00:00 2001
From: mapleapple <mapleapple@localhost.localdomain>
Date: Mon, 22 Feb 2010 17:12:29 +0800
Subject: [PATCH] rt_sig

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


--------------070403020103010803070308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--------------070403020103010803070308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070403020103010803070308--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MMkyT-0001t7-MT
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 15:46:53 +0000
Received: from mail-qy0-f200.google.com ([209.85.221.200])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMkyM-0002T8-8O
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 15:46:53 +0000
Received: by qyk38 with SMTP id 38so2760240qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 03 Jul 2009 08:46:45 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 3 Jul 2009 21:16:45 +0530
Message-ID: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=0015175cd852404142046dcf1091
Subject: [LTP] [FIX PATCHE] rt_sigaction
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
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

--0015175cd852404142046dcf1091
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have divided rt_sigaction01.c test case in to three test cases

1. rt_sigaction01.c (Functionality)
2. rt_sigaction02.c (EFAULT)
3. rt_sigaction03.c (EINVAL)

In these test cases rt_sigaction use signal number from SIGRTMIN (34)
to  SIGRTMAX (64).The Real Time (RT) signals will start from 34 to 64
as per signal.h because sigaction is testing from 1 to 30 signals I
hope.

If you want to test 1 to 64 signals by rt_sigaction signal number 9
and 19 i.e SIGKILL and SIGTERM will FAIL, because as per
Specifications we should not use SIGKILL and SIGTERM signals with
rt_sigaction/sigaction.

long sys_rt_sigaction (int sig, const struct sigaction *act, struct
sigaction *oact, size_t sigsetsize)

SIGSETSIZE is different for different architectures that is taken care
 for ARM, PowerPC, X86 and MIPS in this patch.

Subrata,

Coding style is not as LTP, I did not get much time to fix this.
If you are using any indent for LTP, please share I will use those
script to fix coding style.

If any body is interested to fix coding style issue please welcome... :-)


I have attached fix patch and below.
Please review the same.

Best regards
Naresh Kamboju

/*******************************************************/
Test Start Time: Fri Jul  3 07:52:04 2009
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
rt_sigaction01                 PASS       0
rt_sigaction02                 PASS       0
rt_sigaction03                 PASS       0

-----------------------------------------------
Total Tests: 3
Total Failures: 0
Kernel Version: 2.6.23.17-alp_nl-pc-g56b4520c-dirty
Machine Architecture: i686
Hostname: 43.88.101.228
************************************************************/

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	2009-05-21
23:50:58.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	2009-07-03
19:38:41.000000000 +0530
@@ -55,6 +55,15 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"

+#if defined __mips__
+#define SIGSETSIZE 16
+#endif
+
+#if defined __arm__ || __i386__ || __powerpc__
+#define SIGSETSIZE 8
+#endif
+
+
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
@@ -117,58 +126,35 @@
 }

 int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
+char *test_flags_list[] = {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};

 void
 handler(int sig)
 {
-        tst_resm(TINFO,"Here is signal handler. Got signal: %d, do
nothing here\n", sig);
+        tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
         return;
 }

 int
-set_handler(int sig, int sig_to_mask, int flag, int mask_flags)
+set_handler(int sig, int sig_to_mask, int mask_flags)
 {
         struct sigaction sa, oldaction;
-        int err = 0;

-        if (flag == 0) {
-                tst_resm(TINFO,"flag0 - ");
-                sa.sa_sigaction = (void *)handler;
-                sa.sa_flags = mask_flags;
-                TEST(sigemptyset(&sa.sa_mask));
-                TEST(sigaddset(&sa.sa_mask, sig_to_mask));
-                TEST(err = syscall(__NR_rt_sigaction,sig, &sa, NULL,8));
-        } else if (flag == 1) {
-                tst_resm(TINFO,"flag1 - ");
-                TEST(err = syscall(__NR_rt_sigaction,sig, (void *)-1, NULL,8));
-        } else if (flag == 2) {
-               	tst_resm(TINFO,"flag2 - ");
-                TEST(err = syscall(__NR_rt_sigaction,sig, NULL, (void *)-1,8));
-	} else if (flag == 3) {
-                tst_resm(TINFO,"flag3 - ");
                 sa.sa_sigaction = (void *)handler;
                 sa.sa_flags = mask_flags;
-                TEST(sigemptyset(&sa.sa_mask));
-                TEST(sigaddset(&sa.sa_mask, sig_to_mask));
-                TEST(err = syscall(__NR_rt_sigaction,sig, &sa, &oldaction, 8));
-                if (TEST_RETURN == 0) {
-                        return 0;
-                } else {
-                        return TEST_ERRNO;
-                }
-        } else if (flag == 4){
-                        TEST(err = syscall(__NR_rt_sigaction,sig,
&sa, NULL,9));
-        }
+                sigemptyset(&sa.sa_mask);
+                sigaddset(&sa.sa_mask, sig_to_mask);
+                TEST(syscall(__NR_rt_sigaction,sig, &sa,
&oldaction,SIGSETSIZE));
         if (TEST_RETURN == 0) {
                 return 0;
         } else {
-                return TEST_ERRNO;
+                        return TEST_RETURN;
         }
 }


 int main(int ac, char **av) {
-	int retnval, i, j;
+	int signal, flag;
         int lc;                 /* loop counter */
         char *msg;              /* message returned from parse_opts */
 	
@@ -185,24 +171,26 @@
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {

-			for (i = 0; i <= (SIGRTMAX + 1); i++){//signal for 0 to 65
-	    			tst_resm(TINFO,"Signal : %d",i);
-			                for (j = 0; j < 4; j++){
-			                       	 TEST(retnval = set_handler(i, 0, j,
test_flags[j]));
+			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal
for 34 to 65
+			 	for(flag=0; flag<5;flag++) {
+	                        	 TEST(set_handler(signal, 0, test_flags[flag]));
 						 if (TEST_RETURN == 0) {
-        						tst_resm(TPASS, "rt_sigaction call succeeded: result =
%d",TEST_RETURN);
+        					tst_resm(TINFO,"signal: %d ", signal);
+        					tst_resm(TPASS, "rt_sigaction call succeeded: result =
%d ",TEST_RETURN );
+        					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
+						kill(getpid(),signal);
 			                         } else {
                  	   				tst_resm(TFAIL, "%s failed - errno = %d :
%s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-							cleanup();
-							tst_exit();
                        				}
                 			}
+		 	printf("\n");	
         		}



                 }
         }	
+	cleanup();
         tst_exit();
 }

diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c	1970-01-01
05:30:00.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c	2009-07-03
19:24:26.000000000 +0530
@@ -0,0 +1,183 @@
+/******************************************************************************/
+/* Copyright (c) Crackerjack Project., 2007
        */
+/*
        */
+/* This program is free software;  you can redistribute it and/or
modify      */
+/* it under the terms of the GNU General Public License as published
by       */
+/* the Free Software Foundation; either version 2 of the License, or
        */
+/* (at your option) any later version.
        */
+/*
        */
+/* This program is distributed in the hope that it will be useful,
        */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
        */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
        */
+/* the GNU General Public License for more details.
        */
+/*
        */
+/* You should have received a copy of the GNU General Public License
        */
+/* along with this program;  if not, write to the Free Software
        */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA    */
+/*
        */
+/******************************************************************************/
+/******************************************************************************/
+/*
        */
+/* File:        rt_sigaction02.c
        */
+/*
        */
+/* Description: This tests the rt_sigaction() syscall
        */
+/*		rt_sigaction Expected EFAULT error check                      */
+/*
        */
+/* Usage:  <for command-line>
        */
+/* rt_sigaction02 [-c n] [-e][-i n] [-I x] [-p x] [-t]
        */
+/*      where,  -c n : Run n copies concurrently.
        */
+/*              -e   : Turn on errno logging.
        */
+/*              -i n : Execute test n times.
        */
+/*              -I x : Execute test for x seconds.
        */
+/*              -P x : Pause for x seconds between iterations.
        */
+/*              -t   : Turn on syscall timing.
        */
+/*
        */
+/* Total Tests: 1
        */
+/*
        */
+/* Test Name:   rt_sigaction02                                             */
+/* History:     Porting from Crackerjack to LTP is done by
        */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>
        */
+/******************************************************************************/
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <errno.h>
+#include <sys/syscall.h>
+#include <string.h>
+
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+
+#if defined __mips__
+#define SIGSETSIZE 16
+#endif
+
+#if defined __arm__ || __i386__ || __powerpc__
+#define SIGSETSIZE 8
+#endif
+
+#define INVAL_STRUCT -1
+
+/* Extern Global Variables */
+extern int Tst_count;           /* counter for tst_xxx routines.         */
+extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID = "rt_sigaction02";  /* Test program identifier.*/
+int  testno;
+int  TST_TOTAL = 1;                   /* total number of tests in
this file.   */
+
+/* Extern Global Functions */
+/******************************************************************************/
+/*
        */
+/* Function:    cleanup
        */
+/*
        */
+/* Description: Performs all one time clean up for this test on
successful    */
+/*              completion,  premature exit or  failure. Closes all
temporary */
+/*              files, removes all temporary directories exits the
test with  */
+/*              appropriate return code by calling tst_exit()
function.       */
+/*
        */
+/* Input:       None.
        */
+/*
        */
+/* Output:      None.
        */
+/*
        */
+/* Return:      On failure - Exits calling tst_exit(). Non '0' return
code.   */
+/*              On success - Exits calling tst_exit(). With '0'
return code.  */
+/*
        */
+/******************************************************************************/
+extern void cleanup() {
+        /* Remove tmp dir and all files in it */
+        TEST_CLEANUP;
+        tst_rmdir();
+
+        /* Exit with appropriate return code. */
+        tst_exit();
+}
+
+/* Local  Functions */
+/******************************************************************************/
+/*
        */
+/* Function:    setup
        */
+/*
        */
+/* Description: Performs all one time setup for this test. This
function is   */
+/*              typically used to capture signals, create temporary
dirs      */
+/*              and temporary files that may be used in the course of
this    */
+/*              test.
        */
+/*
        */
+/* Input:       None.
        */
+/*
        */
+/* Output:      None.
        */
+/*
        */
+/* Return:      On failure - Exits by calling cleanup().
        */
+/*              On success - returns 0.
        */
+/*
        */
+/******************************************************************************/
+void setup() {
+        /* Capture signals if any */
+        /* Create temporary directories */
+        TEST_PAUSE;
+        tst_tmpdir();
+}
+
+int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
+char *test_flags_list[] = {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
+
+struct test_case_t {
+        int exp_errno;
+        char *errdesc;
+} test_cases[] = {
+	{ EFAULT, "EFAULT" }
+};
+
+
+int main(int ac, char **av) {
+	int signal, flag;
+        int lc;                 /* loop counter */
+        char *msg;              /* message returned from parse_opts */
+	
+        /* parse standard options */
+        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) !=
(char *)NULL){
+             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+             tst_exit();
+           }
+
+        setup();
+
+        /* Check looping state if -i option given */
+        for (lc = 0; TEST_LOOPING(lc); ++lc) {
+                Tst_count = 0;
+                for (testno = 0; testno < TST_TOTAL; ++testno) {
+
+			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal
for 34 to 65
+			 	for(flag=0; flag<5;flag++) {
+
+				/*   							        *
+				 * long sys_rt_sigaction (int sig, const struct sigaction *act, *
+				 * truct sigaction *oact, size_t sigsetsize);			*
+				 * EFAULT:							*
+		        	 * An invalid act or oact value was specified 			*
+				 */
+
+					 TEST(syscall(__NR_rt_sigaction,signal, INVAL_STRUCT, NULL,SIGSETSIZE));
+					if((TEST_RETURN == -1) && (TEST_ERRNO == test_cases[0].exp_errno)) {
+        						tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
+                 	   				tst_resm(TPASS, "%s failure with sig: %d as
expected errno  = %s : %s", TCID, signal,test_cases[0].errdesc,
strerror(TEST_ERRNO));
+			                         } else {
+        					tst_resm(TFAIL, "rt_sigaction call succeeded: result =
%d got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO,
test_cases[0].exp_errno);
+        					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
+						}
+                			}
+		 	printf("\n");	
+        		}
+
+
+
+                }
+        }	
+	cleanup();
+        tst_exit();
+}
+
diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c	1970-01-01
05:30:00.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c	2009-07-03
19:24:12.000000000 +0530
@@ -0,0 +1,200 @@
+/******************************************************************************/
+/* Copyright (c) Crackerjack Project., 2007
        */
+/*
        */
+/* This program is free software;  you can redistribute it and/or
modify      */
+/* it under the terms of the GNU General Public License as published
by       */
+/* the Free Software Foundation; either version 2 of the License, or
        */
+/* (at your option) any later version.
        */
+/*
        */
+/* This program is distributed in the hope that it will be useful,
        */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
        */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
        */
+/* the GNU General Public License for more details.
        */
+/*
        */
+/* You should have received a copy of the GNU General Public License
        */
+/* along with this program;  if not, write to the Free Software
        */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA    */
+/*
        */
+/******************************************************************************/
+/******************************************************************************/
+/*
        */
+/* File:        rt_sigaction03.c
        */
+/*
        */
+/* Description: This tests the rt_sigaction() syscall
        */
+/*		rt_sigaction Expected EINVAL error check                      */
+/*
        */
+/* Usage:  <for command-line>
        */
+/* rt_sigaction03 [-c n] [-e][-i n] [-I x] [-p x] [-t]
        */
+/*      where,  -c n : Run n copies concurrently.
        */
+/*              -e   : Turn on errno logging.
        */
+/*              -i n : Execute test n times.
        */
+/*              -I x : Execute test for x seconds.
        */
+/*              -P x : Pause for x seconds between iterations.
        */
+/*              -t   : Turn on syscall timing.
        */
+/*
        */
+/* Total Tests: 1
        */
+/*
        */
+/* Test Name:   rt_sigaction03                                             */
+/* History:     Porting from Crackerjack to LTP is done by
        */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>
        */
+/******************************************************************************/
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <errno.h>
+#include <sys/syscall.h>
+#include <string.h>
+
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+
+#define INVAL_SIGSETSIZE -1
+
+/* Extern Global Variables */
+extern int Tst_count;           /* counter for tst_xxx routines.         */
+extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID = "rt_sigaction03";  /* Test program identifier.*/
+int  testno;
+int  TST_TOTAL = 1;                   /* total number of tests in
this file.   */
+
+/* Extern Global Functions */
+/******************************************************************************/
+/*
        */
+/* Function:    cleanup
        */
+/*
        */
+/* Description: Performs all one time clean up for this test on
successful    */
+/*              completion,  premature exit or  failure. Closes all
temporary */
+/*              files, removes all temporary directories exits the
test with  */
+/*              appropriate return code by calling tst_exit()
function.       */
+/*
        */
+/* Input:       None.
        */
+/*
        */
+/* Output:      None.
        */
+/*
        */
+/* Return:      On failure - Exits calling tst_exit(). Non '0' return
code.   */
+/*              On success - Exits calling tst_exit(). With '0'
return code.  */
+/*
        */
+/******************************************************************************/
+extern void cleanup() {
+        /* Remove tmp dir and all files in it */
+        TEST_CLEANUP;
+        tst_rmdir();
+
+        /* Exit with appropriate return code. */
+        tst_exit();
+}
+
+/* Local  Functions */
+/******************************************************************************/
+/*
        */
+/* Function:    setup
        */
+/*
        */
+/* Description: Performs all one time setup for this test. This
function is   */
+/*              typically used to capture signals, create temporary
dirs      */
+/*              and temporary files that may be used in the course of
this    */
+/*              test.
        */
+/*
        */
+/* Input:       None.
        */
+/*
        */
+/* Output:      None.
        */
+/*
        */
+/* Return:      On failure - Exits by calling cleanup().
        */
+/*              On success - returns 0.
        */
+/*
        */
+/******************************************************************************/
+void setup() {
+        /* Capture signals if any */
+        /* Create temporary directories */
+        TEST_PAUSE;
+        tst_tmpdir();
+}
+
+int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
+char *test_flags_list[] = {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
+
+
+struct test_case_t {
+        int exp_errno;
+        char *errdesc;
+} test_cases[] = {
+	{ EINVAL, "EINVAL" }
+};
+
+void
+handler(int sig)
+{
+        tst_resm(TINFO,"Signal Handler Called with signal number %d\n",sig);
+        return;
+}
+
+int
+set_handler(int sig, int sig_to_mask, int mask_flags)
+{
+        struct sigaction sa, oldaction;
+
+                sa.sa_sigaction = (void *)handler;
+                sa.sa_flags = mask_flags;
+                sigemptyset(&sa.sa_mask);
+                sigaddset(&sa.sa_mask, sig_to_mask);
+
+		/*   							        *
+		 * long sys_rt_sigaction (int sig, const struct sigaction *act, *
+		 * truct sigaction *oact, size_t sigsetsize);			*
+		 * EINVAL:							*
+        	 * sigsetsize was not equivalent to the size of a sigset_t type *
+		 */
+
+                TEST(syscall(__NR_rt_sigaction,sig, &sa ,
&oldaction,INVAL_SIGSETSIZE));
+                if (TEST_RETURN == 0) {
+                        return 0;
+                } else {
+                        return TEST_RETURN;
+                }
+}
+
+
+int main(int ac, char **av) {
+	int signal, flag;
+        int lc;                 /* loop counter */
+        char *msg;              /* message returned from parse_opts */
+	
+        /* parse standard options */
+        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) !=
(char *)NULL){
+             tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+             tst_exit();
+           }
+
+        setup();
+
+        /* Check looping state if -i option given */
+        for (lc = 0; TEST_LOOPING(lc); ++lc) {
+                Tst_count = 0;
+                for (testno = 0; testno < TST_TOTAL; ++testno) {
+
+			for (signal = SIGRTMIN; signal <= (SIGRTMAX ); signal++){//signal
for 34 to 65
+			 	for(flag=0; flag<5;flag++) {
+	                        	 TEST(set_handler(signal, 0, test_flags[flag]));
+					if((TEST_RETURN == -1) && (TEST_ERRNO == test_cases[0].exp_errno)) {
+        						tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
+                 	   				tst_resm(TPASS, "%s failure with sig: %d as
expected errno  = %s : %s", TCID, signal,test_cases[0].errdesc,
strerror(TEST_ERRNO));
+			                         } else {
+        					tst_resm(TFAIL, "rt_sigaction call succeeded: result =
%d got error %d:but expected  %d", TEST_RETURN, TEST_ERRNO,
test_cases[0].exp_errno);
+        					tst_resm(TINFO, "sa.sa_flags = %s ",test_flags_list[flag]);
+						}
+                			}
+		 	printf("\n");	
+        		}
+
+
+
+                }
+        }	
+	cleanup();
+        tst_exit();
+}
+

--0015175cd852404142046dcf1091
Content-Type: application/octet-stream; name="ltp-rt_sigaction.patch"
Content-Disposition: attachment; filename="ltp-rt_sigaction.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwp211dg0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2FjdGlvbi9ydF9z
aWdhY3Rpb24wMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdhY3Rpb24vcnRf
c2lnYWN0aW9uMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2FjdGlv
bi9ydF9zaWdhY3Rpb24wMS5jCTIwMDktMDUtMjEgMjM6NTA6NTguMDAwMDAwMDAwICswNTMwCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lnYWN0aW9uL3J0X3NpZ2FjdGlvbjAx
LmMJMjAwOS0wNy0wMyAxOTozODo0MS4wMDAwMDAwMDAgKzA1MzAKQEAgLTU1LDYgKzU1LDE1IEBA
CiAjaW5jbHVkZSAidXNjdGVzdC5oIgogI2luY2x1ZGUgImxpbnV4X3N5c2NhbGxfbnVtYmVycy5o
IgogCisjaWYgZGVmaW5lZCBfX21pcHNfXworI2RlZmluZSBTSUdTRVRTSVpFIDE2CisjZW5kaWYK
KworI2lmIGRlZmluZWQgX19hcm1fXyB8fCBfX2kzODZfXyB8fCBfX3Bvd2VycGNfXworI2RlZmlu
ZSBTSUdTRVRTSVpFIDgKKyNlbmRpZgorCisKIC8qIEV4dGVybiBHbG9iYWwgVmFyaWFibGVzICov
CiBleHRlcm4gaW50IFRzdF9jb3VudDsgICAgICAgICAgIC8qIGNvdW50ZXIgZm9yIHRzdF94eHgg
cm91dGluZXMuICAgICAgICAgKi8KIGV4dGVybiBjaGFyICpURVNURElSOyAgICAgICAgICAgLyog
dGVtcG9yYXJ5IGRpciBjcmVhdGVkIGJ5IHRzdF90bXBkaXIoKSAqLwpAQCAtMTE3LDU4ICsxMjYs
MzUgQEAKIH0KIAogaW50IHRlc3RfZmxhZ3NbXSA9IHtTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTywg
U0FfUkVTRVRIQU5ELCBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTywgU0FfUkVTRVRIQU5EfFNBX1NJ
R0lORk8sIFNBX05PTUFTS307CitjaGFyICp0ZXN0X2ZsYWdzX2xpc3RbXSA9IHsiU0FfUkVTRVRI
QU5EfFNBX1NJR0lORk8iLCAiU0FfUkVTRVRIQU5EIiwgIlNBX1JFU0VUSEFORHxTQV9TSUdJTkZP
IiwgIlNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIiwgIlNBX05PTUFTSyJ9OwogCiB2b2lkCiBoYW5k
bGVyKGludCBzaWcpCiB7Ci0gICAgICAgIHRzdF9yZXNtKFRJTkZPLCJIZXJlIGlzIHNpZ25hbCBo
YW5kbGVyLiBHb3Qgc2lnbmFsOiAlZCwgZG8gbm90aGluZyBoZXJlXG4iLCBzaWcpOworICAgICAg
ICB0c3RfcmVzbShUSU5GTywiU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJl
ciAlZFxuIixzaWcpOwogICAgICAgICByZXR1cm47CiB9CiAKIGludAotc2V0X2hhbmRsZXIoaW50
IHNpZywgaW50IHNpZ190b19tYXNrLCBpbnQgZmxhZywgaW50IG1hc2tfZmxhZ3MpCitzZXRfaGFu
ZGxlcihpbnQgc2lnLCBpbnQgc2lnX3RvX21hc2ssIGludCBtYXNrX2ZsYWdzKQogewogICAgICAg
ICBzdHJ1Y3Qgc2lnYWN0aW9uIHNhLCBvbGRhY3Rpb247Ci0gICAgICAgIGludCBlcnIgPSAwOwog
Ci0gICAgICAgIGlmIChmbGFnID09IDApIHsKLSAgICAgICAgICAgICAgICB0c3RfcmVzbShUSU5G
TywiZmxhZzAgLSAiKTsKLSAgICAgICAgICAgICAgICBzYS5zYV9zaWdhY3Rpb24gPSAodm9pZCAq
KWhhbmRsZXI7Ci0gICAgICAgICAgICAgICAgc2Euc2FfZmxhZ3MgPSBtYXNrX2ZsYWdzOwotICAg
ICAgICAgICAgICAgIFRFU1Qoc2lnZW1wdHlzZXQoJnNhLnNhX21hc2spKTsKLSAgICAgICAgICAg
ICAgICBURVNUKHNpZ2FkZHNldCgmc2Euc2FfbWFzaywgc2lnX3RvX21hc2spKTsKLSAgICAgICAg
ICAgICAgICBURVNUKGVyciA9IHN5c2NhbGwoX19OUl9ydF9zaWdhY3Rpb24sc2lnLCAmc2EsIE5V
TEwsOCkpOwotICAgICAgICB9IGVsc2UgaWYgKGZsYWcgPT0gMSkgewotICAgICAgICAgICAgICAg
IHRzdF9yZXNtKFRJTkZPLCJmbGFnMSAtICIpOwotICAgICAgICAgICAgICAgIFRFU1QoZXJyID0g
c3lzY2FsbChfX05SX3J0X3NpZ2FjdGlvbixzaWcsICh2b2lkICopLTEsIE5VTEwsOCkpOwotICAg
ICAgICB9IGVsc2UgaWYgKGZsYWcgPT0gMikgewotICAgICAgICAgICAgICAgCXRzdF9yZXNtKFRJ
TkZPLCJmbGFnMiAtICIpOwotICAgICAgICAgICAgICAgIFRFU1QoZXJyID0gc3lzY2FsbChfX05S
X3J0X3NpZ2FjdGlvbixzaWcsIE5VTEwsICh2b2lkICopLTEsOCkpOwotCX0gZWxzZSBpZiAoZmxh
ZyA9PSAzKSB7Ci0gICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sImZsYWczIC0gIik7CiAg
ICAgICAgICAgICAgICAgc2Euc2Ffc2lnYWN0aW9uID0gKHZvaWQgKiloYW5kbGVyOwogICAgICAg
ICAgICAgICAgIHNhLnNhX2ZsYWdzID0gbWFza19mbGFnczsKLSAgICAgICAgICAgICAgICBURVNU
KHNpZ2VtcHR5c2V0KCZzYS5zYV9tYXNrKSk7Ci0gICAgICAgICAgICAgICAgVEVTVChzaWdhZGRz
ZXQoJnNhLnNhX21hc2ssIHNpZ190b19tYXNrKSk7Ci0gICAgICAgICAgICAgICAgVEVTVChlcnIg
PSBzeXNjYWxsKF9fTlJfcnRfc2lnYWN0aW9uLHNpZywgJnNhLCAmb2xkYWN0aW9uLCA4KSk7Ci0g
ICAgICAgICAgICAgICAgaWYgKFRFU1RfUkVUVVJOID09IDApIHsKLSAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAwOwotICAgICAgICAgICAgICAgIH0gZWxzZSB7Ci0gICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gVEVTVF9FUlJOTzsKLSAgICAgICAgICAgICAgICB9Ci0gICAgICAg
IH0gZWxzZSBpZiAoZmxhZyA9PSA0KXsKLSAgICAgICAgICAgICAgICAgICAgICAgIFRFU1QoZXJy
ID0gc3lzY2FsbChfX05SX3J0X3NpZ2FjdGlvbixzaWcsICZzYSwgTlVMTCw5KSk7Ci0gICAgICAg
IH0KKyAgICAgICAgICAgICAgICBzaWdlbXB0eXNldCgmc2Euc2FfbWFzayk7CisgICAgICAgICAg
ICAgICAgc2lnYWRkc2V0KCZzYS5zYV9tYXNrLCBzaWdfdG9fbWFzayk7CisgICAgICAgICAgICAg
ICAgVEVTVChzeXNjYWxsKF9fTlJfcnRfc2lnYWN0aW9uLHNpZywgJnNhLCAmb2xkYWN0aW9uLFNJ
R1NFVFNJWkUpKTsKICAgICAgICAgaWYgKFRFU1RfUkVUVVJOID09IDApIHsKICAgICAgICAgICAg
ICAgICByZXR1cm4gMDsKICAgICAgICAgfSBlbHNlIHsKLSAgICAgICAgICAgICAgICByZXR1cm4g
VEVTVF9FUlJOTzsKKyAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBURVNUX1JFVFVSTjsK
ICAgICAgICAgfQogfQogCiAKIGludCBtYWluKGludCBhYywgY2hhciAqKmF2KSB7Ci0JaW50IHJl
dG52YWwsIGksIGo7CisJaW50IHNpZ25hbCwgZmxhZzsKICAgICAgICAgaW50IGxjOyAgICAgICAg
ICAgICAgICAgLyogbG9vcCBjb3VudGVyICovCiAgICAgICAgIGNoYXIgKm1zZzsgICAgICAgICAg
ICAgIC8qIG1lc3NhZ2UgcmV0dXJuZWQgZnJvbSBwYXJzZV9vcHRzICovCiAJCkBAIC0xODUsMjQg
KzE3MSwyNiBAQAogICAgICAgICAgICAgICAgIFRzdF9jb3VudCA9IDA7CiAgICAgICAgICAgICAg
ICAgZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7CiAgICAg
ICAgICAgICAgICAgCi0JCQlmb3IgKGkgPSAwOyBpIDw9IChTSUdSVE1BWCArIDEpOyBpKyspey8v
c2lnbmFsIGZvciAwIHRvIDY1IAotCSAgICAJCQl0c3RfcmVzbShUSU5GTywiU2lnbmFsIDogJWQi
LGkpOwotCQkJICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCA0OyBqKyspewotCQkJICAg
ICAgICAgICAgICAgICAgICAgICAJIFRFU1QocmV0bnZhbCA9IHNldF9oYW5kbGVyKGksIDAsIGos
IHRlc3RfZmxhZ3Nbal0pKTsKKwkJCWZvciAoc2lnbmFsID0gU0lHUlRNSU47IHNpZ25hbCA8PSAo
U0lHUlRNQVggKTsgc2lnbmFsKyspey8vc2lnbmFsIGZvciAzNCB0byA2NSAKKwkJCSAJZm9yKGZs
YWc9MDsgZmxhZzw1O2ZsYWcrKykgeworCSAgICAgICAgICAgICAgICAgICAgICAgIAkgVEVTVChz
ZXRfaGFuZGxlcihzaWduYWwsIDAsIHRlc3RfZmxhZ3NbZmxhZ10pKTsKIAkJCQkJCSBpZiAoVEVT
VF9SRVRVUk4gPT0gMCkgewotICAgICAgICAJCQkJCQl0c3RfcmVzbShUUEFTUywgInJ0X3NpZ2Fj
dGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gJWQiLFRFU1RfUkVUVVJOKTsKKyAgICAgICAg
CQkJCQl0c3RfcmVzbShUSU5GTywic2lnbmFsOiAlZCAiLCBzaWduYWwpOworICAgICAgICAJCQkJ
CXRzdF9yZXNtKFRQQVNTLCAicnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAl
ZCAiLFRFU1RfUkVUVVJOICk7CisgICAgICAgIAkJCQkJdHN0X3Jlc20oVElORk8sICJzYS5zYV9m
bGFncyA9ICVzICIsdGVzdF9mbGFnc19saXN0W2ZsYWddKTsKKwkJCQkJCWtpbGwoZ2V0cGlkKCks
c2lnbmFsKTsKIAkJCSAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UgewogICAgICAgICAg
ICAgICAgICAJICAgCQkJCXRzdF9yZXNtKFRGQUlMLCAiJXMgZmFpbGVkIC0gZXJybm8gPSAlZCA6
ICVzIiwgVENJRCwgVEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOwotCQkJCQkJCWNs
ZWFudXAoKTsKLQkJCQkJCQl0c3RfZXhpdCgpOwogICAgICAgICAgICAgICAgICAgICAgICAJCQkJ
fQogICAgICAgICAgICAgICAgIAkJCX0KKwkJIAlwcmludGYoIlxuIik7CQogICAgICAgICAJCX0K
IAogCiAKICAgICAgICAgICAgICAgICB9CiAgICAgICAgIH0JCisJY2xlYW51cCgpOwogICAgICAg
ICB0c3RfZXhpdCgpOwogfQogCmRpZmYgLU5hdXJiIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9ydF9zaWdhY3Rpb24vcnRfc2lnYWN0aW9uMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcnRfc2lnYWN0aW9uL3J0X3NpZ2FjdGlvbjAyLmMKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9ydF9zaWdhY3Rpb24vcnRfc2lnYWN0aW9uMDIuYwkxOTcwLTAxLTAxIDA1OjMwOjAw
LjAwMDAwMDAwMCArMDUzMAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2Fj
dGlvbi9ydF9zaWdhY3Rpb24wMi5jCTIwMDktMDctMDMgMTk6MjQ6MjYuMDAwMDAwMDAwICswNTMw
CkBAIC0wLDAgKzEsMTgzIEBACisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworLyogQ29weXJpZ2h0
IChjKSBDcmFja2VyamFjayBQcm9qZWN0LiwgMjAwNyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKi8KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgICAg
ICAqLworLyogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBhcyBwdWJsaXNoZWQgYnkgICAgICAgKi8KKy8qIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yICAgICAgICAgICovCisv
KiAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qIFRoaXMg
cHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVs
LCAgICAgICAgICAgICovCisvKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2
ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YgICAgICAgICAgICAqLworLyogTUVSQ0hBTlRBQklM
SVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlICAgICAgICAgICAg
ICAgICAgKi8KKy8qIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRh
aWxzLiAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
LworLyogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgICAgICAgICAgKi8KKy8qIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAg
aWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSAgICAgICAgICAgICAgICovCisvKiBG
b3VuZGF0aW9uLCBJbmMuLCA1OSBUZW1wbGUgUGxhY2UsIFN1aXRlIDMzMCwgQm9zdG9uLCBNQSAw
MjExMS0xMzA3IFVTQSAgICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKiovCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworLyogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKi8KKy8qIEZpbGU6ICAgICAgICBydF9zaWdhY3Rpb24wMi5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwor
LyogRGVzY3JpcHRpb246IFRoaXMgdGVzdHMgdGhlIHJ0X3NpZ2FjdGlvbigpIHN5c2NhbGwgICAg
ICAgICAgICAgICAgICAgICAgICAgKi8KKy8qCQlydF9zaWdhY3Rpb24gRXhwZWN0ZWQgRUZBVUxU
IGVycm9yIGNoZWNrICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqLworLyogVXNhZ2U6ICA8Zm9yIGNvbW1hbmQtbGluZT4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qIHJ0X3NpZ2FjdGlvbjAyIFstYyBuXSBb
LWVdWy1pIG5dIFstSSB4XSBbLXAgeF0gWy10XSAgICAgICAgICAgICAgICAgICAgICAgICovCisv
KiAgICAgIHdoZXJlLCAgLWMgbiA6IFJ1biBuIGNvcGllcyBjb25jdXJyZW50bHkuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAgIC1lICAgOiBUdXJuIG9uIGVy
cm5vIGxvZ2dpbmcuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAg
ICAgICAgICAtaSBuIDogRXhlY3V0ZSB0ZXN0IG4gdGltZXMuICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgLUkgeCA6IEV4ZWN1dGUgdGVzdCBmb3Ig
eCBzZWNvbmRzLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAg
IC1QIHggOiBQYXVzZSBmb3IgeCBzZWNvbmRzIGJldHdlZW4gaXRlcmF0aW9ucy4gICAgICAgICAg
ICAgICAgKi8KKy8qICAgICAgICAgICAgICAtdCAgIDogVHVybiBvbiBzeXNjYWxsIHRpbWluZy4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
LworLyogVG90YWwgVGVzdHM6IDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiBU
ZXN0IE5hbWU6ICAgcnRfc2lnYWN0aW9uMDIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqLworLyogSGlzdG9yeTogICAgIFBvcnRpbmcgZnJvbSBDcmFja2VyamFj
ayB0byBMVFAgaXMgZG9uZSBieSAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAgICAg
ICBNYW5hcyBLdW1hciBOYXlhayBtYWtuYXlha0Bpbi5pYm0uY29tPiAgICAgICAgICAgICAgICAg
ICAgICAgICovCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworI2luY2x1ZGUgPHN0ZGlvLmg+Cisj
aW5jbHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c2lnbmFs
Lmg+CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgorI2luY2x1
ZGUgPHN0cmluZy5oPgorCisvKiBIYXJuZXNzIFNwZWNpZmljIEluY2x1ZGUgRmlsZXMuICovCisj
aW5jbHVkZSAidGVzdC5oIgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKyNpbmNsdWRlICJsaW51eF9z
eXNjYWxsX251bWJlcnMuaCIKKworI2lmIGRlZmluZWQgX19taXBzX18KKyNkZWZpbmUgU0lHU0VU
U0laRSAxNgorI2VuZGlmCisKKyNpZiBkZWZpbmVkIF9fYXJtX18gfHwgX19pMzg2X18gfHwgX19w
b3dlcnBjX18KKyNkZWZpbmUgU0lHU0VUU0laRSA4CisjZW5kaWYKKworI2RlZmluZSBJTlZBTF9T
VFJVQ1QgLTEKKworLyogRXh0ZXJuIEdsb2JhbCBWYXJpYWJsZXMgKi8KK2V4dGVybiBpbnQgVHN0
X2NvdW50OyAgICAgICAgICAgLyogY291bnRlciBmb3IgdHN0X3h4eCByb3V0aW5lcy4gICAgICAg
ICAqLworZXh0ZXJuIGNoYXIgKlRFU1RESVI7ICAgICAgICAgICAvKiB0ZW1wb3JhcnkgZGlyIGNy
ZWF0ZWQgYnkgdHN0X3RtcGRpcigpICovCisKKy8qIEdsb2JhbCBWYXJpYWJsZXMgKi8KK2NoYXIg
KlRDSUQgPSAicnRfc2lnYWN0aW9uMDIiOyAgLyogVGVzdCBwcm9ncmFtIGlkZW50aWZpZXIuKi8K
K2ludCAgdGVzdG5vOworaW50ICBUU1RfVE9UQUwgPSAxOyAgICAgICAgICAgICAgICAgICAvKiB0
b3RhbCBudW1iZXIgb2YgdGVzdHMgaW4gdGhpcyBmaWxlLiAgICovCisKKy8qIEV4dGVybiBHbG9i
YWwgRnVuY3Rpb25zICovCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworLyogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKi8KKy8qIEZ1bmN0aW9uOiAgICBjbGVhbnVwICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
LworLyogRGVzY3JpcHRpb246IFBlcmZvcm1zIGFsbCBvbmUgdGltZSBjbGVhbiB1cCBmb3IgdGhp
cyB0ZXN0IG9uIHN1Y2Nlc3NmdWwgICAgKi8KKy8qICAgICAgICAgICAgICBjb21wbGV0aW9uLCAg
cHJlbWF0dXJlIGV4aXQgb3IgIGZhaWx1cmUuIENsb3NlcyBhbGwgdGVtcG9yYXJ5ICovCisvKiAg
ICAgICAgICAgICAgZmlsZXMsIHJlbW92ZXMgYWxsIHRlbXBvcmFyeSBkaXJlY3RvcmllcyBleGl0
cyB0aGUgdGVzdCB3aXRoICAqLworLyogICAgICAgICAgICAgIGFwcHJvcHJpYXRlIHJldHVybiBj
b2RlIGJ5IGNhbGxpbmcgdHN0X2V4aXQoKSBmdW5jdGlvbi4gICAgICAgKi8KKy8qICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICovCisvKiBJbnB1dDogICAgICAgTm9uZS4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKi8KKy8qIE91dHB1dDogICAgICBOb25lLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwor
LyogUmV0dXJuOiAgICAgIE9uIGZhaWx1cmUgLSBFeGl0cyBjYWxsaW5nIHRzdF9leGl0KCkuIE5v
biAnMCcgcmV0dXJuIGNvZGUuICAgKi8KKy8qICAgICAgICAgICAgICBPbiBzdWNjZXNzIC0gRXhp
dHMgY2FsbGluZyB0c3RfZXhpdCgpLiBXaXRoICcwJyByZXR1cm4gY29kZS4gICovCisvKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqLworLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KK2V4dGVybiB2b2lkIGNs
ZWFudXAoKSB7CisgICAgICAgIC8qIFJlbW92ZSB0bXAgZGlyIGFuZCBhbGwgZmlsZXMgaW4gaXQg
Ki8KKyAgICAgICAgVEVTVF9DTEVBTlVQOworICAgICAgICB0c3Rfcm1kaXIoKTsKKworICAgICAg
ICAvKiBFeGl0IHdpdGggYXBwcm9wcmlhdGUgcmV0dXJuIGNvZGUuICovCisgICAgICAgIHRzdF9l
eGl0KCk7Cit9CisKKy8qIExvY2FsICBGdW5jdGlvbnMgKi8KKy8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KiovCisvKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqLworLyogRnVuY3Rpb246ICAgIHNldHVwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8q
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICovCisvKiBEZXNjcmlwdGlvbjogUGVyZm9ybXMgYWxsIG9uZSB0
aW1lIHNldHVwIGZvciB0aGlzIHRlc3QuIFRoaXMgZnVuY3Rpb24gaXMgICAqLworLyogICAgICAg
ICAgICAgIHR5cGljYWxseSB1c2VkIHRvIGNhcHR1cmUgc2lnbmFscywgY3JlYXRlIHRlbXBvcmFy
eSBkaXJzICAgICAgKi8KKy8qICAgICAgICAgICAgICBhbmQgdGVtcG9yYXJ5IGZpbGVzIHRoYXQg
bWF5IGJlIHVzZWQgaW4gdGhlIGNvdXJzZSBvZiB0aGlzICAgICovCisvKiAgICAgICAgICAgICAg
dGVzdC4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qIElucHV0OiAgICAgICBOb25lLiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICov
CisvKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqLworLyogT3V0cHV0OiAgICAgIE5vbmUuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICovCisvKiBSZXR1cm46ICAgICAgT24gZmFpbHVyZSAtIEV4aXRzIGJ5
IGNhbGxpbmcgY2xlYW51cCgpLiAgICAgICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAg
ICAgIE9uIHN1Y2Nlc3MgLSByZXR1cm5zIDAuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKi8KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqLwordm9pZCBzZXR1cCgpIHsKKyAgICAgICAgLyogQ2FwdHVyZSBzaWduYWxzIGlmIGFueSAq
LworICAgICAgICAvKiBDcmVhdGUgdGVtcG9yYXJ5IGRpcmVjdG9yaWVzICovCisgICAgICAgIFRF
U1RfUEFVU0U7CisgICAgICAgIHRzdF90bXBkaXIoKTsKK30KKworaW50IHRlc3RfZmxhZ3NbXSA9
IHtTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTywgU0FfUkVTRVRIQU5ELCBTQV9SRVNFVEhBTkR8U0Ff
U0lHSU5GTywgU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8sIFNBX05PTUFTS307CitjaGFyICp0ZXN0
X2ZsYWdzX2xpc3RbXSA9IHsiU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8iLCAiU0FfUkVTRVRIQU5E
IiwgIlNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIiwgIlNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIiwg
IlNBX05PTUFTSyJ9OworCitzdHJ1Y3QgdGVzdF9jYXNlX3QgeworICAgICAgICBpbnQgZXhwX2Vy
cm5vOworICAgICAgICBjaGFyICplcnJkZXNjOworfSB0ZXN0X2Nhc2VzW10gPSB7CisJeyBFRkFV
TFQsICJFRkFVTFQiIH0KK307CisKKworaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpIHsKKwlp
bnQgc2lnbmFsLCBmbGFnOworICAgICAgICBpbnQgbGM7ICAgICAgICAgICAgICAgICAvKiBsb29w
IGNvdW50ZXIgKi8KKyAgICAgICAgY2hhciAqbXNnOyAgICAgICAgICAgICAgLyogbWVzc2FnZSBy
ZXR1cm5lZCBmcm9tIHBhcnNlX29wdHMgKi8KKwkKKyAgICAgICAgLyogcGFyc2Ugc3RhbmRhcmQg
b3B0aW9ucyAqLworICAgICAgICBpZiAoKG1zZyA9IHBhcnNlX29wdHMoYWMsIGF2LCAob3B0aW9u
X3QgKilOVUxMLCBOVUxMKSkgIT0gKGNoYXIgKilOVUxMKXsKKyAgICAgICAgICAgICB0c3RfYnJr
bShUQlJPSywgY2xlYW51cCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0gJXMiLCBtc2cpOworICAg
ICAgICAgICAgIHRzdF9leGl0KCk7CisgICAgICAgICAgIH0KKworICAgICAgICBzZXR1cCgpOwor
CisgICAgICAgIC8qIENoZWNrIGxvb3Bpbmcgc3RhdGUgaWYgLWkgb3B0aW9uIGdpdmVuICovCisg
ICAgICAgIGZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyArK2xjKSB7CisgICAgICAgICAg
ICAgICAgVHN0X2NvdW50ID0gMDsKKyAgICAgICAgICAgICAgICBmb3IgKHRlc3RubyA9IDA7IHRl
c3RubyA8IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsKKyAgICAgICAgICAgICAgICAKKwkJCWZvciAo
c2lnbmFsID0gU0lHUlRNSU47IHNpZ25hbCA8PSAoU0lHUlRNQVggKTsgc2lnbmFsKyspey8vc2ln
bmFsIGZvciAzNCB0byA2NSAKKwkJCSAJZm9yKGZsYWc9MDsgZmxhZzw1O2ZsYWcrKykgeworCisJ
CQkJLyogICAJCQkJCQkJICAgICAgICAqCisJCQkJICogbG9uZyBzeXNfcnRfc2lnYWN0aW9uIChp
bnQgc2lnLCBjb25zdCBzdHJ1Y3Qgc2lnYWN0aW9uICphY3QsICoKKwkJCQkgKiB0cnVjdCBzaWdh
Y3Rpb24gKm9hY3QsIHNpemVfdCBzaWdzZXRzaXplKTsJCQkqCisJCQkJICogRUZBVUxUOgkJCQkJ
CQkqCisJCSAgICAgICAgCSAqIEFuIGludmFsaWQgYWN0IG9yIG9hY3QgdmFsdWUgd2FzIHNwZWNp
ZmllZCAJCQkqCisJCQkJICovCisKKwkJCQkJIFRFU1Qoc3lzY2FsbChfX05SX3J0X3NpZ2FjdGlv
bixzaWduYWwsIElOVkFMX1NUUlVDVCwgTlVMTCxTSUdTRVRTSVpFKSk7CisJCQkJCWlmKChURVNU
X1JFVFVSTiA9PSAtMSkgJiYgKFRFU1RfRVJSTk8gPT0gdGVzdF9jYXNlc1swXS5leHBfZXJybm8p
KSB7CisgICAgICAgIAkJCQkJCXRzdF9yZXNtKFRJTkZPLCAic2Euc2FfZmxhZ3MgPSAlcyAiLHRl
c3RfZmxhZ3NfbGlzdFtmbGFnXSk7CisgICAgICAgICAgICAgICAgIAkgICAJCQkJdHN0X3Jlc20o
VFBBU1MsICIlcyBmYWlsdXJlIHdpdGggc2lnOiAlZCBhcyBleHBlY3RlZCBlcnJubyAgPSAlcyA6
ICVzIiwgVENJRCwgc2lnbmFsLHRlc3RfY2FzZXNbMF0uZXJyZGVzYywgc3RyZXJyb3IoVEVTVF9F
UlJOTykpOworCQkJICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7CisgICAgICAgIAkJ
CQkJdHN0X3Jlc20oVEZBSUwsICJydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9
ICVkIGdvdCBlcnJvciAlZDpidXQgZXhwZWN0ZWQgICVkIiwgVEVTVF9SRVRVUk4sIFRFU1RfRVJS
Tk8sIHRlc3RfY2FzZXNbMF0uZXhwX2Vycm5vKTsKKyAgICAgICAgCQkJCQl0c3RfcmVzbShUSU5G
TywgInNhLnNhX2ZsYWdzID0gJXMgIix0ZXN0X2ZsYWdzX2xpc3RbZmxhZ10pOworCQkJCQkJfQor
ICAgICAgICAgICAgICAgIAkJCX0KKwkJIAlwcmludGYoIlxuIik7CQorICAgICAgICAJCX0KKwor
CisKKyAgICAgICAgICAgICAgICB9CisgICAgICAgIH0JCisJY2xlYW51cCgpOworICAgICAgICB0
c3RfZXhpdCgpOworfQorCmRpZmYgLU5hdXJiIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9y
dF9zaWdhY3Rpb24vcnRfc2lnYWN0aW9uMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
cnRfc2lnYWN0aW9uL3J0X3NpZ2FjdGlvbjAzLmMKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9ydF9zaWdhY3Rpb24vcnRfc2lnYWN0aW9uMDMuYwkxOTcwLTAxLTAxIDA1OjMwOjAwLjAw
MDAwMDAwMCArMDUzMAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2FjdGlv
bi9ydF9zaWdhY3Rpb24wMy5jCTIwMDktMDctMDMgMTk6MjQ6MTIuMDAwMDAwMDAwICswNTMwCkBA
IC0wLDAgKzEsMjAwIEBACisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworLyogQ29weXJpZ2h0IChj
KSBDcmFja2VyamFjayBQcm9qZWN0LiwgMjAwNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKi8KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgICAgICAq
LworLyogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcyBwdWJsaXNoZWQgYnkgICAgICAgKi8KKy8qIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yICAgICAgICAgICovCisvKiAo
YXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCAg
ICAgICAgICAgICovCisvKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2YgICAgICAgICAgICAqLworLyogTUVSQ0hBTlRBQklMSVRZ
IG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlICAgICAgICAgICAgICAg
ICAgKi8KKy8qIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxz
LiAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwor
LyogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgICAgICAgICAgKi8KKy8qIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSAgICAgICAgICAgICAgICovCisvKiBGb3Vu
ZGF0aW9uLCBJbmMuLCA1OSBUZW1wbGUgUGxhY2UsIFN1aXRlIDMzMCwgQm9zdG9uLCBNQSAwMjEx
MS0xMzA3IFVTQSAgICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiovCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworLyogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ki8KKy8qIEZpbGU6ICAgICAgICBydF9zaWdhY3Rpb24wMy5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworLyog
RGVzY3JpcHRpb246IFRoaXMgdGVzdHMgdGhlIHJ0X3NpZ2FjdGlvbigpIHN5c2NhbGwgICAgICAg
ICAgICAgICAgICAgICAgICAgKi8KKy8qCQlydF9zaWdhY3Rpb24gRXhwZWN0ZWQgRUlOVkFMIGVy
cm9yIGNoZWNrICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
LworLyogVXNhZ2U6ICA8Zm9yIGNvbW1hbmQtbGluZT4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qIHJ0X3NpZ2FjdGlvbjAzIFstYyBuXSBbLWVd
Wy1pIG5dIFstSSB4XSBbLXAgeF0gWy10XSAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAg
ICAgIHdoZXJlLCAgLWMgbiA6IFJ1biBuIGNvcGllcyBjb25jdXJyZW50bHkuICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAgIC1lICAgOiBUdXJuIG9uIGVycm5v
IGxvZ2dpbmcuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAg
ICAgICAtaSBuIDogRXhlY3V0ZSB0ZXN0IG4gdGltZXMuICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgLUkgeCA6IEV4ZWN1dGUgdGVzdCBmb3IgeCBz
ZWNvbmRzLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAgIC1Q
IHggOiBQYXVzZSBmb3IgeCBzZWNvbmRzIGJldHdlZW4gaXRlcmF0aW9ucy4gICAgICAgICAgICAg
ICAgKi8KKy8qICAgICAgICAgICAgICAtdCAgIDogVHVybiBvbiBzeXNjYWxsIHRpbWluZy4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwor
LyogVG90YWwgVGVzdHM6IDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiBUZXN0
IE5hbWU6ICAgcnRfc2lnYWN0aW9uMDMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqLworLyogSGlzdG9yeTogICAgIFBvcnRpbmcgZnJvbSBDcmFja2VyamFjayB0
byBMVFAgaXMgZG9uZSBieSAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAgICAgICBN
YW5hcyBLdW1hciBOYXlhayBtYWtuYXlha0Bpbi5pYm0uY29tPiAgICAgICAgICAgICAgICAgICAg
ICAgICovCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5j
bHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c2lnbmFsLmg+
CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgorI2luY2x1ZGUg
PHN0cmluZy5oPgorCisvKiBIYXJuZXNzIFNwZWNpZmljIEluY2x1ZGUgRmlsZXMuICovCisjaW5j
bHVkZSAidGVzdC5oIgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKyNpbmNsdWRlICJsaW51eF9zeXNj
YWxsX251bWJlcnMuaCIKKworI2RlZmluZSBJTlZBTF9TSUdTRVRTSVpFIC0xCisKKy8qIEV4dGVy
biBHbG9iYWwgVmFyaWFibGVzICovCitleHRlcm4gaW50IFRzdF9jb3VudDsgICAgICAgICAgIC8q
IGNvdW50ZXIgZm9yIHRzdF94eHggcm91dGluZXMuICAgICAgICAgKi8KK2V4dGVybiBjaGFyICpU
RVNURElSOyAgICAgICAgICAgLyogdGVtcG9yYXJ5IGRpciBjcmVhdGVkIGJ5IHRzdF90bXBkaXIo
KSAqLworCisvKiBHbG9iYWwgVmFyaWFibGVzICovCitjaGFyICpUQ0lEID0gInJ0X3NpZ2FjdGlv
bjAzIjsgIC8qIFRlc3QgcHJvZ3JhbSBpZGVudGlmaWVyLiovCitpbnQgIHRlc3RubzsKK2ludCAg
VFNUX1RPVEFMID0gMTsgICAgICAgICAgICAgICAgICAgLyogdG90YWwgbnVtYmVyIG9mIHRlc3Rz
IGluIHRoaXMgZmlsZS4gICAqLworCisvKiBFeHRlcm4gR2xvYmFsIEZ1bmN0aW9ucyAqLworLyoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi8KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiBGdW5jdGlv
bjogICAgY2xlYW51cCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qIERlc2NyaXB0aW9uOiBQ
ZXJmb3JtcyBhbGwgb25lIHRpbWUgY2xlYW4gdXAgZm9yIHRoaXMgdGVzdCBvbiBzdWNjZXNzZnVs
ICAgICovCisvKiAgICAgICAgICAgICAgY29tcGxldGlvbiwgIHByZW1hdHVyZSBleGl0IG9yICBm
YWlsdXJlLiBDbG9zZXMgYWxsIHRlbXBvcmFyeSAqLworLyogICAgICAgICAgICAgIGZpbGVzLCBy
ZW1vdmVzIGFsbCB0ZW1wb3JhcnkgZGlyZWN0b3JpZXMgZXhpdHMgdGhlIHRlc3Qgd2l0aCAgKi8K
Ky8qICAgICAgICAgICAgICBhcHByb3ByaWF0ZSByZXR1cm4gY29kZSBieSBjYWxsaW5nIHRzdF9l
eGl0KCkgZnVuY3Rpb24uICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworLyogSW5w
dXQ6ICAgICAgIE5vbmUuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiBPdXRwdXQ6ICAg
ICAgTm9uZS4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qIFJldHVybjogICAgICBPbiBm
YWlsdXJlIC0gRXhpdHMgY2FsbGluZyB0c3RfZXhpdCgpLiBOb24gJzAnIHJldHVybiBjb2RlLiAg
ICovCisvKiAgICAgICAgICAgICAgT24gc3VjY2VzcyAtIEV4aXRzIGNhbGxpbmcgdHN0X2V4aXQo
KS4gV2l0aCAnMCcgcmV0dXJuIGNvZGUuICAqLworLyogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8q
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKiovCitleHRlcm4gdm9pZCBjbGVhbnVwKCkgeworICAgICAgICAv
KiBSZW1vdmUgdG1wIGRpciBhbmQgYWxsIGZpbGVzIGluIGl0ICovCisgICAgICAgIFRFU1RfQ0xF
QU5VUDsKKyAgICAgICAgdHN0X3JtZGlyKCk7CisKKyAgICAgICAgLyogRXhpdCB3aXRoIGFwcHJv
cHJpYXRlIHJldHVybiBjb2RlLiAqLworICAgICAgICB0c3RfZXhpdCgpOworfQorCisvKiBMb2Nh
bCAgRnVuY3Rpb25zICovCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworLyogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKi8KKy8qIEZ1bmN0aW9uOiAgICBzZXR1cCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
LworLyogRGVzY3JpcHRpb246IFBlcmZvcm1zIGFsbCBvbmUgdGltZSBzZXR1cCBmb3IgdGhpcyB0
ZXN0LiBUaGlzIGZ1bmN0aW9uIGlzICAgKi8KKy8qICAgICAgICAgICAgICB0eXBpY2FsbHkgdXNl
ZCB0byBjYXB0dXJlIHNpZ25hbHMsIGNyZWF0ZSB0ZW1wb3JhcnkgZGlycyAgICAgICovCisvKiAg
ICAgICAgICAgICAgYW5kIHRlbXBvcmFyeSBmaWxlcyB0aGF0IG1heSBiZSB1c2VkIGluIHRoZSBj
b3Vyc2Ugb2YgdGhpcyAgICAqLworLyogICAgICAgICAgICAgIHRlc3QuICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICovCisvKiBJbnB1dDogICAgICAgTm9uZS4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworLyogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKi8KKy8qIE91dHB1dDogICAgICBOb25lLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwor
LyogUmV0dXJuOiAgICAgIE9uIGZhaWx1cmUgLSBFeGl0cyBieSBjYWxsaW5nIGNsZWFudXAoKS4g
ICAgICAgICAgICAgICAgICAgICAgKi8KKy8qICAgICAgICAgICAgICBPbiBzdWNjZXNzIC0gcmV0
dXJucyAwLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCisvKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqLworLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KK3ZvaWQgc2V0dXAoKSB7
CisgICAgICAgIC8qIENhcHR1cmUgc2lnbmFscyBpZiBhbnkgKi8KKyAgICAgICAgLyogQ3JlYXRl
IHRlbXBvcmFyeSBkaXJlY3RvcmllcyAqLworICAgICAgICBURVNUX1BBVVNFOworICAgICAgICB0
c3RfdG1wZGlyKCk7Cit9CisKK2ludCB0ZXN0X2ZsYWdzW10gPSB7U0FfUkVTRVRIQU5EfFNBX1NJ
R0lORk8sIFNBX1JFU0VUSEFORCwgU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8sIFNBX1JFU0VUSEFO
RHxTQV9TSUdJTkZPLCBTQV9OT01BU0t9OworY2hhciAqdGVzdF9mbGFnc19saXN0W10gPSB7IlNB
X1JFU0VUSEFORHxTQV9TSUdJTkZPIiwgIlNBX1JFU0VUSEFORCIsICJTQV9SRVNFVEhBTkR8U0Ff
U0lHSU5GTyIsICJTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyIsICJTQV9OT01BU0sifTsKKworCitz
dHJ1Y3QgdGVzdF9jYXNlX3QgeworICAgICAgICBpbnQgZXhwX2Vycm5vOworICAgICAgICBjaGFy
ICplcnJkZXNjOworfSB0ZXN0X2Nhc2VzW10gPSB7CisJeyBFSU5WQUwsICJFSU5WQUwiIH0KK307
CisKK3ZvaWQKK2hhbmRsZXIoaW50IHNpZykKK3sKKyAgICAgICAgdHN0X3Jlc20oVElORk8sIlNp
Z25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgJWRcbiIsc2lnKTsKKyAgICAg
ICAgcmV0dXJuOworfQorCitpbnQKK3NldF9oYW5kbGVyKGludCBzaWcsIGludCBzaWdfdG9fbWFz
aywgaW50IG1hc2tfZmxhZ3MpCit7CisgICAgICAgIHN0cnVjdCBzaWdhY3Rpb24gc2EsIG9sZGFj
dGlvbjsKKworICAgICAgICAgICAgICAgIHNhLnNhX3NpZ2FjdGlvbiA9ICh2b2lkICopaGFuZGxl
cjsKKyAgICAgICAgICAgICAgICBzYS5zYV9mbGFncyA9IG1hc2tfZmxhZ3M7CisgICAgICAgICAg
ICAgICAgc2lnZW1wdHlzZXQoJnNhLnNhX21hc2spOworICAgICAgICAgICAgICAgIHNpZ2FkZHNl
dCgmc2Euc2FfbWFzaywgc2lnX3RvX21hc2spOworCisJCS8qICAgCQkJCQkJCSAgICAgICAgKgor
CQkgKiBsb25nIHN5c19ydF9zaWdhY3Rpb24gKGludCBzaWcsIGNvbnN0IHN0cnVjdCBzaWdhY3Rp
b24gKmFjdCwgKgorCQkgKiB0cnVjdCBzaWdhY3Rpb24gKm9hY3QsIHNpemVfdCBzaWdzZXRzaXpl
KTsJCQkqIAorCQkgKiBFSU5WQUw6CQkJCQkJCSoKKyAgICAgICAgCSAqIHNpZ3NldHNpemUgd2Fz
IG5vdCBlcXVpdmFsZW50IHRvIHRoZSBzaXplIG9mIGEgc2lnc2V0X3QgdHlwZSAqCisJCSAqLwor
CisgICAgICAgICAgICAgICAgVEVTVChzeXNjYWxsKF9fTlJfcnRfc2lnYWN0aW9uLHNpZywgJnNh
ICwgJm9sZGFjdGlvbixJTlZBTF9TSUdTRVRTSVpFKSk7CisgICAgICAgICAgICAgICAgaWYgKFRF
U1RfUkVUVVJOID09IDApIHsKKyAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOworICAg
ICAgICAgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gVEVT
VF9SRVRVUk47CisgICAgICAgICAgICAgICAgfQorfQorCisKK2ludCBtYWluKGludCBhYywgY2hh
ciAqKmF2KSB7CisJaW50IHNpZ25hbCwgZmxhZzsKKyAgICAgICAgaW50IGxjOyAgICAgICAgICAg
ICAgICAgLyogbG9vcCBjb3VudGVyICovCisgICAgICAgIGNoYXIgKm1zZzsgICAgICAgICAgICAg
IC8qIG1lc3NhZ2UgcmV0dXJuZWQgZnJvbSBwYXJzZV9vcHRzICovCisJCisgICAgICAgIC8qIHBh
cnNlIHN0YW5kYXJkIG9wdGlvbnMgKi8KKyAgICAgICAgaWYgKChtc2cgPSBwYXJzZV9vcHRzKGFj
LCBhdiwgKG9wdGlvbl90ICopTlVMTCwgTlVMTCkpICE9IChjaGFyICopTlVMTCl7CisgICAgICAg
ICAgICAgdHN0X2Jya20oVEJST0ssIGNsZWFudXAsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtICVz
IiwgbXNnKTsKKyAgICAgICAgICAgICB0c3RfZXhpdCgpOworICAgICAgICAgICB9CisKKyAgICAg
ICAgc2V0dXAoKTsKKworICAgICAgICAvKiBDaGVjayBsb29waW5nIHN0YXRlIGlmIC1pIG9wdGlv
biBnaXZlbiAqLworICAgICAgICBmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HKGxjKTsgKytsYykg
eworICAgICAgICAgICAgICAgIFRzdF9jb3VudCA9IDA7CisgICAgICAgICAgICAgICAgZm9yICh0
ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7CisgICAgICAgICAgICAg
ICAgCisJCQlmb3IgKHNpZ25hbCA9IFNJR1JUTUlOOyBzaWduYWwgPD0gKFNJR1JUTUFYICk7IHNp
Z25hbCsrKXsvL3NpZ25hbCBmb3IgMzQgdG8gNjUgCisJCQkgCWZvcihmbGFnPTA7IGZsYWc8NTtm
bGFnKyspIHsKKwkgICAgICAgICAgICAgICAgICAgICAgICAJIFRFU1Qoc2V0X2hhbmRsZXIoc2ln
bmFsLCAwLCB0ZXN0X2ZsYWdzW2ZsYWddKSk7CisJCQkJCWlmKChURVNUX1JFVFVSTiA9PSAtMSkg
JiYgKFRFU1RfRVJSTk8gPT0gdGVzdF9jYXNlc1swXS5leHBfZXJybm8pKSB7CisgICAgICAgIAkJ
CQkJCXRzdF9yZXNtKFRJTkZPLCAic2Euc2FfZmxhZ3MgPSAlcyAiLHRlc3RfZmxhZ3NfbGlzdFtm
bGFnXSk7CisgICAgICAgICAgICAgICAgIAkgICAJCQkJdHN0X3Jlc20oVFBBU1MsICIlcyBmYWls
dXJlIHdpdGggc2lnOiAlZCBhcyBleHBlY3RlZCBlcnJubyAgPSAlcyA6ICVzIiwgVENJRCwgc2ln
bmFsLHRlc3RfY2FzZXNbMF0uZXJyZGVzYywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOworCQkJICAg
ICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7CisgICAgICAgIAkJCQkJdHN0X3Jlc20oVEZB
SUwsICJydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9ICVkIGdvdCBlcnJvciAl
ZDpidXQgZXhwZWN0ZWQgICVkIiwgVEVTVF9SRVRVUk4sIFRFU1RfRVJSTk8sIHRlc3RfY2FzZXNb
MF0uZXhwX2Vycm5vKTsKKyAgICAgICAgCQkJCQl0c3RfcmVzbShUSU5GTywgInNhLnNhX2ZsYWdz
ID0gJXMgIix0ZXN0X2ZsYWdzX2xpc3RbZmxhZ10pOworCQkJCQkJfQorICAgICAgICAgICAgICAg
IAkJCX0KKwkJIAlwcmludGYoIlxuIik7CQorICAgICAgICAJCX0KKworCisKKyAgICAgICAgICAg
ICAgICB9CisgICAgICAgIH0JCisJY2xlYW51cCgpOworICAgICAgICB0c3RfZXhpdCgpOworfQor
Cg==
--0015175cd852404142046dcf1091
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0015175cd852404142046dcf1091
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0015175cd852404142046dcf1091--


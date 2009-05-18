Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68gL-0006XC-35
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:39:29 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68gC-0001gb-0N
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:39:29 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ0cwS008751
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:00:38 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJAeoL222762
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:10:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJAdh7018970
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:10:40 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:40:35 +0530
Message-Id: <20090518191034.9777.49347.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 09/21] Add rt_sigprocmask02 test for rt_sigprocmask
	syscall
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
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: Deepakraj B Himavantharaj <deepakraj@in.ibm.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>,
To: LTP List <ltp-list@lists.sourceforge.net>,
Cc: Deepakraj B Himavantharaj <deepakraj@in.ibm.com>,
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>,
Cc: Masatake YAMATO <yamato@redhat.com>,
---

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c	2009-05-18 20:40:59.000000000 +0530
@@ -0,0 +1,213 @@
+/******************************************************************************/
+/* Copyright (c) Crackerjack Project., 2007                                   */
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
+/******************************************************************************/
+/******************************************************************************/
+/*                                                                            */
+/* File:        rt_sigprocmask02.c                                              */
+/*                                                                            */
+/* Description: This tests the rt_sigprocmask() syscall                       */
+/*		rt_sigprocmask changes the list of currently blocked signals. */
+/*		The set value stores the signal mask of the pending signals.  */
+/*		The previous action on the signal is saved in oact. The value */
+/*		of how indicates how the call should behave; its values are   */
+/*		as follows:						      */
+/*									      */
+/*		SIG_BLOCK						      */
+/*		    The set of blocked signals is the union of the current set*/ 
+/*		    and the set argument. 				      */
+/*		SIG_UNBLOCK						      */
+/*		    The signals in set are removed from the current set of    */
+/*		    blocked signals. It is okay to unblock a signal that is   */
+/*		    not blocked. 					      */
+/*		SIG_SETMASK						      */
+/*		    The set of blocked signals is set to the set argument.    */
+/*		    sigsetsize should indicate the size of a sigset_t type.   */
+/* 									      */	
+/* 		RETURN VALUE:i						      */
+/* 		rt_sigprocmask returns 0 on success; otherwise, rt_sigprocmask*/ 
+/* 		returns one of the errors listed in the "Errors" section.     */
+/* 									      */
+/* 		Errors:							      */
+/* 			-EINVAL						      */	
+/* 			    sigsetsize was not equivalent to the size of a    */
+/* 			    sigset_t type or the value specified in how was   */
+/* 			    invalid. 					      */
+/* 			-EFAULT						      */
+/* 			    An invalid set, act, or oact was specified.       */
+/*                                                                            */
+/*									      */
+/* Usage:  <for command-line>                                                 */
+/* rt_sigprocmask02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                      */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   rt_sigprocmask02                                              */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+#include <stdio.h>
+#include <signal.h>
+#include <errno.h>
+
+/* Harness Specific Include Files. */
+#include "test.h"
+#include "usctest.h"
+#include "linux_syscall_numbers.h"
+
+/* Extern Global Variables */
+extern int Tst_count;           /* counter for tst_xxx routines.         */
+extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID = "rt_sigprocmask02";  /* Test program identifier.*/
+int  testno;
+int  TST_TOTAL = 2;                   /* total number of tests in this file.   */
+
+/* Extern Global Functions */
+/******************************************************************************/
+/*                                                                            */
+/* Function:    cleanup                                                       */
+/*                                                                            */
+/* Description: Performs all one time clean up for this test on successful    */
+/*              completion,  premature exit or  failure. Closes all temporary */
+/*              files, removes all temporary directories exits the test with  */
+/*              appropriate return code by calling tst_exit() function.       */
+/*                                                                            */
+/* Input:       None.                                                         */
+/*                                                                            */
+/* Output:      None.                                                         */
+/*                                                                            */
+/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
+/*              On success - Exits calling tst_exit(). With '0' return code.  */
+/*                                                                            */
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
+/*                                                                            */
+/* Function:    setup                                                         */
+/*                                                                            */
+/* Description: Performs all one time setup for this test. This function is   */
+/*              typically used to capture signals, create temporary dirs      */
+/*              and temporary files that may be used in the course of this    */
+/*              test.                                                         */
+/*                                                                            */
+/* Input:       None.                                                         */
+/*                                                                            */
+/* Output:      None.                                                         */
+/*                                                                            */
+/* Return:      On failure - Exits by calling cleanup().                      */
+/*              On success - returns 0.                                       */
+/*                                                                            */
+/******************************************************************************/
+void setup() {
+        /* Capture signals if any */
+        /* Create temporary directories */
+        TEST_PAUSE;
+        tst_tmpdir();
+}
+
+sigset_t set;
+
+struct test_case_t {
+        sigset_t *ss;
+        int sssize;
+        int exp_errno;
+} test_cases[] = {
+        { &set, 1, EINVAL },
+        { (sigset_t *)-1, 8, EFAULT }
+};
+
+int test_count = sizeof(test_cases) / sizeof(struct test_case_t);
+
+int main(int ac, char **av) {
+	int i, succeed=0, fail=0;
+        sigset_t s;
+        int lc;                 /* loop counter */
+        char *msg;              /* message returned from parse_opts */
+	
+        /* parse standard options */
+        if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
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
+			TEST(sigfillset(&s));
+			if(TEST_RETURN == -1){
+				tst_resm(TFAIL,"Call to sigfillset() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+                        	cleanup();
+				tst_exit();
+			}
+
+			for(i=0; i<test_count; i++)
+		        {
+				TEST(syscall(175, SIG_BLOCK, &s, test_cases[i].ss, test_cases[i].sssize));
+				if(TEST_RETURN == 0){
+					tst_resm(TFAIL,"Call to rt_sigprocmask()succeeded,but should failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+					fail++;
+				}
+				else {
+					if(TEST_ERRNO == test_cases[i].exp_errno) {
+						tst_resm(TINFO,"got expected errno:%d", TEST_ERRNO);
+		                                succeed++;
+		                        }
+		                        else {
+		                                tst_resm(TINFO,"got unexpected errno:%d", TEST_ERRNO);
+                                		fail++;
+		                        }
+		                }
+		        }
+
+			if(fail != 0) {
+				tst_resm(TFAIL,"Test Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+                        	cleanup();
+				tst_exit();
+		        }
+		        else {
+				tst_resm(TPASS,"Test PASSED");
+                        	cleanup();
+				tst_exit();
+		        }
+
+	
+                }
+	Tst_count++;
+        }	
+        tst_exit();
+}
+
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 20:32:04.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 20:42:26.000000000 +0530
@@ -788,6 +788,7 @@ rmdir05 rmdir05
 
 rt_sigaction01 rt_sigaction01
 rt_sigprocmask01 rt_sigprocmask01
+rt_sigprocmask02 rt_sigprocmask02
 
 sbrk01 sbrk01
 

---
Regards--
Manas


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

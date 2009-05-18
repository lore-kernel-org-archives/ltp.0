Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68Xt-000477-U8
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:30:45 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68Xr-0002un-Du
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:30:45 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ5wpW002327
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:05:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJAJ0S097528
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:10:19 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJAJev015344
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:10:19 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:40:14 +0530
Message-Id: <20090518191014.9777.40688.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 07/21] Add rt_sigaction01 test for rt_sigaction syscall
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

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/rt_sigaction/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/rt_sigaction/Makefile	2009-05-18 14:24:27.000000000 +0530
@@ -0,0 +1,31 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2009
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+CFLAGS += -I../../../../include -Wall -O2 -W
+LDLIBS += -L../../../../lib -lltp
+
+SRCS    = $(wildcard *.c)
+TARGETS = $(patsubst %.c,%,$(SRCS))
+
+all: $(TARGETS)
+
+install:
+	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
+
+clean:
+	rm -f $(TARGETS)
--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	2009-05-18 20:11:35.000000000 +0530
@@ -0,0 +1,208 @@
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
+/* File:        rt_sigaction01.c                                              */
+/*                                                                            */
+/* Description: This tests the rt_sigaction() syscall                         */
+/*		rt_sigaction alters an action taken by a process on receipt   */
+/* 		of a particular signal. The action is specified by the        */
+/*		sigaction structure. The previous action on the signal is     */
+/*		saved in oact.sigsetsize should indicate the size of a        */
+/*		sigset_t type.                       			      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* rt_sigaction01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                        */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   rt_sigaction01                                             */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
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
+/* Extern Global Variables */
+extern int Tst_count;           /* counter for tst_xxx routines.         */
+extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
+
+/* Global Variables */
+char *TCID = "rt_sigaction01";  /* Test program identifier.*/
+int  testno;
+int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
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
+int test_flags[] = {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND, SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
+
+void
+handler(int sig)
+{
+        tst_resm(TINFO,"Here is signal handler. Got signal: %d, do nothing here\n", sig);
+        return;
+}
+
+int
+set_handler(int sig, int sig_to_mask, int flag, int mask_flags)
+{
+        struct sigaction sa, oldaction;
+        int err = 0;
+
+        if (flag == 0) {
+                tst_resm(TINFO,"flag0 - ");
+                sa.sa_sigaction = (void *)handler;
+                sa.sa_flags = mask_flags;
+                TEST(sigemptyset(&sa.sa_mask));
+                TEST(sigaddset(&sa.sa_mask, sig_to_mask));
+                TEST(err = syscall(__NR_rt_sigaction,sig, &sa, NULL,8));
+        } else if (flag == 1) {
+                tst_resm(TINFO,"flag1 - ");
+                TEST(err = syscall(__NR_rt_sigaction,sig, (void *)-1, NULL,8));
+        } else if (flag == 2) {
+               	tst_resm(TINFO,"flag2 - ");
+                TEST(err = syscall(__NR_rt_sigaction,sig, NULL, (void *)-1,8));
+	} else if (flag == 3) {
+                tst_resm(TINFO,"flag3 - ");
+                sa.sa_sigaction = (void *)handler;
+                sa.sa_flags = mask_flags;
+                TEST(sigemptyset(&sa.sa_mask));
+                TEST(sigaddset(&sa.sa_mask, sig_to_mask));
+                TEST(err = syscall(__NR_rt_sigaction,sig, &sa, &oldaction, 8));
+                if (TEST_RETURN == 0) {
+                        return 0;
+                } else {
+                        return TEST_ERRNO;
+                }
+        } else if (flag == 4){
+                        TEST(err = syscall(__NR_rt_sigaction,sig, &sa, NULL,9));
+        }
+        if (TEST_RETURN == 0) {
+                return 0;
+        } else {
+                return TEST_ERRNO;
+        }
+}
+
+
+int main(int ac, char **av) {
+	int retnval, i, j;
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
+                
+			for (i = 0; i <= (SIGRTMAX + 1); i++){//signal for 0 to 65 
+	    			tst_resm(TINFO,"Signal : %d",i);
+			                for (j = 0; j < 4; j++){
+			                       	 TEST(retnval = set_handler(i, 0, j, test_flags[j]));
+						 if (TEST_RETURN == 0) {
+        						tst_resm(TPASS, "rt_sigaction call succeeded: result = %d",TEST_RETURN);
+			                         } else {
+                 	   				tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+							cleanup();
+							tst_exit();
+                       				}
+                			}
+        		}
+
+
+
+                }
+        }	
+        tst_exit();
+}
+
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 19:48:56.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 20:17:24.000000000 +0530
@@ -786,6 +786,8 @@ rmdir03A symlink01 -T rmdir03
 rmdir04 rmdir04
 rmdir05 rmdir05
 
+rt_sigaction01 rt_sigaction01
+
 sbrk01 sbrk01
 
 sched_get_priority_max01 sched_get_priority_max01

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

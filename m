Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68ZX-00061a-CJ
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:32:27 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68ZM-0007y9-DF
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:32:27 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ8uer015657
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:08:56 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJCLfx252796
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:12:21 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJCKf0029137
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:12:21 -0600
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:42:16 +0530
Message-Id: <20090518191216.9777.12249.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 19/21] Add timer_gettime01 test for timer_gettime
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

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/timer_gettime/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/timer_gettime/Makefile	2009-04-05 00:48:47.000000000 +0530
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
+CFLAGS += -I../../../../include -Wall
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
--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c	2009-05-18 23:35:42.000000000 +0530
@@ -0,0 +1,199 @@
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
+/* File:        timer_gettime01.c                                           */
+/*                                                                            */
+/* Description: This tests the timer_gettime() syscall                      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* timer_gettime01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   timer_gettime01                                             */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+#include <time.h>
+#include <signal.h>
+#include <syscall.h>
+#include <stdio.h>
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
+char *TCID = "timer_gettime01";  /* Test program identifier.*/
+int  testno;
+int  TST_TOTAL = 3;                   /* total number of tests in this file.   */
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
+
+        tst_tmpdir();
+}
+
+#define ENTER(normal) tst_resm(TINFO, "Enter block %d: test %d (%s)", \
+                         block, Tst_count, normal?"NORMAL":"ERROR");
+
+char tmpname[40];
+int parent;
+int block = 1;
+
+
+
+int main(int ac, char **av) {
+        int lc;                 /* loop counter */
+        char *msg;              /* message returned from parse_opts */
+
+        timer_t created_timer_id;
+        struct sigevent ev;
+        struct itimerspec spec;
+
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
+	        for (testno = 0; testno < TST_TOTAL; ++testno) {
+                     ENTER(1);
+	                ev.sigev_value = (sigval_t)0;
+	                ev.sigev_signo = SIGALRM;
+	                ev.sigev_notify = SIGEV_SIGNAL;
+	                TEST(syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &created_timer_id ));
+			TEST( syscall(__NR_timer_gettime, created_timer_id, &spec ));
+			if(TEST_RETURN == 0){
+			      tst_resm(TPASS, "Block %d: test %d PASSED", block, Tst_count );
+	                } else {
+				tst_resm(TFAIL, "Block %d: test %d FAILED... errno = %d : %s", block, Tst_count,TEST_ERRNO, strerror(TEST_ERRNO) );
+				cleanup();
+        			tst_exit();
+			 }
+	
+
+			
+/*
+
+ERRORS
+       -EINVAL
+              An invalid timer_id value was specified.
+*/
+                ENTER(0);
+                TEST( syscall(__NR_timer_gettime, -1, &spec ));
+		if(TEST_RETURN < 0 && TEST_ERRNO == EINVAL ) {
+                        tst_resm(TPASS, "Block %d: test %d PASSED", block, Tst_count );
+	        } else {
+			tst_resm(TFAIL, "Block %d: test %d FAILED... errno = %d : %s", block, Tst_count,TEST_ERRNO, strerror(TEST_ERRNO) );
+			cleanup();
+        		tst_exit();
+                }
+
+/*
+
+       -EFAULT
+              An invalid address of setting was specified.
+*/
+
+
+                ENTER(0);
+                TEST( syscall(__NR_timer_gettime, created_timer_id, NULL ));
+		if(TEST_RETURN < 0 && TEST_ERRNO == EFAULT ) {
+                       tst_resm(TPASS, "Block %d: test %d PASSED", block, Tst_count );
+	        } else {
+			tst_resm(TFAIL, "Block %d: test %d FAILED... errno = %d : %s", block, Tst_count,TEST_ERRNO, strerror(TEST_ERRNO) );
+			cleanup();
+        		tst_exit();
+                }
+
+
+
+
+                }
+        }	
+	cleanup();
+        tst_exit();
+}
+
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 23:38:35.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 23:37:34.000000000 +0530
@@ -1159,6 +1159,7 @@ timerfd02 timerfd02
 timerfd03 timerfd03
 
 timer_getoverrun01 timer_getoverrun01
+timer_gettime01 timer_gettime01
 
 truncate01 truncate01
 truncate01_64 truncate01_64

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

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68QF-0003Qy-9A
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:22:51 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68Q6-0003WG-0c
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:22:51 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ8IWr010647
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:08:18 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJCBb3230936
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:12:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJCAXh024170
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:12:11 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:42:06 +0530
Message-Id: <20090518191205.9777.84958.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 18/21] Add timer_getoverrun01 test for
	timer_getoverrun01 syscall
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

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/timer_getoverrun/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/timer_getoverrun/Makefile	2009-04-05 11:58:14.000000000 +0530
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
--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c	2009-05-18 23:29:15.000000000 +0530
@@ -0,0 +1,204 @@
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
+/* File:        timer_getoverrun01.c                                           */
+/*                                                                            */
+/* Description: This tests the timer_getoverrun() syscall                      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* timer_getoverrun01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   timer_getoverrun01                                             */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+
+#include <stdio.h>
+#include <errno.h>
+#include <time.h>
+#include <signal.h>
+#include <syscall.h>
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
+char *TCID = "timer_getoverrun01";  /* Test program identifier.*/
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
+char tmpname[40];
+int parent;
+int block = 1;
+
+#define ENTER(normal) tst_resm(TINFO, "Enter block %d: test %d (%s)", \
+                         block, Tst_count, normal?"NORMAL":"ERROR");
+
+int main(int ac, char **av) {
+        int lc;                 /* loop counter */
+        char *msg;              /* message returned from parse_opts */
+	timer_t created_timer_id;
+        struct sigevent ev;
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
+		ev.sigev_value = (sigval_t)0;
+                ev.sigev_signo = SIGALRM;
+                ev.sigev_notify = SIGEV_SIGNAL;
+
+                TEST(syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &created_timer_id ));
+                
+		ENTER(1);
+                TEST( syscall(__NR_timer_getoverrun, created_timer_id ));
+		if(TEST_RETURN == 0){
+			tst_resm(TPASS, "Block %d: test %d PASSED", block, Tst_count );
+                } else {
+			tst_resm(TFAIL, "Block %d: test %d FAILED... errno = %d : %s", block, Tst_count,TEST_ERRNO, strerror(TEST_ERRNO) );
+                        cleanup();
+                        tst_exit();
+                }
+
+
+		ENTER(0);
+                TEST( syscall(__NR_timer_getoverrun, -1 ));
+                if(TEST_RETURN < 0 && TEST_ERRNO == EINVAL ) {
+                        tst_resm(TPASS, "Block %d: test %d PASSED", block, Tst_count );
+                } else {
+                        tst_resm(TFAIL, "Block %d: test %d FAILED... errno = %d : %s", block, Tst_count,TEST_ERRNO, strerror(TEST_ERRNO) );
+                        cleanup();
+                        tst_exit();
+                }
+
+
+                }
+        }	
+	cleanup();
+        tst_exit();
+}
+
+
+/*
+
+NAME
+       timer_getoverrun
+SYNOPSIS
+       #include <time.h>
+
+       int timer_getoverrun(timer_t timerid);
+
+	Only a single signal shall be queued to the process for a given  timer
+       at any point in time. When a timer for which a signal is still pending
+       expires, no signal shall be queued, and a timer overrun  shall  occur.
+        When  a timer expiration signal is delivered to or accepted by a pro-
+       cess, if the implementation supports the Realtime  Signals  Extension,
+       the  timer_getoverrun()  function  shall  return  the timer expiration
+       overrun count for the specified timer. The overrun count returned con-
+       tains  the number of extra timer expirations that occurred between the
+       time the signal was generated (queued) and when it  was  delivered  or
+       accepted, up to but not including an implementation-defined maximum of
+       {DELAYTIMER_MAX}. If the number of such extra expirations  is  greater
+       than or equal to {DELAYTIMER_MAX}, then the overrun count shall be set
+       to {DELAYTIMER_MAX}. The value returned  by  timer_getoverrun()  shall
+       apply  to the most recent expiration signal delivery or acceptance for
+       the timer.  If no expiration signal has been delivered for the  timer,
+       or  if  the  Realtime  Signals  Extension is not supported, the return
+       value of timer_getoverrun() is unspecified.
+
+RETURN VALUE
+       If the timer_getoverrun() function succeeds, it shall return the timer
+       expiration overrun count as explained above.
+*/
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 23:26:45.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 23:30:40.000000000 +0530
@@ -1158,6 +1158,8 @@ timerfd01 timerfd01
 timerfd02 timerfd02
 timerfd03 timerfd03
 
+timer_getoverrun01 timer_getoverrun01
+
 truncate01 truncate01
 truncate01_64 truncate01_64
 truncate02 truncate02

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

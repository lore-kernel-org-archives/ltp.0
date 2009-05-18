Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68nj-00077U-Jx
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:47:07 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68nW-00037O-C7
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:47:07 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ8Kv1025383
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:08:20 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJB1bg243168
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:11:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJB0pZ024953
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:11:01 -0600
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:40:55 +0530
Message-Id: <20090518191055.9777.50852.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 11/21] Add rt_sigsuspend01 test for rt_sigsuspend
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

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/rt_sigsuspend/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/rt_sigsuspend/Makefile	2009-05-18 14:26:03.000000000 +0530
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
+CFLAGS += -I../../../../include -Wall -g
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
--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c	2009-05-18 21:32:36.000000000 +0530
@@ -0,0 +1,187 @@
+/********************************************************************************/
+/* Copyright (c) Crackerjack Project., 2007                                   	*/
+/*                                                                            	*/
+/* This program is free software;  you can redistribute it and/or modify      	*/
+/* it under the terms of the GNU General Public License as published by       	*/
+/* the Free Software Foundation; either version 2 of the License, or          	*/
+/* (at your option) any later version.                                        	*/
+/*                                                                            	*/
+/* This program is distributed in the hope that it will be useful,            	*/
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            	*/
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  	*/
+/* the GNU General Public License for more details.                           	*/
+/*                                                                            	*/
+/* You should have received a copy of the GNU General Public License          	*/
+/* along with this program;  if not, write to the Free Software               	*/
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    	*/
+/*                                                                            	*/
+/******************************************************************************	*/
+/******************************************************************************	*/
+/*                                                                            	*/
+/* File:        rt_sigsuspend01.c                                           	      	*/
+/*                                                                            	*/
+/* Description: This tests the rt_sigsuspend() syscall.                      	      	*/
+/*		                                                               	*/
+/* Usage:  <for command-line>                                                 	*/
+/* rt_sigsuspend01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     		*/
+/*      where,  -c n : Run n copies concurrently.                             	*/
+/*              -e   : Turn on errno logging.                                 	*/
+/*              -i n : Execute test n times.                                  	*/
+/*              -I x : Execute test for x seconds.                            	*/
+/*              -P x : Pause for x seconds between iterations.                	*/
+/*              -t   : Turn on syscall timing.                                	*/
+/*                                                                            	*/
+/* Total Tests: 2                                                             	*/
+/*                                                                            	*/
+/* Test Name:   rt_sigsuspend01                                             		*/
+/* History:     Porting from Crackerjack to LTP is done by                    	*/
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        	*/
+/********************************************************************************/
+
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
+char *TCID = "rt_sigsuspend01";  /* Test program identifier.*/
+int  testno;
+int  TST_TOTAL =4;                   /* total number of tests in this file.   */
+
+/* Extern Global Functions */
+/******************************************************************************/
+/*                                                                            */
+/* Function:    cleanup                                                       */
+/*                                                                            */
+/* Description: Performs all one time clean up for this test on successful    */
+/*              completion,  premature exit or  failure. Closes all temporary */
+/*              files, removes all temporary directories exits the test with  */
+/*              appropriate TEST_RETURNurn code by calling tst_exit() function.       */
+/*                                                                            */
+/* Input:       None.                                                         */
+/*                                                                            */
+/* Output:      None.                                                         */
+/*                                                                            */
+/* Return:      On failure - Exits calling tst_exit(). Non '0' TEST_RETURNurn code.   */
+/*              On success - Exits calling tst_exit(). With '0' TEST_RETURNurn code.  */
+/*                                                                            */
+/******************************************************************************/
+extern void cleanup() {
+        /* Remove tmp dir and all files in it */
+        TEST_CLEANUP;
+        tst_rmdir();
+
+        /* Exit with appropriate TEST_RETURNurn code. */
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
+/*              On success - TEST_RETURNurns 0.                                       */
+/*                                                                            */
+/******************************************************************************/
+void setup() {
+        /* Capture signals if any */
+        /* Create temporary directories */
+        TEST_PAUSE;
+        tst_tmpdir();
+}
+
+
+
+void sig_handler(int sig)
+{
+}
+
+
+int main(int ac, char **av) {
+	
+	sigset_t set, set1, set2;
+	int lc;                 /* loop counter */
+        char *msg;              /* message TEST_RETURNurned from parse_opts */
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
+			TEST(sigemptyset(&set));
+			if(TEST_RETURN == -1){
+				tst_resm(TFAIL,"sigemptyset() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+				cleanup();
+				tst_exit();
+			}
+			struct sigaction act, oact;
+		        act.sa_handler = sig_handler;
+			
+			TEST(syscall(174, SIGALRM, &act, &oact, 8));
+			if(TEST_RETURN == -1){
+		        	tst_resm(TFAIL,"rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+				cleanup();
+				tst_exit();
+			}
+			TEST(syscall(175, SIG_UNBLOCK, 0, &set1, 8));
+			if(TEST_RETURN == -1){
+		        	tst_resm(TFAIL,"rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+				cleanup();
+				tst_exit();
+			}
+			
+			TEST(alarm(5));
+		        int result;
+			TEST(result = syscall(179, &set, 8));
+		        TEST(alarm(0));
+			if((result == -1) && (TEST_ERRNO != EINTR)){
+				TEST(syscall(175, SIG_UNBLOCK, 0, &set2, 8));
+				if(TEST_RETURN == -1){
+		        		tst_resm(TFAIL,"rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+					cleanup();
+					tst_exit();
+				} else if(set1.__val[0] != set2.__val[0]){
+		                        tst_resm(TFAIL," rt_sigsuspend failed to preserve signal mask,errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+					cleanup();
+					tst_exit();
+			        } else {
+		                        tst_resm(TPASS,"rt_sigsuspend PASSED");
+		                }
+		        }else{
+		             tst_resm(TFAIL," rt_sigsuspend failed ,errrno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+	                     cleanup();
+			     tst_exit();
+			}
+		
+	
+                }
+	 }
+	cleanup();
+        tst_exit();
+}
+
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 21:26:51.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 21:34:12.000000000 +0530
@@ -790,6 +790,7 @@ rt_sigaction01 rt_sigaction01
 rt_sigprocmask01 rt_sigprocmask01
 rt_sigprocmask02 rt_sigprocmask02
 rt_sigqueueinfo01 rt_sigqueueinfo01
+rt_sigsuspend01 rt_sigsuspend01
 
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

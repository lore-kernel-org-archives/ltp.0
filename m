Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68bZ-0000Lf-9W
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:34:33 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68bQ-0000FT-7T
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:34:33 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ94AR017713
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:09:04 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJ9ei5244476
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:09:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJ9dUh020301
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:09:40 -0600
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:39:35 +0530
Message-Id: <20090518190934.9777.58114.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 03/21] Add bdflush01 test for bdflush syscall
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

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/bdflush/bdflush01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/bdflush/bdflush01.c	2009-05-18 18:56:35.000000000 +0530
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
+/* File:        bdflush01.c                                            */
+/*                                                                            */
+/* Description: bdflush() starts, flushes, or tunes the buffer-dirty-flush    */
+/*		daemon. Only a privileged process (one with the CAP_SYS_ADMIN */
+/*		capability) may call bdflush().				      */
+/*									      */
+/*		If func is negative or 0, and no daemon has been started,     */
+/*	        then bdflush() enters the daemon code and never returns.      */	
+/*									      */	
+/*		If func is 1, some dirty buffers are written to disk.	      */
+/*		If func is 2 or more and is even (low bit is 0), then address */
+/*		is the address of a long word, and the tuning parameter       */
+/*		numbered (func-2)/2 is returned to the caller in that address.*/
+/*									      */	
+/*		If func is 3 or more and is odd (low bit is 1), then data is  */ 
+/*		a long word, and the kernel sets tuning parameter numbered    */
+/*		(func-3)/2 to that value.				      */
+/*		    							      */
+/*		The set of parameters, their values, and their legal ranges   */
+/*		are defined in the kernel source file fs/buffer.c. 	      */
+/*									      */
+/*		Return Value:						      */
+/*		If func is negative or 0 and the daemon successfully starts,  */
+/*		bdflush() never returns. Otherwise, the return value is 0 on  */
+/*		success and -1 on failure, with errno set to indicate the     */
+/*		error.							      */	
+/*									      */	
+/*		Errors:							      */
+/*			EBUSY						      */
+/*			    An attempt was made to enter the daemon code after*/ 
+/*			    another process has already entered. 	      */
+/*			EFAULT						      */
+/*			   address points outside your accessible address     */
+/*			   space. 					      */	
+/*			EINVAL						      */
+/*			    An attempt was made to read or write an invalid   */
+/*			    parameter number, or to write an invalid value to */
+/*			    a parameter. 				      */
+/*			EPERM						      */		
+/*			    Caller does not have the CAP_SYS_ADMIN capability.*/
+/*									      */
+/* Usage:  <for command-line>                                                 */
+/* bdflush01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                      */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   bdflush01                                              */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <sys/kdaemon.h>
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
+char *TCID = "bdflush01";  /* Test program identifier.*/
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
+int errnochoose(void)   //choose the relative errno
+{
+    switch errno
+    {
+        case    EFAULT: perror("EFAULT");
+            break;
+        case    EINVAL: perror("EINVAL");
+            break;
+        case    EPERM:  perror("EPERM");
+            break;
+        case    EBUSY:  perror("EBUSY");
+            break;
+        default:        perror("Other Error");
+            break;
+    }
+    TEST_ERRNO=0;
+    return 0 ;
+}
+
+
+
+int main(int ac, char **av) {
+	long data;
+	int lc;                 /* loop counter */
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
+			TEST(syscall(134,0,data));	//bdflush(0,data);
+			if(TEST_RETURN < 0){
+				tst_resm(TFAIL,"Call to bdflush() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+                        	cleanup();
+				tst_exit();
+			}else {
+				tst_resm(TPASS,"Test PASSED and %d is returned \n",TEST_RETURN);
+				tst_resm(TINFO,"bdflush() activated...\n");
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
--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/bdflush/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/bdflush/Makefile	2009-05-18 14:25:03.000000000 +0530
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
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 18:48:57.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 18:57:42.000000000 +0530
@@ -31,6 +31,8 @@ asyncio02 asyncio02
 bind01 bind01
 bind02 bind02
 
+bdflush01 bdflush01
+
 brk01 brk01
 
 capget01 capget01

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

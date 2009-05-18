Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68zB-00074R-Mk
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:58:57 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68z9-0005aP-LN
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:58:57 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ9bY8027284
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:09:37 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJBLuf232132
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:11:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJBKcf017548
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 13:11:20 -0600
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:41:15 +0530
Message-Id: <20090518191115.9777.51227.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 13/21] Add set_thread_area02 test for set_thread_area
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

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	2009-05-18 22:06:44.000000000 +0530
@@ -0,0 +1,198 @@
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
+/* File:        set_thread_area_02.c                                          */
+/*                                                                            */
+/* Description: This test checks for propper error code on syscalls	      */
+/*		1) get__thread_area():					      */
+/*		  get_thread_area returns an entry in the current thread's    */
+/*		  Thread Local Storage (TLS) array.get_thread_area returns 0  */
+/*	          on success. Otherwise, it returns -1			      */
+/*		2)set_thread_area():    				      */
+/*		 set_thread_area() sets an entry in the current thread's      */
+/*	         Thread Local.When  set_thread_area() is passed an            */
+/*		 entry_number of -1, it uses a free TLS entry.                */
+/*		 set_thread_area() returns 0 on success, and -1 on failure    */	
+/*	         with errno set appropriately. 				      */	
+/*              							      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* set_thread_area_02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                    */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 3                                                             */
+/*                                                                            */
+/* Test Name:   set_thread_area_02
+                                            */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+
+#include <stdio.h>
+#include <errno.h>
+#include <linux/unistd.h>
+#include <asm/ldt.h>
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
+char *TCID = "set_thread_area_02";  /* Test program identifier.*/
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
+int main(int ac, char **av) {
+        
+	struct user_desc u_info;
+        int result;
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
+	             u_info.entry_number = 6;
+	
+	/*
+         * This call to get_thread_area function should be sucessful.
+         */
+
+                     TEST(result = syscall(244, &u_info));     //call get_thread_area()
+                     if(TEST_RETURN == -1) {
+                 	   tst_resm(TFAIL, "call get_thraed_area() failed with errno = %d ", TEST_ERRNO, strerror(TEST_ERRNO));
+                           cleanup();
+	  	           tst_exit();
+                     }
+		     
+		     u_info.entry_number = -2;
+        /*
+         * This call to set_thread_area function with invalid entry_number should be FAILED.
+         */
+
+                     TEST(result = syscall(243, &u_info));     //call set_thread_area()
+                     if(TEST_RETURN == -1) {
+			if(TEST_ERRNO == EINVAL){
+				tst_resm(TPASS, "Call to set_thread_area call failed with invalid entry_number result = %d (expected EINVAL)",TEST_ERRNO);
+			 }
+			 else {
+                 	  	  tst_resm(TPASS,"Call to set_thread_area with invalid entry_number got unexpected result = %d (expected EINVAL)",TEST_ERRNO);
+		               }
+		     }
+		     else {
+	           	    tst_resm(TFAIL,"Call to set_thread_area with invalid entry_number succeed,but should fail" );
+			    cleanup();
+                            tst_exit();
+                     	  }
+
+	/*
+         * This call to set_thread_area function with an invalid pointer should be FAILED with EFAULT.
+         */
+
+                     TEST(result = syscall(243,(struct user_desc *)-9));     //call set_thread_area()
+                     if(TEST_RETURN == -1) {
+			if(TEST_ERRNO == EFAULT){
+				tst_resm(TPASS, "Call to set_thread_area call with invalid entry_number result = %d (got expected error EFAULT)",TEST_ERRNO);
+			 }
+			 else {
+                 	  	  tst_resm(TPASS,"Call to set_thread_area with invalid entry_number got unexpected result = %d (expected EFAULT)",TEST_ERRNO);
+		               }
+		     }
+		     else {
+	           	    tst_resm(TFAIL,"Call to set_thread_area with invalid entry_number succeed,but should fail" );
+                            tst_exit();
+                     	  }
+                }
+        }
+	cleanup();
+        tst_exit();
+}
+
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 21:57:18.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 22:07:55.000000000 +0530
@@ -971,6 +971,7 @@ setrlimit03 setrlimit03
 
 set_robust_list01 set_robust_list01
 set_thread_area01 set_thread_area01
+set_thread_area02 set_thread_area02
 
 setsid01 setsid01
 

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

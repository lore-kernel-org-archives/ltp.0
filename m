Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68v3-0006pW-N8
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:54:41 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68uu-0006RR-6p
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:54:41 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ5Bcu017657
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:05:11 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJ9UlB257102
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:09:30 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJ9T3s015617
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:09:30 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:39:25 +0530
Message-Id: <20090518190924.9777.51784.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
References: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 02/21] Add add_key02 test for add_key syscall
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

--- ltp-intermediate-20090518-manas-work-original/testcases/kernel/syscalls/add_key/add_key02.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/testcases/kernel/syscalls/add_key/add_key02.c	2009-05-18 18:43:42.000000000 +0530
@@ -0,0 +1,173 @@
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
+/* File:        add_key02.c                                           */
+/*                                                                            */
+/* Description: This tests the add_key() syscall                      */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* add_key02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 1                                                             */
+/*                                                                            */
+/* Test Name:   add_key02                                             */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+
+#include <stdio.h>
+#include <errno.h>
+#include <linux/keyctl.h>
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
+char *TCID = "add_key02";  /* Test program identifier.*/
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
+struct test_case_t {
+        char *type;
+        char *desc;
+        void *payload;
+        int plen;
+        int exp_errno;
+} test_cases[] = {
+        { "user", "firstkey", NULL, 1, EINVAL }
+};
+
+int test_count = sizeof(test_cases) / sizeof(struct test_case_t);
+
+
+int main(int ac, char **av) {
+	int i, succeed=0, fail=0;
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
+		for(i=0; i<test_count; i++) {
+                	TEST(syscall(286, test_cases[i].type, test_cases[i].desc, test_cases[i].payload, test_cases[i].plen, KEY_SPEC_USER_KEYRING));    //call add_key()
+                	if(TEST_RETURN != -1){
+                        	tst_resm(TINFO,"call add_key() with wrong args succeed, but should fail");
+                        	fail++;
+                	}else{
+	                        if(errno == test_cases[i].exp_errno){
+	                                tst_resm(TINFO,"call add_key() with wrong args got EXPECTED errno:%d", TEST_ERRNO);
+	                                succeed++;
+	                        }else{
+	                                tst_resm(TINFO,"call add_key() with wrong args got UNEXPECTED errno:%d", TEST_ERRNO);
+	                                fail++;
+				}
+                        }
+
+                }
+        
+		 if(fail != 0){
+                 	tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+                        cleanup();
+	  	        tst_exit();
+	        } else {
+        		tst_resm(TPASS, "add_key call succeeded");
+                        cleanup();
+	        }
+
+
+           }
+      }	
+        tst_exit();
+}
+
--- ltp-intermediate-20090518-manas-work-original/runtest/syscalls	2009-05-18 18:35:12.000000000 +0530
+++ ltp-intermediate-20090518-manas-work/runtest/syscalls	2009-05-18 18:44:42.000000000 +0530
@@ -14,6 +14,7 @@ acct01 acct01
 acct02 acct02
 
 add_key01 add_key01
+add_key02 add_key02
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02

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

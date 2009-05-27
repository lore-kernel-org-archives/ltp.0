Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M9G8V-0002M1-A4
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:13:27 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9G8P-0007vk-TY
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:13:27 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4RA1Hkm009943
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:01:17 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4RADJBP135398
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:13:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4RADIFa018258
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 06:13:19 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Wed, 27 May 2009 15:43:01 +0530
Message-Id: <20090527101256.18638.91923.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
References: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 13/13] Add/Port unshare02 test for unshare() syscall
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
Cc: Manas Kumar Nayak <maknayak@in.ibm.com>

Signed-off-by: Manas Kumar Nayak <maknayak@in.ibm.com>
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Masatake YAMATO <yamato@redhat.com>
---

--- ltp-intermediate-20090521.orig/testcases/kernel/syscalls/unshare/unshare02.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20090521/testcases/kernel/syscalls/unshare/unshare02.c	2009-05-27 14:51:53.000000000 +0530
@@ -0,0 +1,183 @@
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
+/* File:        unshare02.c                                                   */
+/*                                                                            */
+/* Description: This tests the unshare error() syscall                        */
+/*                                                                            */
+/* Usage:  <for command-line>                                                 */
+/* unshare02 [-c n] [-e][-i n] [-I x] [-p x] [-t]                             */
+/*      where,  -c n : Run n copies concurrently.                             */
+/*              -e   : Turn on errno logging.                                 */
+/*              -i n : Execute test n times.                                  */
+/*              -I x : Execute test for x seconds.                            */
+/*              -P x : Pause for x seconds between iterations.                */
+/*              -t   : Turn on syscall timing.                                */
+/*                                                                            */
+/* Total Tests: 2                                                             */
+/*                                                                            */
+/* Test Name:   unshare02                                                     */
+/* History:     Porting from Crackerjack to LTP is done by                    */
+/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
+/******************************************************************************/
+
+#include <stdio.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <errno.h>
+#include <pwd.h>
+#include <grp.h>
+#include <string.h>
+#include <sys/param.h>
+#include <stdio.h>
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
+char *TCID = "unshare02";  /* Test program identifier.*/
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
+int main(int ac, char **av) {
+        pid_t pid1;
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
+
+ /*
+ *fork a child process;testing which one is a child or a parent;
+ * */
+		        TEST(pid1=fork());    //call to fork()
+			if (TEST_RETURN == -1){
+			tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+			cleanup();
+			tst_exit();
+			}
+			else if (TEST_RETURN == 0){
+				if((TEST_RETURN = unshare(-1)) == 0) {
+	        		tst_resm(TPASS, "Call succeeded");
+				tst_exit();
+				}
+				else if (TEST_RETURN == -1 ){
+					tst_resm(TFAIL,"Test Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+					tst_exit();
+                     			}
+			}
+
+			TEST(pid1=fork());    //call to fork()
+                        if (pid1 == -1){
+                        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+                        cleanup();
+                        tst_exit();
+                        }
+                        else if (TEST_RETURN == 0){
+                                if((TEST_RETURN = unshare((int)NULL)) == 0) {
+                                tst_resm(TPASS, "Call succeeded");
+				tst_exit();
+                                }
+                                else if (TEST_RETURN == -1 ){
+                                        tst_resm(TFAIL,"Test Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+					tst_exit();
+                                        }
+                        }
+
+
+                }
+	}
+	cleanup();
+        tst_exit();
+}
+
--- ltp-intermediate-20090521.orig/runtest/syscalls	2009-05-27 14:49:30.000000000 +0530
+++ ltp-intermediate-20090521/runtest/syscalls	2009-05-27 14:57:51.000000000 +0530
@@ -1208,6 +1208,7 @@ unlink08 unlink08
 unlinkat01 unlinkat01
 
 unshare01 unshare01
+unshare02 unshare02
 
 #
 # These tests require an unmounted block device

---
Regards--
Manas


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

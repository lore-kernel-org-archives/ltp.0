Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WfQnN-0004s9-SF
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 09:27:17 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WfQnM-0001uI-RZ
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 09:27:17 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3U9R9ki010389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 09:27:10 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3U9R9Qb013204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 09:27:09 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3U9R9HH008995
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 09:27:09 GMT
From: shuang.qiu@oracle.com
Date: Wed, 30 Apr 2014 17:26:57 +0800
Message-Id: <1398850017-10751-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP]  [PATCH 1/2] syscalls/fstatfs: Cleanup
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
To: ltp-list@lists.sourceforge.net

From: Shuang Qiu <shuang.qiu@oracle.com>

* Delete some useless comments

* Make variables and functions static

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs01.c |  102 ++++---------------------
 testcases/kernel/syscalls/fstatfs/fstatfs02.c |   77 +++++--------------
 2 files changed, 34 insertions(+), 145 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs01.c b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
index 66b014f..2714fa0 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs01.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
@@ -31,83 +31,13 @@
  *
  */
 /* $Id: fstatfs01.c,v 1.7 2009/10/26 14:55:47 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: fstatfs01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for fstatfs(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 03/30/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) fstatfs(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the fstatfs(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	fstatfs(2).
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+/*
+ * DETAILED DESCRIPTION
+ *   This is a Phase I test for the fstatfs(2) system call.  It is intended
+ *   to provide a limited exposure of the system call, for now.  It
+ *   should/will be extended when full functional tests are written for
+ *   fstatfs(2).
+ */
 
 #include <sys/types.h>
 #include <sys/fcntl.h>
@@ -118,17 +48,17 @@
 #include "test.h"
 #include "usctest.h"
 
-void setup();
-void cleanup();
+static void setup(void);
+static void cleanup(void);
 
 char *TCID = "fstatfs01";
 int TST_TOTAL = 1;
 
-int exp_enos[] = { 0, 0 };
+static int exp_enos[] = { 0, 0 };
 
-char fname[255];
-int fd;
-struct statfs stats;
+static char fname[255];
+static int fd;
+static struct statfs stats;
 
 int main(int ac, char **av)
 {
@@ -169,9 +99,8 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
@@ -183,7 +112,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
@@ -191,5 +120,4 @@ void cleanup(void)
 		tst_resm(TWARN | TERRNO, "close failed");
 
 	tst_rmdir();
-
 }
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index cee234f..b243af3 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -1,48 +1,24 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	fstatfs02.c
- *
  * DESCRIPTION
  *	Testcase to check fstatfs() sets errno correctly.
- *
- * ALGORITHM
- *	1. Pass -1 as the "fd" parameter for fstatfs(), and expect EBADF.
- *	2. Pass an invalid address (outside the address space of the process),
- *	   as the buf paramter of fstatfs(), and expect EFAULT.
- *
- * USAGE:  <for command-line>
- *  fstatfs02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
  */
 
 #include <sys/vfs.h>
@@ -52,16 +28,16 @@
 #include "test.h"
 #include "usctest.h"
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
 char *TCID = "fstatfs02";
 
-int exp_enos[] = { EBADF, EFAULT, 0 };
+static int exp_enos[] = { EBADF, EFAULT, 0 };
 
-struct statfs buf;
+static struct statfs buf;
 
-struct test_case_t {
+static struct test_case_t {
 	int fd;
 	struct statfs *sbuf;
 	int error;
@@ -126,33 +102,18 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* make a temporary directory and cd to it */
 	tst_tmpdir();
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
-	/* delete the test directory created in setup() */
 	tst_rmdir();
-
 }
-- 
1.7.7


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

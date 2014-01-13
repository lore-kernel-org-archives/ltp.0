Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1W2iHK-0008DK-Oc
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 14:14:10 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W2iHJ-00006j-5H
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 14:14:10 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id s0DEE2dJ003391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 14:14:03 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s0DEE1N5000260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 14:14:02 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s0DEE1Ia022760
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jan 2014 14:14:01 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 13 Jan 2014 18:13:56 +0400
Message-Id: <1389622436-28019-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] syscalls/lchown: 16-bit fixes and minor cleanup
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/lchown/lchown01.c |   86 +++++-------------------
 testcases/kernel/syscalls/lchown/lchown02.c |   96 +++++++--------------------
 testcases/kernel/syscalls/utils/compat_16.h |    5 ++
 3 files changed, 49 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/lchown/lchown01.c b/testcases/kernel/syscalls/lchown/lchown01.c
index 738f0b9..8762883 100644
--- a/testcases/kernel/syscalls/lchown/lchown01.c
+++ b/testcases/kernel/syscalls/lchown/lchown01.c
@@ -1,25 +1,22 @@
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
- * Test Name: lchown01
- *
  * Test Description:
  *  Verify that, lchown(2) succeeds to change the owner and group of a file
  *  specified by path to any numeric owner(uid)/group(gid) values when invoked
@@ -29,44 +26,9 @@
  *  lchown(2) should return 0 and the ownership set on the file should match
  *  the numeric values contained in owner and group respectively.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *	Verify the Functionality of system call
- *      if successful,
- *		Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  lchown01 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
  *	11/2010 Code cleanup by Cyril Hrubis chrubis@suse.cz
- *
- * RESTRICTIONS:
- *  This test should be run by 'super-user' (root) only.
- *
  */
 
 #include <stdio.h>
@@ -79,12 +41,13 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define TESTFILE	"testfile"
 #define SFILE		"slink_file"
 
-char *TCID = "lchown01";
+TCID_DEFINE(lchown01);
 int TST_TOTAL = 5;
 
 struct test_case_t {
@@ -103,8 +66,8 @@ static struct test_case_t test_cases[] = {
 	{NULL, 0, 0}
 };
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int argc, char *argv[])
 {
@@ -132,7 +95,7 @@ int main(int argc, char *argv[])
 			 * group id (numeric values) to set it on
 			 * symlink of testfile.
 			 */
-			TEST(lchown(SFILE, user_id, group_id));
+			TEST(LCHOWN(cleanup, SFILE, user_id, group_id));
 
 			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL,
@@ -193,13 +156,7 @@ int main(int argc, char *argv[])
 	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *	     Create a temporary directory and change directory to it.
- *	     Create a test file under temporary directory and close it
- *	     Create a symlink of testfile under temporary directory.
- */
-void setup(void)
+static void setup(void)
 {
 	int fd;
 
@@ -222,12 +179,7 @@ void setup(void)
 	}
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- *	       Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 4b20410..52185cf 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -1,20 +1,19 @@
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
@@ -39,43 +38,9 @@
  * Expected Result:
  *  lchown() should fail with return value -1 and set expected errno.
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	if errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory(s)/file(s) created.
- *
- * Usage:  <for command-line>
- *  lchown02 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
  *      11/2010 Rewritten by Cyril Hrubis chrubis@suse.cz
- *
- * RESTRICTIONS:
- *
  */
 
 #include <stdio.h>
@@ -93,6 +58,7 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 #define TEST_USER       "nobody"
 #define MODE_RWX	S_IRWXU | S_IRWXG | S_IRWXO
@@ -105,7 +71,7 @@
 #define TFILE3          "t_file"
 #define SFILE3		"t_file/sfile"
 
-char *TCID = "lchown02";
+TCID_DEFINE(lchown02);
 int TST_TOTAL = 7;
 
 static void setup_eperm(int pos);
@@ -140,8 +106,8 @@ static struct passwd *ltpuser;
 static int exp_enos[] =
     { EPERM, EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0 };
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int argc, char *argv[])
 {
@@ -159,7 +125,9 @@ int main(int argc, char *argv[])
 	TEST_EXP_ENOS(exp_enos);
 
 	user_id = geteuid();
+	UID16_CHECK(user_id, lchown, cleanup);
 	group_id = getegid();
+	GID16_CHECK(group_id, lchown, cleanup);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
@@ -173,7 +141,7 @@ int main(int argc, char *argv[])
 			 * verify that it fails with -1 return value and
 			 * sets appropriate errno.
 			 */
-			TEST(lchown(file_name, user_id, group_id));
+			TEST(LCHOWN(cleanup, file_name, user_id, group_id));
 
 			/* Check return code from lchown(2) */
 			if (TEST_RETURN == -1) {
@@ -200,14 +168,7 @@ int main(int argc, char *argv[])
 	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *	Exit the test program on receipt of unexpected signals.
- *	Create a temporary directory and change directory to it.
- *	Invoke individual test setup functions.
- */
-void setup(void)
+static void setup(void)
 {
 	int i;
 
@@ -239,7 +200,7 @@ void setup(void)
  *
  * Create test file and symlink with uid 0.
  */
-void setup_eperm(int pos LTP_ATTRIBUTE_UNUSED)
+static void setup_eperm(int pos LTP_ATTRIBUTE_UNUSED)
 {
 	int fd;
 
@@ -272,7 +233,7 @@ void setup_eperm(int pos LTP_ATTRIBUTE_UNUSED)
  *  Modify the mode permissions on test directory such that process will not
  *  have search permissions on test directory.
  */
-void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
+static void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
 {
 	int fd;
 
@@ -337,7 +298,7 @@ static void setup_highaddress(int pos)
  *
  * Create a regular file "t_file" to call lchown(2) on "t_file/sfile" later.
  */
-void setup_enotdir(int pos LTP_ATTRIBUTE_UNUSED)
+static void setup_enotdir(int pos LTP_ATTRIBUTE_UNUSED)
 {
 	int fd;
 
@@ -355,20 +316,13 @@ void setup_enotdir(int pos LTP_ATTRIBUTE_UNUSED)
  * longpath_setup() - setup to create a node with a name length exceeding
  *                    the length of PATH_MAX.
  */
-void setup_longpath(int pos)
+static void setup_longpath(int pos)
 {
 	memset(test_cases[pos].pathname, 'a', PATH_MAX + 1);
 	test_cases[pos].pathname[PATH_MAX + 1] = '\0';
 }
 
-/*
- * cleanup() - Performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *
- *	Remove temporary directory and sub-directories/files under it
- *	created during setup().
- */
-void cleanup(void)
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index 47f9912..e30dfba 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -125,4 +125,9 @@ int SETREGID(void (cleanup)(void), GID_T rgid, GID_T egid)
 {
 	LTP_CREATE_SYSCALL(setregid, cleanup, rgid, egid);
 }
+
+int LCHOWN(void (cleanup)(void), const char *path, UID_T owner, GID_T group)
+{
+	LTP_CREATE_SYSCALL(lchown, cleanup, path, owner, group);
+}
 #endif /* __LTP_COMPAT_16_H__ */
-- 
1.7.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

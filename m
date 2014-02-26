Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WIdpx-0005hl-MI
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 12:43:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WIdpv-0003yZ-FS
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 12:43:45 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1QChXb8009143
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 20:43:34 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 26 Feb 2014 20:32:25 +0800
Message-Id: <1393417946-8817-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v3 1/2] mknod/mknod07.c: cleanup
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

Delete some useless comment.
Move the test body from main() to mknod_verify().
Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mknod/mknod07.c | 160 ++++++++++--------------------
 1 file changed, 50 insertions(+), 110 deletions(-)

diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index 6cdf980..ea17eef 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   07/2001 Ported by Wayne Boyer
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,12 +14,11 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * Test Name: mknod07
  *
  * Test Description:
  * Verify that,
@@ -27,44 +27,6 @@
  *   2) mknod(2) returns -1 and sets errno to EACCES if parent directory
  *	does not allow  write  permission  to  the process.
  *
- * Expected Result:
- *  mknod() should fail with return value -1 and set expected errno.
- *
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
- *  mknod07 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  This test should be executed by non-super-user only.
  */
 
 #include <stdio.h>
@@ -79,125 +41,103 @@
 
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
-#define NEWMODE		S_IFIFO | S_IRUSR | S_IRGRP | S_IROTH
-#define SOCKET_MODE	S_IFSOCK| S_IRWXU | S_IRWXG | S_IRWXO
-#define DIR_TEMP	"testdir_1"
+#define DIR_TEMP		"testdir_1"
+#define DIR_TEMP_MODE		(S_IRUSR | S_IXUSR)
 
-void setup2();			/* setup function to test mknod for EACCES */
+#define FIFO_MODE	(S_IFIFO | S_IRUSR | S_IRGRP | S_IROTH)
+#define SOCKET_MODE	(S_IFSOCK | S_IRWXU | S_IRWXG | S_IRWXO)
+#define CHR_MODE	(S_IFCHR | S_IRUSR | S_IWUSR)
+#define BLK_MODE	(S_IFBLK | S_IRUSR | S_IWUSR)
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+static struct test_case_t {
 	char *pathname;
 	int mode;
 	int exp_errno;
-	void (*setupfunc) (void);
 } test_cases[] = {
-	{
-	"tnode_1", SOCKET_MODE, EACCES, NULL}, {
-"tnode_2", NEWMODE, EACCES, setup2},};
+	{ "testdir_1/tnode_1", SOCKET_MODE, EACCES },
+	{ "testdir_1/tnode_2", FIFO_MODE, EACCES },
+	{ "tnode_3", CHR_MODE, EPERM },
+	{ "tnode_4", BLK_MODE, EPERM },
+};
 
 char *TCID = "mknod07";
-int TST_TOTAL = 2;
-int exp_enos[] = { EPERM, EACCES, 0 };
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EPERM, EACCES, 0 };
 
-void setup();			/* setup function for the tests */
-void cleanup();			/* cleanup function for the tests */
+static void setup(void);
+static void mknod_verify(const struct test_case_t *test_case);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	char *node_name;	/* ptr. for node name created */
 	int i;
-	int mode;		/* creation mode for the node created */
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
-	TEST_EXP_ENOS(exp_enos);
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			node_name = test_cases[i].pathname;
-			mode = test_cases[i].mode;
-
-			TEST(mknod(node_name, mode, 0));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "mknod succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == test_cases[i].exp_errno)
-				tst_resm(TPASS | TTERRNO,
-					 "mknod failed as expected");
-			else
-				tst_resm(TFAIL | TTERRNO,
-					 "mknod failed unexpectedly; expected: "
-					 "%d - %s", test_cases[i].exp_errno,
-					 strerror(test_cases[i].exp_errno));
-		}
-
+		for (i = 0; i < TST_TOTAL; i++)
+			mknod_verify(&test_cases[i]);
 	}
 
 	cleanup();
 	tst_exit();
 }
 
-void setup()
+static void setup(void)
 {
-	int i;
+	struct passwd *ltpuser;
 
 	tst_require_root(NULL);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid failed");
-
-	TEST_PAUSE;
+	TEST_EXP_ENOS(exp_enos);
 
 	tst_tmpdir();
 
-	if (mkdir(DIR_TEMP, MODE_RWX) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir failed");
-
-	if (chmod(DIR_TEMP, MODE_RWX) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod failed");
+	TEST_PAUSE;
 
-	if (chdir(DIR_TEMP) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "chdir failed");
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
-	for (i = 0; i < TST_TOTAL; i++)
-		if (test_cases[i].setupfunc != NULL)
-			test_cases[i].setupfunc();
+	SAFE_MKDIR(cleanup, DIR_TEMP, DIR_TEMP_MODE);
 }
 
-void setup2()
+static void mknod_verify(const struct test_case_t *test_case)
 {
-	if (chmod(".", NEWMODE) < 0)
-		tst_brkm(TBROK, cleanup, "chmod failed");
+	TEST(mknod(test_case->pathname, test_case->mode, 0));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mknod succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test_case->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "mknod failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mknod failed unexpectedly; expected: "
+			 "%d - %s", test_case->exp_errno,
+			 strerror(test_case->exp_errno));
+	}
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
 	if (seteuid(0) == -1)
-		tst_resm(TBROK, "seteuid(0) failed");
+		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
 
 	tst_rmdir();
-
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W83Ee-0007mg-SS
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 07:37:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W83Ec-0001vb-8q
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 07:37:28 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0S7bIj4023436
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Jan 2014 15:37:18 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 28 Jan 2014 15:36:04 +0800
Message-Id: <1390894565-463-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 1/2] mknod/mknod07.c: cleanup
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

Delete some useless commtents.
Move the test body form main() to mknod_verify().
Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mknod/mknod07.c | 165 ++++++++++--------------------
 1 file changed, 53 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index 6cdf980..09ff604 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -18,7 +18,6 @@
  */
 
 /*
- * Test Name: mknod07
  *
  * Test Description:
  * Verify that,
@@ -27,44 +26,6 @@
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
@@ -79,73 +40,48 @@
 
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
+#define BLK_MODE 	(S_IFBLK | S_IRUSR | S_IWUSR)
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+
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
+static void setup(int ac, char **argv);
+static void mknod_verify(int i);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
 	int lc;
-	char *msg;
-	char *node_name;	/* ptr. for node name created */
 	int i;
-	int mode;		/* creation mode for the node created */
-
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
 
-	TEST_EXP_ENOS(exp_enos);
+	setup(ac, av);
 
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
+		for (i = 0; i < TST_TOTAL; i++)
+			mknod_verify(i);
 
 	}
 
@@ -153,51 +89,56 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-void setup()
+static void setup(int ac, char **av)
 {
-	int i;
+	char *msg;
+	char nobody_uid[] = "nobody";
+	struct passwd *ltpuser;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
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
+	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
-	for (i = 0; i < TST_TOTAL; i++)
-		if (test_cases[i].setupfunc != NULL)
-			test_cases[i].setupfunc();
+	SAFE_MKDIR(cleanup, DIR_TEMP, DIR_TEMP_MODE);
 }
 
-void setup2()
+static void mknod_verify(int i)
 {
-	if (chmod(".", NEWMODE) < 0)
-		tst_brkm(TBROK, cleanup, "chmod failed");
+	TEST(mknod(test_cases[i].pathname, test_cases[i].mode, 0));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "mknod succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test_cases[i].exp_errno) {
+		tst_resm(TPASS | TTERRNO, "mknod failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "mknod failed unexpectedly; expected: "
+			 "%d - %s", test_cases[i].exp_errno,
+			 strerror(test_cases[i].exp_errno));
+	}
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
-	if (seteuid(0) == -1)
-		tst_resm(TBROK, "seteuid(0) failed");
+	SAFE_SETEUID(NULL, 0);
 
 	tst_rmdir();
-
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

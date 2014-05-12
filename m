Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WjjTC-00058d-7C
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 06:12:14 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WjjTA-0001IH-4u
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 06:12:14 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4C6C5fl011941
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 14:12:05 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 12 May 2014 14:09:46 +0800
Message-ID: <1399874987-24926-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] setpgid/setpgid01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Delete some useless comments.
Do some code re-arrangement.
Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setpgid/setpgid01.c | 204 +++++++-------------------
 1 file changed, 57 insertions(+), 147 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c b/testcases/kernel/syscalls/setpgid/setpgid01.c
index 57e71fc..d35f201 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid01.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
@@ -31,83 +31,12 @@
  *
  */
 /* $Id: setpgid01.c,v 1.7 2009/11/02 13:57:18 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: setpgid01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for setpgid(2)
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
- * 	1.) setpgid(2) returns...(See Description)
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
- *	This is a Phase I test for the setpgid(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	setpgid(2).
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
+
+/*
+ * Description:
+ * Verify that:
+ *   1. Basic functionality test for setpgid(2).
+ */
 
 #include <errno.h>
 #include <string.h>
@@ -117,115 +46,96 @@
 #include "test.h"
 #include "usctest.h"
 
-void setup();
-void cleanup();
+static void setup(void);
+static void cleanup(void);
 
 char *TCID = "setpgid01";
-int TST_TOTAL = 1;
-
-int exp_enos[] = { 0, 0 };
 
-int pgid, pid;
+static void setpgid_test1(void);
+static void (*testfunc[])(void) = { setpgid_test1};
+int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	char *msg;
 
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-    /***************************************************************
-     * perform global setup for test
-     ***************************************************************/
 	setup();
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
 		tst_count = 0;
 
-		/*
-		 * Call setpgid(2)
-		 */
-		TEST(setpgid(pid, pgid));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			TEST_ERROR_LOG(TEST_ERRNO);
-			tst_resm(TFAIL, "setpgid(%d, %d) Failed, errno=%d : %s",
-				 pid, pgid, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
-			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
-				tst_resm(TPASS, "setpgid(%d, %d) returned %ld",
-					 pid, pgid, TEST_RETURN);
-			}
-		}
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
 	}
 
-    /***************************************************************
-     * cleanup and exit
-     ***************************************************************/
 	cleanup();
 	tst_exit();
-
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static int wait4child(pid_t child)
 {
 	int status;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	if (waitpid(child, &status, 0) == -1)
+		tst_resm(TBROK | TERRNO, "waitpid");
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+	else
+		return status;
+}
 
-	/*
-	 * Make sure current process is NOT a session or pgrp leader
-	 */
+static void setpgid_test1(void)
+{
+	int ret;
+	pid_t pgid, pid;
 
 	pgid = getpgrp();
 	pid = getpid();
 
+	/*
+	 * Make sure current process is NOT a session or pgrp leader
+	 */
 	if (pgid == pid) {
 		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "fork() in setup() failed - errno %d", errno);
+			tst_brkm(TBROK | TERRNO, cleanup, "fork()");
 		}
 
-		if (pid != 0) {	/* parent - sits and waits */
-			wait(&status);
-			exit(WEXITSTATUS(status));
-		} else {	/* child - continues with test */
+		if (pid != 0) {
+			ret = wait4child(pid);
+		} else {
 			pid = getpid();
+			TEST(setpgid(pid, pgid));
+			if (TEST_RETURN == -1 || getpgrp() != pgid)
+				exit(1);
+			else
+				exit(0);
 		}
+	} else {
+		TEST(setpgid(pid, pgid));
+		if (TEST_RETURN == -1 || getpgrp() != pgid)
+			ret = 1;
+		else
+			ret = 0;
 	}
+
+	if (ret == 0)
+		tst_resm(TPASS, "test setpgid(%d, %d) success", pid, pgid);
+	else
+		tst_resm(TFAIL, "test setpgid(%d, %d) fail", pid, pgid);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void setup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

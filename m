Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Vyelh-0008PO-MM
	for ltp-list@lists.sourceforge.net; Thu, 02 Jan 2014 09:40:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vyelg-00070a-7J
	for ltp-list@lists.sourceforge.net; Thu, 02 Jan 2014 09:40:45 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s029eWRu020728
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jan 2014 17:40:32 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 2 Jan 2014 17:39:34 +0800
Message-Id: <1388655575-4078-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1388655575-4078-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1388655575-4078-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 3/4] delete_module/delete_module03.c: cleanup
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

* Delete some useless commtents and fix some.
* Use SAFE_* macros.
* Make tests only run kernel 2.6.0 or higher
* Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 .../kernel/module/delete_module/delete_module03.c  | 232 +++++++--------------
 1 file changed, 79 insertions(+), 153 deletions(-)

diff --git a/testcases/kernel/module/delete_module/delete_module03.c b/testcases/kernel/module/delete_module/delete_module03.c
index f38c03a..9638e4a 100644
--- a/testcases/kernel/module/delete_module/delete_module03.c
+++ b/testcases/kernel/module/delete_module/delete_module03.c
@@ -14,202 +14,128 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : delete_module03
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking error conditions for delete_module(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
+
+/*
+ *    AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
  *
  *    DESCRIPTION
- *      Verify that, delete_module(2) returns -1 and sets errno to EBUSY, if
- *		 tried to remove a module in-use.
+ *      Verify that, delete_module(2) returns -1 and sets errno to EWOULDBLOCK,
+ *      if tried to remove a module while other modules depend on this module.
  *
- *      Setup:
- *        Setup signal handling.
- *        Test caller is super user
- *        Set expected errnos for logging
- *        Pause for SIGUSR1 if option specified.
- *		   Insert loadable modules
- *
- *      Test:
- *       Loop if the proper options are given.
- *        Execute system call
- *        Check return code and error number, if matching,
- *                   Issue PASS message
- *        Otherwise,
- *                   Issue FAIL message
- *
- *      Cleanup:
- *        Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  delete_module03 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		 		 where,  -c n : Run n copies concurrently. (no
- *		 		 		effect)
- *	 		 		 -e   : Turn on errno logging.
- *	 		 		 -f   : Turn off functional testing
- *	 		 		 -h   : Show help screen
- *	 		 		 -i n : Execute test n times.
- *	 		 		 -I x : Execute test for x seconds.
- *	 		 		 -p   : Pause for SIGUSR1 before
- *	 		 		 	starting
- *	 		 		 -P x : Pause for x seconds between
- *	 		 		 	iterations.
- *	 		 		 -t   : Turn on syscall timing.
- *
- * RESTRICTIONS
- *		 -c option has no effect for this testcase, even if used allows
- *		 only one instance to run at a time.
- *
- * CHANGELOG
- *
- *  11/22/02 -	Added "--force" to insmod options and redirected output to
- *  		/dev/null. This was done to allow kernel mismatches, b/c it
- *  		doesn't matter in this case.
- *		Robbie Williamson <robbiew@us.ibm.com>
- *
- ****************************************************************/
+ */
 
-#include <libgen.h>
 #include <errno.h>
-#include <pwd.h>
 #include "test.h"
 #include "usctest.h"
+#include "tst_module.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
 
-#define DUMMY_MOD		 "dummy_del_mod"
-#define DUMMY_MOD_DEP		 "dummy_del_mod_dep"
-#define EXP_RET_VAL		 -1
-#define EXP_ERRNO		 EWOULDBLOCK
-/*#define EXP_ERRNO		 EBUSY */
+#define DUMMY_MOD		"dummy_del_mod"
+#define DUMMY_MOD_KO		"dummy_del_mod.ko"
+#define DUMMY_MOD_DEP		"dummy_del_mod_dep"
+#define DUMMY_MOD_DEP_KO	"dummy_del_mod_dep.ko"
+
+static int dummy_mod_loaded;
+static int dummy_mod_dep_loaded;
 
 char *TCID = "delete_module03";
-/*static int exp_enos[] = {EBUSY, 0}; */
 static int exp_enos[] = { EWOULDBLOCK, 0 };
 
 int TST_TOTAL = 1;
 
-static void setup(void);
+static void setup(int argc, char *argv[]);
 static void cleanup(void);
 
 int main(int argc, char **argv)
 {
 	int lc;
-	char *msg;
-	char cmd[50];
-
-	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	if (STD_COPIES != 1) {
-		tst_resm(TINFO, "-c option has no effect for this testcase - "
-			 "doesn't allow running more than one instance "
-			 "at a time");
-		STD_COPIES = 1;
-	}
 
-	/* Load first kernel module */
-	if (sprintf(cmd, "/sbin/insmod %s/%s.ko", dirname(argv[0]),
-		    DUMMY_MOD) <= 0) {
-		tst_resm(TBROK, "sprintf failed");
-		return 1;
-	}
-	if ((system(cmd)) != 0) {
-		tst_resm(TBROK, "Failed to load %s module", DUMMY_MOD);
-		return 1;
-	}
-
-	/* Load dependant kernel module */
-	if (sprintf(cmd, "/sbin/insmod %s/%s.ko", dirname(argv[0]),
-		    DUMMY_MOD_DEP) <= 0) {
-		tst_resm(TBROK, "sprintf failed");
-		goto END;
-	}
-	if ((system(cmd)) != 0) {
-		tst_resm(TBROK, "Failed to load %s module", DUMMY_MOD_DEP);
-		goto END;
-	}
-
-	setup();
+	setup(argc, argv);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		/* Test the system call */
-		TEST(delete_module(DUMMY_MOD));
-
-		TEST_ERROR_LOG(TEST_ERRNO);
-		if ((TEST_RETURN == (int)EXP_RET_VAL) &&
-		    (TEST_ERRNO == EXP_ERRNO)) {
-			tst_resm(TPASS, "Expected failure for module in-use, "
-				 "errno: %d", TEST_ERRNO);
+		TEST(ltp_syscall(__NR_delete_module, DUMMY_MOD, 0));
+		TEST_ERROR_LOG(errno);
+
+		if (TEST_RETURN < 0) {
+			switch (errno) {
+			case EWOULDBLOCK:
+				tst_resm(TPASS | TTERRNO,
+					 "delete_module() failed as expected");
+			break;
+			default:
+				tst_resm(TFAIL | TTERRNO, "delete_module() "
+					 "failed unexpectedly; expected: "
+					 "%d - %s", EWOULDBLOCK,
+					 strerror(EWOULDBLOCK));
+			break;
+			}
 		} else {
-			tst_resm(TFAIL, "Unexpected results for module in-use; "
-				 "returned %d (expected %d), errno %d "
-				 "(expected %d)", TEST_RETURN,
-				 EXP_RET_VAL, TEST_ERRNO, EXP_ERRNO);
+			tst_resm(TFAIL, "delete_module()"
+				 "succeeded unexpectedly");
+			dummy_mod_loaded = 0;
+			/*
+			 * insmod DUMMY_MOD_KO again in case running
+			 * with -i option
+			 */
+			tst_module_load(cleanup, DUMMY_MOD_KO, NULL);
+			dummy_mod_loaded = 1;
 		}
 	}
+
 	cleanup();
-END:
-	if (system("rmmod " DUMMY_MOD) != 0) {
-		tst_resm(TBROK, "Failed to unload %s module", DUMMY_MOD);
-		return 1;
-	}
+	tst_exit();
 
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(int argc, char *argv[])
 {
+	char *msg;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	tst_require_root(NULL);
+	if (tst_kvercmp(2, 6, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			 "Test must be run with kernel 2.6 or newer");
+	}
 
-	tst_tmpdir();
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_require_root(NULL);
 
-	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
+	/* Load first kernel module */
+	tst_module_load(cleanup, DUMMY_MOD_KO, NULL);
+	dummy_mod_loaded = 1;
+
+	/* Load dependant kernel module */
+	tst_module_load(cleanup, DUMMY_MOD_DEP_KO, NULL);
+	dummy_mod_dep_loaded = 1;
+
+	if (STD_COPIES != 1) {
+		tst_resm(TINFO, "-c option has no effect for this testcase - "
+			 "doesn't allow running more than one instance "
+			 "at a time");
+		STD_COPIES = 1;
+	}
+
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
 	/* Unload dependent kernel module */
-	if (system("rmmod " DUMMY_MOD_DEP) != 0) {
-		tst_resm(TBROK, "Failed to unload %s module", DUMMY_MOD_DEP);
-	}
+	if (dummy_mod_dep_loaded == 1)
+		tst_module_unload(NULL, DUMMY_MOD_DEP_KO);
+
 	/* Unload first kernel module */
-	if (system("rmmod " DUMMY_MOD) != 0) {
-		tst_resm(TBROK, "Failed to unload %s module", DUMMY_MOD);
-	}
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+	if (dummy_mod_loaded == 1)
+		tst_module_unload(NULL, DUMMY_MOD_KO);
+
 	TEST_CLEANUP;
-	tst_rmdir();
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WD8Py-0004Fc-O7
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 08:10:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WD8Pv-0005bV-U1
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 08:10:10 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1B89wDh028559
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 16:09:58 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 11 Feb 2014 16:08:38 +0800
Message-Id: <1392106121-5480-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 1/4] delete_module/delete_module01.c: cleanup
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

* Delete some useless commtents.
* Use SAFE_* macros.
* Some cleanup and fixes.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 .../kernel/module/delete_module/delete_module01.c  | 148 +++++----------------
 1 file changed, 36 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/module/delete_module/delete_module01.c b/testcases/kernel/module/delete_module/delete_module01.c
index b96564d..cb1a7fb 100644
--- a/testcases/kernel/module/delete_module/delete_module01.c
+++ b/testcases/kernel/module/delete_module/delete_module01.c
@@ -14,157 +14,81 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : delete_module01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for delete_module(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *		 Uses SIGUSR1 to pause before test if option set.
- *		 (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *		 This is a Phase I test for the delete_module(2) system call.
- *		 It is intended to provide limited exposure of the system call.
- *
- *		 Setup:
- *		   Setup signal handling.
- *		   Test caller is superuser
- *		   Pause for SIGUSR1 if option specified.
- *		   Initialize modname for each child process.
- *
- *		 Test:
- *		  Loop if the proper options are given.
- *		   Create module entry
- *		   Execute system call
- *		   Check return code, if system call failed (return=-1),
- *		   	issue a FAIL message with the errno.
- *		   Otherwise, Issue PASS message.
- *
- *		 Cleanup:
- *		   Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  delete_module01 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		 		 where,  -c n : Run n copies concurrently.
- *			 		 -e   : Turn on errno logging.
- *		 	 		 -f   : Turn off functional testing
- *		 	 		 -h   : Show help screen
- *		 	 		 -i n : Execute test n times.
- *		 	 		 -I x : Execute test for x seconds.
- *		 	 		 -p   : Pause for SIGUSR1 before
- *		 	 		 	starting test.
- *		 	 		 -P x : Pause for x seconds between
- *		 	 		 	iterations.
- *		 	 		 -t   : Turn on syscall timing.
+
+/*
+ *    AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
  *
- ****************************************************************/
+ *    DESCRIPTION:
+ *    	Basic tests for delete_module(2)
+ *    	1) insmod dummy_del_mod.ko
+ *    	2) call delete_module(2) to remove dummy_del_mod.ko
+ */
 
-#include <libgen.h>
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
+#include "tst_module.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+
+#define MODULE_NAME	"dummy_del_mod"
+#define MODULE_NAME_KO	"dummy_del_mod.ko"
 
 static void setup(void);
 static void cleanup(void);
 
-char *TCID = "delete_module01";	/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
+
+char *TCID = "delete_module01";
+int TST_TOTAL = 1;
+static int module_loaded;
 
 int main(int argc, char **argv)
 {
 	int lc;
 	char *msg;
-	char cmd[PATH_MAX];
-	char *module_name = "dummy_del_mod";
 
-	if ((msg = parse_opts(argc, argv, NULL, NULL)) != (char *)NULL) {
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		/* Execute system call */
-		sprintf(cmd, "/sbin/insmod %s/%s.ko", dirname(argv[0]),
-			module_name);
-
-		/* Insmod the module */
-		if ((system(cmd)) != 0) {
-			tst_resm(TBROK, "Failed to load %s module",
-				 module_name);
-			printf("system() failed; cannot test init_module: "
-			       "errno=%i\n", errno);
-			goto EXIT;
+		/* insert dummy_del_mod.ko */
+		if (module_loaded == 0) {
+			tst_module_load(NULL, MODULE_NAME_KO, NULL);
+			module_loaded = 1;
 		}
 
-		/* Test the system call */
-		TEST(delete_module(module_name));
-
-		/* check return code */
+		TEST(ltp_syscall(__NR_delete_module, MODULE_NAME, 0));
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "delete_module() failed to remove"
-				 " module entry for %s, errno=%d : %s",
-				 module_name, TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TFAIL | TTERRNO, "delete_module() failed to "
+				 "remove module entry for %s ", MODULE_NAME);
 		} else {
-			tst_resm(TPASS, "delete_module() successful, returned"
-				 " %d", TEST_RETURN);
+			tst_resm(TPASS, "delete_module() successful");
+			module_loaded = 0;
 		}
 
 	}
 
-	/* perform global cleanup and exit */
-EXIT:
 	cleanup();
-
+	tst_exit();
 }
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void setup(void)
 {
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Check whether we are root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
+	tst_require_root(NULL);
 
-	}
-
-	/*
-	 * if (tst_kvercmp(2,5,48) >= 0)
-	 * tst_brkm(TCONF, NULL, "This test will not work on "
-	 *                              "kernels after 2.5.48");
-	 */
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
 	TEST_PAUSE;
-
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+	if (module_loaded == 1)
+		tst_module_unload(NULL, MODULE_NAME_KO);
 	TEST_CLEANUP;
-
 }
-- 
1.8.2.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

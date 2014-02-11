Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WD8Q2-0001wl-CN
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 08:10:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WD8Pz-0005bV-Vz
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 08:10:14 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1B89xSn028562
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 16:09:59 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 11 Feb 2014 16:08:39 +0800
Message-Id: <1392106121-5480-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1392106121-5480-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1392106121-5480-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 2/4] delete_module/delete_module02.c: cleanup
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
* Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 .../kernel/module/delete_module/delete_module02.c  | 242 ++++++---------------
 1 file changed, 64 insertions(+), 178 deletions(-)

diff --git a/testcases/kernel/module/delete_module/delete_module02.c b/testcases/kernel/module/delete_module/delete_module02.c
index 23b0b0a..69fa6cc 100644
--- a/testcases/kernel/module/delete_module/delete_module02.c
+++ b/testcases/kernel/module/delete_module/delete_module02.c
@@ -14,72 +14,19 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : delete_module02
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking error conditions for delete_module(2)
- *
- *    TEST CASE TOTAL   : 5
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
  *      Verify that,
  *      1. delete_module(2) returns -1 and sets errno to ENOENT for nonexistent
  *	   module entry.
- *      2. delete_module(2) returns -1 and sets errno to EINVAL, if module
- *         name parameter is null terminated (zero length) string.
- *      3. delete_module(2) returns -1 and sets errno to EFAULT, if
+ *      2. delete_module(2) returns -1 and sets errno to EFAULT, if
  *         module name parameter is outside program's accessible address space.
- *      4. delete_module(2) returns -1 and sets errno to ENAMETOOLONG, if
- *         module name parameter is too long.
- *      5. delete_module(2) returns -1 and sets errno to EPERM, if effective
+ *      3. delete_module(2) returns -1 and sets errno to EPERM, if effective
  *         user id of the caller is not superuser.
- *
- *      Setup:
- *        Setup signal handling.
- *        Test caller is super user
- *        Check existances of "nobody" user id.
- *        Initialize  long module name
- *        Set expected errnos for logging
- *        Pause for SIGUSR1 if option specified.
- *		   Initialize modname for each child process
- *
- *      Test:
- *       Loop if the proper options are given.
- *		   Perform testcase specific setup (if needed)
- *        Execute system call
- *        Check return code and error number, if matching,
- *                   Issue PASS message
- *        Otherwise,
- *                   Issue FAIL message
- *		   Perform testcase specific cleanup (if needed)
- *
- *      Cleanup:
- *        Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  delete_module02 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		 		 where,  -c n : Run n copies concurrently.
- *	 		 		 -e   : Turn on errno logging.
- *	 		 		 -f   : Turn off functional testing
- *	 		 		 -h   : Show help screen
- *	 		 		 -i n : Execute test n times.
- *	 		 		 -I x : Execute test for x seconds.
- *	 		 		 -p   : Pause for SIGUSR1 before
- *	 		 		 	starting test.
- *	 		 		 -P x : Pause for x seconds between
- *	 		 		 	iterations.
- *	 		 		 -t   : Turn on syscall timing.
- *
- ****************************************************************/
+ */
 
 #include <errno.h>
 #include <pwd.h>
@@ -95,184 +42,123 @@
 #include <sys/mman.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
 
-#define NULLMODNAME ""
-#define BASEMODNAME "dummy"
-#define LONGMODNAMECHAR 'm'	/* Arbitrarily selected */
-#define EXP_RET_VAL -1
-
-/* Test case structure */
-struct test_case_t {
-	char *modname;
-	/* Expected errno. */
-	int experrno;
-	char *desc;
-	/* Individual setup routine. */
-	int (*setup) (void);
-	/* Individual cleanup routine */
-	void (*cleanup) (void);
-};
+#define NULLMODNAME	""
+#define BASEMODNAME	"dummy"
+#define LONGMODNAMECHAR	'm'	/* Arbitrarily selected */
 
 char *TCID = "delete_module02";
-static int exp_enos[] = { EPERM, EINVAL, ENOENT, EFAULT, ENAMETOOLONG, 0 };
+static int exp_enos[] = { EPERM, ENOENT, EFAULT, 0 };
 
 static char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
 static char longmodname[MODULE_NAME_LEN];
-static int testno;
-/* Name of the module */
 static char modname[20];
 
-char *bad_addr = 0;
-
 static void setup(void);
 static void cleanup(void);
-static int setup1(void);
+static void setup1(void);
 static void cleanup1(void);
 
-struct test_case_t;
-
-static struct test_case_t tdat[] = {
-	{modname, ENOENT,
-	 "nonexistent module", NULL, NULL},
-	{NULLMODNAME, ENOENT,
-	 "null terminated module name", NULL, NULL},
-	{(char *)-1, EFAULT,
-	 "module name outside program's "
-	 "accessible address space", NULL, NULL},
-	{longmodname, ENOENT,
-	 "long module name", NULL, NULL},
-	{modname, EPERM,
-	 "non-superuser", setup1, cleanup1},
+static struct test_case_t {
+	char *modname;
+	int experrno;
+	char *desc;
+	void (*setup) (void);
+	void (*cleanup) (void);
+} tdat[] = {
+	{ modname, ENOENT, "nonexistent module", NULL, NULL},
+	{ NULLMODNAME, ENOENT, "null terminated module name", NULL, NULL},
+	{ (char *)-1, EFAULT, "module name outside program's "
+	  "accessible address space", NULL, NULL},
+	{ longmodname, ENOENT, "long module name", NULL, NULL},
+	{ modname, EPERM, "non-superuser", setup1, cleanup1},
 };
 
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
+int TST_TOTAL = ARRAY_SIZE(tdat);
 
 int main(int argc, char **argv)
 {
 	int lc;
+	int i;
+
 	char *msg;
 
-	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if ((tdat[testno].setup) && (tdat[testno].setup())) {
-				/* setup() failed, skip this test */
-				continue;
-			}
-			/* Test the system call */
-			TEST(delete_module(tdat[testno].modname));
+		for (i = 0; i < TST_TOTAL; ++i) {
+			if (tdat[i].setup)
+				tdat[i].setup();
+
+			tst_resm(TINFO, "test %s", tdat[i].desc);
+			TEST(ltp_syscall(__NR_delete_module,
+			     tdat[i].modname, 0));
 			TEST_ERROR_LOG(TEST_ERRNO);
-			printf("TEST_RETURN is %d, TEST_ERRNO is %d\n",
-			       TEST_RETURN, TEST_ERRNO);
-			if ((TEST_RETURN == EXP_RET_VAL) &&
-			    (TEST_ERRNO == tdat[testno].experrno)) {
-				tst_resm(TPASS, "Expected results for %s, "
-					 "errno: %d", tdat[testno].desc,
-					 TEST_ERRNO);
+
+			if (TEST_RETURN != -1) {
+				tst_resm(TFAIL, "delete_module() "
+					 "succeeded unexpectedly");
+			} else if (TEST_ERRNO == tdat[i].experrno) {
+				tst_resm(TPASS | TTERRNO,
+					 "delete_module() failed as expected");
 			} else {
-				tst_resm(TFAIL, "Unexpected results for %s ; "
-					 "returned %d (expected %d), "
-					 "errno %d (expected %d)",
-					 tdat[testno].desc,
-					 TEST_RETURN, EXP_RET_VAL,
-					 TEST_ERRNO, tdat[testno].experrno);
-			}
-			if (tdat[testno].cleanup) {
-				tdat[testno].cleanup();
+				tst_resm(TFAIL | TTERRNO, "delete_module() "
+					 "failed unexpectedly; expected: "
+					 "%d - %s", tdat[i].experrno,
+					 strerror(tdat[i].experrno));
 			}
+			if (tdat[i].cleanup)
+				tdat[i].cleanup();
 		}
 	}
+
 	cleanup();
 	tst_exit();
 }
 
-int setup1(void)
+static void setup1(void)
 {
-	/* Change effective user id to nodody */
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TBROK, "seteuid failed to set the effective"
-			 " uid to %d", ltpuser->pw_uid);
-		return 1;
-	}
-	return 0;
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 }
 
-void cleanup1(void)
+static void cleanup1(void)
 {
-	/* Change effective user id to root */
-	if (seteuid(0) == -1) {
-		tst_brkm(TBROK, NULL, "seteuid failed to set the effective"
-			 " uid to root");
-	}
+	SAFE_SETEUID(cleanup, 0);
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	/* Check whether it is root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
+	tst_require_root(NULL);
 
-	}
+	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
 
-	/*if (tst_kvercmp(2,5,48) >= 0)
-	   tst_brkm(TCONF, NULL, "This test will not work on "
-	   "kernels after 2.5.48");
-	 */
+	TEST_EXP_ENOS(exp_enos);
 
-	/* Check for nobody_uid user id */
-	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
-		tst_brkm(TBROK, NULL, "Required user %s doesn't exists",
-			 nobody_uid);
-	}
+	TEST_PAUSE;
 
 	/* Initialize longmodname to LONGMODNAMECHAR character */
 	memset(longmodname, LONGMODNAMECHAR, MODULE_NAME_LEN - 1);
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
 	/* Get unique module name for each child process */
-	if (sprintf(modname, "%s_%d", BASEMODNAME, getpid()) <= 0) {
+	if (sprintf(modname, "%s_%d", BASEMODNAME, getpid()) <= 0)
 		tst_brkm(TBROK, NULL, "Failed to initialize module name");
-	}
-	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	tdat[2].modname = bad_addr;
 
+	tdat[2].modname = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+				    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
 void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
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

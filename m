Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VjKXa-0004MB-MY
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 03:02:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjKXY-0004WO-5p
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 03:02:50 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAL32Z1p014052
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Nov 2013 11:02:36 +0800
Message-ID: <1385002950.1619.1.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2013 11:02:30 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH v3] clock_getres/clock_getres01.c: cleanup
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Fix the messy testcase of clock_getres01.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/clock_getres/clock_getres01.c  | 299 ++++-----------------
 1 file changed, 58 insertions(+), 241 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 0fb5df4..4df6d87 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -15,8 +15,8 @@
 /* the GNU General Public License for more details.			   */
 /*									    */
 /* You should have received a copy of the GNU General Public License	  */
-/* along with this program;  if not, write to the Free Software	       */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program;  if not, write to the Free Software Foundation, */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA         */
 /*									    */
 /******************************************************************************/
 /******************************************************************************/
@@ -39,8 +39,6 @@
 /*	      -P x : Pause for x seconds between iterations.		*/
 /*	      -t   : Turn on syscall timing.				*/
 /*									    */
-/* Total Tests: 1							     */
-/*									    */
 /* Test Name:   clock_getres01						*/
 /* History:     Porting from Crackerjack to LTP is done by		    */
 /*	      Manas Kumar Nayak maknayak@in.ibm.com>			*/
@@ -61,266 +59,85 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
-char *TCID = "clock_getres01";
-int testno;
-int TST_TOTAL = 1;
+#define NORMAL		1
+#define NULL_POINTER	0
 
-/* Extern Global Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    cleanup						       */
-/*									    */
-/* Description: Performs all one time clean up for this test on successful    */
-/*	      completion,  premature exit or  failure. Closes all temporary */
-/*	      files, removes all temporary directories exits the test with  */
-/*	      appropriate return code by calling tst_exit() function.       */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*	      On success - Exits calling tst_exit(). With '0' return code.  */
-/*									    */
-/******************************************************************************/
-extern void cleanup()
-{
-
-	TEST_CLEANUP;
-	tst_rmdir();
-
-}
-
-/* Local  Functions */
-/******************************************************************************/
-/*									    */
-/* Function:    setup							 */
-/*									    */
-/* Description: Performs all one time setup for this test. This function is   */
-/*	      typically used to capture signals, create temporary dirs      */
-/*	      and temporary files that may be used in the course of this    */
-/*	      test.							 */
-/*									    */
-/* Input:       None.							 */
-/*									    */
-/* Output:      None.							 */
-/*									    */
-/* Return:      On failure - Exits by calling cleanup().		      */
-/*	      On success - returns 0.				       */
-/*									    */
-/******************************************************************************/
-void setup()
-{
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-/*
- * Macros
- */
-#define SYSCALL_NAME    "clock_getres"
-
-/*
- * Global variables
- */
-static int opt_debug;
-static char *progname;
-
-enum test_type {
-	NORMAL,
-	NULL_POINTER,
-};
-
-/*
- * Data Structure
- */
-struct test_case {
+static struct test_case {
+	char *name;
 	clockid_t clk_id;
 	int ttype;
 	int ret;
 	int err;
+} tcase[] = {
+	{"REALTIME", CLOCK_REALTIME, NORMAL, 0, 0},
+	{"MONOTONIC", CLOCK_MONOTONIC, NORMAL, 0, 0},
+	{"PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID, NORMAL, 0, 0},
+	{"THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, NORMAL, 0, 0},
+	{"-1", -1, NORMAL, -1, EINVAL},
+	{"REALTIME", CLOCK_REALTIME, NULL_POINTER, 0, 0},
 };
 
-/* Test cases
-*
-*   test status of errors on man page
-*
-*   EPERM   can't check because clock_getres not requires permission
-*   EINVAL  v (not supported clk_id)
-*/
-
-static struct test_case tcase[] = {
-	{			// case00
-	 .clk_id = CLOCK_REALTIME,
-	 .ttype = NORMAL,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case01
-	 .clk_id = CLOCK_MONOTONIC,
-	 .ttype = NORMAL,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case02
-	 .clk_id = CLOCK_PROCESS_CPUTIME_ID,
-	 .ttype = NORMAL,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case03
-	 .clk_id = CLOCK_THREAD_CPUTIME_ID,
-	 .ttype = NORMAL,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			// case04
-	 .clk_id = -1,
-	 .ttype = NORMAL,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			// case05
-	 .clk_id = CLOCK_REALTIME,
-	 .ttype = NULL_POINTER,
-	 .ret = 0,
-	 .err = 0,
-	 },
-};
-
-#define MEM_LENGTH	      (4 * 1024 * 1024)
-/*
- * do_test()
- *
- *   Input  : TestCase Data
- *   Return : RESULT_OK(0), RESULT_NG(1)
- *
- */
-
-static int do_test(struct test_case *tc)
-{
-	int sys_ret;
-	int sys_errno;
-	int result = RESULT_OK;
-	struct timespec res;
-
-	/*
-	 * Execute system call
-	 */
-	errno = 0;
-	if (tc->ttype == NULL_POINTER)
-		TEST(sys_ret = ltp_syscall(__NR_clock_getres, tc->clk_id,
-			NULL));
-	else
-		TEST(sys_ret = ltp_syscall(__NR_clock_getres, tc->clk_id,
-			&res));
-	sys_errno = errno;
-
-	/*
-	 * Check results
-	 */
-	result |= (sys_errno != tc->err);
-	PRINT_RESULT(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno);
-
-	return result;
-}
-
-/*
- * usage()
- */
-
-static void usage(const char *progname)
-{
-	tst_resm(TINFO, "usage: %s [options]", progname);
-	tst_resm(TINFO, "This is a regression test program of %s system call.",
-		 SYSCALL_NAME);
-	tst_resm(TINFO, "options:");
-	tst_resm(TINFO, "    -d --debug	   Show debug messages");
-	tst_resm(TINFO, "    -h --help	    Show this message");
-
-	exit(1);
-}
+static void setup(void);
+static void cleanup(void);
 
-/*
- * main()
- */
+char *TCID = "clock_getres01";
+int TST_TOTAL = ARRAY_SIZE(tcase);
 
 int main(int ac, char **av)
 {
-	int result = RESULT_OK;
-	int c, i;
+	int i;
 	int lc;
-	int ret;
-	char *msg;
-
-	struct option long_options[] = {
-		{"debug", no_argument, 0, 'd'},
-		{"help", no_argument, 0, 'h'},
-		{NULL, 0, NULL, 0}
-	};
-
-	progname = basename(av[0]);
-
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
+	struct timespec res;
 
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+
 		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(c = getopt_long(ac, av, "dh", long_options, NULL));
-			while (TEST_RETURN != -1) {
-				switch (c) {
-				case 'd':
-					opt_debug = 1;
-					break;
-				default:
-					usage(progname);
 
+		for (i = 0; i < TST_TOTAL; ++i) {
+			if (tcase[i].ttype == NULL_POINTER)
+				TEST(clock_getres(tcase[i].clk_id, NULL));
+			else
+				TEST(clock_getres(tcase[i].clk_id, &res));
+
+			if (TEST_RETURN != tcase[i].ret) {
+				if (TEST_ERRNO != EINVAL) {
+					tst_resm(TFAIL,
+						 "clock_getres %s failed",
+						 tcase[i].name);
+				} else {
+					tst_resm(TCONF,
+						 "clock_getres %s NO SUPPORTED",
+						 tcase[i].name);
+				}
+			} else {
+				if (TEST_ERRNO != tcase[i].err) {
+					tst_resm(TFAIL,
+						 "clock_getres %s failed with "
+						 "unexpect errno: %d",
+						 tcase[i].name, TEST_ERRNO);
+				} else {
+					tst_resm(TPASS,
+						 "clock_getres %s succeeded",
+						 tcase[i].name);
 				}
-			}
-
-			if (ac != optind) {
-				tst_resm(TINFO, "Options are not match.");
-				usage(progname);
-
-			}
-
-			/*
-			 * Execute test
-			 */
-			for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0]));
-			     i++) {
-				tst_resm(TINFO, "(case%02d) START", i);
-				ret = do_test(&tcase[i]);
-				tst_resm((ret == 0 ? TPASS : TFAIL),
-					 "(case%02d) END", i);
-				result |= ret;
-			}
-
-			/*
-			 * Check results
-			 */
-			switch (result) {
-			case RESULT_OK:
-				tst_resm(TPASS, "clock_getres call succeeded");
-				break;
-
-			default:
-				tst_resm(TFAIL, "%s failed", TCID);
-				RPRINTF("NG\n");
-				cleanup();
-				tst_exit();
-				break;
 			}
 
 		}
 	}
+
 	cleanup();
+
 	tst_exit();
 }
+
+static void setup(void)
+{
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.8.2.1




------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

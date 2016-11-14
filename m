From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 14 Nov 2016 17:44:52 +0800
Subject: [LTP] [PATCH 2/4] syscalls/getpriority02: Cleanup && Convert to new
	API
In-Reply-To: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1479116694-23167-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 .../kernel/syscalls/getpriority/getpriority02.c    | 210 ++++++---------------
 1 file changed, 53 insertions(+), 157 deletions(-)

diff --git a/testcases/kernel/syscalls/getpriority/getpriority02.c b/testcases/kernel/syscalls/getpriority/getpriority02.c
index b253a00..30f8ea4 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority02.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority02.c
@@ -1,181 +1,77 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or modify
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
- * Test Name: getpriority02
- *
- * Test Description:
- *  Verify that,
- *   1) getpriority() sets errno to ESRCH  if no process was located
- *	was located for 'which' and 'who' arguments.
- *   2) getpriority() sets errno to EINVAL if 'which' argument was
- *      not one of PRIO_PROCESS, PRIO_PGRP, or PRIO_USER.
- *
- * Expected Result:
- *  getpriority() should fail with return value -1 and set expected errno.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	if errno set == expected errno
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  getpriority02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
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
- *  None.
+ * Verify that,
+ *  1) getpriority(2) fails with -1 and sets errno to EINVAL if 'which'
+ *     argument was not one of PRIO_PROCESS, PRIO_PGRP, or PRIO_USER.
+ *  2) getpriority(2) fails with -1 and sets errno to ESRCH if no
+ *     process was located for 'which' and 'who' arguments.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/param.h>
-#include <sys/time.h>
 #include <sys/resource.h>
+#include <sys/time.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-#define INVAL_PID	-1
-#define INVAL_FLAG      -1
-
-char *TCID = "getpriority02";
-int TST_TOTAL = 4;
+#define INVAL_FLAG	-1
+#define INVAL_ID	-1
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	int pro_which;
-	uid_t pro_uid;
-	char *desc;
+static struct tcase {
+	int which;
+	int who;
 	int exp_errno;
-} Test_cases[] = {
-	{
-	INVAL_FLAG, 0, "Invalid 'which' value specified", EINVAL}, {
-	PRIO_PROCESS, INVAL_PID, "Invalid 'who' value specified", ESRCH}, {
-	PRIO_PGRP, INVAL_PID, "Invalid 'who' value specified", ESRCH}, {
-	PRIO_USER, INVAL_PID, "Invalid 'who' value specified", ESRCH}, {
-	0, 0, NULL, 0}
+} tcases[] = {
+	/* test 1 */
+	{INVAL_FLAG, 0, EINVAL},
+
+	/* test 2 */
+	{PRIO_PROCESS, INVAL_ID, ESRCH},
+	{PRIO_PGRP, INVAL_ID, ESRCH},
+	{PRIO_USER, INVAL_ID, ESRCH}
 };
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void verify_getpriority(unsigned int n)
 {
-	int lc;
-	int ind;		/* counter variable for test case looping */
-	char *test_desc;	/* test specific error message */
-	int which;		/* process priority category */
-	uid_t who;		/* process uid of the test process */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	struct tcase *tc = &tcases[n];
 
-		for (ind = 0; ind < TST_TOTAL; ind++) {
-			which = Test_cases[ind].pro_which;
-			who = Test_cases[ind].pro_uid;
-			test_desc = Test_cases[ind].desc;
-
-			if (who == 0) {
-				/* Get the actual uid of the process */
-				who = getuid();
-			}
-
-			/*
-			 * Invoke getpriority with the specified
-			 * 'which' and 'who' arguments and verify
-			 * that it fails with expected errno.
-			 */
-			TEST(getpriority(which, who));
-
-			/* check return code from getpriority(2) */
-			if (TEST_RETURN < 0) {
-				if (TEST_ERRNO == Test_cases[ind].exp_errno) {
-					tst_resm(TPASS, "getpriority(2) fails, "
-						 "%s, errno:%d",
-						 test_desc, TEST_ERRNO);
-				} else {
-					tst_resm(TFAIL, "getpriority() fails, "
-						 "%s, errno:%d, expected errno:"
-						 "%d", test_desc, TEST_ERRNO,
-						 Test_cases[ind].exp_errno);
-				}
-			} else {
-				tst_resm(TFAIL, "getpriority() returned %ld, "
-					 "expected -1, errno:%d", TEST_RETURN,
-					 Test_cases[ind].exp_errno);
-			}
-		}
+	TEST(getpriority(tc->which, tc->who));
 
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "getpriority(%d, %d) succeeds unexpectedly",
+			tc->which, tc->who);
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (tc->exp_errno != TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO,
+			"getpriority(%d, %d) should fail with %s",
+			tc->which, tc->who, tst_strerrno(tc->exp_errno));
+		return;
+	}
 
-	TEST_PAUSE;
+	tst_res(TPASS | TTERRNO, "getpriority(%d, %d) fails as expected",
+		tc->which, tc->who);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.tid = "getpriority02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getpriority,
+};
-- 
1.8.4.2




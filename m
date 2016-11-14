From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 14 Nov 2016 17:44:51 +0800
Subject: [LTP] [PATCH 1/4] syscalls/getpriority01: Cleanup && Convert to new
	API
Message-ID: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 .../kernel/syscalls/getpriority/getpriority01.c    | 171 +++++----------------
 1 file changed, 41 insertions(+), 130 deletions(-)

diff --git a/testcases/kernel/syscalls/getpriority/getpriority01.c b/testcases/kernel/syscalls/getpriority/getpriority01.c
index e9ff05b..442d644 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority01.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority01.c
@@ -1,147 +1,58 @@
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
- * Test Name: getpriority01
- *
- * Test Description:
- *  Verify that getpriority() succeeds get the scheduling priority of
- *  the current process, process group or user.
- *
- * Expected Result:
- *  getpriority() should return the highest priority of the test process.
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
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  getpriority01 [-c n] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
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
- *
+ * Verify that getpriority(2) succeeds get the scheduling priority of
+ * the current process, process group or user.
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
-char *TCID = "getpriority01";
-int TST_TOTAL = 1;
-
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
-
-int prio_which[] = { PRIO_PROCESS, PRIO_PGRP, PRIO_USER };
+static struct tcase {
+	int which;
+} tcases[] = {
+	{PRIO_PROCESS},
+	{PRIO_PGRP},
+	{PRIO_USER}
+};
 
-int main(int ac, char **av)
+static void verify_getpriority(unsigned int n)
 {
-	int lc;
-	int ind;
-	int which;		/* scheduling priority category */
-
-	TST_TOTAL = sizeof(prio_which) / sizeof(int);
+	struct tcase *tc = &tcases[n];
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	TEST(getpriority(tc->which, 0));
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (ind = 0; ind < TST_TOTAL; ind++) {
-			which = prio_which[ind];
-
-			/*
-			 * Invoke getpriority with the specified
-			 * 'which' argument for the calling process.
-			 */
-			TEST(getpriority(which, 0));
-
-			if (TEST_RETURN < 0 && TEST_ERRNO != 0) {
-				tst_resm(TFAIL, "getpriority(%d, 0) "
-					 "Failed, errno=%d : %s",
-					 which, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TPASS, "getpriority(%d, 0) returned "
-					 "%ld priority value",
-					 which, TEST_RETURN);
-			}
-		}
+	if (TEST_RETURN < 0 && TEST_ERRNO != 0) {
+		tst_res(TFAIL | TTERRNO, "getpriority(%d, 0) returned %ld",
+			tc->which, TEST_RETURN);
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
-
-	TEST_PAUSE;
+	tst_res(TPASS, "getpriority(%d, 0) returned %ld",
+		tc->which, TEST_RETURN);
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
+	.tid = "getpriority01",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_getpriority,
+};
-- 
1.8.4.2




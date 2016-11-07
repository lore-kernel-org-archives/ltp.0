From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Nov 2016 14:19:11 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/6] syscalls/nice02: Convert to the new
	library.
In-Reply-To: <1478524754-15752-1-git-send-email-chrubis@suse.cz>
References: <1478524754-15752-1-git-send-email-chrubis@suse.cz>
Message-ID: <1478524754-15752-3-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/nice/nice02.c | 174 ++++++++------------------------
 1 file changed, 42 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index 248c30b..4c9ccae 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -1,159 +1,69 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
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
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * Test Name: nice02
- *
- * Test Description:
  *  Verify that any user can successfully increase the nice value of
  *  the process by passing a higher increment value (> max. applicable limits)
  *  to nice() system call.
- *
- * Expected Result:
- *  nice() should return value 0 on success and root user should succeed to
- *  increase the nice value of the test process.
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
- *  nice02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  none
  */
 #include <unistd.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <sys/time.h>
 #include <sys/resource.h>
 
-#include "test.h"
-
-char *TCID = "nice02";
-int TST_TOTAL = 1;
-
-#define	NICEINC		50
+#include "tst_test.h"
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+#define	NICEINC 50
+#define MAX_PRIO 19
+#define DEFAULT_PRIO 0
 
-int main(int ac, char **av)
+static void verify_nice(void)
 {
-	int lc;
-	int New_nice;		/* priority of process after nice() */
-	int max_val;		/* Maximum nice value per OS. */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	int new_nice;
 
-		tst_count = 0;
+	TEST(nice(NICEINC));
 
-		/*
-		 * Call nice(2) with an 'incr' parameter set
-		 * to a higher +ve value.
-		 */
-		TEST(nice(NICEINC));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "nice(%d) Failed, errno=%d : %s",
-				 NICEINC, TEST_ERRNO, strerror(TEST_ERRNO));
-			continue;
-		}
-
-		/*
-		 * Get the current priority of the test process.
-		 */
-		errno = 0;
-		New_nice = getpriority(PRIO_PROCESS, 0);
-		if (New_nice == -1 && errno != 0) {
-			tst_brkm(TFAIL, cleanup, "Fail to get priority "
-				 "of process after nice()");
-		}
-
-		/*
-		 * Validate functionality of the nice().
-		 *
-		 * Default priority is 0, Max is 20.
-		 */
-		max_val = 20;
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "nice(%d) returned -1", NICEINC);
+		return;
+	}
 
-		if (New_nice != (max_val - 1)) {
-			tst_resm(TFAIL, "Priority of process : %d "
-				 "doesn't match the expected:%d",
-				 New_nice, (max_val - 1));
-		} else {
-			tst_resm(TPASS, "Functionality of nice(%d)"
-				 " successful", NICEINC);
-		}
+	if (TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO, "nice(%d) failed", NICEINC);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
+	new_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
+	if (new_nice != MAX_PRIO) {
+		tst_res(TFAIL, "Process priority %i, expected %i",
+			new_nice, MAX_PRIO);
+		return;
+	}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_res(TPASS, "nice(%d) passed", NICEINC);
 
-	TEST_PAUSE;
+	TEST(nice(DEFAULT_PRIO));
+	if (TEST_ERRNO)
+		tst_brk(TBROK | TERRNO, "nice(-NICEINC) failed");
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.tid = "nice02",
+	.test_all = verify_nice,
+};
-- 
2.7.3


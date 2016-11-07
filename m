From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Nov 2016 14:19:12 +0100
Subject: [LTP] [COMMITTED] [PATCH 4/6] syscalls/nice03: Convert to the new
	library.
In-Reply-To: <1478524754-15752-1-git-send-email-chrubis@suse.cz>
References: <1478524754-15752-1-git-send-email-chrubis@suse.cz>
Message-ID: <1478524754-15752-4-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/nice/nice03.c | 173 +++++++++-----------------------
 1 file changed, 47 insertions(+), 126 deletions(-)

diff --git a/testcases/kernel/syscalls/nice/nice03.c b/testcases/kernel/syscalls/nice/nice03.c
index 357de9e..6b90c2d 100644
--- a/testcases/kernel/syscalls/nice/nice03.c
+++ b/testcases/kernel/syscalls/nice/nice03.c
@@ -1,156 +1,77 @@
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
- * Test Name: nice03
- *
- * Test Description:
  *  Verify that any user can successfully increase the nice value of
  *  the process by passing an increment value (< max. applicable limits) to
  *  nice() system call.
- *
- * Expected Result:
- *  nice() should return value 0 on success and the user should succeed
- *  to increase the nice value of test process.
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
- *  nice03 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *  The maximum iterations with the -i option is 9
- *
  */
-
-#include <stdio.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <sys/time.h>
 #include <sys/resource.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-char *TCID = "nice03";
-int TST_TOTAL = 1;
-
-#define	NICEINC		2
-int Org_nice;			/* original priority of the test process */
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+#define	NICEINC	2
 
-int main(int ac, char **av)
+static void nice_test(void)
 {
-	int lc;
-	int New_nice;		/* priority of process after nice() */
+	int new_nice;
+	int orig_nice;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
 
-	setup();
+	TEST(nice(NICEINC));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call nice(2) with an 'incr' parameter set
-		 * to a +ve value < max. applicable limit.
-		 * (Linux - 20)
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
-		New_nice = getpriority(PRIO_PROCESS, 0);
-
-		/* Validate functionality of the nice() */
-		if (New_nice != (Org_nice + NICEINC)) {
-			tst_resm(TFAIL, "nice() failed to modify the "
-				 "priority of process");
-		} else {
-			tst_resm(TPASS, "Functionality of nice(%d) is "
-				 "correct", NICEINC);
-		}
-		Org_nice = New_nice;
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "nice(%d) returned -1", NICEINC);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
+	if (TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO, "nice(%d) failed", NICEINC);
+		return;
+	}
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Get the process id of test process.
- *  Get the current nice value of test process and save it in a file.
- *  Read the nice value from file into a variable.
- */
-void setup(void)
-{
+	new_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	if (new_nice != (orig_nice + NICEINC)) {
+		tst_res(TFAIL, "Process priority %i, expected %i",
+		        new_nice, orig_nice + NICEINC);
+		return;
+	}
 
-	TEST_PAUSE;
+	tst_res(TPASS, "nice(%d) passed", NICEINC);
 
-	Org_nice = getpriority(PRIO_PROCESS, 0);
+	exit(0);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void verify_nice(void)
 {
+	if (!SAFE_FORK())
+		nice_test();
 
+	tst_reap_children();
 }
+
+static struct tst_test test = {
+	.tid = "nice03",
+	.forks_child = 1,
+	.test_all = verify_nice,
+};
-- 
2.7.3


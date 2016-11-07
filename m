From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Nov 2016 14:19:13 +0100
Subject: [LTP] [COMMITTED] [PATCH 5/6] syscalls/nice04: Convert to the new
	library.
In-Reply-To: <1478524754-15752-1-git-send-email-chrubis@suse.cz>
References: <1478524754-15752-1-git-send-email-chrubis@suse.cz>
Message-ID: <1478524754-15752-5-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/nice/nice04.c | 179 ++++++++------------------------
 1 file changed, 41 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index 9c043de..3d63f31 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -1,160 +1,63 @@
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
+ * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * Test Name: nice04
- *
- * Test Description:
  *  Verify that, nice(2) fails when, a non-root user attempts to increase
  *  the priority of a process by specifying a negative increment value.
- *
- * Expected Result:
- *  nice() returns -1 and sets errno to EPERM.
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
- *		PASS
- *   		Issue sys call fails with expected return value and errno.
- *   	Otherwise,
- *		FAIL
- *		Issue sys call fails with unexpected errno.
- *   Otherwise,
- *	Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  nice04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *  This test should be executed by 'non-super-user' only.
  */
 #include <pwd.h>
 #include <unistd.h>
 #include <errno.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-char *TCID = "nice04";
-int TST_TOTAL = 1;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
-	int nice_val;
-	char *desc;
-	int exp_errno;
-} Test_cases[] = {
-	{
-	-5, "Non-root cannot specify higher priority", EPERM}
-};
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+#define NICEINC -10
 
-int main(int ac, char **av)
+static void verify_nice(void)
 {
-	int lc;
-	int i;
-	int incr_val;		/* nice value for the process */
-	char *test_desc;	/* test specific error message */
+	TEST(nice(NICEINC));
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			incr_val = Test_cases[i].nice_val;
-			test_desc = Test_cases[i].desc;
-
-			/*
-			 * Call nice(2) with different 'incr' parameter
-			 * values and verify that it fails as expected.
-			 */
-			TEST(nice(incr_val));
-
-			/* check return code from nice(2) */
-			if (TEST_RETURN == -1) {
-				tst_resm(TPASS, "nice(2) returned %ld for %s",
-					 TEST_RETURN, test_desc);
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "nice() returned %ld for %s",
-					 TEST_RETURN, test_desc);
-			}
-		}
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "nice(%i) succeded unexpectedly (returned %li)",
+			NICEINC, TEST_RETURN);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- *  Make sure the test process uid is non-root only.
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
+	if (TEST_ERRNO != EPERM) {
+		tst_res(TFAIL | TTERRNO, "nice(%i) should fail with EPERM",
+			NICEINC);
+		return;
 	}
 
-	TEST_PAUSE;
+	tst_res(TPASS, "nice(%i) failed with EPERM", NICEINC);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
+	struct passwd *ltpuser;
 
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETUID(ltpuser->pw_uid);
 }
+
+static struct tst_test test = {
+	.tid = "nice04",
+	.setup = setup,
+	.test_all = verify_nice,
+	.needs_root = 1,
+};
-- 
2.7.3


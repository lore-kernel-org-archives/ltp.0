From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Fri,  6 Aug 2021 12:00:46 +0800
Subject: [LTP] [PATCH] [4/4] syscalls/chroot04: Convert to new API
Message-ID: <20210806040046.18836-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/chroot/chroot04.c b/testcases/kernel/syscalls/chroot/chroot04.c
index 69fd213c8..ebb1ba363 100644
--- a/testcases/kernel/syscalls/chroot/chroot04.c
+++ b/testcases/kernel/syscalls/chroot/chroot04.c
@@ -1,137 +1,43 @@
+ // SPDX-License-Identifier: GPL-2.0-or-later
  /*
   *   Copyright (C) Bull S.A. 2001
   *   Copyright (c) International Business Machines  Corp., 2001
-  *
-  *   This program is free software;  you can redistribute it and/or modify
-  *   it under the terms of the GNU General Public License as published by
-  *   the Free Software Foundation; either version 2 of the License, or
-  *   (at your option) any later version.
-  *
-  *   This program is distributed in the hope that it will be useful,
-  *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-  *   the GNU General Public License for more details.
-  *
-  *   You should have received a copy of the GNU General Public License
-  *   along with this program;  if not, write to the Free Software
-  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+  *
+  *   04/2002 Ported by Jacky Malcles
   */

-/*
- * NAME
- * 		 chroot04.c
+/*\
+ * [DESCRIPTION]
  *
- * DESCRIPTION
- *		 Testcase to check that chroot sets errno to EACCES.
- *
- * ALGORITHM
- *		 As a non-root user attempt to perform chroot() to a directory. The
- *		 chroot() call should fail with EACCES
- *
- * USAGE:  <for command-line>
- *  chroot04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *		 04/2002 Ported by Jacky Malcles
- *
- * RESTRICTIONS
- * 		 Must be run as non-root user.
+ *	Testcase to check that chroot sets errno to EACCES.
  */

 #include <stdio.h>
-#include <errno.h>
-#include <sys/stat.h>
-#include "test.h"
-#include "safe_macros.h"
 #include <pwd.h>
-
-char *TCID = "chroot04";
-int TST_TOTAL = 1;
+#include "tst_test.h"

 #define TEST_TMPDIR	"chroot04_tmpdir"
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;

-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-void setup(void);
-void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_chroot(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* Check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		TEST(chroot(TEST_TMPDIR));
-
-		if (TEST_RETURN != -1)
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-		else if (TEST_ERRNO == EACCES)
-			tst_resm(TPASS, "got EACCESS as expected");
-		else
-			tst_resm(TFAIL | TTERRNO,
-				 "did not get EACCES as expected");
-
-	}
-	cleanup();
-
-	tst_exit();
-
+	TST_EXP_FAIL(chroot(TEST_TMPDIR), EACCES, "got EACCESS as expected");
 }

-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-
 	/*
 	 * create a temporary directory
 	 */
-	if (mkdir(TEST_TMPDIR, 0222) != 0) {
-		tst_resm(TBROK, "mkdir(%s) failed", TEST_TMPDIR);
-	}
-
-	ltpuser = getpwnam(nobody_uid);
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-
+	SAFE_MKDIR(TEST_TMPDIR, 0222);
+	ltpuser = SAFE_GETPWNAM(nobody_uid);
+	SAFE_SETEUID(ltpuser->pw_uid);
 }

-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		        completion or premature exit.
- */
-void cleanup(void)
-{
-	/* reset the process ID to the saved ID (root) */
-	SAFE_SETUID(NULL, 0);
-	if (rmdir(TEST_TMPDIR) != 0) {
-		tst_brkm(TFAIL | TERRNO, NULL, "rmdir(%s) failed", TEST_TMPDIR);
-	}
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_chroot,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
--
2.20.1




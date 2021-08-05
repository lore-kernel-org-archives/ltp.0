From: sujiaxun <sujiaxun@uniontech.com>
Date: Thu,  5 Aug 2021 18:42:29 +0800
Subject: [LTP] [PATCH] [2/6] syscalls/sysfs: Convert sysfs02 to the new API
Message-ID: <20210805104229.10826-1-sujiaxun@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 testcases/kernel/syscalls/sysfs/sysfs02.c | 121 +++-------------------
 1 file changed, 16 insertions(+), 105 deletions(-)

diff --git a/testcases/kernel/syscalls/sysfs/sysfs02.c b/testcases/kernel/syscalls/sysfs/sysfs02.c
index e9065dda7..6316d0bd0 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs02.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs02.c
@@ -1,127 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: sysfs02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for sysfs(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *    This is a Phase I test for the sysfs(2) system call.
- *    It is intended to provide a limited exposure of the system call.
- *    This test is run for option 2 for sysfs(2)
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * sysfs02  [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-t] [-p] [-f]
- * where:
- *	-c n : run n copies simultaneously
- *	-e   : Turn on errno logging.
- *	-i n : Execute test n times.
- *	-I x : Execute test for x seconds.
- *	-p   : Pause for SIGUSR1 before starting
- *	-P x : Pause for x seconds between iterations.
- *	-t   : Turn on syscall timing.
- *
- *RESTRICTIONS:
- *There is no glibc or libc support
- *****************************************************************************/
+
+/*
+ * [DESCRIPTION]
+ * This test is run for option 2 for sysfs(2)
+ */

 #include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"

-static void setup();
-static void cleanup();
-
-char *TCID = "sysfs02";
-int TST_TOTAL = 1;

-int main(int ac, char **av)
+static void verify_sysfs02(void)
 {
 	int lc;
 	char buf[40];		/* 40 bytes suffice to store fs name */

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
 		/*option 2 buf holds fs name */
-		TEST(ltp_syscall(__NR_sysfs, 2, 0, buf));
+		TEST(tst_syscall(__NR_sysfs, 2, 0, buf));

 		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "sysfs(2) Failed for "
+		if (TST_RET == -1) {
+			tst_res(TFAIL, "sysfs(2) Failed for "
 				 "option 2 and returned"
-				 " %d as error number", TEST_ERRNO);
+				 " %d as error number", TST_ERR);
 		} else {
-			tst_resm(TPASS, "sysfs(2) Passed for option 2");
+			tst_res(TPASS, "sysfs(2) Passed for option 2");
 		}
-	}			/*End of TEST_LOOPING */
-
-	/*Clean up and exit */
-	cleanup();
-
-	tst_exit();
 }

-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - Performs one time cleanup for this test at
- * completion or premature exit
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = verify_sysfs02,
+};
--
2.20.1




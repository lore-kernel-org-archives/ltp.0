From: sujiaxun <sujiaxun@uniontech.com>
Date: Wed, 11 Aug 2021 20:22:35 +0800
Subject: [LTP] [PATCH] [v2,
 5/6] syscalls/sysfs: Convert sysfs05 to the new API
Message-ID: <20210811122235.1627-1-sujiaxun@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 testcases/kernel/syscalls/sysfs/sysfs05.c | 173 +++++-----------------
 1 file changed, 37 insertions(+), 136 deletions(-)

diff --git a/testcases/kernel/syscalls/sysfs/sysfs05.c b/testcases/kernel/syscalls/sysfs/sysfs05.c
index 8f8bb356e..e5ed050f2 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs05.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs05.c
@@ -1,153 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
- *    TEST IDENTIFIER	: sysfs(2)
- *
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Test checking for basic error conditions
- *				 for sysfs(2)
- *
- *    TEST CASE TOTAL	: 3
- *
- *    AUTHOR		: Aniruddha Marathe <aniruddha.marathe@wipro.com>
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This test case checks whether sysfs(2) system call returns
- *	appropriate error number for invalid
- *	option and for invalid filesystem name.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	  Loop if the proper options are given.
- *	  Execute system call with invaid option parameter and for
- *	  invalid filesystem name
- *	  Check return code, if system call fails with errno == expected errno
- *		Issue syscall passed with expected errno
- *	  Otherwise,
- *	  Issue syscall failed to produce expected errno
- *
- *	Cleanup:
- *	  Do cleanup for the test.
- *
- * USAGE:  <for command-line>
- *  sysfs05 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-f] [-h] [-p]
- *  where:
- *	-c n : Run n copies simultaneously
- *	-e   : Turn on errno logging.
- *	-i n : Execute test n times.
- *	-I x : Execute test for x seconds.
- *	-p   : Pause for SIGUSR1 before starting
- *	-P x : Pause for x seconds between iterations.
- *	-t   : Turn on syscall timing.
- *
- *RESTRICTIONS:
- *There is no libc or glibc support
- *Kernel must be compiled with ext2 support
- *****************************************************************************/
+
+/*\
+ * [Description]
+ * This test case checks whether sysfs(2) system call returns appropriate
+ * error number for invalid option and for invalid filesystem name and fs index out of bounds.
+ */

 #include <errno.h>
 #include <sys/syscall.h>
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
-
-static void setup();
-static void cleanup();
-
-char *TCID = "sysfs05";
-static int option[3] = { 1, 4, 1 };	/* valid and invalid option */
-static char *fsname[] = { "ext0", " ext2", (char *)-1 };
-
-static struct test_case_t {
-	char *err_desc;		/*error description */
-	int exp_errno;		/* expected error number */
-	char *exp_errval;	/*Expected errorvalue string */
-} testcase[] = {
-	{
-	"Invalid option", EINVAL, "EINVAL"}, {
-	"Invalid filesystem name", EINVAL, "EINVAL "}, {
-	"Address is out of your address space", EFAULT, "EFAULT "}
+
+char *bad_addr;
+
+static struct test_case {
+	int option;
+	char *fsname;
+	int fsindex;
+	char *err_desc;
+	int exp_errno;
+} tcases[] = {
+	{1, "ext0", 0, "Invalid filesystem name", EINVAL},
+	{4, "ext4", 0, "Invalid option", EINVAL},
+	{1, (char *)-1, 0, "Address is out of your address space", EFAULT},
+	{2, NULL, 1000, "fs_index is out of bounds", EINVAL}
 };

-int TST_TOTAL = ARRAY_SIZE(testcase);
-
-int main(int ac, char **av)
+static void verify_sysfs05(unsigned int nr)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			tst_count = 0;
-			TEST(ltp_syscall(__NR_sysfs, option[i], fsname[i]));
+
+	if (nr < 3)
+		TST_EXP_FAIL(tst_syscall(__NR_sysfs, tcases[nr].option, tcases[nr].fsname),
+					tcases[nr].exp_errno, "%s", tcases[nr].err_desc);
+	else
+		TST_EXP_FAIL(tst_syscall(__NR_sysfs, tcases[nr].option, tcases[nr].fsindex, bad_addr),
+					tcases[nr].exp_errno, "%s", tcases[nr].err_desc);

-			/* check return code */
-			if ((TEST_RETURN == -1)
-			    && (TEST_ERRNO == testcase[i].exp_errno)) {
-				tst_resm(TPASS,
-					 "sysfs(2) expected failure;"
-					 " Got errno - %s : %s",
-					 testcase[i].exp_errval,
-					 testcase[i].err_desc);
-			} else {
-				tst_resm(TFAIL, "sysfs(2) failed to produce"
-					 " expected error; %d, errno"
-					 ": %s and got %d",
-					 testcase[i].exp_errno,
-					 testcase[i].exp_errval, TEST_ERRNO);
-			}
-
-		}		/*End of TEST LOOPS */
-	}
-
-	/*Clean up and exit */
-	cleanup();
-
-	tst_exit();
-}				/*End of main */
+}

-/* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	bad_addr = tst_get_bad_addr(NULL);
 }

-/*
-* cleanup() - Performs one time cleanup for this test at
-* completion or premature exit
-*/
-void cleanup(void)
-{
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_sysfs05,
+};

-}
--
2.20.1




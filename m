From: sujiaxun <sujiaxun@uniontech.com>
Date: Wed, 11 Aug 2021 20:22:59 +0800
Subject: [LTP] [PATCH] [v2,6/6] syscalls/sysfs: remove sysfs06
Message-ID: <20210811122259.1881-1-sujiaxun@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sysfs06 is nearly the same as sysfs05, the only test that is missing in
sysfs05 is fs index out of bounds.  Add that test to sysfs05 and remove sysfs06.

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 runtest/syscalls                           |   1 -
 testcases/kernel/syscalls/sysfs/.gitignore |   1 -
 testcases/kernel/syscalls/sysfs/sysfs06.c  | 162 ---------------------
 3 files changed, 164 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/sysfs/sysfs06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9af5aa5c0..3f44b8084 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1537,7 +1537,6 @@ sysfs02 sysfs02
 sysfs03 sysfs03
 sysfs04 sysfs04
 sysfs05 sysfs05
-sysfs06 sysfs06

 sysinfo01 sysinfo01
 sysinfo02 sysinfo02
diff --git a/testcases/kernel/syscalls/sysfs/.gitignore b/testcases/kernel/syscalls/sysfs/.gitignore
index d38a4336d..acca41170 100644
--- a/testcases/kernel/syscalls/sysfs/.gitignore
+++ b/testcases/kernel/syscalls/sysfs/.gitignore
@@ -3,4 +3,3 @@
 /sysfs03
 /sysfs04
 /sysfs05
-/sysfs06
diff --git a/testcases/kernel/syscalls/sysfs/sysfs06.c b/testcases/kernel/syscalls/sysfs/sysfs06.c
deleted file mode 100644
index d9a8cd51c..000000000
--- a/testcases/kernel/syscalls/sysfs/sysfs06.c
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
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
- */
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
- *	option and for invalid filesystem index and when
- *	buffer is out of address space
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	  Loop if the proper options are given.
- *	  Execute system call with invaid option parameter and for
- *	  invalid filesystem index
- *	  Check return code, if system call fails with errno == expected errno
- *		Issue syscall passed with expected errno
- *	  Otherwise,
- *	  Issue syscall failed to produce expected errno
- *
- *	Cleanup:
- *	  Do cleanup for the test.
- *
- * USAGE:  <for command-line>
- *  sysfs06 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
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
- *****************************************************************************/
-
-#include <errno.h>
-#include <sys/syscall.h>
-#include <sys/mman.h>
-#include "test.h"
-#include "lapi/syscalls.h"
-
-static void setup();
-static void cleanup();
-
-char *TCID = "sysfs06";
-static int option[3] = { 2, 4, 2 };	/* valid and invalid option */
-static int fsindex[3] = { 10000, 0, 1 };	/*invalid and valid fsindex */
-
-static struct test_case_t {
-	char *err_desc;		/*error description */
-	int exp_errno;		/* expected error number */
-	char *exp_errval;	/*Expected errorvalue string */
-} testcase[] = {
-	{
-	"Invalid option", EINVAL, "EINVAL"}, {
-	"fs_index is out of bounds", EINVAL, "EINVAL"}, {
-	"buf is outside your accessible address space", EFAULT, "EFAULT"}
-};
-
-int TST_TOTAL = ARRAY_SIZE(testcase);
-
-char *bad_addr = 0;
-
-int main(int ac, char **av)
-{
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
-			TEST(ltp_syscall
-			     (__NR_sysfs, option[i], fsindex[i], bad_addr));
-
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
-		}		/*End of TEST LOOPS */
-	}
-
-	/*Clean up and exit */
-	cleanup();
-
-	tst_exit();
-}				/*End of main */
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	bad_addr =
-	    mmap(0, 1, PROT_NONE, MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0,
-		 0);
-	if (bad_addr == MAP_FAILED)
-		tst_brkm(TBROK, cleanup, "mmap failed");
-}
-
-/*
-* cleanup() - Performs one time cleanup for this test at
-* completion or premature exit
-*/
-void cleanup(void)
-{
-
-}
--
2.20.1




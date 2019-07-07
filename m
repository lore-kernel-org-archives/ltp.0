From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun,  7 Jul 2019 21:00:15 +0200
Subject: [LTP] [PATCH 4/5] setdomainname02: Convert to new API
In-Reply-To: <20190707190016.27296-1-petr.vorel@gmail.com>
References: <20190707190016.27296-1-petr.vorel@gmail.com>
Message-ID: <20190707190016.27296-5-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../syscalls/setdomainname/setdomainname02.c  | 197 ++++--------------
 1 file changed, 35 insertions(+), 162 deletions(-)

diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname02.c b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
index 6af09ca40..875ed0c44 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname02.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
@@ -1,181 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
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
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
+ * Copyright (c) Wipro Technologies Ltd, 2002. All Rights Reserved.
+ * Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+ * Author: Saji Kumar.V.R <saji.kumar@wipro.com>
  */
- /*******************************************************************
- *
- *    TEST IDENTIFIER   : setdomainname02
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : test for checking error conditions for setdomainame(2)
- *
- *    TEST CASE TOTAL   : 3
- *
- *    AUTHOR            : Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- * DESCRIPTION
- * 	Verify that,
- *   1) setdomainname(2) returns -1 and sets errno to EINVAL if the parameter,
- *	len is less than zero
- *   2) setdomainname(2) returns -1 and sets errno to EINVAL if value of
- *	len is greater than the maximum allowed value
- *   3) setdomainname(2) returns -1 and sets errno to EFAULT for a bad address
- *	for name
- *
- * ALGORITHM
- * Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *   Save current domainname
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if (system call failed (return=-1)) &
- *			   (errno set == expected errno)
- *              Issue sys call fails with expected return value and errno.
- *   Otherwise,
- *      Issue sys call returns unexpected value.
- *
- *  Cleanup:
- *        Restore old domain name.
- *        Print errno log and/or timing stats if options given
- *  Side Effects :
- *	 setdomainname() is resetting value to NULL, if an invalid address
- *	 is given for name. So, to overcome this problem, domainname is
- *	 resetting to original value as part of cleanup() routine.
- *
- * USAGE:  <for command-line>
- *  setdomainname02  [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-h   : Show help screen
- *			-f   : Turn off functional testing
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- *********************************************************************/
 
-#include "test.h"
+#include "setdomainname.h"
 
-#include <errno.h>
-#include <sys/utsname.h>
+#define ERRNO_DESC(x) .exp_errno = x, .errno_desc = #x
 
-#define MAX_NAME_LEN _UTSNAME_DOMAIN_LENGTH - 1
+#define MAX_NAME_LENGTH _UTSNAME_DOMAIN_LENGTH - 1
 
-static void cleanup(void);
-static void setup(void);
-
-char *TCID = "setdomainname02";
-int TST_TOTAL = 3;
-
-static char old_domain_name[MAX_NAME_LEN];
-static struct test_case_t {
+struct test_case {
 	char *desc;
 	char *name;
 	int len;
 	int exp_errno;
-	char err_desc[10];
-} test_cases[] = {
-	{
-	"test with len = -1", "test_dom", -1, EINVAL, "EINVAL"}, {
-	"test with len > allowed maximum", "test_dom", MAX_NAME_LEN + 1,
-		    EINVAL, "EINVAL"}, {
-"test with name = NULL", NULL, MAX_NAME_LEN, EFAULT, "EFAULT"},};
-
-int main(int ac, char **av)
+	char *errno_desc;
+} tcases[] = {
+	{ "len == -1", TST_VALID_DOMAIN_NAME, -1, ERRNO_DESC(EINVAL) },
+	{ "len > allowed maximum", TST_VALID_DOMAIN_NAME, MAX_NAME_LENGTH + 1, ERRNO_DESC(EINVAL) },
+	{ "name == NULL", NULL, MAX_NAME_LENGTH, ERRNO_DESC(EFAULT) }
+};
+
+void verify_setdomainname(unsigned int nr)
 {
-	int lc, ind;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	struct test_case *tcase = &tcases[nr];
 
-		for (ind = 0; ind < TST_TOTAL; ind++) {
+	TEST(do_setdomainname(tcase->name, (size_t) tcase->len));
 
-			/*
-			 * call the system call with the TEST() macro
-			 */
-			TEST(setdomainname(test_cases[ind].name,
-					   (size_t) test_cases[ind].len));
-
-			if ((TEST_RETURN == -1) &&
-			    (TEST_ERRNO == test_cases[ind].exp_errno)) {
-				tst_resm(TPASS, "expected failure; Got %s",
-					 test_cases[ind].err_desc);
-			} else {
-				tst_resm(TFAIL, "Call failed to produce "
-					 "expected error;  Expected errno: %d "
-					 "Got : %d, %s",
-					 test_cases[ind].exp_errno,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
+	tst_res(TINFO, "testing %s", tcase->desc);
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "unexpected exit code: %ld", TST_RET);
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Save current domainname */
-	if ((getdomainname(old_domain_name, MAX_NAME_LEN)) < 0) {
-		tst_brkm(TBROK, NULL, "getdomainname() failed while"
-			 " getting current domain name");
+	if (TST_ERR != tcase->exp_errno) {
+		tst_res(TFAIL | TTERRNO, "unexpected errno: %d, expected: %d",
+			TST_ERR, tcase->exp_errno);
+		return;
 	}
 
-	TEST_PAUSE;
-
+	tst_res(TPASS | TTERRNO, "expected failure");
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-	/* Restore domain name */
-	if ((setdomainname(old_domain_name, sizeof(old_domain_name)))
-	    < 0) {
-		tst_resm(TWARN, "setdomainname() failed while restoring"
-			 " domainname to \"%s\"", old_domain_name);
-	}
-
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_setdomainname,
+	.test_variants = TEST_VARIANTS,
+};
-- 
2.20.1


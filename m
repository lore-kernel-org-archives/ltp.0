From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  9 Sep 2021 17:51:22 +0200
Subject: [LTP] [PATCH 4/8] syscalls/setresgid02: Convert to new API
In-Reply-To: <20210909155126.2720-1-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
Message-ID: <20210909155126.2720-4-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original test looks up specific usernames which may not exist on some
systems. Use any two non-root IDs instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/setresgid/setresgid02.c   | 271 ++++--------------
 1 file changed, 62 insertions(+), 209 deletions(-)

diff --git a/testcases/kernel/syscalls/setresgid/setresgid02.c b/testcases/kernel/syscalls/setresgid/setresgid02.c
index 2c45fc27a..13b8689f0 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid02.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid02.c
@@ -1,237 +1,90 @@
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
+ *    AUTHOR: Madhu T L <madhu.tarikere@wipro.com>
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : setresgid02
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking functionality of setresgid(2) for
- *			  non-root group id.
- *
- *    TEST CASE TOTAL   : 6
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *      Verify that for non-root effective group id,
- *	1. setresgid(2) is successful for setresgid(-1, -1, -1)
- *	2. setresgid(2) is successful for setresgid(-1, -1, bin)
- *	3. setresgid(2) is successful for setresgid(-1, bin, -1)
- *	4. setresgid(2) is successful for setresgid(bin, -1, -1)
- *	5. setresgid(2) is successful for setresgid(root, root, root)
- *	6. setresgid(2) is successful for setresgid(root, nobody, nobody)
- *
- *      Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Check existence of root, bin and nobody user id's
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return value and functionality, if success,
- *		 Issue PASS message
- *	Otherwise,
- *		Issue FAIL message
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  setresgid02 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- * CHANGE:  Madhu T L <madhu.tarikere@wipro.com>
- * Date: April 9 2003
- * Replaced setegid() by setresgid() in setup()
- ****************************************************************/
 
-#define _GNU_SOURCE 1
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+/*\
+ * [Description]
+ *
+ * Verify that setresgid() will successfully set the expected GID when called
+ * by root with the following combinations of arguments:
+ * 1. setresgid(-1, -1, -1)
+ * 2. setresgid(-1, -1, other)
+ * 3. setresgid(-1, other, -1)
+ * 4. setresgid(other, -1, -1)
+ * 5. setresgid(root, root, root)
+ * 6. setresgid(root, main, main)
+ */
 
-#define EXP_RET_VAL	0
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
 struct test_case_t {		/* test case structure */
-	uid_t *rgid;		/* real GID */
-	uid_t *egid;		/* effective GID */
-	uid_t *sgid;		/* saved GID */
-	struct passwd *exp_rgid;	/* Expected real GID */
-	struct passwd *exp_egid;	/* Expected effective GID */
-	struct passwd *exp_sgid;	/* Expected saved GID */
+	gid_t *rgid;		/* real GID */
+	gid_t *egid;		/* effective GID */
+	gid_t *sgid;		/* saved GID */
+	gid_t *exp_rgid;	/* Expected real GID */
+	gid_t *exp_egid;	/* Expected effective GID */
+	gid_t *exp_sgid;	/* Expected saved GID */
 	char *desc;		/* Test description */
 };
 
-TCID_DEFINE(setresgid02);
-static int testno;
-static struct passwd nobody, bin, root;
-static uid_t nobody_gid, root_gid, bin_gid, neg = -1;
-
-static int test_functionality(uid_t, uid_t, uid_t);
-static void setup(void);
-static void cleanup(void);
+static gid_t root_gid, main_gid, other_gid, neg = -1;
 
 /* Don't change order of these test cases */
-static struct test_case_t tdat[] = {
-	{&neg, &neg, &neg, &root, &nobody, &nobody,
+static struct test_case_t test_cases[] = {
+	{&neg, &neg, &neg, &root_gid, &main_gid, &main_gid,
 	 "setresgid(-1, -1, -1)"},
-	{&neg, &neg, &bin.pw_gid, &root, &nobody, &bin,
-	 "setresgid(-1, -1, bin)"},
-	{&neg, &bin.pw_gid, &neg, &root, &bin, &bin,
-	 "setresgid(-1, bin, -1)"},
-	{&bin.pw_gid, &neg, &neg, &bin, &bin, &bin,
-	 "setresgid(bin, -1, -1)"},
-	{&root.pw_gid, &root.pw_gid, &root.pw_gid, &root, &root, &root,
+	{&neg, &neg, &other_gid, &root_gid, &main_gid, &other_gid,
+	 "setresgid(-1, -1, other)"},
+	{&neg, &other_gid, &neg, &root_gid, &other_gid, &other_gid,
+	 "setresgid(-1, other, -1)"},
+	{&other_gid, &neg, &neg, &other_gid, &other_gid, &other_gid,
+	 "setresgid(other, -1, -1)"},
+	{&root_gid, &root_gid, &root_gid, &root_gid, &root_gid, &root_gid,
 	 "setresgid(root, root, root)"},
-	{&root.pw_gid, &nobody.pw_gid, &nobody.pw_gid, &root, &nobody, &nobody,
-	 "setresgid(root, nobody, nobody)"},
+	{&root_gid, &main_gid, &main_gid, &root_gid, &main_gid, &main_gid,
+	 "setresgid(root, main, main)"},
 };
 
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
+	gid_t test_groups[3];
 
-			TEST(SETRESGID(cleanup, *tdat[testno].rgid, *tdat[testno].egid,
-				       *tdat[testno].sgid));
+	root_gid = test_groups[0] = getgid();
+	tst_get_gids(test_groups, 1, 3);
+	main_gid = test_groups[1];
+	other_gid = test_groups[2];
 
-			if (TEST_RETURN == EXP_RET_VAL) {
-				if (!test_functionality
-				    (tdat[testno].exp_rgid->pw_gid,
-				     tdat[testno].exp_egid->pw_gid,
-				     tdat[testno].exp_sgid->pw_gid)) {
+	GID16_CHECK(root_gid, setresgid);
+	GID16_CHECK(main_gid, setresgid);
+	GID16_CHECK(other_gid, setresgid);
 
-					tst_resm(TPASS, "Test for %s "
-						 "successful",
-						 tdat[testno].desc);
-				} else {
-					tst_resm(TFAIL, "Functionality test "
-						 "for %s failed",
-						 tdat[testno].desc);
-				}
-			} else {
-				tst_resm(TFAIL, "Test for %s failed; returned"
-					 " %ld (expected %d), errno %d (expected"
-					 " 0)", tdat[testno].desc,
-					 TEST_RETURN, EXP_RET_VAL, TEST_ERRNO);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
+	/* Set effective/saved GID to main GID */
+	SAFE_SETRESGID(-1, main_gid, main_gid);
 }
 
-static int test_functionality(uid_t exp_rgid, uid_t exp_egid, uid_t exp_sgid)
+static void run(unsigned int n)
 {
-	uid_t cur_rgid, cur_egid, cur_sgid;
-
-	/* Get current real, effective and saved group id */
-	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
-
-	if ((cur_rgid == exp_rgid) && (cur_egid == exp_egid)
-	    && (cur_sgid == exp_sgid)) {
-		return 0;
-	}
-	return 1;
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-	struct passwd *passwd_p;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	if ((passwd_p = getpwnam("root")) == NULL) {
-		tst_brkm(TBROK, NULL, "getpwnam() failed for root");
+	const struct test_case_t *tc = test_cases + n;
 
-	}
-	root = *passwd_p;
-	GID16_CHECK((root_gid = root.pw_gid), "setresgid", cleanup)
+	TST_EXP_PASS_SILENT(SETRESGID(*tc->rgid, *tc->egid, *tc->sgid), "%s",
+		tc->desc);
 
-	if ((passwd_p = getpwnam("bin")) == NULL) {
-		tst_brkm(TBROK, NULL, "bin user id doesn't exist");
+	if (!TST_PASS)
+		return;
 
-	}
-	bin = *passwd_p;
-	GID16_CHECK((bin_gid = bin.pw_gid), "setresgid", cleanup)
-
-	if ((passwd_p = getpwnam("nobody")) == NULL) {
-		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
-
-	}
-	nobody = *passwd_p;
-	GID16_CHECK((nobody_gid = nobody.pw_gid), "setresgid", cleanup)
-
-	/* Set effective/saved gid to nobody */
-	if (setresgid(-1, nobody_gid, nobody_gid) == -1) {
-		tst_brkm(TBROK, NULL, "setup() failed for setting while"
-			 " setting real/effective/saved gid");
-
-	}
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
+	if (tst_check_resgid(tc->desc, *tc->exp_rgid, *tc->exp_egid,
+		*tc->exp_sgid))
+		tst_res(TPASS, "%s works as expected", tc->desc);
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
2.33.0


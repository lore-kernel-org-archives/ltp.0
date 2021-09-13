From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 13 Sep 2021 16:44:53 +0200
Subject: [LTP] [PATCH v2 3/4] syscalls/setresuid02: Convert to new API
In-Reply-To: <20210913144454.22992-1-mdoucha@suse.cz>
References: <20210913144454.22992-1-mdoucha@suse.cz>
Message-ID: <20210913144454.22992-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original test needs user "bin" which may not exist on some systems. Use
any non-root UID instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 .../kernel/syscalls/setresuid/setresuid02.c   | 256 ++++--------------
 1 file changed, 52 insertions(+), 204 deletions(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid02.c b/testcases/kernel/syscalls/setresuid/setresuid02.c
index 87c5eab90..b3b70dea7 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid02.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid02.c
@@ -1,232 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+ *	07/2001 ported by John George
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * NAME
- * 	setresuid02.c
- *
- * DESCRIPTION
- * 	Test that a non-root user can change the real, effective and saved
- *	uid values through the setresuid system call.
- *
- * ALGORITHM
- *
- *	Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *
- *	Setup test values.
- *	Loop if the proper options are given.
- * 	For each test set execute the system call
- * 	  Check that we received the expected result.
- *	  Verify that the uid, euid and suid values are still correct.
- *	Cleanup:
- *	  Print errno log and/or timing stats if option given.
- *
- * USAGE:  <for command-line>
- *	setresuid02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
+/*\
+ * [Description]
  *
- * Restrictions
- * 	This test must be run by root.
- *	nobody and bin must be a valid users.
+ * Test that a non-root user can change the real, effective and saved uid
+ * values through the setresuid system call.
  */
 
 #define _GNU_SOURCE 1
+#include <sys/types.h>
 #include <pwd.h>
-#include <stdlib.h>
-#include "test.h"
-#include <errno.h>
-#include <sys/wait.h>
-#include "compat_16.h"
 
-TCID_DEFINE(setresuid02);
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
-uid_t neg_one = -1;
+static uid_t nobody_uid, other_uid, neg_one = -1;
 
-/* flag to tell parent if child passed or failed. */
-int flag = 0;
-
-uid_t nobody_pw_uid, bin_pw_uid;
-char user1name[] = "nobody";
-char user2name[] = "bin";
-
-struct passwd nobody, bin;
-
-/*
- * The following structure contains all test data.  Each structure in the array
- * is used for a separate test.  The tests are executed in the for loop below.
- */
-
-struct test_data_t {
+static struct test_data_t {
 	uid_t *real_uid;
 	uid_t *eff_uid;
 	uid_t *sav_uid;
-	struct passwd *exp_real_usr;
-	struct passwd *exp_eff_usr;
-	struct passwd *exp_sav_usr;
+	uid_t *exp_real_uid;
+	uid_t *exp_eff_uid;
+	uid_t *exp_sav_uid;
 	char *test_msg;
 } test_data[] = {
-	{
-	&neg_one, &neg_one, &bin_pw_uid, &nobody, &bin, &bin,
-		    "After setresuid(-1, -1, bin),"}, {
-	&neg_one, &nobody_pw_uid, &neg_one, &nobody, &nobody, &bin,
-		    "After setresuid(-1, nobody -1),"}, {
-&bin_pw_uid, &neg_one, &neg_one, &bin, &nobody, &bin,
-		    "After setresuid(bin, -1 -1),"},};
-
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
-
-void setup(void);
-void cleanup(void);
-
-void
-uid_verify(struct passwd *ru, struct passwd *eu, struct passwd *su, char *);
-
-int main(int ac, char **av)
+	{&neg_one, &neg_one, &other_uid, &nobody_uid, &other_uid, &other_uid,
+		"setresuid(-1, -1, other)"},
+	{&neg_one, &nobody_uid, &neg_one, &nobody_uid, &nobody_uid, &other_uid,
+		"setresuid(-1, nobody -1)"},
+	{&other_uid, &neg_one, &neg_one, &other_uid, &nobody_uid, &other_uid,
+		"setresuid(other, -1 -1)"},
+	/* Return to initial state */
+	{&nobody_uid, &other_uid, &nobody_uid, &nobody_uid, &other_uid,
+		&nobody_uid, "setresuid(nobody, other, nobody)"},
+};
+
+static void setup(void)
 {
-	int lc;
+	uid_t test_users[2];
+	struct passwd *pw = SAFE_GETPWNAM("nobody");
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	nobody_uid = test_users[0] = pw->pw_uid;
+	tst_get_uids(test_users, 1, 2);
+	other_uid = test_users[1];
 
-	setup();
+	UID16_CHECK(nobody_uid, setresuid);
+	UID16_CHECK(other_uid, setresuid);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i, pid;
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* set the appropriate ownership values */
-		if (setresuid(nobody_pw_uid, bin_pw_uid, nobody_pw_uid) == -1) {
-			tst_brkm(TFAIL, cleanup, "Initial setresuid failed");
-		}
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork failed");
-		} else if (pid == 0) {	/* child */
-
-			for (i = 0; i < TST_TOTAL; i++) {
-
-				/* Set the real, effective or saved user id */
-				TEST(SETRESUID(NULL, *test_data[i].real_uid,
-					       *test_data[i].eff_uid,
-					       *test_data[i].sav_uid));
-
-				if (TEST_RETURN != -1) {
-					tst_resm(TPASS, "setresuid(%d, %d, %d) "
-						 "succeeded as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid,
-						 *test_data[i].sav_uid);
-				} else {
-					tst_resm(TFAIL, "setresuid(%d, %d, %d) "
-						 "did not return as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid,
-						 *test_data[i].sav_uid);
-					flag = -1;
-				}
-
-				uid_verify(test_data[i].exp_real_usr,
-					   test_data[i].exp_eff_usr,
-					   test_data[i].exp_sav_usr,
-					   test_data[i].test_msg);
-			}
-			exit(flag);
-		} else {	/* parent */
-			tst_record_childstatus(cleanup, pid);
-		}
-	}
-	cleanup();
-	tst_exit();
+	SAFE_SETRESUID(nobody_uid, other_uid, nobody_uid);
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void run(unsigned int n)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	const struct test_data_t *tc = test_data + n;
 
-	if (getpwnam("nobody") == NULL) {
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-	}
+	TST_EXP_PASS_SILENT(SETRESUID(*tc->real_uid, *tc->eff_uid,
+		*tc->sav_uid), "%s", tc->test_msg);
 
-	if (getpwnam("bin") == NULL) {
-		tst_brkm(TBROK, NULL, "bin must be a valid user.");
-	}
-
-	nobody = *(getpwnam("nobody"));
-	UID16_CHECK((nobody_pw_uid = nobody.pw_uid), "setresuid", cleanup)
-
-	bin = *(getpwnam("bin"));
-	UID16_CHECK((bin_pw_uid = bin.pw_uid), "setresuid", cleanup)
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
+	if (!TST_PASS)
+		return;
 
+	if (tst_check_resuid(tc->test_msg, *tc->exp_real_uid,
+		*tc->exp_eff_uid, *tc->exp_sav_uid))
+		tst_res(TPASS, "%s works as expected", tc->test_msg);
 }
 
-void
-uid_verify(struct passwd *ru, struct passwd *eu, struct passwd *su, char *when)
-{
-	uid_t cur_ru, cur_eu, cur_su;
-	if (getresuid(&cur_ru, &cur_eu, &cur_su) != 0) {
-		flag = -1;
-		tst_brkm(TBROK, cleanup, "Set getresuid() failed");
-	}
-	if ((cur_ru != ru->pw_uid) || (cur_eu != eu->pw_uid) || (cur_su !=
-								 su->pw_uid)) {
-		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d; "
-			 "saved uid = %d", when, cur_ru, cur_eu, cur_su);
-		tst_resm(TINFO, "Expected: real uid = %d, effective uid = %d "
-			 "saved uid = %d", ru->pw_uid, eu->pw_uid, su->pw_uid);
-		flag = -1;
-	} else {
-		tst_resm(TINFO, "real uid = %d, effective uid = %d, and "
-			 "saved uid = %d as expected", cur_ru, cur_eu, cur_su);
-	}
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(test_data),
+	.setup = setup,
+	.needs_root = 1,
+};
-- 
2.33.0


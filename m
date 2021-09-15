From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 15 Sep 2021 15:45:03 +0200
Subject: [LTP] [PATCH 2/4] syscalls/setreuid03: Convert to new API
In-Reply-To: <20210915134505.22771-1-mdoucha@suse.cz>
References: <20210915134505.22771-1-mdoucha@suse.cz>
Message-ID: <20210915134505.22771-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original test looks up specific usernames which may not exist on some
systems. Use any non-root UID instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/setreuid/setreuid03.c     | 240 ++++++------------
 1 file changed, 77 insertions(+), 163 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index ecf30d6ec..e83a3586a 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -1,190 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Ported by John George
+ *    Ported by John George
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Test setreuid() when executed by an unpriviledged user.
  */
 
-#include <errno.h>
+#include <sys/types.h>
 #include <pwd.h>
-#include <stdlib.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
-
-#define FAILED  1
-
-TCID_DEFINE(setreuid03);
 
-static int fail = -1;
-static int pass;
-static uid_t neg_one = -1;
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "compat_tst_16.h"
 
-static struct passwd nobody, bin, root;
-
-/*
- * The following structure contains all test data.  Each structure in the array
- * is used for a separate test.  The tests are executed in the for loop below.
- */
+static uid_t root_uid, nobody_uid, other_uid, neg_one = -1;
 
 static struct test_data_t {
 	uid_t *real_uid;
 	uid_t *eff_uid;
-	int *exp_ret;
-	struct passwd *exp_real_usr;
-	struct passwd *exp_eff_usr;
-	char *test_msg;
+	int exp_ret;
+	uid_t *exp_real_uid;
+	uid_t *exp_eff_uid;
+	uid_t *exp_sav_uid;
+	const char *test_msg;
 } test_data[] = {
-	{
-	&nobody.pw_uid, &nobody.pw_uid, &pass, &nobody, &nobody,
-		    "After setreuid(nobody, nobody),"}, {
-	&neg_one, &nobody.pw_uid, &pass, &nobody, &nobody,
-		    "After setreuid(-1, nobody),"}, {
-	&nobody.pw_uid, &neg_one, &pass, &nobody, &nobody,
-		    "After setreuid(nobody, -1),"}, {
-	&neg_one, &neg_one, &pass, &nobody, &nobody, "After setreuid(-1, -1),"},
-	{
-	&neg_one, &root.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(-1, root),"}, {
-	&root.pw_uid, &neg_one, &fail, &nobody, &nobody,
-		    "After setreuid(root, -1),"}, {
-	&root.pw_uid, &root.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(root, root),"}, {
-	&root.pw_uid, &nobody.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(root, nobody),"}, {
-	&root.pw_uid, &bin.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(root, nobody),"}, {
-	&bin.pw_uid, &root.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(bin, root),"}, {
-	&bin.pw_uid, &neg_one, &fail, &nobody, &nobody,
-		    "After setreuid(bin, -1),"}, {
-	&bin.pw_uid, &bin.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(bin, bin,),"}, {
-	&bin.pw_uid, &nobody.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(bin, nobody),"}, {
-	&nobody.pw_uid, &bin.pw_uid, &fail, &nobody, &nobody,
-		    "After setreuid(nobody, bin),"},};
-
-int TST_TOTAL = ARRAY_SIZE(test_data);
-
-static void setup(void);
-static void cleanup(void);
-static void uid_verify(struct passwd *, struct passwd *, char *);
+	{&nobody_uid, &nobody_uid, 0, &nobody_uid, &nobody_uid, &nobody_uid,
+		"setreuid(nobody, nobody)"},
+	{&neg_one, &nobody_uid, 0, &nobody_uid, &nobody_uid, &nobody_uid,
+		"setreuid(-1, nobody)"},
+	{&nobody_uid, &neg_one, 0, &nobody_uid, &nobody_uid, &nobody_uid,
+		"setreuid(nobody, -1)"},
+	{&neg_one, &neg_one, 0, &nobody_uid, &nobody_uid, &nobody_uid,
+		"setreuid(-1, -1)"},
+	{&neg_one, &root_uid, -1, &nobody_uid, &nobody_uid, &nobody_uid,
+		"setreuid(-1, root)"},
+	{&root_uid, &neg_one, -1, &nobody_uid, &nobody_uid, &nobody_uid,
+		"setreuid(root, -1)"},
+	{&root_uid, &root_uid, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(root, root)"},
+	{&root_uid, &nobody_uid, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(root, nobody)"},
+	{&root_uid, &other_uid, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(root, other)"},
+	{&other_uid, &root_uid, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(other, root)"},
+	{&other_uid, &neg_one, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(other, -1)"},
+	{&other_uid, &other_uid, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(other, other)"},
+	{&other_uid, &nobody_uid, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(other, nobody)"},
+	{&nobody_uid, &other_uid, -1, &nobody_uid, &nobody_uid,
+		&nobody_uid, "setreuid(nobody, other)"},
+};
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i;
+	uid_t test_users[2];
+	struct passwd *pw;
 
-		tst_count = 0;
+	root_uid = getuid();
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_uid = test_users[0] = pw->pw_uid;
+	tst_get_uids(test_users, 1, 2);
+	other_uid = test_users[1];
 
-		for (i = 0; i < TST_TOTAL; i++) {
+	UID16_CHECK(root_uid, setreuid);
+	UID16_CHECK(nobody_uid, setreuid);
+	UID16_CHECK(other_uid, setreuid);
 
-			/* Set the real or effective user id */
-			TEST(SETREUID(cleanup, *test_data[i].real_uid,
-				      *test_data[i].eff_uid));
-
-			if (TEST_RETURN == *test_data[i].exp_ret) {
-				if (TEST_RETURN == neg_one) {
-					if (TEST_ERRNO != EPERM) {
-						tst_resm(TFAIL,
-							 "setreuid(%d, %d) "
-							 "did not set errno "
-							 "value as expected.",
-							 *test_data[i].real_uid,
-							 *test_data[i].eff_uid);
-						continue;
-					}
-					tst_resm(TPASS, "setreuid(%d, %d) "
-						 "failed as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid);
-				} else {
-					tst_resm(TPASS, "setreuid(%d, %d) "
-						 "succeeded as expected.",
-						 *test_data[i].real_uid,
-						 *test_data[i].eff_uid);
-				}
-			} else {
-				tst_resm(TFAIL, "setreuid(%d, %d) "
-					 "did not return as expected.",
-					 *test_data[i].real_uid,
-					 *test_data[i].eff_uid);
-			}
-
-			if (TEST_RETURN == -1) {
-			}
-			uid_verify(test_data[i].exp_real_usr,
-				   test_data[i].exp_eff_usr,
-				   test_data[i].test_msg);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_SETUID(nobody_uid);
 }
 
-static void setup(void)
+static void run(unsigned int n)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	if (getpwnam("nobody") == NULL)
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-
-	if (getpwnam("bin") == NULL)
-		tst_brkm(TBROK, NULL, "bin must be a valid user.");
-
-	root = *(getpwnam("root"));
-	UID16_CHECK(root.pw_uid, setreuid, cleanup);
-
-	nobody = *(getpwnam("nobody"));
-	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
-
-	bin = *(getpwnam("bin"));
-	UID16_CHECK(bin.pw_uid, setreuid, cleanup);
+	const struct test_data_t *tc = test_data + n;
+
+	if (tc->exp_ret) {
+		TST_EXP_FAIL(SETREUID(*tc->real_uid, *tc->eff_uid), EPERM,
+			"%s", tc->test_msg);
+	} else {
+		TST_EXP_PASS(SETREUID(*tc->real_uid, *tc->eff_uid), "%s",
+			tc->test_msg);
+	}
 
-	SAFE_SETUID(NULL, nobody.pw_uid);
+	if (!TST_PASS)
+		return;
 
-	TEST_PAUSE;
+	tst_check_resuid(tc->test_msg, *tc->exp_real_uid, *tc->exp_eff_uid,
+		*tc->exp_sav_uid);
 }
 
-static void cleanup(void)
-{
-}
-
-static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
-{
-	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
-		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
-			 when, getuid(), geteuid());
-		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
-			 ru->pw_uid, eu->pw_uid);
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


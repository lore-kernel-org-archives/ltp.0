From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 10 Sep 2018 16:18:59 +0200
Subject: [LTP] [PATCH v2 3/5] setregid02: Convert to newlib
In-Reply-To: <20180910141901.20541-1-cfamullaconrad@suse.de>
References: <20180910141901.20541-1-cfamullaconrad@suse.de>
Message-ID: <20180910141901.20541-3-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Changed some messaged to show errno as string.
* Used SAVE_* functions for getgrnam(), getgrgid() and getpwnam()
* Format changes, put constants on right side

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 testcases/kernel/syscalls/setregid/setregid02.c | 138 ++++++++----------------
 1 file changed, 44 insertions(+), 94 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 21d1c823a..ea262b8c8 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
  *
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
- *
  *   Ported by John George
  */
 
@@ -29,13 +15,9 @@
 #include <pwd.h>
 #include <grp.h>
 #include <stdlib.h>
-#include <string.h>
 
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
-
-TCID_DEFINE(setregid02);
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
 static gid_t neg_one = -1;
 
@@ -48,14 +30,14 @@ static struct group ltpgroup, root, bin;
  * is used for a separate test.  The tests are executed in the for loop below.
  */
 
-struct test_data_t {
+static struct tcase {
 	gid_t *real_gid;
 	gid_t *eff_gid;
 	int exp_errno;
 	struct group *exp_real_usr;
 	struct group *exp_eff_usr;
 	char *test_msg;
-} test_data[] = {
+} tcases[] = {
 	{
 	&neg_one, &root.gr_gid, EPERM, &ltpgroup, &ltpgroup,
 		    "After setregid(-1, root),"}, {
@@ -71,113 +53,81 @@ struct test_data_t {
 		    "After setregid(bin, root),"}
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_data);
-
-static void setup(void);
 static void gid_verify(struct group *ru, struct group *eu, char *when);
 static struct group get_group_by_name(const char *name);
 static struct group get_group_by_gid(gid_t gid);
 
-int main(int ac, char **av)
+static  void run(unsigned int n)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i;
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			/* Set the real or effective group id */
-			TEST(SETREGID(NULL, *test_data[i].real_gid,
-				      *test_data[i].eff_gid));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == test_data[i].exp_errno) {
-					tst_resm(TPASS, "setregid(%d, %d) "
-						 "failed as expected.",
-						 *test_data[i].real_gid,
-						 *test_data[i].eff_gid);
-				} else {
-					tst_resm(TFAIL, "setregid(%d, %d) "
-						 "failed (%d) but did not set the "
-						 "expected errno (%d).",
-						 *test_data[i].real_gid,
-						 *test_data[i].eff_gid,
-						 TEST_ERRNO,
-						 test_data[i].exp_errno);
-				}
-			} else {
-				tst_resm(TFAIL, "setregid(%d, %d) "
-					 "did not fail (ret: %ld) as expected (ret: -1).",
-					 *test_data[i].real_gid,
-					 *test_data[i].eff_gid, TEST_RETURN);
-			}
-			gid_verify(test_data[i].exp_real_usr,
-				   test_data[i].exp_eff_usr,
-				   test_data[i].test_msg);
+	struct tcase *tc = &tcases[n];
+
+	/* Set the real or effective group id */
+	TEST(SETREGID(*tc->real_gid, *tc->eff_gid));
+
+	if (TST_RET == -1) {
+		if (tc->exp_errno == TST_ERR) {
+			tst_res(TPASS | TTERRNO,
+				"setregid(%d, %d) failed as expected",
+				*tc->real_gid, *tc->eff_gid);
+		} else {
+			tst_res(TFAIL | TTERRNO,
+				"setregid(%d, %d) failed unexpectedly, expected %s",
+				*tc->real_gid, *tc->eff_gid,
+				tst_strerrno(tc->exp_errno));
 		}
+	} else {
+		tst_res(TFAIL,
+			"setregid(%d, %d) did not fail (ret: %ld) as expected (ret: -1).",
+			*tc->real_gid, *tc->eff_gid, TST_RET);
 	}
-
-	tst_exit();
+	gid_verify(tc->exp_real_usr, tc->exp_eff_usr, tc->test_msg);
 }
 
 static void setup(void)
 {
-	tst_require_root();
+	ltpuser = SAFE_GETPWNAM("nobody");
 
-	tst_sig(FORK, DEF_HANDLER, NULL);
-
-	ltpuser = getpwnam("nobody");
-	if (ltpuser == NULL)
-		tst_brkm(TBROK, NULL, "getpwnam(\"nobody\") failed");
-
-	SAFE_SETGID(NULL, ltpuser->pw_gid);
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
+	SAFE_SETGID(ltpuser->pw_gid);
+	SAFE_SETUID(ltpuser->pw_uid);
 
 	root = get_group_by_name("root");
 	ltpgroup = get_group_by_gid(ltpuser->pw_gid);
 	bin = get_group_by_name("bin");
-
-	TEST_PAUSE;
 }
 
 static struct group get_group_by_name(const char *name)
 {
-	struct group *ret = getgrnam(name);
-
-	if (ret == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "getgrnam(\"%s\") failed", name);
+	struct group *ret = SAFE_GETGRNAM(name);
 
-	GID16_CHECK(ret->gr_gid, setregid, NULL);
+	GID16_CHECK(ret->gr_gid, setregid);
 
 	return *ret;
 }
 
 static struct group get_group_by_gid(gid_t gid)
 {
-	struct group *ret = getgrgid(gid);
+	struct group *ret = SAFE_GETGRGID(gid);
 
-	if (ret == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "getgrgid(\"%d\") failed", gid);
-
-	GID16_CHECK(ret->gr_gid, setregid, NULL);
+	GID16_CHECK(ret->gr_gid, setregid);
 
 	return *ret;
 }
-
 void gid_verify(struct group *rg, struct group *eg, char *when)
 {
 	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
-		tst_resm(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
+		tst_res(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
-		tst_resm(TINFO, "Expected: real gid = %d; effective gid = %d",
+		tst_res(TINFO, "Expected: real gid = %d; effective gid = %d",
 			 rg->gr_gid, eg->gr_gid);
 	} else {
-		tst_resm(TPASS, "real or effective gid was modified as expected");
+		tst_res(TPASS,
+			"real or effective gid was modified as expected");
 	}
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.test = run,
+	.setup = setup,
+};
-- 
2.16.4


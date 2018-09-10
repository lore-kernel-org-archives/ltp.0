From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 10 Sep 2018 14:38:05 +0200
Subject: [LTP] [PATCH v1] setregid03: convert to newlib
Message-ID: <20180910123805.15668-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Do not fork, cause I don't see the need for it. Maybe a left over
from previous changes.

It requires SAFE_GETGRNAM_FALLBACK() which is not in master, but in
a previous patch "tst_safe_macros: add SAFE_GETGRNAM_FALLBACK()".

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 testcases/kernel/syscalls/setregid/setregid03.c | 216 ++++++++----------------
 1 file changed, 66 insertions(+), 150 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index a4caf238d..e48e28d19 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *
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
  * Ported by John George
  */
 
@@ -22,32 +9,22 @@
  * Test setregid() when executed by a non-root user.
  */
 
-#include <errno.h>
-#include <grp.h>
-#include <stdlib.h>
 #include <pwd.h>
-#include <string.h>
-#include <sys/wait.h>
 
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(setregid03);
 static int fail = -1;
 static int pass;
 static gid_t neg_one = -1;
 
-/* flag to tell parent if child passed or failed. */
-static int flag;
-
 struct group nobody_gr, daemon_gr, root_gr, bin_gr;
 struct passwd nobody;
+
 /*
  * The following structure contains all test data.  Each structure in the array
  * is used for a separate test.  The tests are executed in the for loop below.
  */
-
 struct test_data_t {
 	gid_t *real_gid;
 	gid_t *eff_gid;
@@ -80,150 +57,89 @@ struct test_data_t {
 	&daemon_gr.gr_gid, &daemon_gr.gr_gid, &fail, &bin_gr, &bin_gr,
 		    "After setregid(daemon, daemon)"},};
 
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
 static void setup(void);
 static void gid_verify(struct group *ru, struct group *eu, char *when);
+static struct group get_group_fallback(const char *gr1, const char *gr2);
+static struct group get_group(const char *group);
 
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		pid_t pid;
-		int status, i;
-
-		pass = 0;
-		flag = 0;
-
-		tst_count = 0;
-
-		/* set the appropriate ownership values */
-		if (SETREGID(NULL, daemon_gr.gr_gid, bin_gr.gr_gid) == -1)
-			tst_brkm(TBROK, NULL, "Initial setregid failed");
-
-		SAFE_SETEUID(NULL, nobody.pw_uid);
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, NULL, "fork failed");
-		} else if (pid == 0) {	/* child */
-			for (i = 0; i < TST_TOTAL; i++) {
-				gid_t test_ret;
-				/* Set the real or effective group id */
-				TEST(SETREGID(NULL, *test_data[i].real_gid,
-					      *test_data[i].eff_gid));
-				test_ret = TEST_RETURN;
-
-				if (test_ret == *test_data[i].exp_ret) {
-					if (test_ret == neg_one) {
-						if (TEST_ERRNO != EPERM) {
-							tst_resm(TFAIL,
-								 "setregid(%d, %d) "
-								 "did not set errno "
-								 "value as expected.",
-								 *test_data
-								 [i].real_gid,
-								 *test_data
-								 [i].eff_gid);
-							fail = -1;
-							continue;
-						} else {
-							tst_resm(TPASS,
-								 "setregid(%d, %d) "
-								 "failed as expected.",
-								 *test_data
-								 [i].real_gid,
-								 *test_data
-								 [i].eff_gid);
-						}
-					} else {
-						tst_resm(TPASS,
-							 "setregid(%d, %d) "
-							 "succeeded as expected.",
-							 *test_data[i].real_gid,
-							 *test_data[i].eff_gid);
-					}
-				} else {
-					tst_resm(TFAIL, "setregid(%d, %d) "
-						 "did not return as expected.",
-						 *test_data[i].real_gid,
-						 *test_data[i].eff_gid);
-					flag = -1;
-				}
-				if (test_ret == -1) {
-				}
-
-				gid_verify(test_data[i].exp_real_usr,
-					   test_data[i].exp_eff_usr,
-					   test_data[i].test_msg);
-			}
-			exit(flag);
-		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "test failed within "
-					 "child process.");
+	struct test_data_t *tc = &test_data[i];
+
+	/* Set the real or effective group id */
+	TEST(SETREGID(*tc->real_gid, *tc->eff_gid));
+
+	if (TST_RET == *tc->exp_ret) {
+		if (TST_RET == -1) {
+			if (TST_ERR != EPERM) {
+				tst_res(TFAIL | TTERRNO,
+					"setregid(%d, %d) did not set errno "
+					"value as expected.",
+					*tc->real_gid, *tc->eff_gid);
+			} else {
+				tst_res(TPASS,
+					"setregid(%d, %d) failed as expected.",
+					*tc->real_gid, *tc->eff_gid);
 			}
+		} else {
+			tst_res(TPASS,
+				"setregid(%d, %d) succeeded as expected.",
+				*tc->real_gid, *tc->eff_gid);
 		}
+	} else {
+		tst_res(TFAIL, "setregid(%d, %d) did not return as expected.",
+			*tc->real_gid, *tc->eff_gid);
 	}
-
-	tst_exit();
+	gid_verify(tc->exp_real_usr, tc->exp_eff_usr, tc->test_msg);
 }
 
 static void setup(void)
+{
+	nobody = *SAFE_GETPWNAM("nobody");
+
+	nobody_gr = get_group_fallback("nobody", "nogroup");
+	daemon_gr = get_group("daemon");
+	bin_gr = get_group("bin");
+
+	/* set the appropriate ownership values */
+	SAFE_SETREGID(daemon_gr.gr_gid, bin_gr.gr_gid);
+	SAFE_SETEUID(nobody.pw_uid);
+}
+
+static struct group get_group_fallback(const char *gr1, const char *gr2)
+{
+	struct group *junk;
+
+	junk = SAFE_GETGRNAM_FALLBACK(gr1, gr2);
+	GID16_CHECK(junk->gr_gid, setregid);
+	return *junk;
+}
+
+static struct group get_group(const char *group)
 {
 	struct group *junk;
 
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, NULL);
-
-	if (getpwnam("nobody") == NULL)
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-	nobody = *(getpwnam("nobody"));
-
-#define GET_GID(group) do { \
-	junk = getgrnam(#group); \
-	if (junk == NULL) { \
-		tst_brkm(TBROK, NULL, "%s must be a valid group", #group); \
-	} \
-	GID16_CHECK(junk->gr_gid, setregid, NULL); \
-	group ## _gr = *(junk); \
-} while (0)
-
-#define GET_GID_FALLBACK(group, group2) do { \
-	junk = getgrnam(#group); \
-	if (junk == NULL) { \
-		tst_resm(TINFO, "%s not found, trying fallback %s", #group, #group2); \
-		junk = getgrnam(#group2); \
-		if (junk == NULL) { \
-			tst_brkm(TBROK, NULL, "%s or %s must be a valid group", #group, #group2); \
-		} \
-	} \
-	GID16_CHECK(junk->gr_gid, setregid, NULL); \
-	group ## _gr = *(junk); \
-} while (0)
-
-	GET_GID_FALLBACK(nobody, nogroup);
-	GET_GID(daemon);
-	GET_GID(bin);
-
-	TEST_PAUSE;
+	junk = SAFE_GETGRNAM(group);
+	GID16_CHECK(junk->gr_gid, setregid);
+	return *junk;
 }
 
 static void gid_verify(struct group *rg, struct group *eg, char *when)
 {
 	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
-		tst_resm(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
+		tst_res(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
-		tst_resm(TINFO, "Expected: real gid = %d; effective gid = %d",
+		tst_res(TINFO, "Expected: real gid = %d; effective gid = %d",
 			 rg->gr_gid, eg->gr_gid);
-		flag = -1;
 	} else {
-		tst_resm(TPASS, "real or effective gid was modified as expected");
+		tst_res(TPASS, "real or effective gid was modified as expected");
 	}
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(test_data),
+	.needs_root = 1,
+	.test = run,
+	.setup = setup,
+};
-- 
2.16.4


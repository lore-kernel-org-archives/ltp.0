From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 10 Sep 2018 11:11:43 +0200
Subject: [LTP] [PATCH v1 5/5] setregid04: Convert to newlib
In-Reply-To: <20180910090933.12080-1-cfamullaconrad@suse.de>
References: <20180910090933.12080-1-cfamullaconrad@suse.de>
Message-ID: <20180910091143.12312-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 testcases/kernel/syscalls/setregid/setregid04.c | 114 ++++++------------------
 1 file changed, 26 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index bf744ff05..1ecf03f9b 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
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
 
@@ -22,16 +9,8 @@
  * Test setregid() when executed by root.
  */
 
-#include <errno.h>
-#include <pwd.h>
-#include <grp.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-TCID_DEFINE(setregid04);
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
 static gid_t neg_one = -1;
 
@@ -70,88 +49,47 @@ struct test_data_t {
 		    "After setregid(-1, nobody)"}
 };
 
-int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
-
 static void setup(void);
-static void cleanup(void);
 static void gid_verify(struct group *ru, struct group *eu, const char *when);
 
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int lc;
+	/* Set the real or effective group id */
+	TEST(SETREGID(*test_data[i].real_gid, *test_data[i].eff_gid));
 
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
-			TEST(SETREGID(cleanup, *test_data[i].real_gid,
-				      *test_data[i].eff_gid));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TBROK, "setregid(%d, %d) failed",
-					 *test_data[i].real_gid,
-					 *test_data[i].eff_gid);
-			} else {
-				gid_verify(test_data[i].exp_real_usr,
-					   test_data[i].exp_eff_usr,
-					   test_data[i].test_msg);
-			}
-		}
+	if (TST_RET == -1) {
+		tst_res(TBROK | TTERRNO, "setregid(%d, %d) failed",
+			*test_data[i].real_gid, *test_data[i].eff_gid);
+	} else {
+		gid_verify(test_data[i].exp_real_usr, test_data[i].exp_eff_usr,
+			   test_data[i].test_msg);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-#define SAFE_GETGROUP(GROUPNAME)	\
-	if (getgrnam(#GROUPNAME) == NULL) { \
-		tst_brkm(TBROK, NULL, "Couldn't find the `" #GROUPNAME "' group"); \
-	} \
-	GROUPNAME ## _gr = *(getgrnam(#GROUPNAME));
-
-#define SAFE_GETGROUP_FALLBACK(GROUPNAME, GROUPNAME2)	\
-	if (getgrnam(#GROUPNAME) != NULL) \
-		GROUPNAME ## _gr = *(getgrnam(#GROUPNAME)); \
-	else if (getgrnam(#GROUPNAME2) != NULL) { \
-		GROUPNAME ## _gr = *(getgrnam(#GROUPNAME2)); \
-		tst_resm(TINFO, "`" #GROUPNAME "' group not found, trying fallback `" #GROUPNAME2 "' group"); \
-	} else \
-		tst_brkm(TBROK, NULL, "Couldn't find neither`" #GROUPNAME "' `" #GROUPNAME2 "' nor group");
-
 static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	SAFE_GETGROUP(root);
-	SAFE_GETGROUP_FALLBACK(nobody, nogroup);
-	SAFE_GETGROUP(daemon);
-	SAFE_GETGROUP(bin);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
+	root_gr = *SAFE_GETGRNAM("root");
+	nobody_gr = *SAFE_GETGRNAM_FALLBACK("nobody", "nogroup");
+	daemon_gr = *SAFE_GETGRNAM("daemon");
+	bin_gr = *SAFE_GETGRNAM("bin");
 }
 
 static void gid_verify(struct group *rg, struct group *eg, const char *when)
 {
 	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
-		tst_resm(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
+		tst_res(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
-		tst_resm(TINFO, "Expected: real gid = %d; effective gid = %d",
+		tst_res(TINFO, "Expected: real gid = %d; effective gid = %d",
 			 rg->gr_gid, eg->gr_gid);
 	} else {
-		tst_resm(TPASS, "real or effective gid was modified as "
+		tst_res(TPASS, "real or effective gid was modified as "
 			 "expected");
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


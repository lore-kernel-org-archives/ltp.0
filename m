From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 22 Apr 2021 11:29:20 +0800
Subject: [LTP] [PATCH v2] syscalls/setgid: Update to new API
Message-ID: <20210422032920.9992-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
	testcases/kernel/syscalls/setgid/setgid01.c
	testcases/kernel/syscalls/setgid/setgid02.c
	testcases/kernel/syscalls/setgid/setgid03.c

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2:
	1)use TST_EXP_PASS/TST_EXP_FAIL to simplify the test code
	2)add discription to setgid01.c
	3)remove gid check for setgid03.c

 testcases/kernel/syscalls/setgid/setgid01.c |  90 +++-------------
 testcases/kernel/syscalls/setgid/setgid02.c | 111 +++++---------------
 testcases/kernel/syscalls/setgid/setgid03.c |  99 ++++-------------
 3 files changed, 60 insertions(+), 240 deletions(-)

diff --git a/testcases/kernel/syscalls/setgid/setgid01.c b/testcases/kernel/syscalls/setgid/setgid01.c
index 0c8ef3b2a..2a14f8b85 100644
--- a/testcases/kernel/syscalls/setgid/setgid01.c
+++ b/testcases/kernel/syscalls/setgid/setgid01.c
@@ -1,91 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
- */
-/*
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
+ * AUTHOR		: William Roske
+ * CO-PILOT		: Dave Fenner
  */
-#include <errno.h>
-#include <string.h>
-#include <signal.h>

-#include "test.h"
-#include "compat_16.h"

-static void setup(void);
-static void cleanup(void);
+/*\
+ * [Description]
+ * Calls setgid() with current gid and expects success.
+ */

-TCID_DEFINE(setgid01);
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "compat_tst_16.h"

 static gid_t gid;

-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(SETGID(cleanup, gid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "setgid(%d) Failed, errno=%d : %s", gid,
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "setgid(%d) returned %ld", gid,
-				 TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(SETGID(gid));
 }

 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
 	gid = getgid();
-	GID16_CHECK(gid, setgid, cleanup);
+	GID16_CHECK(gid, setgid);
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/setgid/setgid02.c b/testcases/kernel/syscalls/setgid/setgid02.c
index b3f4fd646..d329f23c0 100644
--- a/testcases/kernel/syscalls/setgid/setgid02.c
+++ b/testcases/kernel/syscalls/setgid/setgid02.c
@@ -1,111 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  Ported by Wayne Boyer
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
  */

-/*
- * Testcase to ensure that the setgid() system call sets errno to EPERM
+/*\
+ * [Description]
+ * Testcase ensures that the setgid() system call sets errno to EPERM.
  *
- * ALGORITHM
- *	Call setgid() to set the gid to that of root. Run this test as
- *	ltpuser1, and expect to get EPERM
+ * [Algorithm]
+ * Call setgid() to set the gid to that of root. Run this test as
+ * nobody, and expect to get EPERM.
  */
-#include <pwd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"

-TCID_DEFINE(setgid02);
-int TST_TOTAL = 1;
+#include <pwd.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"

 static char root[] = "root";
 static char nobody_uid[] = "nobody";
-static char nobody_gid[] = "nobody";
 static struct passwd *ltpuser;

-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(void)
 {
-	struct passwd *getpwnam(), *rootpwent;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	struct passwd *rootpwent;

-		if ((rootpwent = getpwnam(root)) == NULL) {
-			tst_brkm(TBROK, cleanup, "getpwnam failed for user id "
-				 "%s", root);
-		}
+	rootpwent = SAFE_GETPWNAM(root);

-		GID16_CHECK(rootpwent->pw_gid, setgid, cleanup);
+	GID16_CHECK(rootpwent->pw_gid, setgid);

-		TEST(SETGID(cleanup, rootpwent->pw_gid));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			continue;
-		}
-
-		if (TEST_ERRNO != EPERM) {
-			tst_resm(TFAIL, "setgid set invalid errno, expected: "
-				 "EPERM, got: %d\n", TEST_ERRNO);
-		} else {
-			tst_resm(TPASS, "setgid returned EPERM");
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(SETGID(rootpwent->pw_gid), EPERM);
 }

 static void setup(void)
 {
-	tst_require_root();
-
 	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
-			nobody_uid);
-
-	if (setgid(ltpuser->pw_gid) == -1) {
-		tst_resm(TINFO, "setgid failed to "
-			 "to set the effective gid to %d", ltpuser->pw_gid);
-		perror("setgid");
-	}
-
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM(nobody_uid);
+
+	SAFE_SETGID(ltpuser->pw_gid);
+	SAFE_SETUID(ltpuser->pw_uid);
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.test_all = run,
+};
diff --git a/testcases/kernel/syscalls/setgid/setgid03.c b/testcases/kernel/syscalls/setgid/setgid03.c
index f29347a13..2891311ba 100644
--- a/testcases/kernel/syscalls/setgid/setgid03.c
+++ b/testcases/kernel/syscalls/setgid/setgid03.c
@@ -1,100 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  Ported by Wayne Boyer
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
  */

-/*
- * ALGORITHM
- *	As root sets the current group id to ltpuser1, verify the results
+/*\
+ * [Algorithm]
+ * As a root sets current group id to nobody and expects success.
  */
-#include <pwd.h>
-#include <errno.h>
-
-#include "test.h"
-#include <compat_16.h>

-TCID_DEFINE(setgid03);
-int TST_TOTAL = 1;
+#include <pwd.h>
+#include "tst_test.h"
+#include <compat_tst_16.h>

 static char ltpuser1[] = "nobody";
 static char root[] = "root";
 static struct passwd *ltpuser1pwent, *rootpwent;
 static gid_t mygid;

-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(SETGID(cleanup, ltpuser1pwent->pw_gid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly");
-			continue;
-		}
+	TST_EXP_PASS(SETGID(ltpuser1pwent->pw_gid));

-		if (getgid() != ltpuser1pwent->pw_gid) {
-			tst_resm(TFAIL, "setgid failed to set gid to "
-				 "ltpuser1's gid");
-		} else {
-			tst_resm(TPASS, "functionality of getgid() is correct");
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	if (getgid() != ltpuser1pwent->pw_gid)
+		tst_res(TFAIL, "setgid failed to set gid to ltpuser1's gid");
+	else
+		tst_res(TPASS, "functionality of getgid() is correct");
 }

 static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	if ((rootpwent = getpwnam(root)) == NULL) {
-		tst_brkm(TBROK, cleanup, "getpwnam failed for "
-			 "user id %s", root);
-	}
-
-	mygid = getgid();
-
-	if (mygid != rootpwent->pw_gid) {
-		tst_brkm(TBROK, cleanup, "real group id is not root");
-	}
-
-	if ((ltpuser1pwent = getpwnam(ltpuser1)) == NULL) {
-		tst_brkm(TBROK, cleanup, "getpwnam failed for user "
-			 "id %s", ltpuser1);
-	}
-
-	GID16_CHECK(ltpuser1pwent->pw_gid, setgid, cleanup);
+	ltpuser1pwent = SAFE_GETPWNAM(ltpuser1);
+	GID16_CHECK(ltpuser1pwent->pw_gid, setgid);
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.test_all = run,
+};
--
2.17.1


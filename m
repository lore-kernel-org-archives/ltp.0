From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 22 Apr 2021 14:57:41 +0800
Subject: [LTP] [PATCH] syscalls/getgid: Update to new API
Message-ID: <20210422065741.11447-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
	testcases/kernel/syscalls/getgid/getgid01.c
	testcases/kernel/syscalls/getgid/getgid03.c

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/getgid/getgid01.c | 98 ++++++---------------
 testcases/kernel/syscalls/getgid/getgid03.c | 92 ++++++-------------
 2 files changed, 51 insertions(+), 139 deletions(-)

diff --git a/testcases/kernel/syscalls/getgid/getgid01.c b/testcases/kernel/syscalls/getgid/getgid01.c
index bf9ed3250..0277d3862 100644
--- a/testcases/kernel/syscalls/getgid/getgid01.c
+++ b/testcases/kernel/syscalls/getgid/getgid01.c
@@ -1,86 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
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
+ * AUTHOR		: William Roske
+ * CO-PILOT		: Dave Fenner
  */
-/*
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
- */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <signal.h>
-#include <string.h>

-#include "test.h"
-#include "compat_16.h"
+/*\
+ * [Description]
+ * Call getgid() and expects that the gid returned correctly.
+ */

-static void setup(void);
-static void cleanup(void);
+#include <pwd.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"

-TCID_DEFINE(getgid01);
-int TST_TOTAL = 1;
+static struct passwd *ltpuser;
+static char nobody_uid[] = "nobody";

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
-
-		tst_count = 0;
-
-		TEST(GETGID(cleanup));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "getgid failed");
-		} else {
-			tst_resm(TPASS, "getgid returned %ld",
-				 TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TEST(GETGID());
+	if (TST_RET != ltpuser->pw_gid)
+		tst_res(TFAIL, "getgid failed, returned %ld", TST_RET);
+	else
+		tst_res(TPASS, "getgid returned as expectedly");
 }

 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM(nobody_uid);
+	SAFE_SETGID(ltpuser->pw_gid);
 }

-static void cleanup(void)
-{
-}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.test_all = run,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/getgid/getgid03.c b/testcases/kernel/syscalls/getgid/getgid03.c
index b54fa108f..677de4e8d 100644
--- a/testcases/kernel/syscalls/getgid/getgid03.c
+++ b/testcases/kernel/syscalls/getgid/getgid03.c
@@ -1,89 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  Ported by Wayne Boyer
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
+ * Ported by Wayne Boyer
  */

-/*
+/*\
+ * [Description]
  * Testcase to check the basic functionality of getgid().
  *
+ * [Algorithm]
  * For functionality test the return value from getgid() is compared to passwd
  * entry.
  */

 #include <pwd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"

-static void cleanup(void);
-static void setup(void);
-
-TCID_DEFINE(getgid03);
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
 	uid_t uid;
 	struct passwd *pwent;

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	TEST(GETGID());
+	if (TST_RET < 0)
+		tst_brk(TBROK, "This should never happen");

-		TEST(GETGID(cleanup));
+	uid = getuid();
+	pwent = getpwuid(uid);
+	if (pwent == NULL)
+		tst_brk(TBROK | TERRNO, "getuid() returned unexpected value %d", uid);

-		if (TEST_RETURN < 0) {
-			tst_brkm(TBROK, cleanup, "This should never happen");
-		}
+	GID16_CHECK(pwent->pw_gid, getgid);

-		uid = getuid();
-		pwent = getpwuid(uid);
-
-		if (pwent == NULL)
-			tst_brkm(TBROK, cleanup, "getuid() returned "
-				 "unexpected value %d", uid);
-
-		GID16_CHECK(pwent->pw_gid, getgid, cleanup);
-
-		if (pwent->pw_gid != TEST_RETURN) {
-			tst_resm(TFAIL, "getgid() return value "
-				 "%ld unexpected - expected %d",
-				 TEST_RETURN, pwent->pw_gid);
-		} else {
-			tst_resm(TPASS, "values from getuid "
-				 "and getpwuid match");
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	if (pwent->pw_gid != TST_RET) {
+		tst_res(TFAIL, "getgid() return value "
+				"%ld unexpected - expected %d",
+				TST_RET, pwent->pw_gid);
+	} else
+		tst_res(TPASS, "values from getuid and getpwuid match");
 }

-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+};
--
2.17.1


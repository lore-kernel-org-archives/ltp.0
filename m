From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sat, 8 May 2021 14:43:51 +0800
Subject: [LTP] [PATCH v2] syscalls/setfsgid02: Rewrite setfsgid02
Message-ID: <20210508064351.10737-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)update to new API
2)rewrite setfsgid02 according man 2

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2:rewrite setfsgid02.c
 .../kernel/syscalls/setfsgid/setfsgid02.c     | 114 ++++++++----------
 1 file changed, 47 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid02.c b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
index 4788957e2..8951ee83f 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid02.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
@@ -1,91 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) International Business Machines  Corp., 2001
  * Ported by Wayne Boyer
  * Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
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
+ * Adapted by Zhao gongyi (zhaogongyi@huawei.com)
  */

-/*
- *     Testcase to check the basic functionality of setfsgid(2) system
- *     call failures.
+/*\
+ * [Description]
+ * Testcase to check the basic functionality of setfsgid(2) system
+ * call failures with priviledged or unpriviledged user.
  */

-#include <stdio.h>
-#include <unistd.h>
-#include <grp.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <errno.h>
-
-#include "test.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"

-TCID_DEFINE(setfsgid02);
-int TST_TOTAL = 1;
+static gid_t gid;
+static gid_t pre_gid;
+static const char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;

-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int lc;
-
-	gid_t gid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		gid = 1;
-		while (getgrgid(gid))
-			gid++;
+	int cnt;

-		GID16_CHECK(gid, setfsgid, cleanup);
+	GID16_CHECK(gid, setfsgid);

-		TEST(SETFSGID(cleanup, gid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				"setfsgid() failed unexpectedly");
-			continue;
-		}
+	if (i == 0) {
+		ltpuser = SAFE_GETPWNAM(nobody_uid);
+		SAFE_SETEUID(ltpuser->pw_uid);
+	}

-		if (TEST_RETURN == gid) {
-			tst_resm(TFAIL, "setfsgid() returned %ld, expected %d",
-				 TEST_RETURN, gid);
-		} else {
-			tst_resm(TPASS, "setfsgid() returned expected value : "
-				 "%ld", TEST_RETURN);
+	/*
+	 * Run SETFSGID() twice to check the second running have changed
+	 * the gid for priviledged user, and have not changed the gid
+	 * for unpriviledged user.
+	 */
+	for (cnt = 0; cnt < 2; cnt++) {
+		TEST(SETFSGID(gid));
+		if (TST_RET != pre_gid)
+			tst_res(TFAIL, "setfsgid() returned %ld", TST_RET);
+		else {
+			tst_res(TPASS,
+				"setfsgid() returned expected value : %ld",
+				TST_RET);
+			if (i == 1) {
+				pre_gid = gid;
+				gid++;
+			}
 		}
 	}

-	cleanup();
-	tst_exit();
+	if (i == 0) {
+		SAFE_SETEUID(0);
+	}
 }

 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	pre_gid = 0;
+	gid = 1;
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.test = run,
+	.tcnt = 2,
+};
--
2.17.1


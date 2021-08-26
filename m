From: Wang Kunfeng <threefifteen.wangkunfeng@huawei.com>
Date: Thu, 26 Aug 2021 17:05:11 +0800
Subject: [LTP] [PATCH] getuid: Convert getuid01 and getuid03 to new API
Message-ID: <20210826090511.106853-1-threefifteen.wangkunfeng@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert getuid01 and getuid03 to new API.

Signed-off-by: Wang Kunfeng <threefifteen.wangkunfeng@huawei.com>
---
 testcases/kernel/syscalls/getuid/getuid01.c | 90 ++++---------------
 testcases/kernel/syscalls/getuid/getuid03.c | 99 ++++++---------------
 2 files changed, 41 insertions(+), 148 deletions(-)

diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
index cf8c77424..d9770c8dd 100644
--- a/testcases/kernel/syscalls/getuid/getuid01.c
+++ b/testcases/kernel/syscalls/getuid/getuid01.c
@@ -1,84 +1,24 @@
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
- */
-/*
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
+ * AUTHOR: William Roske
+ * CO-PILOT: Dave Fenner
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-static void setup(void);
-static void cleanup(void);
-
-TCID_DEFINE(getuid01);
-int TST_TOTAL = 1;

-int main(int ac, char **av)
-{
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
-		TEST(GETUID(cleanup));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "getuid failed");
-		else
-			tst_resm(TPASS, "getuid returned %ld", TEST_RETURN);
-
-	}
+/*\
+ * [Description]
+ *
+ * Basic test for getuid() function.
+ */

-	cleanup();
-	tst_exit();
-}
+#include "tst_test.h"
+#include "compat_tst_16.h"

-static void setup(void)
+static void verify_getuid(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	TST_EXP_POSITIVE(GETUID(), "getuid()");
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_getuid,
+};
diff --git a/testcases/kernel/syscalls/getuid/getuid03.c b/testcases/kernel/syscalls/getuid/getuid03.c
index 7c81c628e..436cfd3bc 100644
--- a/testcases/kernel/syscalls/getuid/getuid03.c
+++ b/testcases/kernel/syscalls/getuid/getuid03.c
@@ -1,88 +1,41 @@
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
- * Testcase to check the basic functionality of the getuid() system call.
+/*\
+ * [Description]
  *
- * For functionality test the return value from getgid() is compared to passwd
- * entry.
+ * Testcase to check the basic functionality of the getuid() and test the
+ * return value from getgid() is compared to passwd entry.
  */

 #include <pwd.h>
 #include <errno.h>

-#include "test.h"
-#include "compat_16.h"
-
-TCID_DEFINE(getuid03);
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
-{
-	struct passwd *pwent;
-	int lc;
-	uid_t uid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+#include "tst_test.h"
+#include "compat_tst_16.h"

-		tst_count = 0;
-
-		TEST(GETUID(cleanup));
-
-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "getuid failed");
-
-		uid = getuid();
-		pwent = getpwuid(uid);
-
-		if (pwent == NULL)
-			tst_resm(TFAIL | TERRNO, "getpwuid failed");
-
-		UID16_CHECK(pwent->pw_uid, getuid, cleanup);
-
-		if (pwent->pw_uid != TEST_RETURN)
-			tst_resm(TFAIL, "getpwuid value, %d, "
-				 "does not match getuid "
-				 "value, %ld", pwent->pw_uid,
-				 TEST_RETURN);
-		else
-			tst_resm(TPASS, "values from getuid "
-				 "and getpwuid match");
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
+static void verify_getuid(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	static struct passwd *pwent;
+
+	TST_EXP_POSITIVE(GETUID(), "getuid()");
+	if (!TST_PASS)
+		return;
+	pwent = getpwuid(TST_RET);
+	if (pwent == NULL)
+		tst_res(TFAIL | TERRNO, "getpwuid failed");
+
+	UID16_CHECK(pwent->pw_uid, getuid);
+	if (pwent->pw_uid != TST_RET)
+		tst_res(TFAIL, "getpwuid value, %d, does not match getuid value, %ld",
+				pwent->pw_uid, TST_RET);
+	else
+		tst_res(TPASS, "values from getuid and getpwuid match");
 }

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_getuid,
+};
--
2.17.1


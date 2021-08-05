From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu,  5 Aug 2021 15:33:39 +0800
Subject: [LTP] [PATCH] [1/4] syscalls/chroot01: Convert to new API
Message-ID: <20210805073339.15027-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/chroot/chroot01.c b/testcases/kernel/syscalls/chroot/chroot01.c
index a1db5e157..37c73c756 100644
--- a/testcases/kernel/syscalls/chroot/chroot01.c
+++ b/testcases/kernel/syscalls/chroot/chroot01.c
@@ -1,116 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
  */

-/*
- * NAME
- * 	chroot01.c
- *
- * DESCRIPTION
- *	Testcase to check the whether chroot sets errno to EPERM.
+/*\
+ * [DESCRIPTION]
  *
- * ALGORITHM
- *	As a non-root user attempt to perform chroot() to a directory. The
- *	chroot() call should fail with EPERM
- *
- * USAGE:  <for command-line>
- *  chroot01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- * 	Must be run as non-root user.
+ * Testcase to check the whether chroot sets errno to EPERM.
+ * As a non-root user attempt to perform chroot() to a directory. The
+ * chroot() call should fail with EPERM
  */

-#include <stdio.h>
-#include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
 #include <pwd.h>
-
-char *TCID = "chroot01";
-int TST_TOTAL = 1;
-int fail;
+#include "tst_test.h"

 char *path;
-
 char nobody_uid[] = "nobody";
 struct passwd *ltpuser;

-void setup(void);
-void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_chroot(void)
 {
-	int lc;
+	TEST(chroot(path));

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(chroot(path));
-
-		if (TEST_RETURN != -1)
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-		else if (errno != EPERM)
-			tst_resm(TFAIL | TTERRNO, "chroot failed unexpectedly");
-		else
-			tst_resm(TPASS, "chroot set errno to EPERM.");
-	}
-	cleanup();
-
-	tst_exit();
+	if (TST_RET != -1)
+		tst_res(TFAIL, "call succeeded unexpectedly");
+	else if (errno != EPERM)
+		tst_res(TFAIL | TTERRNO, "chroot failed unexpectedly");
+	else
+		tst_res(TPASS, "chroot set errno to EPERM.");

 }

-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_tmpdir();
 	path = tst_get_tmpdir();
+	if (path == NULL)
+		tst_brk(TBROK | TERRNO, "tst_get_tmpdir failed");

-	if ((ltpuser = getpwnam(nobody_uid)) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "getpwnam(\"nobody\") failed");
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	if ((ltpuser = SAFE_GETPWNAM(nobody_uid)) == NULL)
+		tst_brk(TBROK | TERRNO, "getpwnam(\"nobody\") failed");

-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_SETEUID(ltpuser->pw_uid);
 }

-void cleanup(void)
+static void cleanup(void)
 {
-	SAFE_SETEUID(NULL, 0);
+	SAFE_SETEUID(0);

-	free(path);
-	tst_rmdir();
+	if (path) {
+		free(path);
+		path = NULL;
+	}
 }
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.setup = setup,
+	.test_all = verify_chroot,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
--
2.20.1




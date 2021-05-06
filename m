From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 21:09:50 +0800
Subject: [LTP] [PATCH 3/3] syscalls/fchown: Convert fchown03 to the new API
In-Reply-To: <20210506130950.110267-1-xieziyao@huawei.com>
References: <20210506130950.110267-1-xieziyao@huawei.com>
Message-ID: <20210506130950.110267-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleanup and convert fchown03 to the new API.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/fchown/fchown03.c | 177 ++++++++------------
 1 file changed, 67 insertions(+), 110 deletions(-)

diff --git a/testcases/kernel/syscalls/fchown/fchown03.c b/testcases/kernel/syscalls/fchown/fchown03.c
index f7fe994fd..a69ec86ae 100644
--- a/testcases/kernel/syscalls/fchown/fchown03.c
+++ b/testcases/kernel/syscalls/fchown/fchown03.c
@@ -1,139 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * 07/2001 Ported by Wayne Boyer
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Verify that, fchown(2) succeeds to change the group of a file specified
+ * by path when called by non-root user with the following constraints:
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * - euid of the process is equal to the owner of the file;
+ * - the intended gid is either egid, or one of the supplementary gids
+ *   of the process.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Description:
- *  Verify that, fchown(2) succeeds to change the group of a file specified
- *  by path when called by non-root user with the following constraints,
- *	- euid of the process is equal to the owner of the file.
- *	- the intended gid is either egid, or one of the supplementary gids
- *	  of the process.
- *  Also, verify that fchown() clears the setuid/setgid bits set on the file.
+ * Also verify that fchown() clears the setuid/setgid bits set on the file.
  */

-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <grp.h>
 #include <pwd.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/types.h>

-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
-
-#define FILE_MODE (mode_t)(S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
-#define NEW_PERMS (mode_t)(S_IFREG | S_IRWXU | S_IRWXG | S_ISUID | S_ISGID)
-#define FCHOWN_PERMS	(mode_t)(NEW_PERMS & ~(S_ISUID | S_ISGID))
-#define TESTFILE	"testfile"
+#include "tst_test.h"
+#include "compat_tst_16.h"

-TCID_DEFINE(fchown03);
-int TST_TOTAL = 1;
+#define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
+#define NEW_PERMS	(S_IFREG|S_IRWXU|S_IRWXG|S_ISUID|S_ISGID)
+#define FILENAME	"fchown03_testfile"

-static int fildes;
-char nobody_uid[] = "nobody";
+static int fd;
 static struct passwd *ltpuser;

-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void check_owner(struct stat *s, uid_t exp_uid, gid_t exp_gid)
 {
-	struct stat stat_buf;
-	int lc;
-	uid_t user_id;
-	gid_t group_id;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		user_id = geteuid();
-		GID16_CHECK((group_id = getegid()), "fchown", cleanup)
-
-		TEST(FCHOWN(cleanup, fildes, -1, group_id));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "fchown() on %s Fails, errno=%d",
-				 TESTFILE, TEST_ERRNO);
-			continue;
-		}
+	if (s->st_uid != exp_uid || s->st_gid != exp_gid)
+		tst_res(TFAIL, "%s: wrong owner set to (uid=%d, gid=%d),"
+			       " expected (uid=%d, gid=%d)",
+			FILENAME, s->st_uid, s->st_gid, exp_uid, exp_gid);
+}

-		SAFE_FSTAT(cleanup, fildes, &stat_buf);
+static void check_mode(struct stat *s, mode_t exp_mode)
+{
+	if (s->st_mode != exp_mode)
+		tst_res(TFAIL, "%s: wrong mode permissions %#o, expected %#o",
+			FILENAME, s->st_mode, exp_mode);
+}

-		if ((stat_buf.st_uid != user_id) ||
-		    (stat_buf.st_gid != group_id)) {
-			tst_resm(TFAIL, "%s: Incorrect "
-				 "ownership set, Expected %d %d",
-				 TESTFILE, user_id, group_id);
-			continue;
-		}
+static void run(void)
+{
+	SAFE_SETEUID(0);
+	SAFE_FCHOWN(fd, -1, 0);
+	SAFE_FCHMOD(fd, NEW_PERMS);
+	SAFE_SETEUID(ltpuser->pw_uid);

-		if (stat_buf.st_mode != FCHOWN_PERMS) {
-			tst_resm(TFAIL, "%s: Incorrect mode permissions"
-				 " %#o, Expected %#o", TESTFILE,
-				 stat_buf.st_mode, FCHOWN_PERMS);
-		} else {
-			tst_resm(TPASS, "fchown() on %s succeeds: "
-				 "Setuid/gid bits cleared", TESTFILE);
-		}
-	}
+	uid_t uid;
+	gid_t gid;
+	UID16_CHECK((uid = geteuid()), "fchown");
+	GID16_CHECK((gid = getegid()), "fchown");

-	cleanup();
-	tst_exit();
+	struct stat stat_buf;
+	SAFE_STAT(FILENAME, &stat_buf);
+	check_owner(&stat_buf, uid, 0);
+	check_mode(&stat_buf, NEW_PERMS);
+
+	TST_EXP_PASS(FCHOWN(fd, -1, gid), "fchown(fd, %d, %d)", -1, gid);
+	SAFE_STAT(FILENAME, &stat_buf);
+	check_owner(&stat_buf, uid, gid);
+	check_mode(&stat_buf, NEW_PERMS & ~(S_ISUID | S_ISGID));
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEGID(ltpuser->pw_gid);
+	SAFE_SETEUID(ltpuser->pw_uid);

-	ltpuser = SAFE_GETPWNAM(cleanup, nobody_uid);
-	SAFE_SETEUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fildes = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-
-	SAFE_SETEUID(cleanup, 0);
-
-	SAFE_FCHOWN(cleanup, fildes, -1, 0);
-	SAFE_FCHMOD(cleanup, fildes, NEW_PERMS);
-
-	SAFE_SETEGID(cleanup, ltpuser->pw_gid);
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	fd = SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, FILE_MODE);
 }

 static void cleanup(void)
 {
-	if (fildes > 0 && close(fildes))
-		tst_resm(TWARN | TERRNO, "close(%s) Failed", TESTFILE);
-
-	tst_rmdir();
+	SAFE_SETEGID(0);
+	SAFE_SETEUID(0);
+	SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
--
2.17.1


From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 21:09:49 +0800
Subject: [LTP] [PATCH 2/3] syscalls/fchown: Convert fchown02 to the new API
In-Reply-To: <20210506130950.110267-1-xieziyao@huawei.com>
References: <20210506130950.110267-1-xieziyao@huawei.com>
Message-ID: <20210506130950.110267-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Cleanup and convert fchown02 to the new API;
2. Remove useless testcase {0, NULL, NULL, 0, 0, 0}.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/fchown/fchown02.c | 175 ++++++--------------
 1 file changed, 52 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/fchown/fchown02.c b/testcases/kernel/syscalls/fchown/fchown02.c
index 0fef74dee..a99962911 100644
--- a/testcases/kernel/syscalls/fchown/fchown02.c
+++ b/testcases/kernel/syscalls/fchown/fchown02.c
@@ -1,158 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * 07/2001 Ported by Wayne Boyer
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
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
- * Test Description:
- *  Verify that, when fchown(2) invoked by super-user to change the owner and
- *  group of a file specified by file descriptor to any numeric
- *  owner(uid)/group(gid) values,
- *	- clears setuid and setgid bits set on an executable file.
- *	- preserves setgid bit set on a non-group-executable file.
+/*\
+ * [Description]
+ *
+ * Verify that fchown(2) invoked by super-user:
+ *  - clears setuid and setgid bits set on an executable file
+ *  - preserves setgid bit set on a non-group-executable file
  */

 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
-
-#define FILE_MODE	S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define NEW_PERMS1	S_IFREG | S_IRWXU | S_IRWXG | S_ISUID | S_ISGID
-#define NEW_PERMS2	S_IFREG | S_IRWXU | S_ISGID
-#define EXP_PERMS	S_IFREG | S_IRWXU | S_IRWXG
+
+#include "tst_test.h"
+#include "compat_tst_16.h"
+#include "tst_safe_macros.h"
+
+#define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
+#define NEW_PERMS1	(S_IFREG|S_IRWXU|S_IRWXG|S_ISUID|S_ISGID)
+#define NEW_PERMS2	(S_IFREG|S_IRWXU|S_ISGID)
+#define EXP_PERMS	(S_IFREG|S_IRWXU|S_IRWXG)
 #define TESTFILE1	"testfile1"
 #define TESTFILE2	"testfile2"

-TCID_DEFINE(fchown02);
-int TST_TOTAL = 2;
-static int fd1;
-static int fd2;
+static int fd1, fd2;

-struct test_case {
+struct test_case_t {
 	int *fd;
-	char *pathname;
-	char *desc;
-	uid_t user_id;
-	gid_t group_id;
-	int test_flag;
+	const char *filename;
+	mode_t set_mode;
+	mode_t exp_mode;
 } tc[] = {
-	{&fd1, TESTFILE1, "Setuid/Setgid bits cleared", 700, 701, 1},
-	{&fd2, TESTFILE2, "Setgid bit not cleared", 700, 701, 2},
-	{0, NULL, NULL, 0, 0, 0}
+	{&fd1, TESTFILE1, NEW_PERMS1, EXP_PERMS},
+	{&fd2, TESTFILE2, NEW_PERMS2, NEW_PERMS2}
 };

-static void setup(void);
-static void cleanup(void);
-
-static void verify_fchown(struct test_case *t)
+static void run(unsigned int i)
 {
-	struct stat stat_buf;
+	uid_t uid;
+	gid_t gid;

-	TEST(FCHOWN(cleanup, *t->fd, t->user_id, t->group_id));
-
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "fchown() Fails on %s", t->pathname);
-		return;
-	}
-
-	SAFE_FSTAT(cleanup, *t->fd, &stat_buf);
-
-	if ((stat_buf.st_uid != t->user_id) ||
-	    (stat_buf.st_gid != t->group_id)) {
-		tst_resm(TFAIL,
-		         "%s: Incorrect ownership expected %d %d, have %d %d",
-		         t->pathname, t->user_id, t->group_id,
-		         stat_buf.st_uid, stat_buf.st_gid);
-	}
-
-	switch (t->test_flag) {
-	case 1:
-		if (((stat_buf.st_mode & (S_ISUID | S_ISGID)))) {
-			tst_resm(TFAIL, "%s: Incorrect mode "
-					"permissions %#o, Expected "
-					"%#o", t->pathname, NEW_PERMS1,
-					 EXP_PERMS);
-			return;
-		}
-	break;
-	case 2:
-		if ((!(stat_buf.st_mode & S_ISGID))) {
-			tst_resm(TFAIL,
-				 "%s: Incorrect mode "
-				 "permissions %#o, Expected "
-				 "%#o", t->pathname,
-				 stat_buf.st_mode, NEW_PERMS2);
-			return;
-		}
-	break;
-	}
-
-	tst_resm(TPASS, "fchown() on %s succeeds : %s", t->pathname, t->desc);
-}
+	UID16_CHECK((uid = geteuid()), "fchown");
+	GID16_CHECK((gid = getegid()), "fchown");

-int main(int ac, char **av)
-{
-	int lc, i;
+	SAFE_CHMOD(tc[i].filename, tc[i].set_mode);

-	tst_parse_opts(ac, av, NULL, NULL);
+	TST_EXP_PASS(FCHOWN(*tc[i].fd, uid, gid));

-	setup();
+	struct stat stat_buf;
+	SAFE_STAT(tc[i].filename, &stat_buf);

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; tc[i].desc != NULL; i++)
-			verify_fchown(tc + i);
-	}
+	if (stat_buf.st_uid != uid || stat_buf.st_gid != gid)
+		tst_res(TFAIL, "%s: owner set to (uid=%d, gid=%d), expected (uid=%d, gid=%d)",
+			tc[i].filename, stat_buf.st_uid, stat_buf.st_gid, uid, gid);

-	cleanup();
-	tst_exit();
+	if (stat_buf.st_mode != tc[i].exp_mode)
+		tst_res(TFAIL, "%s: wrong mode permissions %#o, expected %#o",
+			tc[i].filename, stat_buf.st_mode, tc[i].exp_mode);
 }

 static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd1 = SAFE_OPEN(cleanup, TESTFILE1, O_RDWR | O_CREAT, FILE_MODE);
-	SAFE_CHMOD(cleanup, TESTFILE1, NEW_PERMS1);
-	fd2 = SAFE_OPEN(cleanup, TESTFILE2, O_RDWR | O_CREAT, FILE_MODE);
-	SAFE_CHMOD(cleanup, TESTFILE2, NEW_PERMS2);
+	for (unsigned int i = 0; i < ARRAY_SIZE(tc); ++i)
+		*tc[i].fd = SAFE_OPEN(tc[i].filename, O_RDWR | O_CREAT, FILE_MODE);
 }

 static void cleanup(void)
 {
-	if (fd1 > 0 && close(fd1))
-		tst_resm(TWARN | TERRNO, "Failed to close fd1");
-
-	if (fd2 > 0 && close(fd2))
-		tst_resm(TWARN | TERRNO, "Failed to close fd2");
-
-	tst_rmdir();
+	for (unsigned int i = 0; i < ARRAY_SIZE(tc); ++i)
+		SAFE_CLOSE(*tc[i].fd);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+};
--
2.17.1


From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 4 Jul 2018 16:00:52 +0800
Subject: [LTP] [PATCH] syscalls/open11.c: Fix the failure of opening device
	special file
Message-ID: <1530691252-12500-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) If temporary directory(TMPDIR/TEMPDIR) is on the mountpoint which
   is mounted with nodev option(or temporary directory is mounted with
   with nodev option directly), open(2) has no permission to open device
   special file in the temporary directory and failed as expected.  as below:
   --------------------------------------------------------------------------
   open11.c:351: Open device special file O_RDONLY - expected errno 0 - Got: TEST_ERRNO=EACCES(13): Permission denied
   open11.c:351: Open device special file O_WRONLY - expected errno 0 - Got: TEST_ERRNO=EACCES(13): Permission denied
   open11.c:351: Open device special file O_RDWR - expected errno 0 - Got: TEST_ERRNO=EACCES(13): Permission denied
   --------------------------------------------------------------------------
   We try to fix this issue by creating device special file in /dev/ instead.

2) Cleanup && Convert to new API.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/open/open11.c | 165 +++++++++-----------------------
 1 file changed, 45 insertions(+), 120 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 78002f3..c540eb8 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -1,28 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2013 Red Hat, Inc.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-/*
  * Basic tests for open(2) and make sure open(2) works and handles error
  * conditions correctly.
  *
@@ -60,25 +39,15 @@
  */
 
 #define _GNU_SOURCE
-#include "config.h"
+#include <errno.h>
+#include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/sysmacros.h>
-#include <sys/wait.h>
-#include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include "test.h"
-#include "safe_macros.h"
 
-char *TCID = "open11";
+#include "tst_test.h"
 
-/* Define test files */
 #define T_REG "t_reg"			/* regular file with content */
 #define T_REG_EMPTY "t_reg_empty"	/* empty regular file */
 #define T_LINK_REG "t_link_reg"		/* hard link to T_REG */
@@ -86,24 +55,18 @@ char *TCID = "open11";
 #define T_SYMLINK_REG "t_symlink_reg"	/* symlink to T_REG */
 #define T_DIR "t_dir"			/* test dir */
 #define T_SYMLINK_DIR "t_symlink_dir"	/* symlink to T_DIR */
-#define T_DEV "t_dev"			/* test device special file */
+#define T_DEV "/dev/t_dev"		/* test device special file */
 
 #define T_MSG "this is a test string"
 
-static void setup(void);
-static void cleanup(void);
-
-struct test_case {
+static struct test_case {
 	char *desc;
 	char *path;
 	int flags;
 	mode_t mode;
 	int err;
-};
-struct test_case tc[] = {
-	/*
-	 * Test open(2) regular file
-	 */
+} tc[] = {
+	/* Test open(2) regular file */
 	{	/* open regular file O_RDONLY */
 		.desc = "Open regular file O_RDONLY",
 		.path = T_REG_EMPTY,
@@ -139,9 +102,7 @@ struct test_case tc[] = {
 		.mode = 0644,
 		.err = 0,
 	},
-	/*
-	 * Test open(2) directory
-	 */
+	/* Test open(2) directory */
 	{	/* open dir O_RDONLY */
 		.desc = "Open dir O_RDONLY",
 		.path = T_DIR,
@@ -163,9 +124,7 @@ struct test_case tc[] = {
 		.mode = 0644,
 		.err = ENOTDIR,
 	},
-	/*
-	 * Test open(2) hard link
-	 */
+	/* Test open(2) hard link */
 	{	/* open hard link file O_RDONLY */
 		.desc = "Open hard link file O_RDONLY",
 		.path = T_LINK_REG,
@@ -187,9 +146,7 @@ struct test_case tc[] = {
 		.mode = 0644,
 		.err = 0,
 	},
-	/*
-	 * Test open(2) sym link
-	 */
+	/* Test open(2) sym link */
 	{	/* open sym link file O_RDONLY */
 		.desc = "Open sym link file O_RDONLY",
 		.path = T_SYMLINK_REG,
@@ -232,9 +189,7 @@ struct test_case tc[] = {
 		.mode = 0644,
 		.err = EISDIR,
 	},
-	/*
-	 * Test open(2) device special
-	 */
+	/* * Test open(2) device special */
 	{	/* open device special file O_RDONLY */
 		.desc = "Open device special file O_RDONLY",
 		.path = T_DEV,
@@ -256,9 +211,7 @@ struct test_case tc[] = {
 		.mode = 0644,
 		.err = 0,
 	},
-	/*
-	 * Test open(2) non-existing file
-	 */
+	/* * Test open(2) non-existing file */
 	{	/* open non-existing regular file in existing dir */
 		.desc = "Open non-existing regular file in existing dir",
 		.path = T_DIR"/"T_NEW_REG,
@@ -266,9 +219,7 @@ struct test_case tc[] = {
 		.mode = 0644,
 		.err = 0,
 	},
-	/*
-	 * test open(2) with O_CREAT
-	 */
+	/* test open(2) with O_CREAT */
 	{	/* open hard link file O_RDONLY | O_CREAT */
 		.desc = "Open link file O_RDONLY | O_CREAT",
 		.path = T_LINK_REG,
@@ -304,9 +255,7 @@ struct test_case tc[] = {
 		.mode = 0644,
 		.err = EISDIR,
 	},
-	/*
-	 * Other random open(2) tests
-	 */
+	/* Other random open(2) tests */
 	{	/* open regular file O_RDONLY | O_TRUNC */
 		.desc = "Open regular file O_RDONLY | O_TRUNC, "
 			"behaviour is undefined but should not oops or hang",
@@ -325,42 +274,22 @@ struct test_case tc[] = {
 	},
 };
 
-int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
-
-int main(int argc, char *argv[])
+static void verify_open(unsigned int n)
 {
-	int lc;
-	int i;
 	int fd;
-	int ret;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	TEST(open(tc[n].path, tc[n].flags, tc[n].mode));
+	fd = TEST_RETURN;
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(open(tc[i].path, tc[i].flags, tc[i].mode));
-			fd = TEST_RETURN;
-
-			if (tc[i].err == -1 || TEST_ERRNO == tc[i].err) {
-				tst_resm(TPASS, "%s", tc[i].desc);
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "%s - expected errno %d - Got",
-					 tc[i].desc, tc[i].err);
-			}
-			if (fd > 0) {
-				ret = close(fd);
-				if (ret < 0)
-					tst_resm(TWARN, "%s - close failed: %s",
-						 tc[i].desc, strerror(errno));
-			}
-		}
+	if (tc[n].err == -1 || TEST_ERRNO == tc[n].err) {
+		tst_res(TPASS, "%s", tc[n].desc);
+	} else {
+		tst_res(TFAIL | TTERRNO, "%s - expected errno %d - Got",
+			tc[n].desc, tc[n].err);
 	}
 
-	cleanup();
-	tst_exit();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static void setup(void)
@@ -368,36 +297,32 @@ static void setup(void)
 	int fd;
 	int ret;
 
-	tst_require_root();
-
-	tst_tmpdir();
-
-	/* Create test files */
-	fd = SAFE_OPEN(cleanup, T_REG, O_WRONLY | O_CREAT, 0644);
+	fd = SAFE_OPEN(T_REG, O_WRONLY | O_CREAT, 0644);
 	ret = write(fd, T_MSG, sizeof(T_MSG));
 	if (ret == -1) {
-		close(fd);
-		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", T_REG);
+		SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "Write %s failed", T_REG);
 	}
-	close(fd);
-
-	fd = SAFE_CREAT(cleanup, T_REG_EMPTY, 0644);
-	close(fd);
-
-	SAFE_LINK(cleanup, T_REG, T_LINK_REG);
-	SAFE_SYMLINK(cleanup, T_REG, T_SYMLINK_REG);
-	SAFE_MKDIR(cleanup, T_DIR, 0755);
-	SAFE_SYMLINK(cleanup, T_DIR, T_SYMLINK_DIR);
+	SAFE_CLOSE(fd);
 
-	ret = mknod(T_DEV, S_IFCHR, makedev(1, 5));
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create char dev %s failed",
-			 T_DEV);
-
-	TEST_PAUSE;
+	SAFE_TOUCH(T_REG_EMPTY, 0644, NULL);
+	SAFE_LINK(T_REG, T_LINK_REG);
+	SAFE_SYMLINK(T_REG, T_SYMLINK_REG);
+	SAFE_MKDIR(T_DIR, 0755);
+	SAFE_SYMLINK(T_DIR, T_SYMLINK_DIR);
+	SAFE_MKNOD(T_DEV, S_IFCHR, makedev(1, 5));
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	if (!access(T_DEV, F_OK))
+		SAFE_UNLINK(T_DEV);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_open,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1




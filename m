From: Sandeep Patil <sspatil@android.com>
Date: Mon, 25 Mar 2019 16:20:12 -0700
Subject: [LTP] [PATCH 4/4] syscalls/acct01: convert to new library
In-Reply-To: <20190325232012.67123-1-sspatil@android.com>
References: <20190325232012.67123-1-sspatil@android.com>
Message-ID: <20190325232012.67123-5-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use pre-created files provided by the library instead of creating
them by hand in the setup() routine.

Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 testcases/kernel/syscalls/acct/acct01.c | 207 +++++++-----------------
 1 file changed, 62 insertions(+), 145 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index eb104315b..b2bde13ed 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -1,31 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
- *
  *  Copyright (c) International Business Machines  Corp., 2002
- *
- *  This program is free software;  you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *  the GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program;  if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /* 12/03/2002	Port to LTP     robbiew@us.ibm.com */
 /* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
 
-/*
- * ALGORITHM
- *	issue calls to acct and test the returned values against
- *	expected results
- */
-
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
@@ -36,8 +17,7 @@
 #include <unistd.h>
 #include <sys/mount.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
@@ -48,169 +28,106 @@
 #define TEST_FILE5	"./tmpfile"
 #define TEST_FILE6	"test_file_eloop1"
 #define TEST_FILE7	nametoolong
-#define TEST_FILE8	"mntpoint/tmp"
+#define TEST_FILE8	"mntpoint/file"
 
 static char nametoolong[PATH_MAX+2];
-static const char *fs_type;
-static const char *device;
-static int mount_flag;
+static struct passwd *ltpuser;
 
-static void setup(void);
-static void cleanup(void);
-static void setup2(void);
-static void cleanup2(void);
-static void acct_verify(int);
+static void setup_euid(void)
+{
+	SAFE_SETEUID(ltpuser->pw_uid);
+}
 
-static struct test_case_t {
+static void cleanup_euid(void)
+{
+	SAFE_SETEUID(0);
+}
+
+static struct test_case {
 	char *filename;
 	char *exp_errval;
 	int exp_errno;
 	void (*setupfunc) ();
 	void (*cleanfunc) ();
-} test_cases[] = {
+} tcases[] = {
 	{TEST_FILE1, "EISDIR",  EISDIR,  NULL,   NULL},
 	{TEST_FILE2, "EACCES",  EACCES,  NULL,   NULL},
 	{TEST_FILE3, "ENOENT",  ENOENT,  NULL,   NULL},
 	{TEST_FILE4, "ENOTDIR", ENOTDIR, NULL,   NULL},
-	{TEST_FILE5, "EPERM",   EPERM,   setup2, cleanup2},
-	{NULL,       "EPERM",   EPERM,   setup2, cleanup2},
+	{TEST_FILE5, "EPERM",   EPERM,   setup_euid, cleanup_euid},
+	{NULL,       "EPERM",   EPERM,   setup_euid, cleanup_euid},
 	{TEST_FILE6, "ELOOP",        ELOOP,        NULL, NULL},
 	{TEST_FILE7, "ENAMETOOLONG", ENAMETOOLONG, NULL, NULL},
 	{TEST_FILE8, "EROFS",        EROFS,        NULL, NULL},
 };
 
-char *TCID = "acct01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static struct passwd *ltpuser;
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			acct_verify(i);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void check_acct_in_kernel(void)
-{
-	/* check if acct is implemented in kernel */
-	if (acct(NULL) == -1) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF,
-				 NULL, "BSD process accounting is not configured in "
-				 "this kernel");
-		}
-	}
-}
-
 static void setup(void)
 {
 	int fd;
 
-	tst_require_root();
-
-	check_acct_in_kernel();
-
-	tst_tmpdir();
+	TEST(acct(NULL));
+	if (TST_RET == -1 && TST_ERR == ENOSYS)
+		tst_brk(TCONF, "acct() system call isn't configured in kernel");
 
-	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+	ltpuser = SAFE_GETPWNAM("nobody");
 
-	fd = SAFE_CREAT(cleanup, TEST_FILE5, 0777);
-	SAFE_CLOSE(cleanup, fd);
+	fd = SAFE_CREAT(TEST_FILE5, 0777);
+	SAFE_CLOSE(fd);
 
-	if (acct(TEST_FILE5) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
+	TEST(acct(TEST_FILE5));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "acct failed unexpectedly");
 
 	/* turn off acct, so we are in a known state */
-	if (acct(NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "acct(NULL) failed");
+	TEST(acct(NULL));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "acct(NULL) failed");
 
 	/* ELOOP SETTING */
-	SAFE_SYMLINK(cleanup, TEST_FILE6, "test_file_eloop2");
-	SAFE_SYMLINK(cleanup, "test_file_eloop2", TEST_FILE6);
+	SAFE_SYMLINK(TEST_FILE6, "test_file_eloop2");
+	SAFE_SYMLINK("test_file_eloop2", TEST_FILE6);
 
 	/* ENAMETOOLONG SETTING */
 	memset(nametoolong, 'a', PATH_MAX+1);
-
-	/* EROFS SETTING */
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, 0, NULL);
-	mount_flag = 1;
-
-	/* Create a file in the file system, then remount it as read-only */
-	fd = SAFE_CREAT(cleanup, TEST_FILE8, 0644);
-	SAFE_CLOSE(cleanup, fd);
-	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type,
-		   MS_REMOUNT | MS_RDONLY, NULL);
 }
 
-static void acct_verify(int i)
+static void cleanup(void)
 {
-
-	if (test_cases[i].setupfunc)
-		test_cases[i].setupfunc();
-
-	TEST(acct(test_cases[i].filename));
-
-	if (test_cases[i].cleanfunc)
-		test_cases[i].cleanfunc();
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "acct(%s) succeeded unexpectedly",
-			 test_cases[i].filename);
-		return;
-	}
-
-	if (TEST_ERRNO == test_cases[i].exp_errno) {
-		tst_resm(TPASS | TTERRNO, "acct failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "acct failed unexpectedly; expected: %d - %s",
-			 test_cases[i].exp_errno,
-			 strerror(test_cases[i].exp_errno));
-	}
+	SAFE_UNLINK(TEST_FILE5);
+	SAFE_UNLINK(TEST_FILE6);
 }
 
-static void setup2(void)
+static void verify_acct(unsigned int nr)
 {
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-}
+	struct test_case *tcase = &tcases[nr];
 
-static void cleanup2(void)
-{
-	SAFE_SETEUID(cleanup, 0);
-}
+	if (tcase->setupfunc)
+		tcase->setupfunc();
 
-static void cleanup(void)
-{
-	if (acct(NULL) == -1)
-		tst_resm(TWARN | TERRNO, "acct(NULL) failed");
+	TEST(acct(tcase->filename));
 
-	if (mount_flag && tst_umount("mntpoint") < 0) {
-		tst_resm(TWARN | TERRNO,
-			 "umount device:%s failed", device);
-	}
+	if (tcase->cleanfunc)
+		tcase->cleanfunc();
 
-	if (device)
-		tst_release_device(device);
+	if (TST_RET != -1)
+		tst_res(TFAIL, "acct(%s) succeeded unexpectedly",
+				tcase->filename);
 
-	tst_rmdir();
+	if (TST_ERR == tcase->exp_errno)
+		tst_res(TPASS | TTERRNO, "acct() failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO,
+				"acct() failed, expected: %d - %s",
+				tcase->exp_errno, strerror(tcase->exp_errno));
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = "mntpoint",
+	.needs_rofs = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_acct,
+};
-- 
2.21.0.392.gf8f6787159e-goog


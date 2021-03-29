From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 29 Mar 2021 20:47:05 +0800
Subject: [LTP] [PATCH 1/3] syscalls/chown: rewrite chown/chown04.c with the
 new api
In-Reply-To: <20210329124707.117102-1-xieziyao@huawei.com>
References: <20210329124707.117102-1-xieziyao@huawei.com>
Message-ID: <20210329124707.117102-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- rewrite chown/chown04.c with the new api;
- add MAP_PRIVATE_EXCEPT_UCLINUX to SAFE_MMAP() for uClinux systems:
  mmap() doesn't support MAP_PRIVATE on uClinux systems, so use
  MAP_PRIVATE_EXCEPT_UCLINUX instead, which will skip the option on uClinux.
  If MAP_PRIVATE really is required, the test can not be run on uClinux.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 include/tst_safe_macros.h                 |  12 ++
 testcases/kernel/syscalls/chown/chown04.c | 207 ++++++++--------------
 2 files changed, 85 insertions(+), 134 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 2a2b0088a..84849f62a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -240,6 +240,18 @@ static inline void *safe_mmap(const char *file, const int lineno,

 	return rval;
 }
+
+/*
+ * mmap() doesn't support MAP_PRIVATE on uClinux systems, so use
+ * MAP_PRIVATE_EXCEPT_UCLINUX instead, which will skip the option on uClinux.
+ * If MAP_PRIVATE really is required, the test can not be run on uClinux.
+ */
+#ifdef UCLINUX
+# define MAP_PRIVATE_EXCEPT_UCLINUX	0
+#else
+# define MAP_PRIVATE_EXCEPT_UCLINUX	MAP_PRIVATE
+#endif
+
 #define SAFE_MMAP(addr, length, prot, flags, fd, offset) \
 	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
 	(flags), (fd), (offset))
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 1f3ed412b..a1a7f269a 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -1,41 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ *   07/2001 Ported by Wayne Boyer
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */

-/*
- * Test Name: chown04
+/*\
+ * [Description]
  *
- * Test Description:
- *   Verify that,
- *   1) chown(2) returns -1 and sets errno to EPERM if the effective user id
- *		 of process does not match the owner of the file and the process
- *		 is not super user.
- *   2) chown(2) returns -1 and sets errno to EACCES if search permission is
- *		 denied on a component of the path prefix.
- *   3) chown(2) returns -1 and sets errno to EFAULT if pathname points
- *		 outside user's accessible address space.
- *   4) chown(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
- *		 component is too long.
- *   5) chown(2) returns -1 and sets errno to ENOTDIR if the directory
- *		 component in pathname is not a directory.
- *   6) chown(2) returns -1 and sets errno to ENOENT if the specified file
- *		 does not exists.
+ * Verify that,
+ * 1) chown(2) returns -1 and sets errno to EPERM if the effective user id
+ *    of process does not match the owner of the file and the process is not
+ *    super user.
+ * 2) chown(2) returns -1 and sets errno to EACCES if search permission is
+ *    denied on a component of the path prefix.
+ * 3) chown(2) returns -1 and sets errno to EFAULT if pathname points outside
+ *    user's accessible address space.
+ * 4) chown(2) returns -1 and sets errno to ENAMETOOLONG if the pathname
+ *    component is too long.
+ * 5) chown(2) returns -1 and sets errno to ENOTDIR if the directory component
+ *    in pathname is not a directory.
+ * 6) chown(2) returns -1 and sets errno to ENOENT if the specified file does
+ *    not exists.
  */

 #include <stdio.h>
@@ -52,24 +38,24 @@
 #include <sys/mman.h>
 #include <sys/mount.h>

-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
-
-#define MODE_RWX		 (S_IRWXU|S_IRWXG|S_IRWXO)
-#define FILE_MODE		 (S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
-#define DIR_MODE		 (S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
-				 S_IXGRP|S_IROTH|S_IXOTH)
-#define DIR_TEMP		 "testdir_1"
-#define TEST_FILE1		 "tfile_1"
-#define TEST_FILE2		 (DIR_TEMP "/tfile_2")
-#define TEST_FILE3		 "t_file/tfile_3"
-#define TEST_FILE4		 "test_eloop1"
-#define TEST_FILE5		 "mntpoint"
-
-static char long_path[PATH_MAX + 2];
-static const char *device;
-static int mount_flag;
+#include "tst_test.h"
+#include "compat_tst_16.h"
+#include "tst_safe_macros.h"
+
+#define MNT_POINT "mntpoint"
+#define MODE_RWX		(S_IRWXU|S_IRWXG|S_IRWXO)
+#define FILE_MODE		(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
+#define DIR_MODE		(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+				S_IXGRP|S_IROTH|S_IXOTH)
+
+#define DIR_TEMP		"testdir_1"
+#define TEST_FILE1		"tfile_1"
+#define TEST_FILE2		(DIR_TEMP "/tfile_2")
+#define TEST_FILE3		"t_file/tfile_3"
+#define TEST_FILE4		"test_eloop1"
+#define TEST_FILE5		"mntpoint"
+
+static char long_path[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};

 static struct test_case_t {
 	char *pathname;
@@ -85,111 +71,64 @@ static struct test_case_t {
 	{TEST_FILE5, EROFS}
 };

-TCID_DEFINE(chown04);
-int TST_TOTAL = ARRAY_SIZE(tc);
-
 static char *bad_addr;

-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int lc;
-	int i;
 	uid_t user_id;
 	gid_t group_id;

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	UID16_CHECK((user_id = geteuid()), "chown", cleanup)
-	GID16_CHECK((group_id = getegid()), "chown", cleanup)
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(CHOWN(cleanup, tc[i].pathname, user_id, group_id));
+	UID16_CHECK((user_id = geteuid()), "chown");
+	GID16_CHECK((group_id = getegid()), "chown");

-			if (TEST_RETURN == 0) {
-				tst_resm(TFAIL, "chown succeeded unexpectedly");
-				continue;
-			}
+	TEST(CHOWN(tc[i].pathname, user_id, group_id));
+	if (TST_RET == 0)
+		tst_res(TFAIL, "chown succeeded unexpectedly");

-			if (TEST_ERRNO == tc[i].exp_errno) {
-				tst_resm(TPASS | TTERRNO, "chown failed");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "chown failed; expected: %d - %s",
-					 tc[i].exp_errno,
-					 tst_strerrno(tc[i].exp_errno));
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	if (TST_ERR == tc[i].exp_errno)
+		tst_res(TPASS | TTERRNO, "chown failed");
+	else
+		tst_res(TFAIL | TTERRNO,
+			"chown failed; expected: %d - %s",
+			tc[i].exp_errno,
+			tst_strerrno(tc[i].exp_errno));
 }

 static void setup(void)
 {
 	struct passwd *ltpuser;
-	const char *fs_type;
-
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	ltpuser = SAFE_GETPWNAM(NULL, "nobody");
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM("nobody");

-	memset(long_path, 'a', PATH_MAX - 1);
-
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
+	bad_addr = SAFE_MMAP(0, 1, PROT_NONE,
+			     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS,
+			     0, 0);

 	tc[2].pathname = bad_addr;

-	SAFE_SYMLINK(cleanup, "test_eloop1", "test_eloop2");
-	SAFE_SYMLINK(cleanup, "test_eloop2", "test_eloop1");
-
-	SAFE_SETEUID(cleanup, 0);
-	SAFE_TOUCH(cleanup, "t_file", MODE_RWX, NULL);
-	SAFE_TOUCH(cleanup, TEST_FILE1, 0666, NULL);
-	SAFE_MKDIR(cleanup, DIR_TEMP, S_IRWXU);
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
+	SAFE_SYMLINK("test_eloop1", "test_eloop2");
+	SAFE_SYMLINK("test_eloop2", "test_eloop1");

-	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, MS_RDONLY, NULL);
-	mount_flag = 1;
+	SAFE_SETEUID(0);
+	SAFE_TOUCH("t_file", MODE_RWX, NULL);
+	SAFE_TOUCH(TEST_FILE1, 0666, NULL);
+	SAFE_MKDIR(DIR_TEMP, S_IRWXU);
+	SAFE_TOUCH(TEST_FILE2, 0666, NULL);

-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	SAFE_SETEUID(ltpuser->pw_uid);
 }

-void cleanup(void)
+static void cleanup(void)
 {
-	if (seteuid(0) == -1)
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
-
-	if (mount_flag && tst_umount("mntpoint") < 0) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "umount device:%s failed", device);
-	}
+    SAFE_SETEUID(0);
+}

-	if (device)
-		tst_release_device(device);
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+};

-	tst_rmdir();
-}
--
2.17.1


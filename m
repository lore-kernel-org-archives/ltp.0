From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 31 May 2021 19:49:35 +0800
Subject: [LTP] [PATCH v5] syscalls/chown: Rewrite chown/chown04.c with the
 new api
Message-ID: <20210531114935.26000-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rewrite chown/chown04.c with the new api.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v4->v5:
1. Add a copyright for this modification.
2. Change chown(2) to chown() in [Description].

 testcases/kernel/syscalls/chown/chown04.c | 229 +++++++---------------
 1 file changed, 73 insertions(+), 156 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 1f3ed412b..69a0dee09 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -1,75 +1,55 @@
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
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
+ * Verify that:
+ *
+ * 1. Chown() returns -1 and sets errno to EPERM if the effective user id
+ *    of process does not match the owner of the file and the process is not
+ *    super user.
+ * 2. Chown() returns -1 and sets errno to EACCES if search permission is
+ *    denied on a component of the path prefix.
+ * 3. Chown() returns -1 and sets errno to EFAULT if pathname points outside
+ *    user's accessible address space.
+ * 4. Chown() returns -1 and sets errno to ENAMETOOLONG if the pathname
+ *    component is too long.
+ * 5. Chown() returns -1 and sets errno to ENOENT if the specified file does
+ *    not exists.
+ * 6. Chown() returns -1 and sets errno to ENOTDIR if the directory component
+ *    in pathname is not a directory.
+ * 7. Chown() returns -1 and sets errno to ELOOP if too many symbolic links
+ *    were encountered in resolving pathname.
+ * 8. Chown() returns -1 and sets errno to EROFS if the named file resides on
+ *    a read-only filesystem.
  */

-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <grp.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-
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
+
+#include "tst_test.h"
+#include "compat_tst_16.h"
+#include "tst_safe_macros.h"
+
+#define MODE 0666
+#define MODE_RWX	(S_IRWXU|S_IRWXG|S_IRWXO)
+#define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH)
+
+#define MNT_POINT	"mntpoint"
+#define DIR_TEMP	"testdir_1"
+#define TEST_FILE1	"tfile_1"
+#define TEST_FILE2	"testdir_1/tfile_2"
+#define TEST_FILE3	"t_file/tfile_3"
+#define TEST_FILE4	"test_eloop1"
+#define TEST_FILE5	"mntpoint"
+
+static char long_path[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};

 static struct test_case_t {
 	char *pathname;
@@ -85,111 +65,48 @@ static struct test_case_t {
 	{TEST_FILE5, EROFS}
 };

-TCID_DEFINE(chown04);
-int TST_TOTAL = ARRAY_SIZE(tc);
-
-static char *bad_addr;
+static void run(unsigned int i)
+{
+	uid_t uid;
+	gid_t gid;

-static void setup(void);
-static void cleanup(void);
+	UID16_CHECK((uid = geteuid()), "chown");
+	GID16_CHECK((gid = getegid()), "chown");

-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-	uid_t user_id;
-	gid_t group_id;
-
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
-
-			if (TEST_RETURN == 0) {
-				tst_resm(TFAIL, "chown succeeded unexpectedly");
-				continue;
-			}
-
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
+	TST_EXP_FAIL(CHOWN(tc[i].pathname, uid, gid), tc[i].exp_errno);
 }

 static void setup(void)
 {
 	struct passwd *ltpuser;
-	const char *fs_type;
-
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	ltpuser = SAFE_GETPWNAM(NULL, "nobody");

-	tst_tmpdir();
+	tc[2].pathname = SAFE_MMAP(0, 1, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS,
+				   0, 0);

-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	SAFE_SYMLINK("test_eloop1", "test_eloop2");
+	SAFE_SYMLINK("test_eloop2", "test_eloop1");

-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+	SAFE_SETEUID(0);
+	SAFE_TOUCH("t_file", MODE_RWX, NULL);
+	SAFE_TOUCH(TEST_FILE1, MODE, NULL);
+	SAFE_MKDIR(DIR_TEMP, S_IRWXU);
+	SAFE_TOUCH(TEST_FILE2, MODE, NULL);

-	TEST_PAUSE;
-
-	memset(long_path, 'a', PATH_MAX - 1);
-
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-
-	tc[2].pathname = bad_addr;
-
-	SAFE_SYMLINK(cleanup, "test_eloop1", "test_eloop2");
-	SAFE_SYMLINK(cleanup, "test_eloop2", "test_eloop1");
-
-	SAFE_SETEUID(cleanup, 0);
-	SAFE_TOUCH(cleanup, "t_file", MODE_RWX, NULL);
-	SAFE_TOUCH(cleanup, TEST_FILE1, 0666, NULL);
-	SAFE_MKDIR(cleanup, DIR_TEMP, S_IRWXU);
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
-
-	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, MS_RDONLY, NULL);
-	mount_flag = 1;
-
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+	ltpuser = SAFE_GETPWNAM("nobody");
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
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
+	SAFE_SETEUID(0);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
--
2.17.1


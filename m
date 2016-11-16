From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 16 Nov 2016 10:41:03 +0800
Subject: [LTP] [PATCH v4] syscalls/access04: Convert to new API && Rename
In-Reply-To: <1478146654-10284-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1478146654-10284-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1479264063-13784-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert access06 to new API and merge it into access05,
then rename the new access05 to access04.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   3 +-
 runtest/stress.part3                        |   3 +-
 runtest/syscalls                            |   3 +-
 testcases/kernel/syscalls/.gitignore        |   3 +-
 testcases/kernel/syscalls/access/access04.c | 146 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/access/access05.c | 126 -----------------------
 testcases/kernel/syscalls/access/access06.c | 148 ----------------------------
 7 files changed, 150 insertions(+), 282 deletions(-)
 create mode 100644 testcases/kernel/syscalls/access/access04.c
 delete mode 100644 testcases/kernel/syscalls/access/access05.c
 delete mode 100644 testcases/kernel/syscalls/access/access06.c

diff --git a/runtest/ltplite b/runtest/ltplite
index a05d3ed..1c5ffd0 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -64,8 +64,7 @@ accept01 accept01
 access01 access01
 access02 access02
 access03 access03
-access05 access05
-access06 access06
+access04 access04
 
 acct01 acct01
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 274c8a4..7e43124 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -6,8 +6,7 @@ accept01 accept01
 access01 access01
 access02 access02
 access03 access03
-access05 access05
-access06 access06
+access04 access04
 
 acct01 acct01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 2f2dde5..dada427 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -7,8 +7,7 @@ accept4_01 accept4_01
 access01 access01
 access02 access02
 access03 access03
-access05 access05
-access06 access06
+access04 access04
 
 acct01 acct01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 348c235..531779d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -4,8 +4,7 @@
 /access/access01
 /access/access02
 /access/access03
-/access/access05
-/access/access06
+/access/access04
 /acct/acct01
 /add_key/add_key01
 /add_key/add_key02
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
new file mode 100644
index 0000000..f43c38c
--- /dev/null
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Fujitsu Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Verify that,
+ *  1) access() fails with -1 return value and sets errno to EINVAL
+ *     if the specified access mode argument is invalid.
+ *  2) access() fails with -1 return value and sets errno to ENOENT
+ *     if the specified file doesn't exist (or pathname is NULL).
+ *  3) access() fails with -1 return value and sets errno to ENAMETOOLONG
+ *     if the pathname size is > PATH_MAX characters.
+ *  4) access() fails with -1 return value and sets errno to ENOTDIR
+ *     if a component used as a directory in pathname is not a directory.
+ *  5) access() fails with -1 return value and sets errno to ELOOP
+ *     if too many symbolic links were encountered in resolving pathname.
+ *  6) access() fails with -1 return value and sets errno to EROFS
+ *     if write permission was requested for files on a read-only file system.
+ *
+ *  07/2001 Ported by Wayne Boyer
+ *  11/2013 Ported by Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ */
+
+#include <errno.h>
+#include <pwd.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+
+#define FNAME1	"accessfile1"
+#define FNAME2	"accessfile2/accessfile2"
+#define DNAME	"accessfile2"
+#define SNAME1	"symlink1"
+#define SNAME2	"symlink2"
+#define MNT_POINT	"mntpoint"
+
+static uid_t uid;
+static char longpathname[PATH_MAX + 2];
+int mount_flag;
+
+static struct tcase {
+	const char *pathname;
+	int mode;
+	int exp_errno;
+} tcases[] = {
+	{FNAME1, -1, EINVAL},
+	{"", W_OK, ENOENT},
+	{longpathname, R_OK, ENAMETOOLONG},
+	{FNAME2, R_OK, ENOTDIR},
+	{SNAME1, R_OK, ELOOP},
+	{MNT_POINT, W_OK, EROFS}
+};
+
+static void access_test(struct tcase *tc, const char *user)
+{
+	TEST(access(tc->pathname, tc->mode));
+
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "access as %s succeeded unexpectedly", user);
+		return;
+	}
+
+	if (tc->exp_errno != TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO,
+			"access as %s should fail with %s",
+			user, tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "access as %s failed expectedly", user);
+}
+
+static void verify_access(unsigned int n)
+{
+	struct tcase *tc = tcases + n;
+	pid_t pid;
+
+	access_test(tc, "root");
+
+	pid = SAFE_FORK();
+	if (pid) {
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		SAFE_SETUID(uid);
+		access_test(tc, "nobody");
+	}
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+
+	uid = pw->pw_uid;
+
+	memset(longpathname, 'a', sizeof(longpathname) - 1);
+
+	SAFE_TOUCH(FNAME1, 0333, NULL);
+	SAFE_TOUCH(DNAME, 0644, NULL);
+
+	SAFE_SYMLINK(SNAME1, SNAME2);
+	SAFE_SYMLINK(SNAME2, SNAME1);
+
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
+	SAFE_MKDIR(MNT_POINT, 0755);
+	SAFE_MOUNT(tst_device->dev, MNT_POINT, tst_device->fs_type,
+		MS_RDONLY, NULL);
+	mount_flag = 1;
+}
+
+static void cleanup(void)
+{
+	if (mount_flag)
+		tst_umount(MNT_POINT);
+}
+
+static struct tst_test test = {
+	.tid = "access04",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.needs_device = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_access,
+};
diff --git a/testcases/kernel/syscalls/access/access05.c b/testcases/kernel/syscalls/access/access05.c
deleted file mode 100644
index 8f2cf8d..0000000
--- a/testcases/kernel/syscalls/access/access05.c
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
- */
-
-/*
- * Test Description:
- *  Verify that,
- *   1. access() fails with -1 return value and sets errno to EINVAL
- *	if the specified access mode argument is invalid.
- *   2. access() fails with -1 return value and sets errno to ENOENT
- *	if the specified file doesn't exist (or pathname is NULL).
- *   3. access() fails with -1 return value and sets errno to ENAMETOOLONG
- *      if the pathname size is > PATH_MAX characters.
- *   4. access() fails with -1 return value and sets errno to ENOTDIR
- *      if a component used as a directory in pathname is not a directory.
- *   5. access() fails with -1 return value and sets errno to ELOOP
- *      if too many symbolic links were encountered in resolving pathname.
- *
- *   07/2001 Ported by Wayne Boyer
- *   07/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- */
-
-#include <errno.h>
-#include <pwd.h>
-#include <string.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include "tst_test.h"
-
-#define FNAME1	"accessfile1"
-#define FNAME2	"accessfile2/accessfile2"
-#define DNAME	"accessfile2"
-#define SNAME1	"symlink1"
-#define SNAME2	"symlink2"
-
-static uid_t uid;
-static char longpathname[PATH_MAX + 2];
-
-static struct tcase {
-	const char *pathname;
-	int mode;
-	int exp_errno;
-} tcases[] = {
-	{FNAME1, -1, EINVAL},
-	{"", W_OK, ENOENT},
-	{longpathname, R_OK, ENAMETOOLONG},
-	{FNAME2, R_OK, ENOTDIR},
-	{SNAME1, R_OK, ELOOP}
-};
-
-static void access_test(struct tcase *tc, const char *user)
-{
-	TEST(access(tc->pathname, tc->mode));
-
-	if (TEST_RETURN != -1) {
-		tst_res(TFAIL, "access as %s succeeded unexpectedly", user);
-		return;
-	}
-
-	if (TEST_ERRNO != tc->exp_errno) {
-		tst_res(TFAIL | TTERRNO,
-			"access as %s should fail with %s",
-			user, tst_strerrno(tc->exp_errno));
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "access as %s failed expectedly", user);
-}
-
-static void verify_access(unsigned int n)
-{
-	struct tcase *tc = tcases + n;
-	pid_t pid;
-
-	access_test(tc, "root");
-
-	pid = SAFE_FORK();
-	if (pid) {
-		SAFE_WAITPID(pid, NULL, 0);
-	} else {
-		SAFE_SETUID(uid);
-		access_test(tc, "nobody");
-	}
-}
-
-static void setup(void)
-{
-	struct passwd *pw;
-
-	pw = SAFE_GETPWNAM("nobody");
-
-	uid = pw->pw_uid;
-
-	memset(longpathname, 'a', sizeof(longpathname) - 1);
-
-	SAFE_TOUCH(FNAME1, 0333, NULL);
-	SAFE_TOUCH(DNAME, 0644, NULL);
-
-	SAFE_SYMLINK(SNAME1, SNAME2);
-	SAFE_SYMLINK(SNAME2, SNAME1);
-}
-
-static struct tst_test test = {
-	.tid = "access05",
-	.needs_tmpdir = 1,
-	.needs_root = 1,
-	.forks_child = 1,
-	.setup = setup,
-	.test = verify_access,
-	.tcnt = ARRAY_SIZE(tcases)
-};
diff --git a/testcases/kernel/syscalls/access/access06.c b/testcases/kernel/syscalls/access/access06.c
deleted file mode 100644
index e9372f8..0000000
--- a/testcases/kernel/syscalls/access/access06.c
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- * Copyright (c) 2013 Fujitsu Ltd.
- * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/*
- * Description:
- * Verify that,
- *  1. access() fails with -1 return value and sets errno to EROFS
- *     if write permission was requested for files on a read-only file system.
- */
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void access_verify(int i);
-static void cleanup(void);
-
-#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
-			 S_IXGRP|S_IROTH|S_IXOTH)
-#define MNT_POINT	"mntpoint"
-
-static const char *device;
-static const char *fs_type;
-static int mount_flag;
-
-static struct test_case_t {
-	char *pathname;
-	int a_mode;
-	int exp_errno;
-} test_cases[] = {
-	{MNT_POINT, W_OK, EROFS}
-};
-
-char *TCID = "access06";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			access_verify(i);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-
-	TEST_PAUSE;
-
-	/*
-	 * mount a read-only file system for test EROFS
-	 */
-	if (mount(device, MNT_POINT, fs_type, MS_RDONLY, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "mount device:%s failed", device);
-	}
-	mount_flag = 1;
-}
-
-static void access_verify(int i)
-{
-	char *file_name;
-	int access_mode;
-
-	file_name = test_cases[i].pathname;
-	access_mode = test_cases[i].a_mode;
-
-	TEST(access(file_name, access_mode));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "access(%s, %#o) succeeded unexpectedly",
-			 file_name, access_mode);
-		return;
-	}
-
-	if (TEST_ERRNO == test_cases[i].exp_errno) {
-		tst_resm(TPASS | TTERRNO, "access failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "access failed unexpectedly; expected: "
-			 "%d - %s", test_cases[i].exp_errno,
-			 strerror(test_cases[i].exp_errno));
-	}
-}
-
-static void cleanup(void)
-{
-	if (mount_flag && tst_umount(MNT_POINT) < 0) {
-		tst_resm(TWARN | TERRNO,
-			 "umount device:%s failed", device);
-	}
-
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
-}
-- 
1.8.4.2




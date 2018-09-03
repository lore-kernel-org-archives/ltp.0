From: Vaishnavi D <vaishnavi.d@zilogic.com>
Date: Mon, 03 Sep 2018 12:18:28 -0000
Subject: [LTP] [PATCH v7 4/4] Testing statx syscall
Message-ID: <20180903121828.3806-1-vaishnavi.d@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


From: vaishnavid <vaishnavi.d@zilogic.com>

* statx04.c: This file will check attribute flag by defining flag
to that directory and checks another directory with no flags.
Changes from V5 to V6:
* Made changes in the m4 file and LTP_CHECK_STATX added to configure.ac
* Replaced arch-specific printf format with general one.
* Added ifndef cases for structs in stat.h.

Signed-off-by: Tarun.T.U <tarun@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                           |   3 +-
 testcases/kernel/syscalls/statx/.gitignore |   3 +-
 testcases/kernel/syscalls/statx/statx04.c  | 217 +++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 554ebe63f..dac6466be 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1498,4 +1498,5 @@ copy_file_range01 copy_file_range01
 
 statx01 statx01
 statx02 statx02
-statx03 statx03
\ No newline at end of file
+statx03 statx03
+statx04 statx04
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 067ac6493..7d1c18dec 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -1,3 +1,4 @@
 /statx01
 /statx02
-/statx03
\ No newline at end of file
+/statx03
+/statx04
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
new file mode 100644
index 000000000..d811c1aed
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test statx
+ *
+ * This code tests the functionality of statx system call.
+ * This code tests if the attributes field of statx received expected value.
+ * File set with following flags by using SAFE_IOCTL and e4crypt:
+ * 1) STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
+ * 2) STATX_ATTR_IMMUTABLE - The file cannot be modified.
+ * 3) STATX_ATTR_APPEND - The file can only be opened in append mode for
+ *                        writing.
+ * 4) STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
+ *                        program such as dump(8) is run.
+ * 5) STATX_ATTR_ENCRYPTED - A key is required for the file to be encrypted by
+ *                          the filesystem.
+ *
+ * A test directory is created with flags added to it.
+ *
+ * SAFE_IOCTL() is used to modify the atttributes of the directory such as
+ * compressed, append, nodump and immutable.
+ *
+ * e4crypt is used to set the encrypt flag.
+ *
+ * Two directory are tested.
+ * First directory has all flags set.
+ * Second directory has no flags set.
+ *
+ * Minimum kernel version required is 4.11.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+#include <stdlib.h>
+#include "lapi/stat.h"
+
+#define MOUNT_POINT "mnt_point"
+#define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
+#define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
+#define COMMAND_NOT_FOUND 127
+
+static int encrypt_flag;
+
+static void test_flagged(void)
+{
+	struct statx buf;
+
+	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
+
+	if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
+		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_COMPRESSED flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_APPEND)
+		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_APPEND flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
+		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_IMMUTABLE flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_NODUMP)
+		tst_res(TPASS, "STATX_ATTR_NODUMP flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_NODUMP flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_ENCRYPTED)
+		tst_res(TPASS, "STATX_ATTR_ENCRYPTED flag is set");
+	else if (encrypt_flag == 1)
+		tst_res(TCONF, "e4crypt tool not available");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_ENCRYPTED flag is not set");
+}
+
+static void test_unflagged(void)
+{
+	struct statx buf;
+
+	TEST(statx(AT_FDCWD, TESTDIR_UNFLAGGED, 0, 0, &buf));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
+			TESTDIR_UNFLAGGED);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
+			TESTDIR_UNFLAGGED);
+
+	if ((buf.stx_attributes & STATX_ATTR_COMPRESSED) == 0)
+		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_COMPRESSED flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_APPEND) == 0)
+		tst_res(TPASS, "STATX_ATTR_APPEND flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_APPEND flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_IMMUTABLE) == 0)
+		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_IMMUTABLE flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_NODUMP) == 0)
+		tst_res(TPASS, "STATX_ATTR_NODUMP flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_NODUMP flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_ENCRYPTED) == 0)
+		tst_res(TPASS, "STATX_ATTR_ENCRYPTED flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_ENCRYPTED flag is set");
+}
+
+struct test_cases {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&test_flagged},
+	{&test_unflagged},
+};
+
+static void run(unsigned int i)
+{
+	struct test_cases *tc = &tcases[i];
+
+	tc->tfunc();
+}
+
+static void caid_flags_setup(void)
+{
+	int fd;
+	int attr;
+
+	fd = SAFE_OPEN(TESTDIR_FLAGGED, O_RDONLY | O_DIRECTORY);
+
+	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
+
+	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
+
+	SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
+
+	SAFE_CLOSE(fd);
+}
+
+static void encrypt_flag_setup(void)
+{
+	TEST(tst_system("echo qwery | e4crypt add_key "TESTDIR_FLAGGED));
+
+	if (TST_RET == 0)
+		tst_res(TINFO, "Encryption flag is added to %s",
+			TESTDIR_FLAGGED);
+	else
+		tst_res(TFAIL | TERRNO,
+			"Encryption flag failed to add to %s", TESTDIR_FLAGGED);
+
+	if (WEXITSTATUS(TST_RET) == COMMAND_NOT_FOUND)
+		encrypt_flag = 1;
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
+	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
+
+	encrypt_flag_setup();
+	caid_flags_setup();
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_device = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.dev_fs_type = "ext4",
+	.dev_extra_opt = "-O encrypt",
+	.dev_min_size = 512,
+};
-- 
2.11.0


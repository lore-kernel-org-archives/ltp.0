From: Vaishnavi D <vaishnavi.d@zilogic.com>
Date: Mon, 03 Sep 2018 12:17:13 -0000
Subject: [LTP] [PATCH v7 2/4] Testing statx syscall * statx02.c: This file
	will check flag like AT_EMPTY_PATH,
	AT_SYMLINK_NOFOLLOW * AT_EMPTY_PATH: If pathname is an empty string,
	operate on the file referred to by dirfd. * AT_SYMLINK_NOFOLLOW:If
	pathname is a symbolic link,
	do not dereference it: instead return information about the link
	itself.
Message-ID: <20180903121713.3706-1-vaishnavi.d@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


From: vaishnavid <vaishnavi.d@zilogic.com>

Signed-off-by: Tarun.T.U <tarun@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                           |   3 +-
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx02.c  | 144 +++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b7c74446b..079c18fc7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1496,4 +1496,5 @@ memfd_create04 memfd_create04
 
 copy_file_range01 copy_file_range01
 
-statx01 statx01
\ No newline at end of file
+statx01 statx01
+statx02 statx02
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index aec497382..1849891d6 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -1 +1,2 @@
 /statx01
+/statx02
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
new file mode 100644
index 000000000..2f79bec1c
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -0,0 +1,144 @@
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
+ * This code tests the following flags:
+ * 1) AT_EMPTY_PATH
+ * 2) AT_SYMLINK_NOFOLLOW
+ *
+ * A test file and a link for it is created.
+ *
+ * To check empty path flag, test file fd alone is passed.
+ * Predefined size of testfile is checked against obtained value.
+ *
+ * To check symlink no follow flag, the linkname is statxed.
+ * To ensure that link is not dereferenced, obtained inode is compared
+ * with test file inode.
+ * Minimum kernel version required is 4.11.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/stat.h"
+
+#define TESTFILE "test_temp"
+#define LINK_FILE "test_temp_ln"
+#define MODE 0644
+#define SIZE 14
+
+static int file_fd;
+
+static void test_empty_path(void)
+{
+	struct statx buf;
+
+	TEST(statx(file_fd, "", AT_EMPTY_PATH, 0, &buf));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(file_fd, \" \", AT_EMPTY_PATH, 0, &buf)");
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(file_fd, \" \", AT_EMPTY_PATH, 0, &buff)");
+
+	if (buf.stx_size == SIZE)
+		tst_res(TPASS,
+			"stx_size(%"PRIu64") obtained is correct",
+			buf.stx_size);
+	else
+		tst_res(TFAIL,
+			"stx_size(%"PRIu64") obtained is not same as expected(%u)",
+			buf.stx_size, SIZE);
+
+}
+
+static void test_sym_link(void)
+{
+	struct statx fbuf;
+	struct statx lbuf;
+
+	TEST(statx(AT_FDCWD, TESTFILE, 0, 0, &fbuf));
+
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(AT_FDCWD, %s, 0, 0, &fbuf)", TESTFILE);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, 0, &fbuf)", TESTFILE);
+
+	TEST(statx(AT_FDCWD, LINK_FILE, AT_SYMLINK_NOFOLLOW, 0, &lbuf));
+
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(AT_FDCWD, %s, AT_SYMLINK_NOFOLLOW, 0,&lbuf)",
+			LINK_FILE);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, AT_SYMLINK_NOFOLLOW, 0,&lbuf)",
+			LINK_FILE);
+
+	if (fbuf.stx_ino != lbuf.stx_ino)
+		tst_res(TPASS, "Statx symlink flag worked as expected");
+	else
+		tst_res(TFAIL,
+			"Statx symlink flag failed to work as expected");
+}
+
+struct tcase {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&test_empty_path},
+	{&test_sym_link}
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *t;
+
+	t = &tcases[i];
+	t->tfunc();
+}
+
+static void setup(void)
+{
+	char data_buf[SIZE] = "LinusTorvalds";
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, MODE);
+	SAFE_WRITE(0, file_fd, data_buf, sizeof(data_buf));
+
+	SAFE_SYMLINK(TESTFILE, LINK_FILE);
+}
+
+static void cleanup(void)
+{
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_tmpdir = 1,
+};
-- 
2.11.0


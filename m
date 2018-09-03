From: Vaishnavi D <vaishnavi.d@zilogic.com>
Date: Mon, 03 Sep 2018 12:17:53 -0000
Subject: [LTP] [PATCH v7 3/4] Testing statx syscall
Message-ID: <20180903121753.3756-1-vaishnavi.d@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


From: vaishnavid <vaishnavi.d@zilogic.com>

* stat03.c: This file will check error code(errno) by providing
required input in statx argument syscall. The following errno are
checked: EBADF, EBADF, ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT.
Signed-off-by: Tarun.T.U <tarun@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 runtest/syscalls                           |   3 +-
 testcases/kernel/syscalls/statx/.gitignore |   3 +-
 testcases/kernel/syscalls/statx/statx03.c  | 134 +++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/statx/statx03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 079c18fc7..554ebe63f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1497,4 +1497,5 @@ memfd_create04 memfd_create04
 copy_file_range01 copy_file_range01
 
 statx01 statx01
-statx02 statx02
\ No newline at end of file
+statx02 statx02
+statx03 statx03
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 1849891d6..067ac6493 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -1,2 +1,3 @@
 /statx01
-/statx02
\ No newline at end of file
+/statx02
+/statx03
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
new file mode 100644
index 000000000..3c11f198e
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx03.c
@@ -0,0 +1,134 @@
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
+ * This code tests if expected error values are returned for specific cases by
+ * statx.
+ * The error cases are simulated and the return value is checked against
+ * expected error number value.
+ * The following error values are tested:
+ * 1) EBADF - Bad file descriptor
+ * 2) EFAULT - Bad address
+ * 3) EINVAL - Invalid argument
+ * 4) ENOENT - No such file or directory
+ * 5) ENOTDIR - Not a directory
+ * 6) ENAMETOOLONG - Filename too long
+ *
+ * Error scenario is simulated for each listed flag by passing
+ * respective arguments.
+ * The obtained error flag is checked against the expected
+ * flag value for that scenario.
+ *
+ * Minimum Kernel version required is 4.11.
+ */
+#include <stdio.h>
+#include <string.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_get_bad_addr.h"
+#include "lapi/stat.h"
+
+#define TESTFILE "test_file"
+#define MODE 0644
+
+static int file_fd;
+static char long_pathname[257];
+
+static char *test_fname = TESTFILE;
+static char *efault_fname;
+static char *empty_fname = "";
+static char *etoolong_fname = long_pathname;
+
+static struct test_case {
+	uint32_t dfd;
+	char **filename;
+	uint32_t flag;
+	uint32_t mask;
+	int32_t errnum;
+} tcases[] = {
+	{.dfd = -1, .filename = &test_fname, .flag = 0,
+	 .mask = 0, .errnum = EBADF},
+
+	{.dfd = AT_FDCWD, .filename = &efault_fname, .flag = 0,
+	 .mask = 0, .errnum = EFAULT},
+
+	{.dfd = AT_FDCWD, .filename = &test_fname, .flag = -1,
+	 .mask = 0, .errnum = EINVAL},
+
+	{.dfd = AT_FDCWD, .filename = &test_fname, .flag = 0,
+	 .mask = -1, .errnum = EINVAL},
+
+	{.dfd = AT_FDCWD, .filename = &empty_fname, .flag = 0,
+	 .mask = 0, .errnum = ENOENT},
+
+	{.dfd = 1, .filename = &test_fname, .flag = 0,
+	 .mask = 0, .errnum = ENOTDIR},
+
+	{.dfd = AT_FDCWD, .filename = &etoolong_fname, .flag = 0,
+	 .mask = 0, .errnum = ENAMETOOLONG},
+};
+
+static void run_test(unsigned int i)
+{
+	struct statx buf;
+	struct test_case *tc = &tcases[i];
+
+	TEST(statx(tc->dfd, *(tc->filename), tc->flag,
+		   tc->mask, &buf));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "statx() returned with %ld", TST_RET);
+		return;
+	}
+
+	if (tc->errnum == TST_ERR) {
+		tst_res(TPASS | TTERRNO, "statx() failed with");
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO,
+		"statx() should fail with %s", tst_strerrno(tc->errnum));
+}
+
+static void setup(void)
+{
+	file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, MODE);
+
+	memset(long_pathname, '@', sizeof(long_pathname));
+	long_pathname[sizeof(long_pathname) - 1] = 0;
+
+	efault_fname = tst_get_bad_addr(NULL);
+}
+
+static void cleanup(void)
+{
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_tmpdir = 1,
+};
-- 
2.11.0


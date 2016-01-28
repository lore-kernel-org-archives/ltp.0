From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jan 2016 15:28:51 +0300
Subject: [LTP] [PATCH v2 5/6] kernel/syscalls: add new test with 'open() +
	O_TMPFILE'
In-Reply-To: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
References: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1453984132-6240-6-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test does the following steps:
* create an unnamed temporary file in TMP directory,
* write data into it,
* check that file not visible in the filesystem,
* name the file and check that it becomes visible in FS.

'openat() + O_TMPFILE' test repeats the same steps.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/syscalls                            |    2 +
 testcases/kernel/syscalls/.gitignore        |    2 +
 testcases/kernel/syscalls/open/open14.c     |  120 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/openat/openat03.c |  120 +++++++++++++++++++++++++++
 4 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open14.c
 create mode 100644 testcases/kernel/syscalls/openat/openat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7173f22..3439948 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -721,10 +721,12 @@ open10 open10
 open11 open11
 open12 open12
 open13 open13
+open14 open14
 
 #openat test cases
 openat01 openat01
 openat02 openat02
+openat03 openat03
 
 mincore01 mincore01
 mincore02 mincore02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5f21ef..6451dc4 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -624,9 +624,11 @@
 /open/open12
 /open/open12_child
 /open/open13
+/open/open14
 /openat/openat01
 /openat/openat02
 /openat/openat02_child
+/openat/openat03
 /pathconf/pathconf01
 /pause/pause01
 /pause/pause02
diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
new file mode 100644
index 0000000..3784cb3
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+
+char *TCID = "open14";
+int TST_TOTAL = 1;
+static const char *test_dir = ".";
+static const ssize_t size = 1024;
+static char buf[1024];
+static const ssize_t blocks_num = 4;
+static struct stat st;
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+	tst_tmpdir();
+
+	memset(buf, 1, size);
+}
+
+void test01(void)
+{
+	int fd, i;
+
+	char path[PATH_MAX], tmp[PATH_MAX];
+
+	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
+
+	fd = open(test_dir, O_TMPFILE | O_WRONLY | O_SYNC);
+	if (fd == -1) {
+		if (errno == EISDIR) {
+			tst_brkm(TCONF, cleanup,
+				"O_TMPFILE not supported");
+		}
+		tst_resm(TFAIL | TERRNO, "open() failed");
+		return;
+	}
+
+	tst_resm(TINFO, "writing data to the file");
+	for (i = 0; i < blocks_num; ++i)
+		SAFE_WRITE(cleanup, 1, fd, buf, size);
+
+	SAFE_FSTAT(cleanup, fd, &st);
+	tst_resm(TINFO, "file size is '%zu'", st.st_size);
+
+	if (st.st_size != blocks_num * size) {
+		tst_resm(TFAIL, "not expected size: '%zu' != '%zu'",
+			 st.st_size, blocks_num * size);
+		SAFE_CLOSE(cleanup, fd);
+		return;
+	}
+
+	tst_resm(TINFO, "looking for the file in '%s'", test_dir);
+	if (!tst_dir_is_empty(cleanup, test_dir, 1))
+		tst_brkm(TBROK, cleanup, "found a file, this is not expected");
+	tst_resm(TINFO, "file not found, OK");
+
+	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
+	SAFE_READLINK(cleanup, path, tmp, PATH_MAX);
+
+	tst_resm(TINFO, "renaming '%s' -> '%s/tmpfile'",
+		 tmp, test_dir);
+	SAFE_LINKAT(cleanup, AT_FDCWD, path, AT_FDCWD, "tmpfile",
+		    AT_SYMLINK_FOLLOW);
+
+	if (tst_dir_is_empty(cleanup, test_dir, 1))
+		tst_brkm(TBROK, cleanup, "file not found");
+
+	SAFE_UNLINK(cleanup, "tmpfile");
+	SAFE_CLOSE(cleanup, fd);
+
+	tst_resm(TPASS, "test succeeded");
+}
+
+int main(int ac, char *av[])
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
+		test01();
+	}
+
+	cleanup();
+	tst_exit();
+}
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
new file mode 100644
index 0000000..3a0c2f1
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -0,0 +1,120 @@
+/*
+ * Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+
+char *TCID = "openat03";
+int TST_TOTAL = 1;
+static const char *test_dir = ".";
+static const ssize_t size = 1024;
+static char buf[1024];
+static const ssize_t blocks_num = 4;
+static struct stat st;
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+	tst_tmpdir();
+
+	memset(buf, 1, size);
+}
+
+void test01(void)
+{
+	int fd, i;
+
+	char path[PATH_MAX], tmp[PATH_MAX];
+
+	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
+
+	fd = openat(AT_FDCWD, test_dir, O_TMPFILE | O_WRONLY | O_SYNC);
+	if (fd == -1) {
+		if (errno == EISDIR) {
+			tst_brkm(TCONF, cleanup,
+				"O_TMPFILE not supported");
+		}
+		tst_resm(TFAIL | TERRNO, "openat() failed");
+		return;
+	}
+
+	tst_resm(TINFO, "writing data to the file");
+	for (i = 0; i < blocks_num; ++i)
+		SAFE_WRITE(cleanup, 1, fd, buf, size);
+
+	SAFE_FSTAT(cleanup, fd, &st);
+	tst_resm(TINFO, "file size is '%zu'", st.st_size);
+
+	if (st.st_size != blocks_num * size) {
+		tst_resm(TFAIL, "not expected size: '%zu' != '%zu'",
+			 st.st_size, blocks_num * size);
+		SAFE_CLOSE(cleanup, fd);
+		return;
+	}
+
+	tst_resm(TINFO, "looking for the file in '%s'", test_dir);
+	if (!tst_dir_is_empty(cleanup, test_dir, 1))
+		tst_brkm(TBROK, cleanup, "found a file, this is not expected");
+	tst_resm(TINFO, "file not found, OK");
+
+	snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
+	SAFE_READLINK(cleanup, path, tmp, PATH_MAX);
+
+	tst_resm(TINFO, "renaming '%s' -> '%s/tmpfile'",
+		 tmp, test_dir);
+	SAFE_LINKAT(cleanup, AT_FDCWD, path, AT_FDCWD, "tmpfile",
+		    AT_SYMLINK_FOLLOW);
+
+	if (tst_dir_is_empty(cleanup, test_dir, 1))
+		tst_brkm(TBROK, cleanup, "file not found");
+
+	SAFE_UNLINK(cleanup, "tmpfile");
+	SAFE_CLOSE(cleanup, fd);
+
+	tst_resm(TPASS, "test succeeded");
+}
+
+int main(int ac, char *av[])
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
+		test01();
+	}
+
+	cleanup();
+	tst_exit();
+}
-- 
1.7.1


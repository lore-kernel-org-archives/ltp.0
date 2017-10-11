From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 16:41:20 +0200
Subject: [LTP] [PATCH v3 06/16] syscalls/fallocate05: New test
In-Reply-To: <20171011144130.29728-1-chrubis@suse.cz>
References: <20171011144130.29728-1-chrubis@suse.cz>
Message-ID: <20171011144130.29728-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tests that fallocate() works fine when filesystem is full.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/.gitignore              |   1 +
 testcases/kernel/syscalls/fallocate/fallocate05.c | 104 ++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fallocate/fallocate05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2362a231d..a31d15da6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -160,6 +160,7 @@ fallocate01 fallocate01
 fallocate02 fallocate02
 fallocate03 fallocate03
 fallocate04 fallocate04
+fallocate05 fallocate05
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 930f3f999..a91abd9f0 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -141,6 +141,7 @@
 /fallocate/fallocate02
 /fallocate/fallocate03
 /fallocate/fallocate04
+/fallocate/fallocate05
 /fchdir/fchdir01
 /fchdir/fchdir02
 /fchdir/fchdir03
diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
new file mode 100644
index 000000000..1fac26adb
--- /dev/null
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
+ * Tests that writing to fallocated file works when filesystem is full.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include "tst_test.h"
+#include "lapi/fallocate.h"
+
+#define MNTPOINT "mntpoint"
+#define FALLOCATE_SIZE 8192
+
+static int fd;
+
+static void run(void)
+{
+	char buf[FALLOCATE_SIZE];
+	ssize_t ret;
+
+	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
+
+	if (fallocate(fd, 0, 0, FALLOCATE_SIZE)) {
+		if (errno == EOPNOTSUPP) {
+			tst_res(TCONF | TERRNO, "fallocate() not supported");
+			SAFE_CLOSE(fd);
+			return;
+		}
+
+		tst_brk(TBROK | TERRNO,
+			"fallocate(fd, 0, 0, %i)", FALLOCATE_SIZE);
+	}
+
+	tst_fill_fs(MNTPOINT, 1);
+
+	ret = write(fd, buf, sizeof(buf));
+
+	if (ret < 0)
+		tst_res(TFAIL | TERRNO, "write() failed unexpectedly");
+	else
+		tst_res(TPASS, "write() wrote %zu bytes", ret);
+
+	ret = fallocate(fd, 0, FALLOCATE_SIZE, FALLOCATE_SIZE);
+	if (ret != -1)
+		tst_brk(TFAIL, "fallocate() succeeded unexpectedly");
+
+	if (errno != ENOSPC)
+		tst_brk(TFAIL | TERRNO, "fallocate() should fail with ENOSPC");
+
+	tst_res(TPASS | TERRNO, "fallocate() on full FS");
+
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE, 0, FALLOCATE_SIZE);
+	if (ret == -1) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+
+		tst_brk(TBROK | TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+	}
+	tst_res(TPASS, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+
+	ret = write(fd, buf, 10);
+	if (ret == -1)
+		tst_res(TFAIL | TERRNO, "write()");
+	else
+		tst_res(TPASS, "write()");
+
+	SAFE_CLOSE(fd);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.13.5


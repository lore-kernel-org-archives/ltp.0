From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 16:26:39 +0100
Subject: [LTP] [PATCH 3/3] ioctl04: Add BLKROSET/BLKROGET test.
In-Reply-To: <20170214152639.11603-1-chrubis@suse.cz>
References: <20170214152639.11603-1-chrubis@suse.cz>
Message-ID: <20170214152639.11603-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/.gitignore      |   1 +
 testcases/kernel/syscalls/ioctl/ioctl04.c | 104 ++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dc03c4c..1ef6161 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -452,6 +452,7 @@ getxattr03 getxattr03
 # Introducing ioctl tests for all /dev/tty* devices
 ioctl01_02   test_ioctl
 ioctl03      ioctl03
+ioctl04      ioctl04
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 91dccef..4c645f6 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -384,6 +384,7 @@
 /ioctl/ioctl01
 /ioctl/ioctl02
 /ioctl/ioctl03
+/ioctl/ioctl04
 /ioperm/ioperm01
 /ioperm/ioperm02
 /iopl/iopl01
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
new file mode 100644
index 0000000..d3de368
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
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
+/*
+ * Basic test for the BLKROSET and BLKROGET ioctls.
+ *
+ * - Set the device read only, read the value back.
+ * - Try to mount the device read write, expect failure.
+ * - Try to mount the device read only, expect success.
+ */
+
+#include <errno.h>
+#include <sys/mount.h>
+#include <linux/fs.h>
+#include "tst_test.h"
+
+static int fd;
+
+static void verify_ioctl(void)
+{
+	int ro = 1;
+
+	SAFE_IOCTL(fd, BLKROGET, &ro);
+
+	if (ro == 0)
+		tst_res(TPASS, "BLKROGET returned 0");
+	else
+		tst_res(TFAIL, "BLKROGET returned %i", ro);
+
+	ro = 1;
+	SAFE_IOCTL(fd, BLKROSET, &ro);
+
+	ro = 0;
+	SAFE_IOCTL(fd, BLKROGET, &ro);
+
+	if (ro == 0)
+		tst_res(TFAIL, "BLKROGET returned 0");
+	else
+		tst_res(TPASS, "BLKROGET returned %i", ro);
+
+	TEST(mount(tst_device->dev, "mntpoint", tst_device->fs_type, 0, NULL));
+
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "Mounting RO device RW succeeded");
+		tst_umount("mntpoint");
+		goto next;
+	}
+
+	if (TEST_ERRNO == EACCES) {
+		tst_res(TPASS | TERRNO, "Mounting RO device RW failed");
+		goto next;
+	}
+
+	tst_res(TFAIL | TERRNO,
+		"Mounting RO device RW failed unexpectedly expected EACCES");
+
+next:
+	TEST(mount(tst_device->dev, "mntpoint", tst_device->fs_type, MS_RDONLY, NULL));
+
+	if (TEST_RETURN == 0) {
+		tst_res(TPASS, "Mounting RO device RO works");
+		tst_umount("mntpoint");
+	} else {
+		tst_res(TFAIL | TTERRNO, "Mounting RO device RO failed");
+	}
+
+	ro = 0;
+	SAFE_IOCTL(fd, BLKROSET, &ro);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR("mntpoint", 0777);
+	fd = SAFE_OPEN(tst_device->dev, O_RDONLY);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tid = "ioctl04",
+	.needs_tmpdir = 1,
+	.needs_device = 1,
+	.format_device = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ioctl,
+};
-- 
2.10.2


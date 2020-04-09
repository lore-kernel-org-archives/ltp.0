From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 18:44:40 +0800
Subject: [LTP] [PATCH v2 05/10] syscalls/ioctl_loop03: Add LOOP_CHANGE_FD
 test with WR mode
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1586429086-22975-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is designed to test LOOP_CHANGE_FD can not succeed(get EINAL error)
when loop_dev is not read only.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |  1 +
 .../kernel/syscalls/ioctl/ioctl_loop03.c      | 76 +++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 80005227d..46d877fa3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -530,6 +530,7 @@ ioctl08      ioctl08
 
 ioctl_loop01 ioctl_loop01
 ioctl_loop02 ioctl_loop02
+ioctl_loop03 ioctl_loop03
 
 ioctl_ns01 ioctl_ns01
 ioctl_ns02 ioctl_ns02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 534c4ab34..1501c2779 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -8,6 +8,7 @@
 /ioctl08
 /ioctl_loop01
 /ioctl_loop02
+/ioctl_loop03
 /ioctl_ns01
 /ioctl_ns02
 /ioctl_ns03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
new file mode 100644
index 000000000..4e7c29cde
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * This is a basic ioctl test about loopdevice.
+ *
+ * It is designed to test LOOP_CHANGE_FD can not succeed(get EINAL error)
+ * when loop_dev is not read only.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include "ioctl_loop_support.h"
+#include "lapi/loop.h"
+#include "tst_test.h"
+
+static char dev_path[1024];
+static int dev_num, dev_fd, file_fd, attach_flag;
+
+static void verify_ioctl_loop(void)
+{
+	TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_fd));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "LOOP_CHANGE_FD succeeded unexpectedly");
+		return;
+	}
+	if (TST_ERR == EINVAL)
+		tst_res(TPASS | TTERRNO, "LOOP_CHANGE_FD failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed expected EINVAL got");
+}
+
+static void setup(void)
+{
+	struct loop_info loopinfoget;
+
+	memset(&loopinfoget, 0, sizeof(loopinfoget));
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+
+	tst_fill_file("test.img", 0, 1024, 10);
+	tst_attach_device(dev_path, "test.img");
+	attach_flag = 1;
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	file_fd = SAFE_OPEN("test.img", O_RDWR);
+	SAFE_IOCTL(dev_fd, LOOP_GET_STATUS, &loopinfoget);
+
+	if (loopinfoget.lo_flags & LO_FLAGS_READ_ONLY)
+		tst_brk(TCONF, "Current environment has unexpected LO_FLAGS_READ_ONLY flag");
+}
+
+static void cleanup(void)
+{
+	if (dev_fd > 0)
+		SAFE_CLOSE(dev_fd);
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
+	if (attach_flag)
+		tst_detach_device(dev_path);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_ioctl_loop,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_drivers = (const char *const []) {
+		"loop",
+		NULL
+	}
+};
-- 
2.23.0




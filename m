From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 18:44:44 +0800
Subject: [LTP] [PATCH v2 09/10] syscalls/ioctl_loop07: Add dio with logic
 block size error test
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1586429086-22975-9-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a basic ioctl test about loopdevice LOOP_SET_BLOCK_SIZE
and LOOP_SET_DIRECT_IO. When logical blocksize is 1024, set dio
with  512 offset will fail.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |  1 +
 .../kernel/syscalls/ioctl/ioctl_loop07.c      | 85 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e9b0a8f60..f83561724 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -534,6 +534,7 @@ ioctl_loop03 ioctl_loop03
 ioctl_loop04 ioctl_loop04
 ioctl_loop05 ioctl_loop05
 ioctl_loop06 ioctl_loop06
+ioctl_loop07 ioctl_loop07
 
 ioctl_ns01 ioctl_ns01
 ioctl_ns02 ioctl_ns02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index ec19b4901..3a3d49adc 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -12,6 +12,7 @@
 /ioctl_loop04
 /ioctl_loop05
 /ioctl_loop06
+/ioctl_loop07
 /ioctl_ns01
 /ioctl_ns02
 /ioctl_ns03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
new file mode 100644
index 000000000..c58a92b3c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * This is a basic ioctl test about loopdevice LOOP_SET_BLOCK_SIZE
+ * and LOOP_SET_DIRECT_IO.
+ * When blocksize is 1024(default align size is 512), set dio with
+ * 512 offset will fail.
+ */
+
+#include <stdio.h>
+#include <linux/loop.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include "ioctl_loop_support.h"
+#include "lapi/loop.h"
+#include "tst_test.h"
+
+static char dev_path[1024], sys_loop_logicalpath[1024];
+static int dev_num, dev_fd, attach_flag, logical_block_size;
+
+static void verify_ioctl_loop(void)
+{
+	check_sys_value(sys_loop_logicalpath, 1024);
+	SAFE_IOCTL(dev_fd, BLKSSZGET, &logical_block_size);
+	if (logical_block_size == 1024)
+		tst_res(TPASS, "logical block size is 1024 by using BLKSSZGET ioctl");
+	else
+		tst_res(TFAIL, "expected logical block size is 1024 but got %d by using BLKSSZGET ioctl",
+				logical_block_size);
+	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "LOOP_SET_DIRECT_IO succeeded unexpectedly");
+		return;
+	}
+	if (TST_ERR == EINVAL)
+		tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed expected EINVAL got");
+}
+
+static void setup(void)
+{
+	struct loop_info loopinfo;
+
+	memset(&loopinfo, 0, sizeof(loopinfo));
+	loopinfo.lo_offset = 512;
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+
+	sprintf(sys_loop_logicalpath, "/sys/block/loop%d/queue/logical_block_size", dev_num);
+	tst_fill_file("test.img", 0, 1024 * 1024, 1);
+	tst_attach_device(dev_path, "test.img");
+	attach_flag = 1;
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+	check_support_cmd(dev_fd, LOOP_SET_DIRECT_IO, 0, "LOOP_SET_DIRECT_IO");
+	check_support_cmd(dev_fd, LOOP_SET_BLOCK_SIZE, 512, "LOOP_SET_BLOCK_SIZE");
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, 1024), TST_RETVAL_EQ0);
+}
+
+static void cleanup(void)
+{
+	if (dev_fd > 0)
+		SAFE_CLOSE(dev_fd);
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




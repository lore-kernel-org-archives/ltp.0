From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 18:44:42 +0800
Subject: [LTP] [PATCH v2 07/10] syscalls/ioctl_loop05: Add
 LOOP_SET_DIRECT_IO ioctl test
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1586429086-22975-7-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LOOP_SET_DIRECT_IO can update a live loop device dio mode. It needs the
backing file also supports dio mode and the lo_offset is aligned with
the logical block size(getting by BLKSSZGET ioctl).

It was introduced into kernel since 4.10
commit ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO").

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 125 ++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 51ad8ff69..8b120b43a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -532,6 +532,7 @@ ioctl_loop01 ioctl_loop01
 ioctl_loop02 ioctl_loop02
 ioctl_loop03 ioctl_loop03
 ioctl_loop04 ioctl_loop04
+ioctl_loop05 ioctl_loop05
 
 ioctl_ns01 ioctl_ns01
 ioctl_ns02 ioctl_ns02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 039a5251c..f484d98d6 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -10,6 +10,7 @@
 /ioctl_loop02
 /ioctl_loop03
 /ioctl_loop04
+/ioctl_loop05
 /ioctl_ns01
 /ioctl_ns02
 /ioctl_ns03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
new file mode 100644
index 000000000..16c7a468c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * This is a basic ioctl test about loopdevice.
+ *
+ * It is designed to test LOOP_SET_DIRECT_IO can updata a live
+ * loop device dio mode. It need the backing file also supports
+ * dio mode and the lo_offset is aligned with the logical block size.
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include "ioctl_loop_support.h"
+#include "lapi/loop.h"
+#include "tst_test.h"
+
+#define DIO_MESSAGE "In dio mode"
+#define NON_DIO_MESSAGE "In non dio mode"
+
+static char dev_path[1024], sys_loop_diopath[1024];
+static int dev_num, dev_fd, attach_flag, logical_block_size;
+
+static void check_dio_value(int flag)
+{
+	struct loop_info loopinfoget;
+
+	memset(&loopinfoget, 0, sizeof(loopinfoget));
+
+	SAFE_IOCTL(dev_fd, LOOP_GET_STATUS, &loopinfoget);
+	tst_res(TINFO, "%s", flag ? DIO_MESSAGE : NON_DIO_MESSAGE);
+
+	if (loopinfoget.lo_flags & LO_FLAGS_DIRECT_IO)
+		tst_res(flag ? TPASS : TFAIL, "lo_flags has LO_FLAGS_DIRECT_IO flag");
+	else
+		tst_res(flag ? TFAIL : TPASS, "lo_flags doesn't have LO_FLAGS_DIRECT_IO flag");
+
+	check_sys_value(sys_loop_diopath, flag);
+}
+
+static void verify_ioctl_loop(void)
+{
+	struct loop_info loopinfo;
+
+	memset(&loopinfo, 0, sizeof(loopinfo));
+
+	tst_res(TINFO, "Without setting lo_offset or sizelimit");
+	SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 1);
+	check_dio_value(1);
+
+	SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
+	check_dio_value(0);
+
+	tst_res(TINFO, "With offset equal to logical_block_size");
+	loopinfo.lo_offset = logical_block_size;
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
+	if (TST_RET == 0) {
+		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
+		check_dio_value(1);
+		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
+	} else {
+		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed");
+	}
+
+	tst_res(TINFO, "With offset less than or unalign logical_block_size");
+	loopinfo.lo_offset = logical_block_size / 2;
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+
+	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "LOOP_SET_DIRECT_IO succeeded unexpectedly");
+		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
+		return;
+	}
+	if (TST_ERR == EINVAL)
+		tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed expected EINVAL got");
+
+	loopinfo.lo_offset = 0;
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+}
+
+static void setup(void)
+{
+	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
+		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag, skip it");
+
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+
+	sprintf(sys_loop_diopath, "/sys/block/loop%d/loop/dio", dev_num);
+	tst_fill_file("test.img", 0, 1024, 1024);
+	tst_attach_device(dev_path, "test.img");
+	attach_flag = 1;
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	check_support_cmd(dev_fd, LOOP_SET_DIRECT_IO, 0, "LOOP_SET_DIRECT_IO");
+	SAFE_IOCTL(dev_fd, BLKSSZGET, &logical_block_size);
+	tst_res(TINFO, "%s default logical_block_size is %d", dev_path, logical_block_size);
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




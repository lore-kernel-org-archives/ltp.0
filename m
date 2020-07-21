From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Jul 2020 10:26:19 +0800
Subject: [LTP] [PATCH v3] syscalls/ioctl09: Add test for BLKRRPART ioctl
In-Reply-To: <20200720145646.GA20216@yuki.lan>
References: <20200720145646.GA20216@yuki.lan>
Message-ID: <1595298379-4585-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #699

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
---
v2->v3
1. remove useless cmd judgement about 255 and use tst_brk
2. move tst_find_free_loopdev into setup
3. use new api tst_prealloc_file instead of tst_fill_file 
   and move it into setup
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore |   1 +
 testcases/kernel/syscalls/ioctl/ioctl09.c  | 119 +++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 819e8d8ee..c2bfc6df3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -529,6 +529,7 @@ ioctl05      ioctl05
 ioctl06      ioctl06
 ioctl07      ioctl07
 ioctl08      ioctl08
+ioctl09      ioctl09
 
 ioctl_loop01 ioctl_loop01
 ioctl_loop02 ioctl_loop02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 3a3d49adc..5fff7a61d 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -6,6 +6,7 @@
 /ioctl06
 /ioctl07
 /ioctl08
+/ioctl09
 /ioctl_loop01
 /ioctl_loop02
 /ioctl_loop03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
new file mode 100644
index 000000000..d159869d6
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * Basic test for the BLKRRPART ioctl, it is the same as blockdev
+ * --rereadpt command.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <stdbool.h>
+#include "lapi/loop.h"
+#include "tst_test.h"
+
+static char dev_path[1024];
+static int dev_num, attach_flag, dev_fd;
+static char loop_partpath[1026], sys_loop_partpath[1026];
+
+static void change_partition(const char *const cmd[])
+{
+	int ret;
+
+	ret = tst_cmd(cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
+	if (ret)
+		tst_brk(TBROK, "parted return %i", ret);
+}
+
+static void check_partition(int part_num, bool value)
+{
+	int ret;
+
+	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp%d",
+		dev_num, dev_num, part_num);
+	sprintf(loop_partpath, "%sp%d", dev_path, part_num);
+
+	ret = access(sys_loop_partpath, F_OK);
+	if (ret == 0)
+		tst_res(value ? TPASS : TFAIL, "access %s succeeds",
+			sys_loop_partpath);
+	else
+		tst_res(value ? TFAIL : TPASS, "access %s fails",
+			sys_loop_partpath);
+
+	ret = access(loop_partpath, F_OK);
+	if (ret == 0)
+		tst_res(value ? TPASS : TFAIL, "access %s succeeds",
+			loop_partpath);
+	else
+		tst_res(value ? TFAIL : TPASS, "access %s fails",
+			loop_partpath);
+}
+
+static void verify_ioctl(void)
+{
+	const char *const cmd_parted_old[] = {"parted", "-s", "test.img",
+					      "mklabel", "msdos", "mkpart",
+					      "primary", "ext4", "1M", "10M",
+					      NULL};
+	const char *const cmd_parted_new[] = {"parted", "-s", "test.img",
+					      "mklabel", "msdos", "mkpart",
+					      "primary", "ext4", "1M", "10M",
+					      "mkpart", "primary", "ext4",
+					      "10M", "20M", NULL};
+	struct loop_info loopinfo = {0};
+
+	change_partition(cmd_parted_old);
+	tst_attach_device(dev_path, "test.img");
+	attach_flag = 1;
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	loopinfo.lo_flags =  LO_FLAGS_PARTSCAN;
+	SAFE_IOCTL(dev_fd, LOOP_SET_STATUS, &loopinfo);
+	check_partition(1, true);
+	check_partition(2, false);
+
+	change_partition(cmd_parted_new);
+	TST_RETRY_FUNC(ioctl(dev_fd, BLKRRPART, 0), TST_RETVAL_EQ0);
+	check_partition(1, true);
+	check_partition(2, true);
+
+	SAFE_CLOSE(dev_fd);
+	tst_detach_device(dev_path);
+	attach_flag = 0;
+}
+
+static void setup(void)
+{
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+	tst_prealloc_file("test.img", 1024 * 1024, 20);
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
+	.test_all = verify_ioctl,
+	.needs_root = 1,
+	.needs_drivers = (const char *const []) {
+		"loop",
+		NULL
+	},
+	.needs_cmds = (const char *const []) {
+		"parted",
+		NULL
+	},
+	.needs_tmpdir = 1,
+};
-- 
2.23.0




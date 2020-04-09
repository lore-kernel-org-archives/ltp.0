From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 18:44:43 +0800
Subject: [LTP] [PATCH v2 08/10] syscalls/ioctl_loop06: Add
 LOOP_SET_BLOCK_SIZE error test
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1586429086-22975-8-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |  1 +
 .../kernel/syscalls/ioctl/ioctl_loop06.c      | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8b120b43a..e9b0a8f60 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -533,6 +533,7 @@ ioctl_loop02 ioctl_loop02
 ioctl_loop03 ioctl_loop03
 ioctl_loop04 ioctl_loop04
 ioctl_loop05 ioctl_loop05
+ioctl_loop06 ioctl_loop06
 
 ioctl_ns01 ioctl_ns01
 ioctl_ns02 ioctl_ns02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index f484d98d6..ec19b4901 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -11,6 +11,7 @@
 /ioctl_loop03
 /ioctl_loop04
 /ioctl_loop05
+/ioctl_loop06
 /ioctl_ns01
 /ioctl_ns02
 /ioctl_ns03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
new file mode 100644
index 000000000..ef98efbca
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * This is a basic ioctl error test about loopdevice
+ * LOOP_SET_BLOCK_SIZE.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include "ioctl_loop_support.h"
+#include "lapi/loop.h"
+#include "tst_test.h"
+
+static char dev_path[1024], sys_loop_logicalpath[1024];
+static int dev_num, dev_fd, attach_flag;
+static unsigned int invalid_value, half_value, unalign_value;
+
+static struct tcase {
+	unsigned int *setvalue;
+	int exp_err;
+	char *message;
+} tcases[] = {
+	{&half_value, EINVAL, "arg < 512"},
+	{&invalid_value, EINVAL, "arg > PAGE_SIZE"},
+	{&unalign_value, EINVAL, "arg != power_of_2"},
+};
+
+static void verify_ioctl_loop(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->message);
+	TEST(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, *(tc->setvalue)));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "LOOP_SET_BLOCK_SIZE succeed unexpectedly");
+		return;
+	}
+	if (TST_ERR == tc->exp_err)
+		tst_res(TPASS | TTERRNO, "LOOP_SET_BLOCK_SIZE failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "LOOP_SET_BLOCK_SIZE failed expected %s got",
+				tst_strerrno(tc->exp_err));
+}
+
+static void setup(void)
+{
+	unsigned int pg_size;
+
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+
+	sprintf(sys_loop_logicalpath, "/sys/block/loop%d/logical_block_size", dev_num);
+	tst_fill_file("test.img", 0, 1024, 1024);
+	tst_attach_device(dev_path, "test.img");
+	attach_flag = 1;
+	half_value = 256;
+	pg_size = getpagesize();
+	invalid_value = pg_size * 2 ;
+	unalign_value = pg_size - 1;
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	check_support_cmd(dev_fd, LOOP_SET_BLOCK_SIZE, 512, "LOOP_SET_BLOCK_SIZE");
+}
+
+static void cleanup(void)
+{
+	if (dev_fd > 0)
+		SAFE_CLOSE(dev_fd);
+	if (attach_flag)
+		tst_detach_device(dev_path);
+	unlink("test.img");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_ioctl_loop,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_drivers = (const char *const []) {
+		"loop",
+		NULL
+	}
+};
-- 
2.23.0




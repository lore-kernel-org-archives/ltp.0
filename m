From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Jun 2020 18:35:15 +0800
Subject: [LTP] [PATCH v1 3/4] syscalls/ioctl_loop08: Add LOOP_CONFIGURE
 error test with invalid block size
In-Reply-To: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1591871716-21250-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl"),
it can set the correct block size immediately by setting loop_config.block_size.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_loop08.c      | 101 ++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index cd0c65094..7259f2a92 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -536,6 +536,7 @@ ioctl_loop04 ioctl_loop04
 ioctl_loop05 ioctl_loop05
 ioctl_loop06 ioctl_loop06
 ioctl_loop07 ioctl_loop07
+ioctl_loop08 ioctl_loop08
 
 ioctl_ns01 ioctl_ns01
 ioctl_ns02 ioctl_ns02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 3a3d49adc..97134aa0b 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -13,6 +13,7 @@
 /ioctl_loop05
 /ioctl_loop06
 /ioctl_loop07
+/ioctl_loop08
 /ioctl_ns01
 /ioctl_ns02
 /ioctl_ns03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop08.c b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
new file mode 100644
index 000000000..93b75a381
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * This is a basic ioctl test about loopdevice.
+ * It is designed to test LOOP_CONFIGURE ioctl with invalid block size config.
+ * It is similar with ioctl_loop06.c.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include "lapi/loop.h"
+#include "tst_test.h"
+
+static char dev_path[1024];
+static int dev_num, dev_fd, file_fd;
+static unsigned int invalid_value, half_value, unalign_value;
+static struct loop_config loopconfig;
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
+	loopconfig.block_size = *(tc->setvalue);
+	TEST(ioctl(dev_fd, LOOP_CONFIGURE, &loopconfig));
+	if (TST_RET == 0) {
+		tst_res(TFAIL, "LOOP_CONFIGURE block_size succeed unexpectedly");
+		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_CLR_FD, 0), TST_RETVAL_EQ0);
+		return;
+	}
+
+	if (TST_ERR == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "LOOP_CONFIGURE block failed as expected");
+	} else {
+		tst_res(TFAIL | TTERRNO, "LOOP_CONFIGURE block size failed expected %s got",
+				tst_strerrno(tc->exp_err));
+	}
+}
+
+static void setup(void)
+{
+	unsigned int pg_size;
+	int ret;
+
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+
+	tst_fill_file("test.img", 0, 1024, 1024);
+	half_value = 256;
+	pg_size = getpagesize();
+	invalid_value = pg_size * 2 ;
+	unalign_value = pg_size - 1;
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	file_fd = SAFE_OPEN("test.img", O_RDWR);
+	loopconfig.fd = file_fd;
+
+	ret = ioctl(dev_fd, LOOP_CONFIGURE, &loopconfig);
+	if (ret == 0) {
+		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_CLR_FD, 0), TST_RETVAL_EQ0);
+		return;
+	}
+	if (errno == EINVAL)
+		tst_brk(TCONF, "LOOP_CONFIGURE is not supported");
+}
+
+static void cleanup(void)
+{
+	if (dev_fd > 0)
+		SAFE_CLOSE(dev_fd);
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
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




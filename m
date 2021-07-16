From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 16 Jul 2021 18:22:57 +0800
Subject: [LTP] [PATCH 5/5 v2] epoll_pwait: Add test for epoll_pwait03
In-Reply-To: <20210716102257.20882-1-xieziyao@huawei.com>
References: <20210628080424.245911-3-xieziyao@huawei.com>
 <20210716102257.20882-1-xieziyao@huawei.com>
Message-ID: <20210716102257.20882-6-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that epoll_pwait/epoll_pwait2 timeout correctly.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Add test variants to switch between epoll_pwait and epoll_pwait2.

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  1 +
 .../syscalls/epoll_pwait/epoll_pwait03.c      | 74 +++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bed224809..1deb6118f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -167,6 +167,7 @@ epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
 epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
+epoll_pwait03 epoll_pwait03

 eventfd01 eventfd01

diff --git a/testcases/kernel/syscalls/epoll_pwait/.gitignore b/testcases/kernel/syscalls/epoll_pwait/.gitignore
index ab049f173..1d16367e6 100644
--- a/testcases/kernel/syscalls/epoll_pwait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_pwait/.gitignore
@@ -1,2 +1,3 @@
 epoll_pwait01
 epoll_pwait02
+epoll_pwait03
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
new file mode 100644
index 000000000..ec3b9579d
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that epoll_pwait and epoll_pwait2 timeout correctly.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_timer_test.h"
+#include "epoll_pwait_var.h"
+
+#define USEC_PER_MSEC (1000L)
+
+static int efd, sfd[2];
+static struct epoll_event e;
+
+int sample_fn(int clk_id, long long usec)
+{
+	unsigned int ms = usec / USEC_PER_MSEC;
+
+	tst_timer_start(clk_id);
+	TEST(do_epoll_pwait(efd, &e, 1, ms, NULL));
+	tst_timer_stop();
+	tst_timer_sample();
+
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"do_epoll_pwait() returned %li, expected 0", TST_RET);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void setup(void)
+{
+	epoll_pwait_info();
+
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
+
+	efd = epoll_create(1);
+	if (efd == -1)
+		tst_brk(TBROK | TERRNO, "epoll_create()");
+
+	e.events = EPOLLIN;
+	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+}
+
+static void cleanup(void)
+{
+	if (efd > 0)
+		SAFE_CLOSE(efd);
+
+	if (sfd[0] > 0)
+		SAFE_CLOSE(sfd[0]);
+
+	if (sfd[1] > 0)
+		SAFE_CLOSE(sfd[1]);
+}
+
+static struct tst_test test = {
+	.scall = "do_epoll_pwait()",
+	.sample = sample_fn,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = TEST_VARIANTS,
+};
--
2.17.1


From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 10 Aug 2021 19:00:24 +0800
Subject: [LTP] [PATCH 2/2] epoll_pwait: Add invalid timespec test for
 epoll_pwait05
In-Reply-To: <20210810110024.106436-1-xieziyao@huawei.com>
References: <20210810110024.106436-1-xieziyao@huawei.com>
Message-ID: <20210810110024.106436-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that, epoll_pwait2() return -1 and set errno to EINVAL with an invalid timespec.

Fixes: #792
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  1 +
 .../syscalls/epoll_pwait/epoll_pwait05.c      | 70 +++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 206281f6e..d3fc98758 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -169,6 +169,7 @@ epoll_pwait01 epoll_pwait01
 epoll_pwait02 epoll_pwait02
 epoll_pwait03 epoll_pwait03
 epoll_pwait04 epoll_pwait04
+epoll_pwait05 epoll_pwait05

 eventfd01 eventfd01

diff --git a/testcases/kernel/syscalls/epoll_pwait/.gitignore b/testcases/kernel/syscalls/epoll_pwait/.gitignore
index cdefffa2d..fafb2d782 100644
--- a/testcases/kernel/syscalls/epoll_pwait/.gitignore
+++ b/testcases/kernel/syscalls/epoll_pwait/.gitignore
@@ -2,3 +2,4 @@ epoll_pwait01
 epoll_pwait02
 epoll_pwait03
 epoll_pwait04
+epoll_pwait05
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
new file mode 100644
index 000000000..1373c36e5
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that, epoll_pwait2() return -1 and set errno to EINVAL with an
+ * invalid timespec.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "lapi/epoll.h"
+
+static int efd, sfd[2];
+static struct epoll_event e;
+
+static struct test_case_t {
+	struct timespec ts;
+	int exp_errno;
+	const char *desc;
+} tc[] = {
+	{{.tv_sec = -1}, EINVAL, "ts.tv_sec < 0"},
+	{{.tv_nsec = -1}, EINVAL, "ts.tv_nsec < 0"},
+	{{.tv_nsec = NSEC_PER_SEC}, EINVAL, "ts.tv_nsec >= NSEC_PER_SEC"},
+};
+
+static void run_all(unsigned int n)
+{
+	TST_EXP_FAIL(epoll_pwait2(efd, &e, 1, &tc[n].ts, NULL),
+		     tc[n].exp_errno, "with %s", tc[n].desc);
+}
+
+static void setup(void)
+{
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
+
+	efd = epoll_create(1);
+	if (efd == -1)
+		tst_brk(TBROK | TERRNO, "epoll_create()");
+
+	e.events = EPOLLIN;
+	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+	SAFE_WRITE(1, sfd[1], "w", 1);
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
+	.test = run_all,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tc),
+};
--
2.17.1


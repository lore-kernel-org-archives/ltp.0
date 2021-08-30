From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Mon, 30 Aug 2021 19:16:37 +0800
Subject: [LTP] [PATCH 2/3] epoll_ctl: Add test for epoll_ctl05
In-Reply-To: <20210830111638.66371-1-ziyaoxie@outlook.com>
References: <20210830111638.66371-1-ziyaoxie@outlook.com>
Message-ID: <OSZP286MB087162F01AEBEB096D291779CCCB9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that epoll_ctl() fails with ELOOP if fd refers to an epoll
instance and this EPOLL_CTL_ADD operation would result in a circular
loop of epoll instances monitoring one another.

Signed-off-by: Xie Ziyao <ziyaoxie@outlook.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |  1 +
 .../kernel/syscalls/epoll_ctl/epoll_ctl05.c   | 71 +++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 100ca932f..4c6b75dfa 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -166,6 +166,7 @@ epoll_ctl01 epoll_ctl01
 epoll_ctl02 epoll_ctl02
 epoll_ctl03 epoll_ctl03
 epoll_ctl04 epoll_ctl04
+epoll_ctl05 epoll_ctl05
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
diff --git a/testcases/kernel/syscalls/epoll_ctl/.gitignore b/testcases/kernel/syscalls/epoll_ctl/.gitignore
index f78db4002..3e05f2e1f 100644
--- a/testcases/kernel/syscalls/epoll_ctl/.gitignore
+++ b/testcases/kernel/syscalls/epoll_ctl/.gitignore
@@ -2,3 +2,4 @@ epoll_ctl01
 epoll_ctl02
 epoll_ctl03
 epoll_ctl04
+epoll_ctl05
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
new file mode 100644
index 000000000..d03009cf3
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2021
+ * Author: Xie Ziyao <ziyaoxie@outlook.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll_ctl() fails with ELOOP if fd refers to an epoll instance
+ * and this EPOLL_CTL_ADD operation would result in a circular loop of epoll
+ * instances monitoring one another.
+ */
+
+#include <poll.h>
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+
+#define MAX_DEPTH 5
+
+static int epfd, origin_epfd, new_epfd;
+static int fd[2];
+
+static struct epoll_event events = {.events = EPOLLIN};
+
+static void setup(void)
+{
+	int i;
+
+	SAFE_PIPE(fd);
+
+	for (i = 0, epfd = fd[0]; i < MAX_DEPTH; i++, epfd = new_epfd) {
+		new_epfd = epoll_create(1);
+		if (new_epfd == -1)
+			tst_brk(TBROK | TERRNO, "fail to create epoll instance");
+
+		if (i == 0)
+			origin_epfd = new_epfd;
+
+		events.data.fd = epfd;
+		if (epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events))
+			tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+	}
+
+	events.data.fd = fd[0];
+	if (epoll_ctl(origin_epfd, EPOLL_CTL_DEL, fd[0], &events))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_DEL, ...)");
+}
+
+static void cleanup(void)
+{
+	if (fd[0])
+		SAFE_CLOSE(fd[0]);
+
+	if (fd[1])
+		SAFE_CLOSE(fd[1]);
+}
+
+static void verify_epoll_ctl(void)
+{
+	events.data.fd = epfd;
+	TST_EXP_FAIL(epoll_ctl(origin_epfd, EPOLL_CTL_ADD, epfd, &events),
+		     ELOOP, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_epoll_ctl,
+};
--
2.25.1


From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Wed, 25 Aug 2021 15:39:30 +0000
Subject: [LTP] [PATCH 2/4 v2] epoll_ctl: Add test for epoll_ctl03
In-Reply-To: <20210825153932.138396-1-ziyaoxie@outlook.com>
References: <20210825153932.138396-1-ziyaoxie@outlook.com>
Message-ID: <OSZP286MB08712608A50835393F85FF90CCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Xie Ziyao" <ziyaoxie@outlook.com>

Check that epoll_ctl returns zero with different combinations of events on
success.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <ziyaoxie@outlook.com>
---
v1->v2:
1. Use IS_BIT_SET() macro to check whether the n-th bit of val is set.

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_ctl/.gitignore      |  5 +-
 .../kernel/syscalls/epoll_ctl/epoll_ctl03.c   | 78 +++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6762a234c..f6fe140b2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -161,6 +161,7 @@ epoll_create1_02 epoll_create1_02
 epoll01 epoll-ltp
 epoll_ctl01 epoll_ctl01
 epoll_ctl02 epoll_ctl02
+epoll_ctl03 epoll_ctl03
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
diff --git a/testcases/kernel/syscalls/epoll_ctl/.gitignore b/testcases/kernel/syscalls/epoll_ctl/.gitignore
index 634470a06..2b50d924c 100644
--- a/testcases/kernel/syscalls/epoll_ctl/.gitignore
+++ b/testcases/kernel/syscalls/epoll_ctl/.gitignore
@@ -1,2 +1,3 @@
-/epoll_ctl01
-/epoll_ctl02
+epoll_ctl01
+epoll_ctl02
+epoll_ctl03
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
new file mode 100644
index 000000000..df065c7c6
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2021
+ * Author: Xie Ziyao <ziyaoxie@outlook.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check that epoll_ctl returns zero with different combinations of events on
+ * success.
+ */
+
+#include <poll.h>
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "tst_bitmap.h"
+
+#define NUM_EPOLL_EVENTS 8
+#define WIDTH_EPOLL_EVENTS 256
+
+static int epfd, fds[2];
+static struct epoll_event events = {.events = EPOLLIN};
+
+static unsigned int events_type[NUM_EPOLL_EVENTS] = {
+		EPOLLIN, EPOLLOUT, EPOLLPRI, EPOLLERR,
+		EPOLLHUP, EPOLLET, EPOLLONESHOT, EPOLLRDHUP
+};
+
+static void run_all(void)
+{
+	unsigned int i, j, events_bitmap;
+
+	for (i = 0; i < WIDTH_EPOLL_EVENTS; i++) {
+		events_bitmap = 0;
+
+		for (j = 0; j < NUM_EPOLL_EVENTS; j++)
+			events_bitmap |= (events_type[j] * IS_BIT_SET(i, j));
+
+		events.events = events_bitmap;
+		TST_EXP_PASS(epoll_ctl(epfd, EPOLL_CTL_MOD, fds[0], &events),
+			     "epoll_ctl(..., EPOLL_CTL_MOD, ...) with events.events=%x",
+			     events.events);
+	}
+}
+
+static void setup(void)
+{
+	epfd = epoll_create(1);
+	if (epfd == -1)
+		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
+
+	SAFE_PIPE(fds);
+	events.data.fd = fds[0];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &events))
+		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+}
+
+static void cleanup(void)
+{
+	if (epfd)
+		SAFE_CLOSE(epfd);
+
+	if (fds[0])
+		SAFE_CLOSE(fds[0]);
+
+	if (fds[1])
+		SAFE_CLOSE(fds[1]);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_all,
+	.min_kver = "2.6.17",
+};
--
2.25.1


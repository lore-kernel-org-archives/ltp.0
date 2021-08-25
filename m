From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Wed, 25 Aug 2021 15:39:31 +0000
Subject: [LTP] [PATCH 3/4 v2] epoll_create: Add test for epoll_create01
In-Reply-To: <20210825153932.138396-1-ziyaoxie@outlook.com>
References: <20210825153932.138396-1-ziyaoxie@outlook.com>
Message-ID: <OSZP286MB08714234AC4DFA511FF003C2CCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Xie Ziyao" <ziyaoxie@outlook.com>

Verify that epoll_create return a nonnegative file descriptor on success.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <ziyaoxie@outlook.com>
---
v1->v2:
1. Use TST_EXP_FD() to check whether fd is valid.

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_create/.gitignore   |  1 +
 .../kernel/syscalls/epoll_create/Makefile     |  9 +++++
 .../syscalls/epoll_create/epoll_create01.c    | 37 +++++++++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_create/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_create/Makefile
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f6fe140b2..2540905a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -156,6 +156,7 @@ dup205 dup205
 dup3_01 dup3_01
 dup3_02 dup3_02

+epoll_create01 epoll_create01
 epoll_create1_01 epoll_create1_01
 epoll_create1_02 epoll_create1_02
 epoll01 epoll-ltp
diff --git a/testcases/kernel/syscalls/epoll_create/.gitignore b/testcases/kernel/syscalls/epoll_create/.gitignore
new file mode 100644
index 000000000..0ed4d940a
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/.gitignore
@@ -0,0 +1 @@
+epoll_create01
diff --git a/testcases/kernel/syscalls/epoll_create/Makefile b/testcases/kernel/syscalls/epoll_create/Makefile
new file mode 100644
index 000000000..ad856cee4
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2021
+# Author: Xie Ziyao <ziyaoxie@outlook.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
new file mode 100644
index 000000000..54fd0810d
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2021
+ * Author: Xie Ziyao <ziyaoxie@outlook.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that epoll_create return a nonnegative file descriptor on success.
+ *
+ * The size argument informed the kernel of the number of file descriptors
+ * that the caller expected to add to the epoll instance, but it is no longer
+ * required.
+ */
+
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "lapi/epoll.h"
+#include "lapi/syscalls.h"
+
+static int tc[] = {1, INT_MAX};
+
+static void run(unsigned int n)
+{
+	TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)", tc[n]);
+
+	if (!TST_PASS)
+		return;
+	SAFE_CLOSE(TST_PASS);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
+};
--
2.25.1


From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 16 Jul 2021 18:22:55 +0800
Subject: [LTP] [PATCH 3/5 v2] epoll_pwait: Add test variants for epoll_pwait
In-Reply-To: <20210716102257.20882-1-xieziyao@huawei.com>
References: <20210628080424.245911-3-xieziyao@huawei.com>
 <20210716102257.20882-1-xieziyao@huawei.com>
Message-ID: <20210716102257.20882-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add test variants to switch between different syscall variants/wrappers at runtime.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Add test variants to switch between epoll_pwait and epoll_pwait2.

 .../syscalls/epoll_pwait/epoll_pwait_var.h    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h

diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
new file mode 100644
index 000000000..2bdea17e9
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021. All rights reserved.
+ * Author: Xie Ziyao <xieziyao@huawei.com>
+ */
+
+#ifndef LTP_EPOLL_PWAIT_VAR_H
+#define LTP_EPOLL_PWAIT_VAR_H
+
+#include "lapi/epoll.h"
+
+#define TEST_VARIANTS 2
+#define MSEC_PER_SEC (1000L)
+#define NSEC_PER_MSEC (1000000L)
+
+static int do_epoll_pwait(int epfd, struct epoll_event *events, int
+	maxevents, int timeout, const sigset_t *sigmask)
+{
+	if (tst_variant == 0)
+		return epoll_pwait(epfd, events, maxevents, timeout, sigmask);
+
+	struct timespec ts;
+
+	if (timeout < 0) {
+		return epoll_pwait2(epfd, events, maxevents, NULL, sigmask);
+	} else {
+		ts.tv_sec = timeout / MSEC_PER_SEC;
+		ts.tv_nsec = NSEC_PER_MSEC * (timeout % MSEC_PER_SEC);
+	}
+
+	return epoll_pwait2(epfd, events, maxevents, &ts, sigmask);
+
+}
+
+static void epoll_pwait_info(void)
+{
+	if (tst_variant == 0)
+		tst_res(TINFO, "Test epoll_pwait()");
+	else
+		tst_res(TINFO, "Test epoll_pwait2()");
+}
+
+#endif //LTP_EPOLL_PWAIT_VAR_H
--
2.17.1


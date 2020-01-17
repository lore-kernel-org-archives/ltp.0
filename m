From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 17 Jan 2020 16:45:10 +0530
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open
In-Reply-To: <b4f5242fdca1659b2f71e1b3290fd32194e7340a.1579259595.git.viresh.kumar@linaro.org>
References: <b4f5242fdca1659b2f71e1b3290fd32194e7340a.1579259595.git.viresh.kumar@linaro.org>
Message-ID: <4dd4dabd2cd574dc2657c5926e8e3d1a0c8a8ae6.1579259595.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of pidfd_open() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                  |  1 +
 include/lapi/pidfd_open.h                     | 21 ++++++
 runtest/syscalls                              |  3 +
 .../kernel/syscalls/pidfd_open/.gitignore     |  2 +
 testcases/kernel/syscalls/pidfd_open/Makefile |  6 ++
 .../kernel/syscalls/pidfd_open/pidfd_open01.c | 38 +++++++++++
 .../kernel/syscalls/pidfd_open/pidfd_open02.c | 68 +++++++++++++++++++
 7 files changed, 139 insertions(+)
 create mode 100644 include/lapi/pidfd_open.h
 create mode 100644 testcases/kernel/syscalls/pidfd_open/.gitignore
 create mode 100644 testcases/kernel/syscalls/pidfd_open/Makefile
 create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
 create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open02.c

diff --git a/configure.ac b/configure.ac
index 50d14967d3c6..1bf0911d88ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,6 +79,7 @@ AC_CHECK_FUNCS([ \
     mknodat \
     name_to_handle_at \
     openat \
+    pidfd_open \
     pidfd_send_signal \
     pkey_mprotect \
     preadv \
diff --git a/include/lapi/pidfd_open.h b/include/lapi/pidfd_open.h
new file mode 100644
index 000000000000..ced163be83bf
--- /dev/null
+++ b/include/lapi/pidfd_open.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef PIDFD_OPEN_H
+#define PIDFD_OPEN_H
+
+#include "config.h"
+#include <sys/types.h>
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_PIDFD_OPEN
+int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return tst_syscall(__NR_pidfd_open, pid, flags);
+}
+#endif
+
+#endif /* PIDFD_OPEN_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index fa87ef63fbc1..9d6d288780a3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -846,6 +846,9 @@ pause03 pause03
 personality01 personality01
 personality02 personality02
 
+pidfd_open01 pidfd_open01
+pidfd_open02 pidfd_open02
+
 pidfd_send_signal01 pidfd_send_signal01
 pidfd_send_signal02 pidfd_send_signal02
 pidfd_send_signal03 pidfd_send_signal03
diff --git a/testcases/kernel/syscalls/pidfd_open/.gitignore b/testcases/kernel/syscalls/pidfd_open/.gitignore
new file mode 100644
index 000000000000..be218f88647d
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/.gitignore
@@ -0,0 +1,2 @@
+pidfd_open01
+pidfd_open02
diff --git a/testcases/kernel/syscalls/pidfd_open/Makefile b/testcases/kernel/syscalls/pidfd_open/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
new file mode 100644
index 000000000000..4e3417c487a6
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic pidfd_open() test, fetches the PID of the current process and tries to
+ * get its file descriptor.
+ */
+#include <sys/types.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "lapi/pidfd_open.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	int p_id, fd;
+
+	p_id = getpid();
+
+	TEST(pidfd_open(p_id, 0));
+
+	fd = TST_RET;
+	if (fd == -1) {
+		tst_res(TFAIL, "Cannot retrieve file descriptor to the current process");
+		return;
+	}
+
+	SAFE_CLOSE(fd);
+
+	tst_res(TPASS, "Retrieved file descriptor to the current process");
+}
+
+static struct tst_test test = {
+	.min_kver = "5.3",
+	.test_all = run,
+};
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
new file mode 100644
index 000000000000..b67393bcafa2
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * This program opens the PID file descriptor of the child process created with
+ * fork(). It then uses poll to monitor the file descriptor for process exit, as
+ * indicated by an EPOLLIN event.
+ */
+#include <poll.h>
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "lapi/pidfd_open.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	struct pollfd pollfd;
+	int p_id, fd, ready;
+
+	TEST(fork());
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "fork() Failed");
+		tst_res(TBROK, "unable to continue");
+	}
+
+	if (TST_RET == 0) {
+		/* child */
+		usleep(1000);
+		exit(EXIT_SUCCESS);
+	} else {
+		/* parent */
+		p_id = TST_RET;
+
+		TEST(pidfd_open(p_id, 0));
+
+		fd = TST_RET;
+		if (fd == -1) {
+			tst_res(TFAIL, "Cannot retrieve file descriptor to the child process");
+			return;
+		}
+
+		pollfd.fd = fd;
+		pollfd.events = POLLIN;
+
+		ready = poll(&pollfd, 1, -1);
+		if (ready == -1) {
+			tst_res(TFAIL, "poll() Failed");
+			tst_res(TBROK, "unable to continue");
+		}
+
+		printf("Events (0x%x): POLLIN is %sset\n", pollfd.revents,
+				(pollfd.revents & POLLIN) ? "" : "not ");
+
+		SAFE_CLOSE(fd);
+	}
+}
+
+static struct tst_test test = {
+	.min_kver = "5.3",
+	.test_all = run,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b


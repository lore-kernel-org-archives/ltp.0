From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Jan 2020 15:18:27 +0530
Subject: [LTP] [PATCH V3 2/2] syscalls/pidfd_open
In-Reply-To: <1dbcadb1781ba1f0584eb92c83aec5f66abb109c.1579858930.git.viresh.kumar@linaro.org>
References: <1dbcadb1781ba1f0584eb92c83aec5f66abb109c.1579858930.git.viresh.kumar@linaro.org>
Message-ID: <8dc3dff0390db58b2f472501c30595647a913e34.1579858930.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of pidfd_open() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Add pidfd_open03 to syscalls and .gitignore files.
- Use TEST, tst_get_unused_pid, etc.
- Do the failure testing with help of array and .tcnt.
- Improved print messages.
- Removed useless comments.
- Few more minor changes.

V1->V2:
- New test to test failures
- Use SAFE_FORK, checkpoints, etc
- Print error numbers as well.
- Improved print messages.

 configure.ac                                  |  1 +
 include/lapi/pidfd_open.h                     | 21 +++++++
 runtest/syscalls                              |  4 ++
 .../kernel/syscalls/pidfd_open/.gitignore     |  3 +
 testcases/kernel/syscalls/pidfd_open/Makefile |  6 ++
 .../kernel/syscalls/pidfd_open/pidfd_open01.c | 34 ++++++++++
 .../kernel/syscalls/pidfd_open/pidfd_open02.c | 63 +++++++++++++++++++
 .../kernel/syscalls/pidfd_open/pidfd_open03.c | 63 +++++++++++++++++++
 8 files changed, 195 insertions(+)
 create mode 100644 include/lapi/pidfd_open.h
 create mode 100644 testcases/kernel/syscalls/pidfd_open/.gitignore
 create mode 100644 testcases/kernel/syscalls/pidfd_open/Makefile
 create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
 create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
 create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open03.c

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
index f58fefe17c34..f083758bc637 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -848,6 +848,10 @@ pause03 pause03
 personality01 personality01
 personality02 personality02
 
+pidfd_open01 pidfd_open01
+pidfd_open02 pidfd_open02
+pidfd_open03 pidfd_open03
+
 pidfd_send_signal01 pidfd_send_signal01
 pidfd_send_signal02 pidfd_send_signal02
 pidfd_send_signal03 pidfd_send_signal03
diff --git a/testcases/kernel/syscalls/pidfd_open/.gitignore b/testcases/kernel/syscalls/pidfd_open/.gitignore
new file mode 100644
index 000000000000..e0b8900c1c33
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/.gitignore
@@ -0,0 +1,3 @@
+pidfd_open01
+pidfd_open02
+pidfd_open03
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
index 000000000000..e40ea4f2eff5
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -0,0 +1,34 @@
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
+	int fd;
+
+	TEST(pidfd_open(getpid(), 0));
+
+	fd = TST_RET;
+	if (fd == -1)
+		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
+
+	SAFE_CLOSE(fd);
+
+	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
+}
+
+static struct tst_test test = {
+	.min_kver = "5.3",
+	.test_all = run,
+};
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
new file mode 100644
index 000000000000..5e5431335731
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic pidfd_open() test to test invalid arguments.
+ */
+#include <sys/types.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "lapi/pidfd_open.h"
+#include "lapi/syscalls.h"
+
+#define INVALID_PID	-1
+#define MY_PID		0
+#define EXPIRED_PID	1
+
+static struct tcase {
+	char *name;
+	int pid;
+	int flags;
+	int exp_errno;
+} tcases[] = {
+	{"test-expired-pid", EXPIRED_PID, 0, ESRCH},
+	{"test-invalid-pid", INVALID_PID, 0, EINVAL},
+	{"test-invalid-flags", MY_PID, 1, EINVAL},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
+
+	if (tc->pid == EXPIRED_PID)
+		pid = tst_get_unused_pid();
+	else if (tc->pid == MY_PID)
+		pid = getpid();
+	else
+		pid = tc->pid;
+
+	TEST(pidfd_open(pid, tc->flags));
+
+	if (TST_RET != -1) {
+		SAFE_CLOSE(TST_RET);
+		tst_brk(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
+			tc->name, n);
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_brk(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	}
+
+	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
+		tc->name);
+}
+
+static struct tst_test test = {
+	.min_kver = "5.3",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
new file mode 100644
index 000000000000..efa14dc52d7a
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
@@ -0,0 +1,63 @@
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
+
+#include "tst_test.h"
+#include "lapi/pidfd_open.h"
+#include "lapi/syscalls.h"
+
+static void run(void)
+{
+	struct pollfd pollfd;
+	int fd, ready;
+	pid_t pid;
+
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		TST_CHECKPOINT_WAIT(0);
+		exit(EXIT_SUCCESS);
+	} else {
+		TEST(pidfd_open(pid, 0));
+
+		fd = TST_RET;
+		if (fd == -1)
+			tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");
+
+		TST_CHECKPOINT_WAKE(0);
+
+		pollfd.fd = fd;
+		pollfd.events = POLLIN;
+
+		ready = poll(&pollfd, 1, -1);
+
+		SAFE_CLOSE(fd);
+		SAFE_WAITPID(pid, NULL, 0);
+
+		if (ready == -1)
+			tst_brk(TBROK | TERRNO, "poll() failed");
+
+		if (ready != 1)
+			tst_brk(TBROK, "poll() should return 1");
+
+		tst_res(TPASS, "pidfd_open() passed");
+	}
+}
+
+static struct tst_test test = {
+	.min_kver = "5.3",
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.21.0.rc0.269.g1a574e7a288b


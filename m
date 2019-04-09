From: Christian Amann <camann@suse.com>
Date: Tue,  9 Apr 2019 08:29:26 +0200
Subject: [LTP] [PATCH v1] syscalls/ioprio: add ioprio_get/ioprio_set tests
Message-ID: <20190409062926.13584-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

    ioprio01:
        Tests the functionality to set I/O priority using
        ioprio_set and then checks if it was set correctly
        using ioprio_get.

    ioprio02:
        Tests if ioprio_set fails with correct error when
        wrong arguments get passed.

Signed-off-by: Christian Amann <camann@suse.com>
---
 testcases/kernel/syscalls/ioprio/.gitignore |   2 +
 testcases/kernel/syscalls/ioprio/Makefile   |  14 ++++
 testcases/kernel/syscalls/ioprio/ioprio01.c | 106 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioprio/ioprio02.c |  88 +++++++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioprio/.gitignore
 create mode 100644 testcases/kernel/syscalls/ioprio/Makefile
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio01.c
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio02.c

diff --git a/testcases/kernel/syscalls/ioprio/.gitignore b/testcases/kernel/syscalls/ioprio/.gitignore
new file mode 100644
index 000000000..35e759777
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/.gitignore
@@ -0,0 +1,2 @@
+/ioprio01
+/ioprio02
diff --git a/testcases/kernel/syscalls/ioprio/Makefile b/testcases/kernel/syscalls/ioprio/Makefile
new file mode 100644
index 000000000..d89eb7797
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/Makefile
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright (c) 2019 SUSE LLC
+#
+#   Author: Christian Amann <camann@suse.com>
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+ioprio01: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/ioprio/ioprio01.c b/testcases/kernel/syscalls/ioprio/ioprio01.c
new file mode 100644
index 000000000..b35dcd09e
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio01.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ *
+ */
+
+/*
+ * Tests the functionality to set I/O priority using
+ * ioprio_set and then checks if it was set correctly
+ * using ioprio_get
+ *
+ * 1) Set the priority using the process ID to best-effort scheduling
+ * 2) Set the priority using the process ID to idle scheduling
+ * 3) Set the priority using the group ID to best-effort scheduling
+ * 4) Set the priority using the ID of a thread to real-time scheduling
+ * 5) Set the priority using the user ID to best-effort scheduling
+ *
+ */
+
+#include <stdlib.h>
+#include "config.h"
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/syscalls.h"
+#include "sys/types.h"
+#include "../utils/ioprio.h"
+
+#define gettid() tst_syscall(__NR_gettid)
+
+static int uid;
+static int pid;
+static int gid;
+static int tid;
+
+static struct tcase {
+	int	which;
+	int	*who;
+	int	priority;
+	int	sched_class;
+} tcases[] = {
+	{IOPRIO_WHO_PROCESS, &pid, 0, IOPRIO_CLASS_BE},
+	{IOPRIO_WHO_PROCESS, &pid, 7, IOPRIO_CLASS_IDLE},
+	{IOPRIO_WHO_PGRP, &gid, 0, IOPRIO_CLASS_BE},
+	{IOPRIO_WHO_PROCESS, &tid, 7, IOPRIO_CLASS_RT},
+	{IOPRIO_WHO_USER, &uid, 3, IOPRIO_CLASS_BE},
+};
+
+static int sys_ioprio_get(int which, int who)
+{
+	return tst_syscall(__NR_ioprio_get, which, who);
+}
+static int sys_ioprio_set(int which, int who, int ioprio)
+{
+	return tst_syscall(__NR_ioprio_set, which, who, ioprio);
+}
+
+static void verify_ioprio(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int setIOprio, getIOprio;
+
+	setIOprio = IOPRIO_PRIO_VALUE(tc->sched_class, tc->priority);
+
+	TEST(sys_ioprio_set(tc->which, *tc->who, setIOprio));
+
+	if (TST_RET != 0) {
+		tst_res(TFAIL, "ioprio_set failed with error %s",
+				tst_strerrno(TST_ERR));
+		return;
+	}
+
+	TEST(getIOprio = sys_ioprio_get(tc->which, *tc->who));
+
+	if (setIOprio != getIOprio) {
+		tst_res(TFAIL, "ioprio_get returned wrong IO priority");
+		return;
+	}
+
+	tst_res(TPASS, "ioprio_set set correct IO priority");
+}
+
+static void io_thread(void)
+{
+	tid = gettid();
+	pause();
+}
+
+static void setup(void)
+{
+	uid = getuid();
+	gid = getgid();
+	pid = getpid();
+	pthread_t thread;
+
+	SAFE_PTHREAD_CREATE(&thread, NULL,
+			(void * (*)(void *)) io_thread, NULL);
+}
+
+static struct tst_test test = {
+	.test = verify_ioprio,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.needs_root = 1,
+	.min_kver = "2.6.13",
+};
diff --git a/testcases/kernel/syscalls/ioprio/ioprio02.c b/testcases/kernel/syscalls/ioprio/ioprio02.c
new file mode 100644
index 000000000..92fb804ef
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio02.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ *
+ */
+
+/*
+ * Tests if ioprio_set fails correctly when presented with wrong
+ * arguments
+ *
+ * 1) Set 'which' to an invalid value -> fails with EINVAL
+ * 2) Set the priority to 2 while the schedule class is set
+ *    to 'None' -> fails with EINVAL
+ * 3) Set the priority to a invalid value -> fails with EINVAL
+ * 4) Trying to set the IO priority of a non-existent process
+ *    -> fails with ESRCH
+ * 5) Trying to set real-time scheduling as non-root user
+ *    (privileges are dropped) -> fails with EPERM
+ */
+
+#include <stdlib.h>
+#include <pwd.h>
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "sys/types.h"
+#include "../utils/ioprio.h"
+
+static int pid;
+static int unused_pid;
+static struct passwd *pw;
+
+static struct tcase {
+	int	which;
+	int	*who;
+	int	priority;
+	int	sched_class;
+	int	exp_error;
+} tcases[] = {
+	{-1, &pid, 0, IOPRIO_CLASS_BE, EINVAL},
+	{IOPRIO_WHO_PROCESS, &pid, 2, IOPRIO_CLASS_NONE, EINVAL},
+	{IOPRIO_WHO_PROCESS, &pid, 50, IOPRIO_CLASS_BE, EINVAL},
+	{IOPRIO_WHO_PROCESS, &unused_pid, 0, IOPRIO_CLASS_BE, ESRCH},
+	{IOPRIO_WHO_PROCESS, &pid, 5, IOPRIO_CLASS_RT, EPERM},
+};
+
+static int sys_ioprio_set(int which, int who, int ioprio)
+{
+	return tst_syscall(__NR_ioprio_set, which, who, ioprio);
+}
+
+static void verify_ioprio(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int setIOprio;
+
+	setIOprio = IOPRIO_PRIO_VALUE(tc->sched_class, tc->priority);
+
+	TEST(sys_ioprio_set(tc->which, *tc->who, setIOprio));
+
+	if (tc->exp_error != TST_ERR) {
+		tst_res(TFAIL, "ioprio_set returned error %s, expected %s",
+				tst_strerrno(TST_ERR),
+				tst_strerrno(tc->exp_error));
+		return;
+	}
+
+	tst_res(TPASS, "ioprio_set failed as expected");
+}
+
+static void setup(void)
+{
+	pid = getpid();
+	unused_pid = tst_get_unused_pid();
+
+	if (!getuid()) {
+		pw = SAFE_GETPWNAM("nobody");
+		SAFE_SETUID(pw->pw_uid);
+	}
+}
+
+static struct tst_test test = {
+	.test = verify_ioprio,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.min_kver = "2.6.13",
+};
-- 
2.16.4


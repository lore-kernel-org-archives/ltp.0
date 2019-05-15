From: Christian Amann <camann@suse.com>
Date: Wed, 15 May 2019 14:01:16 +0200
Subject: [LTP] [PATCH v1 4/4] syscalls/pidfd_send_signal03
In-Reply-To: <20190515120116.11589-1-camann@suse.com>
References: <20190515120116.11589-1-camann@suse.com>
Message-ID: <20190515120116.11589-4-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add testcase to check if the syscall will send a signal
to a process with the same PID as the targeted process.

Signed-off-by: Christian Amann <camann@suse.com>
---
 runtest/syscalls                                   |   1 +
 .../kernel/syscalls/pidfd_send_signal/.gitignore   |   1 +
 .../pidfd_send_signal/pidfd_send_signal03.c        | 118 +++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fd57e2ee7..a534a663b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -840,6 +840,7 @@ personality02 personality02
 
 pidfd_send_signal01 pidfd_send_signal01
 pidfd_send_signal02 pidfd_send_signal02
+pidfd_send_signal03 pidfd_send_signal03
 
 pipe01 pipe01
 pipe02 pipe02
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/.gitignore b/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
index 6ea6401a8..cba7d50a4 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
+++ b/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
@@ -1,2 +1,3 @@
 /pidfd_send_signal01
 /pidfd_send_signal02
+/pidfd_send_signal03
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
new file mode 100644
index 000000000..ee17e714e
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+/*
+ * This test checks if the pidfd_send_signal syscall wrongfully sends
+ * a signal to a new process which inherited the PID of the actual
+ * target process.
+ * In order to do so it is necessary to start a process with a pre-
+ * determined PID. This is accomplished by writing to the
+ * /proc/sys/kernel/ns_last_pid file.
+ * By utilizing this, this test forks two children with the same PID.
+ * It is then checked, if the syscall will send a signal to the second
+ * child using the pidfd of the first one.
+ */
+
+#define _GNU_SOURCE
+
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "pidfd_send_signal.h"
+#include "tst_safe_pthread.h"
+
+#define PIDTRIES	3
+
+static char *last_pid_file;
+static int pidfd, last_pidfd;
+
+static void verify_pidfd_send_signal(void)
+{
+	pid_t pid, new_pid;
+	char pid_filename[32];
+	char pid_str[16];
+	int i, fail;
+
+	fail = 1;
+	for (i = 1; i <= PIDTRIES; i++) {
+		pid = SAFE_FORK();
+		if (pid == 0) {
+			TST_CHECKPOINT_WAIT(0);
+			return;
+		}
+
+		sprintf(pid_filename, "/proc/%d", pid);
+		pidfd = SAFE_OPEN(pid_filename, O_DIRECTORY | O_CLOEXEC);
+
+		TST_CHECKPOINT_WAKE(0);
+		tst_reap_children();
+
+		/* Manipulate PID for next process */
+		sprintf(pid_str, "%d", pid - 1);
+		SAFE_LSEEK(last_pidfd, 0, SEEK_SET);
+		SAFE_WRITE(1, last_pidfd, pid_str, strlen(pid_str));
+
+		new_pid = SAFE_FORK();
+		if (new_pid == 0) {
+			TST_CHECKPOINT_WAIT(i);
+			return;
+		} else if (new_pid == pid) {
+			fail = 0;
+			break;
+		}
+
+		if (i < PIDTRIES)
+			tst_res(TINFO,
+				"Failed to set correct PID, trying again...");
+		SAFE_CLOSE(pidfd);
+		TST_CHECKPOINT_WAKE(i);
+		tst_reap_children();
+	}
+	if (fail)
+		tst_brk(TBROK,
+			"Could not set new child to same PID as the old one!");
+
+	TEST(tst_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0));
+	if (TST_RET == -1 && TST_ERR == ESRCH) {
+		tst_res(TPASS,
+			"Did not send signal to wrong process with same PID!");
+	} else
+		tst_res(TFAIL | TTERRNO,
+			"pidf_send_signal() ended unexpectedly - return value: %ld, error",
+			TST_RET);
+
+	TST_CHECKPOINT_WAKE(i);
+	tst_reap_children();
+
+	SAFE_CLOSE(pidfd);
+}
+
+static void setup(void)
+{
+	last_pid_file = "/proc/sys/kernel/ns_last_pid";
+	if (access(last_pid_file, F_OK) == -1)
+		tst_brk(TCONF, "%s does not exist, cannot set PIDs",
+			last_pid_file);
+	last_pidfd = SAFE_OPEN(last_pid_file, O_RDWR);
+}
+
+static void cleanup(void)
+{
+	tst_reap_children();
+	if (pidfd > 0)
+		SAFE_CLOSE(pidfd);
+	if (last_pidfd > 0)
+		SAFE_CLOSE(last_pidfd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_pidfd_send_signal,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.timeout = 20,
+};
-- 
2.16.4


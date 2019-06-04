From: Christian Amann <camann@suse.com>
Date: Tue,  4 Jun 2019 13:47:02 +0200
Subject: [LTP] [PATCH v2 4/4] syscalls/pidfd_send_signal03
In-Reply-To: <20190604114702.28255-1-camann@suse.com>
References: <20190604114702.28255-1-camann@suse.com>
Message-ID: <20190604114702.28255-3-camann@suse.com>
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
 .../pidfd_send_signal/pidfd_send_signal03.c        | 142 +++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 90a1cf8e6..7274c7741 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -838,6 +838,7 @@ personality02 personality02
 
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
index 000000000..a04d59ef2
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -0,0 +1,142 @@
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
+//#include "tst_safe_file_ops.h"
+
+#define PIDTRIES	3
+
+static char *last_pid_file;
+static int pidfd, new_pidfd;
+static int old_inode, new_inode;
+
+static int get_inode_number(int fd)
+{
+	struct stat file_stat;
+
+	SAFE_FSTAT(fd, &file_stat);
+	return file_stat.st_ino;
+}
+
+static void verify_pidfd_send_signal(void)
+{
+	pid_t pid, new_pid;
+	char pid_filename[32];
+	char pid_str[16];
+	int i, fail;
+
+	fail = 1;
+	for (i = 0; i < PIDTRIES; i++) {
+		pid = SAFE_FORK();
+		if (pid == 0) {
+			TST_CHECKPOINT_WAIT(0);
+			return;
+		}
+
+		sprintf(pid_filename, "/proc/%d", pid);
+		pidfd = SAFE_OPEN(pid_filename, O_DIRECTORY | O_CLOEXEC);
+		old_inode = get_inode_number(pidfd);
+
+		TST_CHECKPOINT_WAKE(0);
+		tst_reap_children();
+
+		/* Manipulate PID for next process */
+		sprintf(pid_str, "%d", pid - 1);
+		SAFE_FILE_PRINTF(last_pid_file, pid_str);
+
+		new_pid = SAFE_FORK();
+		if (new_pid == 0) {
+			TST_CHECKPOINT_WAIT(0);
+			return;
+		}
+
+		if (new_pid == pid) {
+			new_pidfd = SAFE_OPEN(pid_filename,
+					O_DIRECTORY | O_CLOEXEC);
+			new_inode = get_inode_number(new_pidfd);
+			SAFE_CLOSE(new_pidfd);
+			fail = 0;
+			break;
+		}
+
+		if (i < PIDTRIES) {
+			tst_res(TINFO,
+				"Failed to set correct PID, trying again...");
+		}
+		SAFE_CLOSE(pidfd);
+		TST_CHECKPOINT_WAKE(0);
+		tst_reap_children();
+	}
+	if (fail) {
+		tst_brk(TBROK,
+			"Could not set new child to same PID as the old one!");
+	}
+	if (old_inode == new_inode) {
+		tst_res(TWARN,
+			"File descriptor of new process points to the inode "
+			"of the old process!");
+	}
+
+	TEST(pidfd_send_signal(pidfd, SIGUSR1, NULL, 0));
+	if (TST_RET == -1 && TST_ERR == ESRCH) {
+		tst_res(TPASS,
+			"Did not send signal to wrong process with same PID!");
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"pidf_send_signal() ended unexpectedly - return value: %ld, error",
+			TST_RET);
+	}
+	TST_CHECKPOINT_WAKE(0);
+	tst_reap_children();
+
+	SAFE_CLOSE(pidfd);
+}
+
+static void setup(void)
+{
+	check_syscall_support();
+
+	last_pid_file = "/proc/sys/kernel/ns_last_pid";
+	if (access(last_pid_file, F_OK) == -1) {
+		tst_brk(TCONF, "%s does not exist, cannot set PIDs",
+			last_pid_file);
+	}
+}
+
+static void cleanup(void)
+{
+	tst_reap_children();
+	if (new_pidfd > 0)
+		SAFE_CLOSE(new_pidfd);
+	if (pidfd > 0)
+		SAFE_CLOSE(pidfd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_pidfd_send_signal,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+};
-- 
2.16.4


From: Vishnu K <vishnu@zilogic.com>
Date: Thu, 20 Sep 2018 11:27:31 -0000
Subject: [LTP] [PATCH v1] Test statx() with flag AT_NO_AUTOMOUNT.
Message-ID: <20180920112731.6108-1-vishnu@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Signed-off-by: vishnu@zilogic.com
Signed-off-by: vaishnavi.d@zilogic.com
Signed-off-by: tarun@zilogic.com
---
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx11.c  | 194 +++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be7713..99c9a2fce 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1504,3 +1504,4 @@ statx02 statx02
 statx03 statx03
 statx04 statx04
 statx05 statx05
+statx11 statx11
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 209fc3a33..606fb1a59 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -3,3 +3,4 @@
 /statx03
 /statx04
 /statx05
+/statx11
diff --git a/testcases/kernel/syscalls/statx/statx11.c b/testcases/kernel/syscalls/statx/statx11.c
new file mode 100644
index 000000000..62b4e7b48
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx11.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ *  Email : code@zilogic.com
+ */
+
+/*
+ * Testcase for statx syscall with AT_NO_AUTOMOUNT flag
+ *
+ * --Test Logic--
+ * Configure a mount point for autofs.
+ *
+ * Spawn a new child process.
+ *
+ * statx() is invoked within the child process-
+ *   With AT_NO_AUTOMOUNT flag- Child won't send any autofs notification
+ *                              message to parent.
+ *   Without AT_NO_AUTOMOUNT flag- Child will send autofs notification
+ *                                 message to parent, that can be read via pipe.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/time.h>
+#include <sys/eventfd.h>
+#include <stdbool.h>
+
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT "mntpoint"
+
+static int autofs_fds[2] = {-1};
+static int ev_fd = -1;
+static int mounted;
+static int pipe_created;
+static int mnt_dir_created;
+static int ev_fd_created;
+
+static bool check_autofs_notification_msg(int autofs_read_fd, int ev_fd)
+{
+	int retval;
+	int max_fd;
+	fd_set rfds;
+	u_int64_t statx_status;
+	struct timeval tv;
+	bool notification_msg_status;
+
+	max_fd = (autofs_read_fd > ev_fd) ? autofs_read_fd : ev_fd;
+
+	FD_ZERO(&rfds);
+	FD_SET(autofs_read_fd, &rfds);
+	FD_SET(ev_fd, &rfds);
+
+	tv.tv_sec = 5;
+	tv.tv_usec = 0;
+
+	retval = select((max_fd + 1), &rfds, NULL, NULL, &tv);
+	if (retval == -1)
+		tst_brk(TBROK | TERRNO, "select() failed");
+
+	if (FD_ISSET(autofs_read_fd, &rfds))
+		notification_msg_status = true;
+	else
+		notification_msg_status = false;
+
+	if (FD_ISSET(ev_fd, &rfds)) {
+		SAFE_READ(0, ev_fd, &statx_status, sizeof(statx_status));
+		if (statx_status == 1)
+			tst_brk(TBROK, "statx() failed");
+		else if (statx_status == 2)
+			tst_res(TINFO, "statx() passed");
+	}
+
+	return notification_msg_status;
+}
+
+void autofs_mount(int fd)
+{
+	char mnt_options[64];
+
+	SAFE_MKDIR(MNTPOINT, 0666);
+	mnt_dir_created = 1;
+
+	snprintf(mnt_options, sizeof(mnt_options),
+		 "fd=%i,minproto=5,maxproto=5,direct", fd);
+
+	SAFE_MOUNT("ltp_test", MNTPOINT, "autofs", 0, mnt_options);
+	mounted = 1;
+}
+
+static void autofs_run_test(bool automount)
+{
+	pid_t pid;
+	bool mnt_status;
+	u_int64_t value;
+	struct statx file_info;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		setpgrp();
+
+		TEST(statx(AT_FDCWD, MNTPOINT,
+			   (automount) ? 0 : AT_NO_AUTOMOUNT,
+			   0, &file_info)
+		     );
+
+		if (TST_RET == -1) {
+			/* 1 -> statx() fail*/
+			value = 1;
+			SAFE_WRITE(1, ev_fd, &value, sizeof(value));
+
+			exit(1);
+		}
+
+		/* 2 -> statx() pass*/
+		value = 2;
+		SAFE_WRITE(1, ev_fd, &value, sizeof(value));
+
+		exit(0);
+	}
+
+	mnt_status = check_autofs_notification_msg(autofs_fds[0], ev_fd);
+	if (automount == mnt_status)
+		tst_res(TPASS, "Mount Status: %d Expected Status: %d",
+			mnt_status, automount);
+	else
+		tst_brk(TFAIL, "Mount Status: %d Expected Status: %d",
+			mnt_status, automount);
+
+	SAFE_KILL(pid, SIGKILL);
+	SAFE_WAITPID(pid, NULL, 0);
+}
+
+static void setup(void)
+{
+	/*
+	 * Need for eventfd()-
+	 * To make the parent process aware that statx() has
+	 * passed/failed in the child process.
+	 */
+	ev_fd = eventfd(0, O_NONBLOCK);
+	if (ev_fd == -1)
+		tst_brk(TBROK | TERRNO, "eventfd() failed");
+	ev_fd_created = 1;
+
+	SAFE_PIPE(autofs_fds);
+	pipe_created = 1;
+
+	autofs_mount(autofs_fds[1]);
+}
+
+static void cleanup(void)
+{
+	if (mounted)
+		SAFE_UMOUNT(MNTPOINT);
+
+	if (mnt_dir_created)
+		SAFE_RMDIR(MNTPOINT);
+
+	if (ev_fd_created)
+		SAFE_CLOSE(ev_fd);
+
+	if (pipe_created) {
+		SAFE_CLOSE(autofs_fds[0]);
+		SAFE_CLOSE(autofs_fds[1]);
+	}
+}
+
+const struct {
+	bool automount;
+} tests[] = { {false},
+	      {true} };
+
+static void test_controller(unsigned int tst_nr)
+{
+	bool automount = tests[tst_nr].automount;
+
+	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, 0, &file_info)",
+		MNTPOINT, (automount) ? "0" : "AT_NO_AUTOMOUNT");
+
+	autofs_run_test(automount);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tests),
+	.test = test_controller,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.17.1


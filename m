From: Jan Kara <jack@suse.cz>
Date: Tue, 14 Mar 2017 10:40:38 +0100
Subject: [LTP] [PATCH v2] fanotify: Add test for permission event destruction
Message-ID: <20170314094038.10412-1-jack@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test whether kernel's notification subsystem gets stuck when some
fanotify permission events are not responded to. Also test destruction
of fanotify instance while there are outstanding permission events. This
can result in hanging of processes indefinitely in kernel or in kernel
crashes.

Kernel crashes should be fixed by commit 96d41019e3ac "fanotify: fix
list corruption in fanotify_get_response()", kernel hangs by "fanotify:
Release SRCU lock when waiting for userspace response" (not yet landed
upstream).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/fanotify/fanotify07.c | 264 ++++++++++++++++++++++++
 2 files changed, 265 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify07.c

OK, I finally got to porting the fanotify permission events test to new LTP
api. Here is the result.

diff --git a/runtest/syscalls b/runtest/syscalls
index 89abac5ff5f8..94232c6cf21e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -473,6 +473,7 @@ fanotify03 fanotify03
 fanotify04 fanotify04
 fanotify05 fanotify05
 fanotify06 fanotify06
+fanotify07 fanotify07
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
new file mode 100644
index 000000000000..69722fc365df
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -0,0 +1,264 @@
+/*
+ * Copyright (c) 2016 SUSE.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Started by Jan Kara <jack@suse.cz>
+ *
+ * DESCRIPTION
+ *     Check that fanotify permission events are handled properly on instance
+ *     destruction.
+ */
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/fcntl.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/syscall.h>
+#include "tst_test.h"
+#include "linux_syscall_numbers.h"
+#include "fanotify.h"
+#include "tst_safe_macros.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define BUF_SIZE 256
+static char fname[BUF_SIZE];
+static char buf[BUF_SIZE];
+static volatile int fd_notify;
+
+/* Number of children we start */
+#define MAX_CHILDREN 16
+static pid_t child_pid[MAX_CHILDREN];
+
+/* Number of children we don't respond to before stopping */
+#define MAX_NOT_RESPONDED 4
+
+static void generate_events(void)
+{
+	int fd;
+
+	/*
+	 * generate sequence of events
+	 */
+	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
+		exit(1);
+
+	/* Run until killed... */
+	while (1) {
+		lseek(fd, 0, SEEK_SET);
+		if (read(fd, buf, BUF_SIZE) == -1)
+			exit(3);
+	}
+}
+
+static void run_children(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHILDREN; i++) {
+		child_pid[i] = SAFE_FORK();
+		if (!child_pid[i]) {
+			/* Child will generate events now */
+			close(fd_notify);
+			generate_events();
+			exit(0);
+		}
+	}
+}
+
+static int stop_children(void)
+{
+	int child_ret;
+	int i, ret = 0;
+
+	for (i = 0; i < MAX_CHILDREN; i++)
+		kill(child_pid[i], SIGKILL);
+
+	for (i = 0; i < MAX_CHILDREN; i++) {
+		if (waitpid(child_pid[i], &child_ret, 0) < 0) {
+			tst_brk(TBROK | TERRNO,
+				"waitpid(-1, &child_ret, 0) failed");
+		}
+		if (!WIFSIGNALED(child_ret))
+			ret = 1;
+	}
+
+	return ret;
+}
+
+static int setup_instance(void)
+{
+	int fd;
+
+	if ((fd = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY)) < 0) {
+		if (errno == ENOSYS) {
+			tst_brk(TCONF,
+				"fanotify is not configured in this kernel.");
+		} else {
+			tst_brk(TBROK | TERRNO, "fanotify_init failed");
+		}
+	}
+
+	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,
+			  fname) < 0) {
+		close(fd);
+		if (errno == EINVAL) {
+			tst_brk(TCONF | TERRNO,
+				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
+				"configured in kernel?");
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, "
+				"AT_FDCWD, %s) failed.", fd, fname);
+		}
+	}
+
+	return fd;
+}
+
+static void loose_fanotify_events(void)
+{
+	int ret;
+	int not_responded = 0;
+
+	/*
+	 * check events
+	 */
+	while (not_responded < MAX_NOT_RESPONDED) {
+		struct fanotify_event_metadata event;
+		struct fanotify_response resp;
+
+		/* Get more events */
+		ret = read(fd_notify, &event, sizeof(event));
+		if (ret < 0) {
+			tst_brk(TBROK, "read(%d, &event, %zu) failed",
+				fd_notify, sizeof(event));
+		}
+		if (ret == 0) {
+			tst_brk(TBROK, "premature EOF while reading from "
+				"fanotify fd");
+		}
+
+		if (event.mask != FAN_ACCESS_PERM) {
+			tst_res(TFAIL,
+				"get event: mask=%llx (expected %llx) "
+				"pid=%u fd=%u",
+				(unsigned long long)event.mask,
+				(unsigned long long)FAN_ACCESS_PERM,
+				(unsigned)event.pid, event.fd);
+			break;
+		}
+
+		/*
+		 * We respond to permission event with 95% percent
+		 * probability. */
+		if (random() % 100 > 5) {
+			/* Write response to permission event */
+			resp.fd = event.fd;
+			resp.response = FAN_ALLOW;
+			SAFE_WRITE(1, fd_notify, &resp, sizeof(resp));
+		} else {
+			not_responded++;
+		}
+		close(event.fd);
+	}
+}
+
+static void test_fanotify(void)
+{
+	int newfd;
+	int ret;
+
+	fd_notify = setup_instance();
+	run_children();
+	loose_fanotify_events();
+
+	/*
+	 * Create and destroy another instance. This may hang if
+	 * unanswered fanotify events block notification subsystem.
+	 */
+	newfd = setup_instance();
+	if (close(newfd)) {
+		tst_brk(TBROK | TERRNO, "close(%d) failed", newfd);
+	}
+
+	tst_res(TPASS, "second instance destroyed successfully");
+
+	/*
+	 * Now destroy the fanotify instance while there are permission
+	 * events at various stages of processing. This may provoke
+	 * kernel hangs or crashes.
+	 */
+	if (close(fd_notify)) {
+		tst_brk(TBROK | TERRNO, "close(%d) failed", fd_notify);
+	}
+	fd_notify = -1;
+
+	ret = stop_children();
+	if (ret)
+		tst_res(TFAIL, "child exited for unexpected reason");
+	else
+		tst_res(TPASS, "all children exited successfully");
+}
+
+static void setup(void)
+{
+	int fd;
+
+	sprintf(fname, "fname_%d", getpid());
+	fd = SAFE_OPEN(fname, O_CREAT | O_RDWR, 0644);
+	SAFE_WRITE(1, fd, fname, 1);
+	SAFE_CLOSE(fd);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0 && close(fd_notify))
+		tst_res(TWARN | TERRNO, "close(%d) failed", fd_notify);
+}
+
+static struct tst_test test = {
+	.tid = "fanotify07",
+	.test_all = test_fanotify,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_root = 1,
+};
+
+#else
+
+int main(void)
+{
+	tst_brk(TCONF, "system doesn't have required fanotify support");
+}
+
+#endif
-- 
2.10.2


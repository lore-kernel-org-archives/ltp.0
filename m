From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Mar 2021 15:11:34 +0200
Subject: [LTP] [PATCH 8/8] syscalls/fanotify: New test to validate
 unprivileged listener events
In-Reply-To: <20210318131134.3562203-1-amir73il@gmail.com>
References: <20210318131134.3562203-1-amir73il@gmail.com>
Message-ID: <20210318131134.3562203-9-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Defined test cases that are responsible for validating that the events
returned to an unprivileged event listener contain the correct values.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify19.c     | 253 ++++++++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify19.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9caa3cf7a..2d1e7b648 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -592,6 +592,7 @@ fanotify15 fanotify15
 fanotify16 fanotify16
 fanotify17 fanotify17
 fanotify18 fanotify18
+fanotify19 fanotify19
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index 175e68ca3..9554b16b1 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -16,4 +16,5 @@
 /fanotify16
 /fanotify17
 /fanotify18
+/fanotify19
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify19.c b/testcases/kernel/syscalls/fanotify/fanotify19.c
new file mode 100644
index 000000000..83a9aaa98
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
+ *
+ * Started by Matthew Bobrowski <mbobrowski@mbobrowski.org>
+ *
+ * DESCRIPTION
+ *	This set of tests is to ensure that the unprivileged listener feature of
+ *	fanotify is functioning as expected. The objective of this test file is
+ *	to generate a sequence of events and ensure that the returned events
+ *	contain the limited values that an unprivileged listener is expected
+ *	to receive.
+ */
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <pwd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define EVENT_MAX 1024
+#define EVENT_SIZE (sizeof (struct fanotify_event_metadata))
+#define EVENT_BUF_LEN (EVENT_MAX * EVENT_SIZE)
+#define EVENT_SET_MAX 48
+
+#define BUF_SIZE 256
+
+#define MOUNT_PATH	"fs_mnt"
+#define TEST_FILE	MOUNT_PATH "/testfile"
+
+static int fd_notify;
+static char buf[BUF_SIZE];
+static struct fanotify_event_metadata event_buf[EVENT_BUF_LEN];
+
+static struct test_case_t {
+	const char *name;
+	unsigned int fork;
+	unsigned int event_count;
+	unsigned long long event_set[EVENT_SET_MAX];
+} test_cases[] = {
+	{
+		"unprivileged listener - events by self",
+		0,
+		4,
+		{
+			FAN_OPEN,
+			FAN_ACCESS,
+			FAN_MODIFY,
+			FAN_CLOSE,
+		}
+	},
+	{
+		"unprivileged lisneter - events by child",
+		1,
+		4,
+		{
+			FAN_OPEN,
+			FAN_ACCESS,
+			FAN_MODIFY,
+			FAN_CLOSE,
+		}
+	}
+};
+
+static void generate_events(void)
+{
+	int fd;
+
+	/* FAN_OPEN */
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR);
+
+	/* FAN_ACCESS */
+	SAFE_READ(0, fd, buf, BUF_SIZE);
+
+	/* FAN_MODIFY */
+	SAFE_WRITE(1, fd, TEST_FILE, 1);
+
+	/* FAN_CLOSE */
+	SAFE_CLOSE(fd);
+}
+
+static void do_fork(void)
+{
+	int status;
+	pid_t child;
+
+	child = SAFE_FORK();
+
+	if (child == 0) {
+		SAFE_CLOSE(fd_notify);
+		generate_events();
+		exit(0);
+	}
+
+	SAFE_WAITPID(child, &status, 0);
+
+	if (WIFEXITED(child) && WEXITSTATUS(child) != 0)
+		tst_brk(TBROK, "Child process terminated incorrectly. Aborting");
+}
+
+static void test_fanotify(unsigned int n)
+{
+	int len = 0;
+	pid_t pid = getpid();
+	unsigned int test_number = 0;
+	struct fanotify_event_metadata *event;
+	struct test_case_t *tc = &test_cases[n];
+
+	tst_res(TINFO, "Test #%d %s", n, tc->name);
+
+	/* Initialize fanotify */
+	fd_notify = fanotify_init(FANOTIFY_REQUIRED_USER_INIT_FLAGS, O_RDONLY);
+
+	if (fd_notify < 0) {
+		if (errno == EPERM || errno == EINVAL) {
+			tst_res(TCONF,
+				"unprivileged fanotify not supported by kernel?");
+			return;
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_init(FAN_CLASS_NOTIF, O_RDONLY) failed");
+		}
+	}
+
+	/* Place mark on object */
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ALL_EVENTS,
+				AT_FDCWD, TEST_FILE) < 0) {
+		tst_brk(TBROK | TERRNO,
+			"fanotify_mark(%d, FAN_MARK_ADD, %d, "
+			"AT_FDCWD, %s) failed",
+			fd_notify,
+			FAN_ALL_EVENTS,
+			TEST_FILE);
+	}
+
+	/* Generate events in either child or listening process */
+	if (tc->fork)
+		do_fork();
+	else
+		generate_events();
+
+	/* Read events from queue */
+	len = SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+
+	event = event_buf;
+
+	/* Iterate over and validate events against expected result set */
+	while (FAN_EVENT_OK(event, len) && test_number < tc->event_count) {
+		if (!(event->mask & tc->event_set[test_number])) {
+			tst_res(TFAIL,
+				"Received unexpected event mask: mask=%llx "
+				"pid=%u fd=%d",
+				(unsigned long long) event->mask,
+				(unsigned) event->pid,
+				event->fd);
+		} else if ((!tc->fork && event->pid != pid) ||
+			   (tc->fork && event->pid != 0)) {
+			tst_res(TFAIL,
+				"Received unexpected pid in event: "
+				"mask=%llx pid=%u (expected %u) fd=%d",
+				(unsigned long long) event->mask,
+				(unsigned) event->pid,
+				(tc->fork ? 0 : pid),
+				event->fd);
+		} else if (event->fd != FAN_NOFD) {
+			tst_res(TFAIL,
+				"Received unexpected file descriptor: "
+				"mask=%llx pid=%u fd=%d (expected %d)",
+				(unsigned long long) event->pid,
+				(unsigned) event->pid,
+				event->fd,
+				FAN_NOFD);
+			SAFE_CLOSE(event->fd);
+		} else {
+			tst_res(TPASS,
+				"Received event: mask=%llx, pid=%u fd=%d",
+				(unsigned long long) event->mask,
+				(unsigned) event->pid,
+				event->fd);
+		}
+
+		/* Non-permission events can be merged into a single event. */
+		event->mask &= ~tc->event_set[test_number];
+
+		if (event->mask == 0)
+			event = FAN_EVENT_NEXT(event, len);
+		test_number++;
+	}
+
+	/*
+	 * Determine whether there is still unprocessed events remaining in the
+	 * buffer. This is to cover the basis whereby the event processing loop
+	 * terminates prematurely. In that case, we need to ensure that any
+	 * event file descriptor that is open is closed so that the temporary
+	 * filesystem can be unmounted.
+	 */
+	if (FAN_EVENT_OK(event, len)) {
+		tst_res(TFAIL,
+			"Event processing loop exited prematurely. Did NOT "
+			"finish processing events in buffer. Cleaning up.");
+		while (FAN_EVENT_OK(event, len)) {
+			if (event->fd != FAN_NOFD)
+				SAFE_CLOSE(event->fd);
+			event = FAN_EVENT_NEXT(event, len);
+		}
+	}
+}
+
+static void setup(void)
+{
+	SAFE_FILE_PRINTF(TEST_FILE, "1");
+	SAFE_CHMOD(TEST_FILE, 0666);
+
+	/* Check for kernel fanotify support */
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, TEST_FILE);
+
+	/* Relinquish privileged user */
+	if (geteuid() == 0) {
+		tst_res(TINFO,
+			"Running as privileged user, revoking.");
+		struct passwd *nobody = SAFE_GETPWNAM("nobody");
+		SAFE_SETUID(nobody->pw_uid);
+	}
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.test = test_fanotify,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MOUNT_PATH,
+};
+
+#else
+	TST_TEST_CONF("System does not have required fanotify support");
+#endif
-- 
2.25.1


From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Nov 2018 11:28:24 +0200
Subject: [LTP] [PATCH v3] syscalls/fanotify11: new test for report thread id
Message-ID: <20181128092824.2054-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: nixiaoming <nixiaoming@huawei.com>

Test fanotify_init with FAN_REPORT_TID -
Verify that event->pid is pid of the thread that caused the event

Test fanotify_init without FAN_REPORT_TID -
Verify that event->pid is tgid of the process that caused the event

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Cyril,

This is a test for yet another new fanotify API that was introduced in
kernel v4.20-rc1.

The new API as well as this test were written by nixiaoming, but since
I helped with review and final touches over v2 of the test, I promissed
to post v3 when the time comes...

Thanks,
Amir.

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/Makefile   |   2 +-
 testcases/kernel/syscalls/fanotify/fanotify.h |   4 +
 .../kernel/syscalls/fanotify/fanotify11.c     | 109 ++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 61865f8e0..ac1d2d2cd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -508,6 +508,7 @@ fanotify07 fanotify07
 fanotify08 fanotify08
 fanotify09 fanotify09
 fanotify10 fanotify10
+fanotify11 fanotify11
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index c26f2bd27..3818e241f 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -8,3 +8,4 @@
 /fanotify08
 /fanotify09
 /fanotify10
+/fanotify11
diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
index bb58878d7..5d01b4825 100644
--- a/testcases/kernel/syscalls/fanotify/Makefile
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -17,7 +17,7 @@
 #
 
 top_srcdir		?= ../../../..
-
+fanotify11: CFLAGS+=-pthread
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 535f1cef2..880dea534 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -54,6 +54,10 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 
 #endif /* HAVE_SYS_FANOTIFY_H */
 
+#ifndef FAN_REPORT_TID
+#define FAN_REPORT_TID		0x00000100
+#endif
+
 #ifndef FAN_MARK_INODE
 #define FAN_MARK_INODE		0
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
new file mode 100644
index 000000000..b62720d8a
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Huawei.  All Rights Reserved.
+ *
+ * Started by nixiaoming <nixiaoming@huawei.com>
+ *
+ * DESCRIPTION
+ *     After fanotify_init adds flags FAN_REPORT_TID,
+ *     check whether the program can accurately identify which thread id
+ *     in the multithreaded program triggered the event.
+ *
+ */
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <pthread.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define gettid() syscall(SYS_gettid)
+static int tid;
+
+void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	char tid_file[64] = {0};
+
+	tid = gettid();
+	snprintf(tid_file, sizeof(tid_file), "test_tid_%d",  tid);
+	SAFE_FILE_PRINTF(tid_file, "1");
+
+	pthread_exit(0);
+}
+
+static unsigned int tcases[] = {
+	FAN_CLASS_NOTIF,
+	FAN_CLASS_NOTIF | FAN_REPORT_TID
+};
+
+void test01(unsigned int i)
+{
+	int ret;
+	pthread_t p_id;
+	struct fanotify_event_metadata event;
+	int fd_notify;
+	int tgid = getpid();
+
+	fd_notify = fanotify_init(tcases[i], 0);
+	if (fd_notify < 0) {
+		if (errno == EINVAL && (tcases[i] & FAN_REPORT_TID)) {
+			tst_res(TCONF,
+				"FAN_REPORT_TID not supported in kernel?");
+			return;
+		}
+		tst_brk(TBROK | TERRNO, "fanotify_init(0x%x, 0) failed",
+				tcases[i]);
+	}
+
+	ret = fanotify_mark(fd_notify, FAN_MARK_ADD,
+			FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
+	if (ret != 0)
+		tst_brk(TBROK, "fanotify_mark FAN_MARK_ADD fail ret=%d", ret);
+
+	SAFE_PTHREAD_CREATE(&p_id, NULL, thread_create_file, NULL);
+
+	SAFE_READ(0, fd_notify, &event, sizeof(struct fanotify_event_metadata));
+	tst_res(TINFO, "%s FAN_REPORT_TID: tgid=%d, tid=%d, event.pid=%d",
+			(tcases[i] & FAN_REPORT_TID) ? "with" : "without",
+			tgid, tid, event.pid);
+	if ((tcases[i] & FAN_REPORT_TID) && event.pid == tid)
+		tst_res(TPASS, "event.pid == tid");
+	else if (!(tcases[i] & FAN_REPORT_TID) && event.pid == tgid)
+		tst_res(TPASS, "event.pid == tgid");
+	else
+		tst_res(TFAIL, "unexpected event.pid value");
+
+	if (event.fd != FAN_NOFD)
+		SAFE_CLOSE(event.fd);
+	SAFE_CLOSE(fd_notify);
+	SAFE_PTHREAD_JOIN(p_id, NULL);
+}
+
+
+static struct tst_test test = {
+	.test = test01,
+	.tcnt =  ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
+
+#else
+TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.17.1


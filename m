From: nixiaoming <nixiaoming@huawei.com>
Date: Fri, 28 Sep 2018 09:09:58 +0800
Subject: [LTP] [PATCH v4] syscalls/fanotify11: new test for report thread id
Message-ID: <20180928010958.20601-1-nixiaoming@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

syscalls/fanotify11
test fanotify_init with FAN_EVENT_INFO_TID
	data->pid is ID(pid)  of the thread that caused the event
test fanotify_init without FAN_EVENT_INFO_TID
	data->pid is ID(tgid) of the process that caused the event

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---

this is not testing an upstream feature, only RFC.

 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore   |   1 +
 testcases/kernel/syscalls/fanotify/Makefile     |   2 +-
 testcases/kernel/syscalls/fanotify/fanotify11.c | 131 ++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be77..84b0d6e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -497,6 +497,7 @@ fanotify06 fanotify06
 fanotify07 fanotify07
 fanotify08 fanotify08
 fanotify09 fanotify09
+fanotify11 fanotify11
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index ec75539..62180ab 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -7,3 +7,4 @@
 /fanotify07
 /fanotify08
 /fanotify09
+/fanotify11
diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
index bb58878..5d01b48 100644
--- a/testcases/kernel/syscalls/fanotify/Makefile
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -17,7 +17,7 @@
 #
 
 top_srcdir		?= ../../../..
-
+fanotify11: CFLAGS+=-pthread
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
new file mode 100644
index 0000000..45959b4
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (c) 2018 Huawei.  All Rights Reserved.
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
+ * Started by nixiaoming <nixiaoming@huawei.com>
+ *
+ * DESCRIPTION
+ *     After fanotify_init adds flags FAN_EVENT_INFO_TID,
+ *     check whether the program can accurately identify which thread id
+ *     in the multithreaded program triggered the event..
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
+#ifdef FAN_EVENT_INFO_TID
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
+	FAN_CLASS_NOTIF | FAN_EVENT_INFO_TID
+};
+
+void test01(unsigned int i)
+{
+	int ret;
+	pthread_t p_id;
+	struct fanotify_event_metadata data;
+	int fd_notify;
+	int tgid = getpid();
+
+	fd_notify = fanotify_init(tcases[i], 0);
+	if (fd_notify < 0) {
+		if (errno == EINVAL && (tcases[i] & FAN_EVENT_INFO_TID))
+			return;
+		tst_brk(TBROK | TERRNO, "fanotify_init(0x%x, 0) failed",
+				tcases[i]);
+	}
+
+	ret = fanotify_mark(fd_notify, FAN_MARK_ADD,
+			FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
+	if (ret != 0)
+		tst_brk(TBROK, "fanotify_mark FAN_MARK_ADD fail ret=%d\n", ret);
+
+	SAFE_PTHREAD_CREATE(&p_id, NULL, thread_create_file, NULL);
+
+	SAFE_READ(0, fd_notify, &data, sizeof(struct fanotify_event_metadata));
+	tst_res(TINFO, "%s FAN_EVENT_INFO_TID: tgid=%d, tid=%d, data.pid=%d\n",
+			(tcases[i] & FAN_EVENT_INFO_TID) ? "with" : "without",
+			tgid, tid, data.pid);
+	if ((tcases[i] & FAN_EVENT_INFO_TID) && (data.pid == tid))
+		tst_res(TPASS, "data.pid == tid\n");
+	else if (!(tcases[i] & FAN_EVENT_INFO_TID) && (data.pid == tgid))
+		tst_res(TPASS, "data.pid == tgid\n");
+	else
+		tst_res(TFAIL, "fail..");
+
+	if (data.fd != FAN_NOFD)
+		SAFE_CLOSE(data.fd);
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
+
+#else
+TST_TEST_TCONF("system doesn't support flags: FAN_EVENT_INFO_TID");
+
+#endif /* ifdef FAN_EVENT_INFO_TID */
+
+#else
+TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.10.1


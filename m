From: nixiaoming <nixiaoming@huawei.com>
Date: Thu, 27 Sep 2018 18:10:28 +0800
Subject: [LTP] [PATCH v2] syscalls/fanotify11: new test for report thread id
Message-ID: <20180927101028.61686-1-nixiaoming@huawei.com>
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
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore   |   1 +
 testcases/kernel/syscalls/fanotify/Makefile     |   2 +-
 testcases/kernel/syscalls/fanotify/fanotify11.c | 221 ++++++++++++++++++++++++
 4 files changed, 224 insertions(+), 1 deletion(-)
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
index 0000000..6218b22
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -0,0 +1,221 @@
+/*
+ * Copyright (c) 2013 SUSE.  All Rights Reserved.
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
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+#define FAN_EVENT_INFO_TID 0x02000000
+#ifdef FAN_EVENT_INFO_TID
+
+#define BUF_SIZE 256
+#define gettid() syscall(SYS_gettid)
+
+static char fname[BUF_SIZE];
+
+static int tid;
+static int tgid;
+
+void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	int fd;
+	char tid_file[64] = {0};
+	char buf[64];
+
+	tid = gettid();
+	snprintf(tid_file, sizeof(tid_file), "%s/test_tid_%d", fname, tid);
+	fd = SAFE_OPEN(tid_file, O_RDWR|O_CREAT, 0600);
+	tst_res(TINFO, "file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	SAFE_WRITE(1, fd, tid_file, sizeof(tid_file));
+	lseek(fd, 0, SEEK_SET);
+	SAFE_READ(0, fd, buf, sizeof(buf));
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(tid_file);
+	pthread_exit(0);
+}
+
+static const char *mask2str(uint64_t mask)
+{
+	static char buffer[10];
+	int offset = 0;
+
+	if (mask & FAN_ACCESS)
+		buffer[offset++] = 'R';
+	if (mask & FAN_ONDIR)
+		buffer[offset++] = 'D';
+	if (mask & FAN_OPEN)
+		buffer[offset++] = 'O';
+	if (mask & FAN_CLOSE_WRITE || mask & FAN_CLOSE_NOWRITE)
+		buffer[offset++] = 'C';
+	if (mask & FAN_MODIFY || mask & FAN_CLOSE_WRITE)
+		buffer[offset++] = 'W';
+	buffer[offset] = '\0';
+
+	return buffer;
+}
+
+
+static void show_data(const struct fanotify_event_metadata *data)
+{
+	static char printbuf[100];
+	static char pathname[PATH_MAX];
+	struct stat st;
+	int len;
+
+	snprintf(printbuf, sizeof(printbuf), "/proc/self/fd/%i", data->fd);
+	len = readlink(printbuf, pathname, sizeof(pathname));
+	if (len < 0) {
+		/* fall back to the device/inode */
+		if (fstat(data->fd, &st) < 0) {
+			perror("stat");
+			exit(1);
+		}
+		snprintf(pathname, sizeof(pathname), "device %i:%i inode %ld\n",
+				major(st.st_dev), minor(st.st_dev), st.st_ino);
+	} else {
+		pathname[len] = '\0';
+	}
+	tst_res(TINFO, "envnt: %i %s %s\n", data->pid, mask2str(data->mask),
+			pathname);
+}
+
+void test_init_bit(unsigned int flags, unsigned long long mask)
+{
+	int ret;
+	pthread_t p_id;
+	struct fanotify_event_metadata data;
+	int fd_notify;
+
+	fd_notify = fanotify_init(flags, 0);
+	if (fd_notify == -EINVAL)
+		tst_brk(TCONF, "no support FAN_EVENT_INFO_TID\n");
+
+	ret = fanotify_mark(fd_notify, FAN_MARK_ADD, mask | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
+	if (ret != 0) {
+		tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_ADD, %x, AT_FDCWD, %s) failed, ret=%d\n", mask | FAN_EVENT_ON_CHILD, fd_notify, fname, ret);
+	}
+	pthread_create(&p_id, NULL, thread_create_file, NULL);
+	res = SAFE_READ(0, fd_notify, &data, sizeof(struct fanotify_event_metadata));
+	show_data(&data);
+	if (((flags & FAN_EVENT_INFO_TID) && (data.pid == tid)) ||
+			((!(flags & FAN_EVENT_INFO_TID)) && (data.pid == tgid)))
+		tst_res(TPASS, "%s FAN_EVENT_INFO_TID: tgid=%d, tid=%d, data->pid=%d\n", (flags & FAN_EVENT_INFO_TID) ? "with" : "without", tgid, tid, data.pid);
+	else
+		tst_res(TFAIL, "%s FAN_EVENT_INFO_TID: tgid=%d, tid=%d, data->pid=%d\n", (flags & FAN_EVENT_INFO_TID) ? "with" : "without", tgid, tid, data.pid);
+	if (data.fd != FAN_NOFD)
+		SAFE_CLOSE(data.fd);
+
+	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
+	ret = fanotify_mark(fd_notify, FAN_MARK_REMOVE, mask | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
+	if (ret != 0) {
+		tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_REMOVE, %x, AT_FDCWD, %s) failed, ret=%d\n", mask | FAN_EVENT_ON_CHILD, fd_notify, fname, ret);
+	}
+
+	SAFE_CLOSE(fd_notify);
+
+}
+
+static void run(unsigned int i)
+{
+	switch (i) {
+	case 0:
+		test_init_bit(FAN_EVENT_INFO_TID, FAN_CLOSE);
+		break;
+	case 1:
+		test_init_bit(FAN_EVENT_INFO_TID, FAN_OPEN);
+		break;
+	case 2:
+		test_init_bit(FAN_EVENT_INFO_TID, FAN_MODIFY);
+		break;
+	case 3:
+		test_init_bit(FAN_EVENT_INFO_TID, FAN_ACCESS);
+		break;
+	case 4:
+		test_init_bit(0, FAN_CLOSE);
+		break;
+	case 5:
+		test_init_bit(0, FAN_OPEN);
+		break;
+	case 6:
+		test_init_bit(0, FAN_MODIFY);
+		break;
+	case 7:
+		test_init_bit(0, FAN_ACCESS);
+		break;
+	}
+}
+
+static void setup(void)
+{
+	tgid = getpid();
+	sprintf(fname, "tfile_%d", tgid);
+	mkdir(fname, 0755);
+}
+
+static void cleanup(void)
+{
+	rmdir(fname);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 8,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
+
+
+#else
+TST_TEST_TCONF("system doesn't support fanotify_init flags: FAN_EVENT_INFO_TID");
+#endif /* ifdef FAN_EVENT_INFO_TID */
+
+#else
+TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.10.1


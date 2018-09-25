From: nixiaoming <nixiaoming@huawei.com>
Date: Tue, 25 Sep 2018 16:43:44 +0800
Subject: [LTP] [PATCH] syscalls/fanotify: test fanotify_init new flags
	FAN_EVENT_INFO_TID
Message-ID: <20180925084344.4397-1-nixiaoming@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fanotify_info_tid:
	test fanotify_init with FAN_EVENT_INFO_TID
	data->pid is ID(pid)  of the thread that caused the event
fanotify_info_tgid:
	test fanotify_init without FAN_EVENT_INFO_TID
	data->pid is ID(tgid) of the process that caused the event

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 testcases/kernel/syscalls/fanotify/Makefile        |   3 +-
 .../kernel/syscalls/fanotify/fanotify_info_tgid.c  | 200 ++++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify_info_tid.c   | 204 +++++++++++++++++++++
 3 files changed, 406 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify_info_tid.c

diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
index bb58878..d85c755 100644
--- a/testcases/kernel/syscalls/fanotify/Makefile
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -17,7 +17,8 @@
 #
 
 top_srcdir		?= ../../../..
-
+fanotify_info_tid: CFLAGS+=-pthread
+fanotify_info_tgid: CFLAGS+=-pthread
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c b/testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c
new file mode 100644
index 0000000..3b10d79
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c
@@ -0,0 +1,200 @@
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
+ *     After fanotify_init without FAN_EVENT_INFO_TID,
+ *     check whether the program can only show tgid 
+ *     in the multithreaded program triggered the event..
+ *
+ * This is a regression test for commit 55c5b2ed10331c3b22:
+ *
+ *     fanotify: support reporting thread id instead of process id
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
+
+
+#define BUF_SIZE 256
+#define gettid() syscall(SYS_gettid)
+
+static char fname[BUF_SIZE];
+int fd_notify;
+
+static int tid;
+static int tgid;
+static char tid_file[BUF_SIZE];
+
+void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	int fd;
+
+	tid = gettid();
+	snprintf(tid_file, sizeof(tid_file), "%s/test_tid_%d", fname, tid);
+	sleep(1);
+	fd = SAFE_OPEN(tid_file, O_WRONLY|O_CREAT, 0600);
+	tst_res(TINFO, "open file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	SAFE_WRITE(1, fd, tid_file, sizeof(tid_file));
+	tst_res(TINFO, "write file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	SAFE_CLOSE(fd);
+	tst_res(TINFO, "close file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	SAFE_UNLINK(tid_file);
+	tst_res(TINFO, "unlink file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	sleep(1);
+	pthread_exit(0);
+}
+
+static const char* mask2str(uint64_t mask)
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
+void test01(void)
+{
+	int res;
+	int ret;
+	char buffer[4096] = {0};
+	struct fanotify_event_metadata *data;
+
+	ret = fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
+	if (ret != 0) {
+		tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_ADD, FAN_CLOSE | FAN_OPEN |FAN_EVENT_ON_CHILD, AT_FDCWD, %s) "
+				"failed, ret=%d\n", fd_notify, fname, ret);
+	}
+	tst_res(TINFO, "add notify mark\n");
+	res = SAFE_READ(0, fd_notify, buffer, 4096);
+	data = (struct fanotify_event_metadata *) buffer;
+	while (FAN_EVENT_OK(data, res)) {
+		show_data(data);
+		if (data->pid == tid)
+			tst_res(TFAIL, "data->pid == envent task thread id %u\n", tid);
+		else if (data->pid == tgid)
+			tst_res(TPASS, "data->pid %u != envent task thread id %u\n", data->pid, tid);
+		else
+			tst_res(TINFO, "Environmental interference....\n");
+		close(data->fd);
+		data = FAN_EVENT_NEXT(data, res);
+	}
+	fflush(stdout);
+
+	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
+	ret = fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
+	if (ret != 0) {
+		tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, %s) "
+				"failed, ret=%d\n", fd_notify, fname, ret);
+	}
+	tst_res(TINFO, "remove notify mark\n");
+}
+
+static void setup(void)
+{
+	pthread_t p_id;
+
+	tgid = getpid();
+	sprintf(fname, "tfile_%d", tgid);
+	mkdir(fname, 0755);
+
+	fd_notify = SAFE_FANOTIFY_INIT(0, 0);
+	if (fd_notify < 0)
+		tst_brk(TCONF, "no support\n");
+	pthread_create(&p_id, NULL, thread_create_file, NULL);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+	rmdir(fname);
+}
+
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
+
+#else
+TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify_info_tid.c b/testcases/kernel/syscalls/fanotify/fanotify_info_tid.c
new file mode 100644
index 0000000..4baf714
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify_info_tid.c
@@ -0,0 +1,204 @@
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
+ * This is a regression test for commit 55c5b2ed10331c3b22:
+ *
+ *     fanotify: support reporting thread id instead of process id
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
+#ifdef FAN_EVENT_INFO_TID
+
+#define BUF_SIZE 256
+#define gettid() syscall(SYS_gettid)
+
+static char fname[BUF_SIZE];
+int fd_notify;
+
+static int tid;
+static int tgid;
+static char tid_file[BUF_SIZE];
+
+void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	int fd;
+
+	tid = gettid();
+	snprintf(tid_file, sizeof(tid_file), "%s/test_tid_%d", fname, tid);
+	sleep(1);
+	fd = SAFE_OPEN(tid_file, O_WRONLY|O_CREAT, 0600);
+	tst_res(TINFO, "open file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	SAFE_WRITE(1, fd, tid_file, sizeof(tid_file));
+	tst_res(TINFO, "write file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	SAFE_CLOSE(fd);
+	tst_res(TINFO, "close file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	SAFE_UNLINK(tid_file);
+	tst_res(TINFO, "unlink file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
+	sleep(1);
+	pthread_exit(0);
+}
+
+static const char* mask2str(uint64_t mask)
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
+void test01(void)
+{
+	int res;
+	int ret;
+	char buffer[4096] = {0};
+	struct fanotify_event_metadata *data;
+
+	ret = fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
+	if (ret != 0) {
+		tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_ADD, FAN_CLOSE | FAN_OPEN |FAN_EVENT_ON_CHILD, AT_FDCWD, %s) "
+				"failed, ret=%d\n", fd_notify, fname, ret);
+	}
+	tst_res(TINFO, "add notify mark\n");
+	res = SAFE_READ(0, fd_notify, buffer, 4096);
+	data = (struct fanotify_event_metadata *) buffer;
+	while (FAN_EVENT_OK(data, res)) {
+		show_data(data);
+		if (data->pid == tid)
+			tst_res(TPASS, "data->pid == envent task thread id %u\n", tid);
+		else if (data->pid == tgid)
+			tst_res(TFAIL, "data->pid %u != envent task thread id %u\n", data->pid, tid);
+		else
+			tst_res(TINFO, "Environmental interference....\n");
+		close(data->fd);
+		data = FAN_EVENT_NEXT(data, res);
+	}
+	fflush(stdout);
+
+	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
+	ret = fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
+	if (ret != 0) {
+		tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, %s) "
+				"failed, ret=%d\n", fd_notify, fname, ret);
+	}
+	tst_res(TINFO, "remove notify mark\n");
+}
+
+static void setup(void)
+{
+	pthread_t p_id;
+
+	tgid = getpid();
+	sprintf(fname, "tfile_%d", tgid);
+	mkdir(fname, 0755);
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_EVENT_INFO_TID, 0);
+	if (fd_notify < 0)
+		tst_brk(TCONF, "no support FAN_EVENT_INFO_TID\n");
+	pthread_create(&p_id, NULL, thread_create_file, NULL);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+	rmdir(fname);
+}
+
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
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


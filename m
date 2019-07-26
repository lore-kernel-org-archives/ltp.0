From: Christian Amann <camann@suse.com>
Date: Fri, 26 Jul 2019 10:19:26 +0200
Subject: [LTP] [PATCH v1] syscalls/ioprio: Add functional test case
Message-ID: <20190726081926.8250-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add ioprio_set03 which tests if the I/O priority set by
the ioprio_set(2) syscall is taken into account when
writing to files.

Signed-off-by: Christian Amann <camann@suse.com>
---

Notes:
    This patch was written to be aplicable after the current test
    cases from Linus Walleij on the mailing list were corrected
    and applied. (That means, putting the runtest entires in place,
    moving the syscall function to the "ioprio.h" file, etc.)
    Slight adjustment could be necessary, though.

 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/ioprio/.gitignore     |   1 +
 testcases/kernel/syscalls/ioprio/Makefile       |   2 +
 testcases/kernel/syscalls/ioprio/ioprio_set03.c | 187 ++++++++++++++++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 20e4ef0f5..2c205ae8e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -543,6 +543,7 @@ ioprio_get01 ioprio_get01
 
 ioprio_set01 ioprio_set01
 ioprio_set02 ioprio_set02
+ioprio_set03 ioprio_set03
 
 iopl01 iopl01
 iopl02 iopl02
diff --git a/testcases/kernel/syscalls/ioprio/.gitignore b/testcases/kernel/syscalls/ioprio/.gitignore
index 890081d8c..373079bf2 100644
--- a/testcases/kernel/syscalls/ioprio/.gitignore
+++ b/testcases/kernel/syscalls/ioprio/.gitignore
@@ -1,3 +1,4 @@
 ioprio_get01
 ioprio_set01
 ioprio_set02
+ioprio_set03
diff --git a/testcases/kernel/syscalls/ioprio/Makefile b/testcases/kernel/syscalls/ioprio/Makefile
index 5ea7d67db..647d296ca 100644
--- a/testcases/kernel/syscalls/ioprio/Makefile
+++ b/testcases/kernel/syscalls/ioprio/Makefile
@@ -4,3 +4,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+ioprio_set03: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set03.c b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
new file mode 100644
index 000000000..333723b3a
--- /dev/null
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+/*
+ * Functional test to see if the I/O priority set with ioprio_set(2)
+ * has an effect when writing to files.
+ *
+ * In order to do so, this test mounts a loop device for which the
+ * I/O scheduler is set to either 'bfq' or 'cfq'. Then two write threads
+ * are started which both simultaneusly write to a file each. One thread
+ * is set to IDLE priority while the other is set to BE.
+ * If the thread with the higher I/O priority writes at least 10% more
+ * to its file, the test is successful.
+ */
+
+#define _GNU_SOURCE
+
+#include <malloc.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+#include "ioprio.h"
+
+#define MNTPOINT	"MNTPOINT"
+#define FILE1		MNTPOINT"/file1"
+#define FILE2		MNTPOINT"/file2"
+#define CHUNKSIZE	(blksize > 8192 ? blksize : 8192) /* Bytes */
+#define IOTIME		(2)	/* Seconds */
+
+#define SCHED_TEMPLATE	"/sys/block/%s/queue/scheduler"
+
+static blksize_t blksize;
+
+static struct thread_data {
+	int		fd;
+	pthread_t	thread;
+	long		prio;
+	int		writes;
+	char		*out_buf;
+} tdata[2];
+
+static void set_io_scheduler(const char *device_name)
+{
+	int fd;
+	unsigned int i;
+	const char * const schedulers[] = {"bfq", "cfq"};
+	const char *used_scheduler = NULL;
+	char avail_schedulers[256];
+	char sched_path[256];
+
+	sprintf(sched_path, SCHED_TEMPLATE, device_name);
+
+	fd = SAFE_OPEN(sched_path, O_RDWR);
+
+	SAFE_READ(0, fd, avail_schedulers, 255);
+	avail_schedulers[255] = '\0';
+
+	/* Check if right I/O schedulers are available */
+	for (i = 0; i < ARRAY_SIZE(schedulers); ++i) {
+		if (strstr(avail_schedulers, schedulers[i]))
+			used_scheduler = schedulers[i];
+	}
+	if (!used_scheduler)
+		tst_brk(TCONF, "Needed I/O schedulers are not available");
+
+	/* Set I/O scheduler */
+	TEST(write(fd, used_scheduler, sizeof(used_scheduler)));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "Could not set I/O scheduler");
+
+	SAFE_CLOSE(fd);
+
+	tst_res(TINFO, "Set I/O scheduler to '%s'", used_scheduler);
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "Could not set I/O scheduler");
+}
+
+static void *io_thread(void *arg)
+{
+	long thread_num = (long) arg;
+	int ret;
+
+	ret = sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, tdata[thread_num].prio);
+	if (ret == -1)
+		tst_brk(TBROK || TTERRNO, "ioprio_set() failed");
+
+	ret = sys_ioprio_get(IOPRIO_WHO_PROCESS, 0);
+	if (ret != tdata[thread_num].prio)
+		tst_brk(TBROK, "ioprio_set() set wrong priority");
+
+	/* align to blocksize for O_DIRECT writes */
+	tdata[thread_num].out_buf = SAFE_MEMALIGN(blksize, CHUNKSIZE);
+	memset(tdata[thread_num].out_buf, 'X', CHUNKSIZE);
+
+	tdata[thread_num].writes = 0;
+	while (1) {
+		SAFE_WRITE(1, tdata[thread_num].fd,
+				tdata[thread_num].out_buf, CHUNKSIZE);
+		tdata[thread_num].writes++;
+		if (tdata[thread_num].writes % 1000 == 0)
+			SAFE_LSEEK(tdata[thread_num].fd, 0, SEEK_SET);
+	}
+
+	return arg;
+}
+
+static void verify_ioprio(void)
+{
+	long i;
+	time_t time_started, time_spent = 0;
+
+	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+
+	for (i = 0; i < 2; i++) {
+		SAFE_PTHREAD_CREATE(&tdata[i].thread, NULL,
+					io_thread, (void *) i);
+	}
+
+	time_started = time(NULL);
+	while (time_spent < IOTIME) {
+		time_spent = time(NULL) - time_started;
+		usleep(10000);
+	}
+
+	for (i = 0; i < 2; i++)
+		pthread_cancel(tdata[i].thread);
+
+	tst_res(TINFO, "Writes done with low  priority: %d", tdata[0].writes);
+	tst_res(TINFO, "Writes done with high priority: %d", tdata[1].writes);
+
+	/* High priority output should be@least 10% more */
+	if (tdata[1].writes >= tdata[0].writes + tdata[0].writes/10.0)
+		tst_res(TPASS, "High priority write was successful");
+	else
+		tst_res(TFAIL, "High priority write did not show any effect");
+
+	for (i = 0; i < 2; ++i) {
+		if (tdata[i].out_buf)
+			free(tdata[i].out_buf);
+	}
+}
+
+static void setup(void)
+{
+	const char *device_name;
+	struct stat statbuf;
+
+	device_name = &tst_device->dev[5]; /* skip '/dev/' prefix */
+
+	set_io_scheduler(device_name);
+
+	tdata[0].fd = SAFE_OPEN(FILE1, O_RDWR | O_CREAT | O_DIRECT, 0644);
+	tdata[1].fd = SAFE_OPEN(FILE2, O_RDWR | O_CREAT | O_DIRECT, 0644);
+
+	tdata[0].prio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0);
+	tdata[1].prio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE,   0);
+
+	SAFE_FSTAT(tdata[0].fd, &statbuf);
+	blksize = statbuf.st_blksize;
+
+	tst_res(TINFO, "Blocksize: %ld", blksize);
+}
+
+static void cleanup(void)
+{
+	if (tdata[1].fd > 0)
+		SAFE_CLOSE(tdata[1].fd);
+	if (tdata[0].fd > 0)
+		SAFE_CLOSE(tdata[0].fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_ioprio,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.dev_min_size = 64,
+	.dev_fs_type = "ext4",
+};
-- 
2.16.4


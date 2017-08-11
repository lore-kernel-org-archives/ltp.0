From: Xiong Zhou <xzhou@redhat.com>
Date: Fri, 11 Aug 2017 11:14:34 +0800
Subject: [LTP] [PATCH] syscalls/fcntl36: add tests for OFD locks
Message-ID: <1502421274-6475-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fcntl/Makefile  |   3 +
 testcases/kernel/syscalls/fcntl/fcntl36.c | 315 ++++++++++++++++++++++++++++++
 2 files changed, 318 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl36.c

diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
index d78dd72..ae37214 100644
--- a/testcases/kernel/syscalls/fcntl/Makefile
+++ b/testcases/kernel/syscalls/fcntl/Makefile
@@ -24,6 +24,9 @@ fcntl33_64: LDLIBS+=-lrt
 fcntl34: LDLIBS += -lpthread
 fcntl34_64: LDLIBS += -lpthread
 
+fcntl36: LDLIBS += -lpthread
+fcntl36_64: LDLIBS += -lpthread
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
new file mode 100644
index 0000000..4c55279
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -0,0 +1,315 @@
+/*
+ * Copyright (c) 2017 Red Hat Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Xiong Zhou <xzhou@redhat.com>
+ *
+ * This is testing OFD locks racing with POSIX locks:
+ *
+ *	OFD read  lock   vs   OFD   write lock
+ *	OFD read  lock   vs   POSIX write lock
+ *	OFD write lock   vs   POSIX write lock
+ *	OFD write lock   vs   POSIX read  lock
+ *	OFD write lock   vs   OFD   write lock
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <errno.h>
+
+#include "lapi/fcntl.h"
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+static int thread_cnt;
+static const int max_thread_cnt = 32;
+static const char fname[] = "tst_ofd_locks";
+static int write_flag_cnt;
+const int write_size = 4096;
+
+static void setup(void)
+{
+	thread_cnt = tst_ncpus_conf() * 3;
+	if (thread_cnt > max_thread_cnt)
+		thread_cnt = max_thread_cnt;
+}
+
+static void spawn_threads(pthread_t *id, void *(*thread_fn)(void *))
+{
+	intptr_t i;
+
+	for (i = 0; i < thread_cnt; ++i)
+		SAFE_PTHREAD_CREATE(id + i, NULL, thread_fn, (void *)i);
+}
+
+static void wait_threads(pthread_t *id)
+{
+	int i;
+
+	for (i = 0; i < thread_cnt; ++i)
+		SAFE_PTHREAD_JOIN(id[i], NULL);
+}
+
+/* Loop OFD wlock writing data*/
+static void *thread_fn_ofd_wlock(void *arg)
+{
+	unsigned char buf[write_size];
+	long start = (intptr_t)arg * write_size;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+	int i = 0;
+
+	/* write with half writesize offset in the second spawning */
+	start += (write_flag_cnt % 2) * write_size / 2;
+	memset(buf, 'o', write_size);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = start,
+		.l_len    = write_size,
+		.l_pid    = 0,
+	};
+
+	struct timespec ts = {
+               .tv_sec = 0,
+               .tv_nsec = 50000000,
+	};
+
+	for (; i < thread_cnt; i++) {
+
+		lck.l_type = F_WRLCK;
+		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+
+		SAFE_LSEEK(fd, start, SEEK_SET);
+		SAFE_WRITE(1, fd, buf, write_size);
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+
+		nanosleep(&ts, NULL);
+		sched_yield();
+	}
+
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+/* Loop POSIX wlock writing data*/
+static void *thread_fn_posix_wlock(void *arg)
+{
+	unsigned char buf[write_size];
+	long start = (intptr_t)arg * write_size;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+	int i = 0;
+
+	memset(buf, 'p', write_size);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = start,
+		.l_len    = write_size,
+	};
+
+	for (; i < thread_cnt; i++) {
+
+		lck.l_type = F_WRLCK;
+		SAFE_FCNTL(fd, F_SETLKW, &lck);
+
+		SAFE_LSEEK(fd, start, SEEK_SET);
+		SAFE_WRITE(1, fd, buf, write_size);
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_SETLKW, &lck);
+
+		sched_yield();
+	}
+
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+/* Loop OFD rlock reading data*/
+static void *thread_fn_ofd_rlock(void *arg)
+{
+	unsigned char buf[write_size];
+	long start = (intptr_t)arg * write_size;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+	int i = 0;
+
+	memset(buf, (intptr_t)arg, write_size);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = start,
+		.l_len    = write_size,
+		.l_pid    = 0,
+	};
+
+	for (; i < thread_cnt; i++) {
+
+		lck.l_type = F_RDLCK;
+		if (fcntl(fd, F_OFD_SETLK, &lck) == -1) {
+			/* can only fail with EAGAIN */
+			if (errno != EAGAIN)
+				tst_brk(TBROK, "errno not equal to EAGAIN");
+		} else {
+
+			/* rlock acquired */
+			SAFE_LSEEK(fd, start, SEEK_SET);
+			SAFE_READ(0, fd, buf, write_size);
+
+			lck.l_type = F_UNLCK;
+			SAFE_FCNTL(fd, F_OFD_SETLK, &lck);
+		}
+		sched_yield();
+	}
+
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+/* Loop POSIX rlock reading data */
+static void *thread_fn_posix_rlock(void *arg)
+{
+	unsigned char buf[write_size];
+	long start = (intptr_t)arg * write_size;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+	int i = 0;
+
+	memset(buf, (intptr_t)arg, write_size);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = start,
+		.l_len    = write_size,
+	};
+
+	for (; i < thread_cnt; i++) {
+
+		lck.l_type = F_RDLCK;
+		if (fcntl(fd, F_SETLK, &lck) == -1) {
+			/* can only fail with EAGAIN */
+			if (errno != EAGAIN)
+				tst_brk(TBROK, "errno not equal to EAGAIN");
+		} else {
+
+			/* rlock acquired */
+			SAFE_LSEEK(fd, start, SEEK_SET);
+			SAFE_READ(0, fd, buf, write_size);
+
+			lck.l_type = F_UNLCK;
+			SAFE_FCNTL(fd, F_SETLK, &lck);
+		}
+		sched_yield();
+	}
+
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+static int test_fn(void *f0(void *), void *f1(void *))
+{
+	intptr_t i;
+	int k;
+	pthread_t id0[thread_cnt];
+	pthread_t id1[thread_cnt];
+	unsigned char buf[write_size];
+
+	int fd = SAFE_OPEN(fname, O_CREAT | O_TRUNC | O_RDWR, 0600);
+
+	spawn_threads(id0, f0);
+	write_flag_cnt++;
+	spawn_threads(id1, f1);
+	wait_threads(id0);
+	wait_threads(id1);
+
+	tst_res(TINFO, "Verifying file's data");
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+
+	for (i = 0; i <= thread_cnt; ++i) {
+
+		SAFE_READ(1, fd, buf, write_size/2);
+
+		if (buf[0] != 'o' && buf[0] != 'p') {
+			tst_res(TFAIL, "unexpected data read");
+			return -1;
+		}
+
+		for (k = 1; k < write_size/2; ++k) {
+			if (buf[k] != buf[0]) {
+				tst_res(TFAIL, "unexpected block read");
+				return -1;
+			}
+		}
+	}
+
+	SAFE_CLOSE(fd);
+
+	return 0;
+}
+
+static void tests(void)
+{
+	int ret = 0;
+
+	tst_res(TINFO, "OFD read locks vs OFD write locks");
+	ret = test_fn(thread_fn_ofd_wlock, thread_fn_ofd_rlock);
+	if (ret == 0)
+		tst_res(TPASS, "access between threads synchronized");
+
+	ret = 0;
+	write_flag_cnt = 0;
+	tst_res(TINFO, "OFD write locks vs POSIX write locks");
+	ret = test_fn(thread_fn_ofd_wlock, thread_fn_posix_wlock);
+	if (ret == 0)
+		tst_res(TPASS, "access between threads synchronized");
+
+	ret = 0;
+	write_flag_cnt = 0;
+	tst_res(TINFO, "OFD read locks vs POSIX write locks");
+	ret = test_fn(thread_fn_ofd_rlock, thread_fn_posix_wlock);
+	if (ret == 0)
+		tst_res(TPASS, "access between threads synchronized");
+
+	ret = 0;
+	write_flag_cnt = 0;
+	tst_res(TINFO, "OFD write locks vs POSIX read locks");
+	ret = test_fn(thread_fn_ofd_wlock, thread_fn_posix_rlock);
+	if (ret == 0)
+		tst_res(TPASS, "access between threads synchronized");
+
+	ret = 0;
+	write_flag_cnt = 0;
+	tst_res(TINFO, "OFD write locks vs OFD write locks");
+	ret = test_fn(thread_fn_ofd_wlock, thread_fn_ofd_wlock);
+	if (ret == 0)
+		tst_res(TPASS, "access between threads synchronized");
+}
+
+static struct tst_test test = {
+	.min_kver = "3.15.0",
+	.needs_tmpdir = 1,
+	.test_all = tests,
+	.setup = setup
+};
-- 
1.8.3.1


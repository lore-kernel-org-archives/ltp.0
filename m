From: Xiong Zhou <xzhou@redhat.com>
Date: Mon, 21 Aug 2017 19:17:06 +0800
Subject: [LTP] [PATCH v2] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <20170814160243.GA12224@rei.lan>
References: <20170814160243.GA12224@rei.lan>
Message-ID: <1503314226-3502-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

v2:
  Basically rewritten.
  Pass structure parameter to threads.
  Block on read lock.
  Spawn racing threads one by one.
  Use tcnt iteration.

 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/fcntl/Makefile  |   3 +
 testcases/kernel/syscalls/fcntl/fcntl36.c | 380 ++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl36.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 407e055..f2b2cbc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -271,6 +271,8 @@ fcntl34 fcntl34
 fcntl34_64 fcntl34_64
 fcntl35 fcntl35
 fcntl35_64 fcntl35_64
+fcntl36 fcntl36
+fcntl36_64 fcntl36_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
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
index 0000000..18b5d02
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -0,0 +1,380 @@
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
+ * For example:
+ *
+ * 	Init an file with preset values.
+ *
+ * 	Threads acquire OFD READ  locks to read  a 4k section start from 0;
+ * 		checking data read back, there should not be any surprise
+ * 		values and data should be consistent in a 2k block.
+ *
+ * 	Threads acquire OFD WRITE locks to write a 4k section start from 2k,
+ * 		writing different values in different threads.
+ *
+ * 	Check file data after racing, there should not be any surprise values
+ * 		and data should be consistent in a 2k block.
+ *
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
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
+static const char fname[] = "tst_ofd_posix_locks";
+const long write_size = 4096;
+
+struct param {
+	long offset;
+	long length;
+	long cnt;
+};
+
+static void setup(void)
+{
+	int fd = SAFE_OPEN(fname, O_CREAT | O_TRUNC | O_RDWR, 0600);
+	char *s = NULL;
+
+	thread_cnt = tst_ncpus_conf() * 3;
+	if (thread_cnt > max_thread_cnt)
+		thread_cnt = max_thread_cnt;
+
+	s = SAFE_MALLOC(thread_cnt * write_size);
+	memset(s, 1, thread_cnt * write_size);
+	SAFE_WRITE(1, fd, s, thread_cnt * write_size);
+
+	SAFE_CLOSE(fd);
+	if (s) {
+		free(s);
+		s = NULL;
+	}
+}
+
+static void spawn_threads(int cnt, pthread_t *id0, pthread_t *id1,
+		void *(*thread_f0)(void *), void *(*thread_f1)(void *),
+		struct param *p0, struct param *p1)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		SAFE_PTHREAD_CREATE(id0 + i, NULL, thread_f0, (void *)&p0[i]);
+		SAFE_PTHREAD_CREATE(id1 + i, NULL, thread_f1, (void *)&p1[i]);
+	}
+}
+
+static void wait_threads(int cnt, pthread_t *id0, pthread_t *id1)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		SAFE_PTHREAD_JOIN(id0[i], NULL);
+		SAFE_PTHREAD_JOIN(id1[i], NULL);
+	}
+}
+
+/* OFD write lock writing data*/
+static void *fn_ofd_w(void *arg)
+{
+	unsigned char buf[write_size];
+	struct param *pa = (struct param *)arg;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+		.l_pid    = 0,
+	};
+
+	memset(buf, pa->cnt, write_size);
+
+	lck.l_type = F_WRLCK;
+	SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+
+	SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+	SAFE_WRITE(1, fd, buf, pa->length);
+
+	lck.l_type = F_UNLCK;
+	SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+
+	sched_yield();
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+/* POSIX write lock writing data*/
+static void *fn_posix_w(void *arg)
+{
+	unsigned char buf[write_size];
+	struct param *pa = (struct param *)arg;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+
+	memset(buf, pa->cnt, write_size);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+	};
+
+	lck.l_type = F_WRLCK;
+	SAFE_FCNTL(fd, F_SETLKW, &lck);
+
+	SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+	SAFE_WRITE(1, fd, buf, pa->length);
+
+	lck.l_type = F_UNLCK;
+	SAFE_FCNTL(fd, F_SETLKW, &lck);
+
+	sched_yield();
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+/* OFD read lock reading data*/
+static void *fn_ofd_r(void *arg)
+{
+	unsigned char buf[write_size];
+	struct param *pa = (struct param *)arg;
+	int i;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+
+	memset(buf, 0, write_size);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+		.l_pid    = 0,
+	};
+
+	lck.l_type = F_RDLCK;
+	if (fcntl(fd, F_OFD_SETLKW, &lck) == -1) {
+
+		tst_brk(TBROK | TERRNO, "acquiring OFD read lock failed");
+	} else {
+
+		/* rlock acquired */
+		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+		SAFE_READ(1, fd, buf, pa->length);
+
+		/* Verifying data read */
+		for (i = 0; i < pa->length; i++) {
+
+			if (buf[i] < 1 || buf[i] > thread_cnt + 1) {
+				tst_res(TFAIL, "unexpected data "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				break;
+			}
+
+			if ((i < pa->length / 2 && buf[i] != buf[0]) ||
+				(i >= pa->length / 2 &&
+					buf[i] != buf[pa->length / 2])) {
+				tst_res(TFAIL, "unexpected data "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				break;
+			}
+		}
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_OFD_SETLK, &lck);
+	}
+
+	sched_yield();
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+/* POSIX read lock reading data */
+static void *fn_posix_r(void *arg)
+{
+	unsigned char buf[write_size];
+	struct param *pa = (struct param *)arg;
+	int i;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+
+	memset(buf, 0, write_size);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+	};
+
+	lck.l_type = F_RDLCK;
+	if (fcntl(fd, F_SETLKW, &lck) == -1) {
+
+		tst_brk(TBROK | TERRNO, "acquiring OFD read lock failed");
+	} else {
+
+		/* rlock acquired */
+		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+		SAFE_READ(1, fd, buf, pa->length);
+
+		/* Verifying data read */
+		for (i = 0; i < pa->length; i++) {
+
+			if (buf[i] < 1 || buf[i] > thread_cnt + 1) {
+				tst_res(TFAIL, "unexpected data, "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				break;
+			}
+
+			if ((i < pa->length / 2 && buf[i] != buf[0]) ||
+				(i >= pa->length / 2 &&
+					buf[i] != buf[pa->length / 2])) {
+				tst_res(TFAIL, "unexpected data, "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				break;
+			}
+		}
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_SETLK, &lck);
+	}
+
+	sched_yield();
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+/* Test different functions and verify data */
+static int test_fn(void *f0(void *), void *f1(void *), char *msg)
+{
+	int i, k, fd;
+	pthread_t id0[thread_cnt];
+	pthread_t id1[thread_cnt];
+	struct param p0[thread_cnt];
+	struct param p1[thread_cnt];
+	unsigned char buf[write_size];
+
+	setup();
+	tst_res(TINFO, msg);
+
+	for (i = 0; i < thread_cnt; i++) {
+
+		p0[i].offset = i * write_size;
+		p0[i].length = write_size;
+		p0[i].cnt = i + 2;
+
+		p1[i].offset = i * write_size;
+		p1[i].offset += write_size / 2;
+		p1[i].length = write_size;
+		p1[i].cnt = i + 2;
+	}
+
+	spawn_threads(thread_cnt, id0, id1, f0, f1, p0, p1);
+	wait_threads(thread_cnt, id0, id1);
+
+	tst_res(TINFO, "Verifying file's data");
+	fd = SAFE_OPEN(fname, O_RDWR);
+	memset(buf, 0, write_size);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+
+	for (i = 0; i <= thread_cnt; i++) {
+
+		SAFE_READ(1, fd, buf, write_size/2);
+
+		for (k = 0; k < write_size/2; k++) {
+
+			if (buf[k] < 2 || buf[k] > thread_cnt + 1) {
+				if (i == 0 && buf[k] == 1)
+					continue;
+				tst_res(TFAIL, "unexpected data, "
+					"offset %ld value %d",
+					i * write_size + k, buf[k]);
+				return -1;
+			}
+		}
+
+		for (k = 1; k < write_size/2; k++) {
+			if (buf[k] != buf[0]) {
+				tst_res(TFAIL, "unexpected block read");
+				return -1;
+			}
+		}
+	}
+
+	SAFE_CLOSE(fd);
+	tst_res(TPASS, "access between threads synchronized");
+
+	return 0;
+}
+
+static void tests(unsigned int i)
+{
+	switch (i) {
+	case 0:
+		test_fn(fn_ofd_r, fn_ofd_w,
+			"OFD read locks vs OFD write locks");
+		break;
+	case 1:
+		test_fn(fn_ofd_w, fn_posix_w,
+			"OFD write locks vs POSIX write locks");
+		break;
+	case 2:
+		test_fn(fn_ofd_r, fn_posix_w,
+			"OFD read locks vs POSIX write locks");
+		break;
+	case 3:
+		test_fn(fn_posix_r, fn_ofd_w,
+			"OFD write locks vs POSIX read locks");
+		break;
+	case 4:
+		test_fn(fn_ofd_w, fn_ofd_w,
+			"OFD write locks vs OFD write locks");
+		break;
+	}
+}
+
+static struct tst_test test = {
+	.min_kver = "3.15",
+	.needs_tmpdir = 1,
+	.test = tests,
+	.tcnt = 5,
+	.setup = setup
+};
-- 
1.8.3.1


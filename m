From: Xiong Zhou <xzhou@redhat.com>
Date: Fri,  1 Sep 2017 11:00:09 +0800
Subject: [LTP] [PATCH v7] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <20170829142748.GA18897@rei.lan>
References: <20170829142748.GA18897@rei.lan>
Message-ID: <1504234809-313-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testing OFD locks racing with POSIX locks:

  OFD read  lock   vs   OFD   write lock
  OFD read  lock   vs   POSIX write lock
  OFD write lock   vs   POSIX write lock
  OFD write lock   vs   POSIX read  lock
  OFD write lock   vs   OFD   write lock
  OFD   r/w locks  vs   POSIX write locks
  OFD   r/w locks  vs   POSIX read  locks

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

v7:
  Add pthread_barrier.
  Run only one kind of POSIX lock threads.
  Add fn_dummy, save efforts to look at thread funcs before firing them.

v6:
  Use param->length in thread_fn as r/w size instead of
write_size directly. Thanks to C99.

  Reset fail_flag after each sub case.

  Race up to 4 bunches of threads acquiring these 4 kinds of locks,
not just only 2 of them. (kind crazy)

v5:
  Optimize data checking.

v4:
  Add .gitignore entry.
  Count failures in reader, then check it in main loop.
  Other fix.

v3:
  Use tst_fill_file.
  Loop in test function.
  Other fix.

v2:
  Basically rewritten.
  Pass structure parameter to threads.
  Block on read lock.
  Spawn racing threads one by one.
  Use tcnt iteration.
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/Makefile  |   3 +
 testcases/kernel/syscalls/fcntl/fcntl36.c | 419 ++++++++++++++++++++++++++++++
 4 files changed, 426 insertions(+)
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
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 2a7026d..32193e1 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -234,6 +234,8 @@
 /fcntl/fcntl34_64
 /fcntl/fcntl35
 /fcntl/fcntl35_64
+/fcntl/fcntl36
+/fcntl/fcntl36_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flistxattr/flistxattr01
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
index 0000000..fad3d8a
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -0,0 +1,419 @@
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
+ *	OFD   r/w locks vs POSIX write locks
+ *	OFD   r/w locks vs POSIX read locks
+ *
+ * For example:
+ *
+ * 	Init an file with preset values.
+ *
+ * 	Threads acquire OFD READ  locks to read  a 4k section start from 0;
+ * 		checking data read back, there should not be any surprise
+ * 		values and data should be consistent in a 2k block.
+ *
+ * 	Threads acquire OFD WRITE locks to write a 4k section start from 1k,
+ * 		writing different values in different threads.
+ *
+ * 	Check file data after racing, there should not be any surprise values
+ * 		and data should be consistent in a 1k block.
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
+static int fail_flag = 0;
+static volatile int loop_flag = 1;
+static const int max_thread_cnt = 32;
+static const char fname[] = "tst_ofd_posix_locks";
+static const long write_size = 4096;
+static pthread_barrier_t barrier;
+
+struct param {
+	long offset;
+	long length;
+	long cnt;
+};
+
+static void setup(void)
+{
+	thread_cnt = tst_ncpus_conf() * 3;
+	if (thread_cnt > max_thread_cnt)
+		thread_cnt = max_thread_cnt;
+}
+
+/* OFD write lock writing data*/
+static void *fn_ofd_w(void *arg)
+{
+	struct param *pa = (struct param *)arg;
+	unsigned char buf[pa->length];
+	int fd = SAFE_OPEN(fname, O_RDWR);
+	long wt = pa->cnt;
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+		.l_pid    = 0,
+	};
+
+	while (loop_flag) {
+
+		memset(buf, wt, pa->length);
+
+		lck.l_type = F_WRLCK;
+		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+
+		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+		SAFE_WRITE(1, fd, buf, pa->length);
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+
+		wt++;
+		if (wt >= 255)
+			wt = pa->cnt;
+
+		sched_yield();
+	}
+
+	pthread_barrier_wait(&barrier);
+	SAFE_CLOSE(fd);
+	return NULL;
+}
+
+/* POSIX write lock writing data*/
+static void *fn_posix_w(void *arg)
+{
+	struct param *pa = (struct param *)arg;
+	unsigned char buf[pa->length];
+	int fd = SAFE_OPEN(fname, O_RDWR);
+	long wt = pa->cnt;
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+	};
+
+	while (loop_flag) {
+
+		memset(buf, wt, pa->length);
+
+		lck.l_type = F_WRLCK;
+		SAFE_FCNTL(fd, F_SETLKW, &lck);
+
+		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+		SAFE_WRITE(1, fd, buf, pa->length);
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_SETLKW, &lck);
+
+		wt++;
+		if (wt >= 255)
+			wt = pa->cnt;
+
+		sched_yield();
+	}
+
+	pthread_barrier_wait(&barrier);
+	SAFE_CLOSE(fd);
+	return NULL;
+}
+
+/* OFD read lock reading data*/
+static void *fn_ofd_r(void *arg)
+{
+	struct param *pa = (struct param *)arg;
+	unsigned char buf[pa->length];
+	int i;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+		.l_pid    = 0,
+	};
+
+	while (loop_flag) {
+
+		memset(buf, 0, pa->length);
+
+		lck.l_type = F_RDLCK;
+		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+
+		/* rlock acquired */
+		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+		SAFE_READ(1, fd, buf, pa->length);
+
+		/* Verifying data read */
+		for (i = 0; i < pa->length; i++) {
+
+			if (buf[i] < 1 || buf[i] > 254) {
+
+				tst_res(TFAIL, "Unexpected data "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				fail_flag = 1;
+				break;
+			}
+
+			int j = (i / (pa->length/4)) * pa->length/4;
+
+			if (buf[i] != buf[j]) {
+
+				tst_res(TFAIL, "Unexpected data "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				fail_flag = 1;
+				break;
+			}
+		}
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_OFD_SETLK, &lck);
+
+		sched_yield();
+	}
+
+	pthread_barrier_wait(&barrier);
+	SAFE_CLOSE(fd);
+	return NULL;
+}
+
+/* POSIX read lock reading data */
+static void *fn_posix_r(void *arg)
+{
+	struct param *pa = (struct param *)arg;
+	unsigned char buf[pa->length];
+	int i;
+	int fd = SAFE_OPEN(fname, O_RDWR);
+
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+	};
+
+	while (loop_flag) {
+
+		memset(buf, 0, pa->length);
+
+		lck.l_type = F_RDLCK;
+		SAFE_FCNTL(fd, F_SETLKW, &lck);
+
+		/* rlock acquired */
+		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
+		SAFE_READ(1, fd, buf, pa->length);
+
+		/* Verifying data read */
+		for (i = 0; i < pa->length; i++) {
+
+			if (buf[i] < 1 || buf[i] > 254) {
+
+				tst_res(TFAIL, "Unexpected data "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				fail_flag = 1;
+				break;
+			}
+
+			int j = (i / (pa->length/4)) * pa->length/4;
+
+			if (buf[i] != buf[j]) {
+
+				tst_res(TFAIL, "Unexpected data "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				fail_flag = 1;
+				break;
+			}
+		}
+
+		lck.l_type = F_UNLCK;
+		SAFE_FCNTL(fd, F_SETLK, &lck);
+
+		sched_yield();
+	}
+
+	pthread_barrier_wait(&barrier);
+	SAFE_CLOSE(fd);
+	return NULL;
+}
+
+static void *fn_dummy(void *arg)
+{
+	arg = NULL;
+
+	pthread_barrier_wait(&barrier);
+	return arg;
+}
+
+/* Test different functions and verify data */
+static void test_fn(void *f0(void *), void *f1(void *),
+		    void *f2(void *), const char *msg)
+{
+	int i, k, fd;
+	pthread_t id0[thread_cnt];
+	pthread_t id1[thread_cnt];
+	pthread_t id2[thread_cnt];
+	struct param p0[thread_cnt];
+	struct param p1[thread_cnt];
+	struct param p2[thread_cnt];
+	unsigned char buf[write_size];
+
+	tst_res(TINFO, msg);
+
+	if (tst_fill_file(fname, 1, write_size, thread_cnt + 1))
+		tst_brk(TBROK, "Failed to create tst file");
+
+	if (pthread_barrier_init(&barrier, NULL, thread_cnt*3) != 0)
+		tst_brk(TBROK, "Failed to init pthread barrier");
+
+	for (i = 0; i < thread_cnt; i++) {
+
+		p0[i].offset = i * write_size;
+		p0[i].length = write_size;
+		p0[i].cnt = i + 2;
+
+		p1[i].offset = i * write_size + write_size / 4;
+		p1[i].length = write_size;
+		p1[i].cnt = i + 2;
+
+		p2[i].offset = i * write_size + write_size / 2;
+		p2[i].length = write_size;
+		p2[i].cnt = i + 2;
+	}
+
+	fail_flag = 0;
+	loop_flag = 1;
+
+	for (i = 0; i < thread_cnt; i++) {
+
+		SAFE_PTHREAD_CREATE(id0 + i, NULL, f0, (void *)&p0[i]);
+		SAFE_PTHREAD_CREATE(id1 + i, NULL, f1, (void *)&p1[i]);
+		SAFE_PTHREAD_CREATE(id2 + i, NULL, f2, (void *)&p2[i]);
+	}
+
+	sleep(1);
+	loop_flag = 0;
+
+	for (i = 0; i < thread_cnt; i++) {
+
+		SAFE_PTHREAD_JOIN(id0[i], NULL);
+		SAFE_PTHREAD_JOIN(id1[i], NULL);
+		SAFE_PTHREAD_JOIN(id2[i], NULL);
+	}
+
+	fd = SAFE_OPEN(fname, O_RDONLY);
+
+	for (i = 0; i < thread_cnt * 4; i++) {
+
+		SAFE_READ(1, fd, buf, write_size/4);
+
+		for (k = 0; k < write_size/4; k++) {
+
+			if (buf[k] < 2 || buf[k] > 254) {
+
+				if (i < 3 && buf[k] == 1)
+					continue;
+				tst_res(TFAIL, "Unexpected data "
+					"offset %ld value %d",
+					i * write_size / 4 + k, buf[k]);
+				SAFE_CLOSE(fd);
+				return;
+			}
+		}
+
+		for (k = 1; k < write_size/4; k++) {
+
+			if (buf[k] != buf[0]) {
+				tst_res(TFAIL, "Unexpected block read");
+				SAFE_CLOSE(fd);
+				return;
+			}
+		}
+	}
+
+	if (pthread_barrier_destroy(&barrier) != 0)
+		tst_brk(TBROK, "Failed to destroy pthread barrier");
+
+	SAFE_CLOSE(fd);
+	if (fail_flag == 0)
+		tst_res(TPASS, "Access between threads synchronized");
+}
+
+static struct tcase {
+
+	void *(*fn0)(void *);
+	void *(*fn1)(void *);
+	void *(*fn2)(void *);
+	const char *desc;
+
+} tcases[] = {
+
+	{fn_ofd_r, fn_ofd_w, fn_dummy, "OFD read lock vs OFD write lock"},
+
+	{fn_ofd_w, fn_posix_w, fn_dummy, "OFD write lock vs POSIX write lock"},
+
+	{fn_ofd_r, fn_posix_w, fn_dummy, "OFD read lock vs POSIX write lock"},
+
+	{fn_ofd_w, fn_posix_r, fn_dummy, "OFD write lock vs POSIX read lock"},
+
+	{fn_ofd_w, fn_ofd_w, fn_dummy, "OFD write lock vs OFD write lock"},
+
+	{fn_ofd_r, fn_ofd_w, fn_posix_w, "OFD r/w lock vs POSIX write lock"},
+
+	{fn_ofd_r, fn_ofd_w, fn_posix_r, "OFD r/w lock vs POSIX read lock"},
+};
+
+static void tests(unsigned int i)
+{
+	test_fn(tcases[i].fn0, tcases[i].fn1, tcases[i].fn2, tcases[i].desc);
+}
+
+static struct tst_test test = {
+	.min_kver = "3.15",
+	.needs_tmpdir = 1,
+	.test = tests,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup
+};
-- 
1.8.3.1


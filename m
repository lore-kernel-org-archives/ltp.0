From: Xiong Zhou <xzhou@redhat.com>
Date: Wed, 23 Aug 2017 17:42:00 +0800
Subject: [LTP] [PATCH v4] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <20170823084019.GA8175@rei.lan>
References: <20170823084019.GA8175@rei.lan>
Message-ID: <1503481320-10418-1-git-send-email-xzhou@redhat.com>
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

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

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
 testcases/kernel/syscalls/fcntl/fcntl36.c | 378 ++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
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
index 0000000..1afa278
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -0,0 +1,378 @@
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
+static int fail_cnt = 0;
+static volatile int loop_flag = 1;
+static const int max_thread_cnt = 32;
+static const char fname[] = "tst_ofd_posix_locks";
+static const long write_size = 4096;
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
+	unsigned char buf[write_size];
+	struct param *pa = (struct param *)arg;
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
+		memset(buf, wt, write_size);
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
+	SAFE_CLOSE(fd);
+	return NULL;
+}
+
+/* POSIX write lock writing data*/
+static void *fn_posix_w(void *arg)
+{
+	unsigned char buf[write_size];
+	struct param *pa = (struct param *)arg;
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
+		memset(buf, wt, write_size);
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
+	SAFE_CLOSE(fd);
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
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+		.l_pid    = 0,
+	};
+
+	while (loop_flag) {
+
+		memset(buf, 0, write_size);
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
+				fail_cnt++;
+				break;
+			}
+
+			long tmp = pa->length / 2;
+
+			if ((i < tmp && buf[i] != buf[0]) ||
+			    (i >= tmp && buf[i] != buf[tmp])) {
+
+				tst_res(TFAIL, "Unexpected data "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				fail_cnt++;
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
+	SAFE_CLOSE(fd);
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
+	struct flock64 lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = pa->offset,
+		.l_len    = pa->length,
+	};
+
+	while (loop_flag) {
+
+		memset(buf, 0, write_size);
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
+				tst_res(TFAIL, "Unexpected data, "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				fail_cnt++;
+				break;
+			}
+
+			long tmp = pa->length / 2;
+
+			if ((i < tmp && buf[i] != buf[0]) ||
+			    (i >= tmp && buf[i] != buf[tmp])) {
+
+				tst_res(TFAIL, "Unexpected data, "
+					"offset %ld value %d",
+					pa->offset + i, buf[i]);
+				fail_cnt++;
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
+	SAFE_CLOSE(fd);
+	return NULL;
+}
+
+/* Test different functions and verify data */
+static void test_fn(void *f0(void *), void *f1(void *), const char *msg)
+{
+	int i, k, fd;
+	pthread_t id0[thread_cnt];
+	pthread_t id1[thread_cnt];
+	struct param p0[thread_cnt];
+	struct param p1[thread_cnt];
+	unsigned char buf[write_size];
+
+	if (tst_fill_file(fname, 1, write_size, thread_cnt))
+		tst_brk(TBROK, "Failed to create tst file");
+
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
+	loop_flag = 1;
+	for (i = 0; i < thread_cnt; i++) {
+		SAFE_PTHREAD_CREATE(id0 + i, NULL, f0, (void *)&p0[i]);
+		SAFE_PTHREAD_CREATE(id1 + i, NULL, f1, (void *)&p1[i]);
+	}
+
+	sleep(1);
+	loop_flag = 0;
+	for (i = 0; i < thread_cnt; i++) {
+		SAFE_PTHREAD_JOIN(id0[i], NULL);
+		SAFE_PTHREAD_JOIN(id1[i], NULL);
+	}
+
+	tst_res(TINFO, "Verifying file's data");
+	fd = SAFE_OPEN(fname, O_RDONLY);
+
+	for (i = 0; i < thread_cnt * 2; i++) {
+
+		SAFE_READ(1, fd, buf, write_size/2);
+
+		for (k = 0; k < write_size/2; k++) {
+
+			if (buf[k] < 2 || buf[k] > 254) {
+
+				if (i == 0 && buf[k] == 1)
+					continue;
+				tst_res(TFAIL, "Unexpected data, "
+					"offset %ld value %d",
+					i * write_size / 2 + k, buf[k]);
+				SAFE_CLOSE(fd);
+				return;
+			}
+		}
+
+		for (k = 1; k < write_size/2; k++) {
+
+			if (buf[k] != buf[0]) {
+				tst_res(TFAIL, "Unexpected block read");
+				SAFE_CLOSE(fd);
+				return;
+			}
+		}
+	}
+
+	SAFE_CLOSE(fd);
+	if (fail_cnt == 0)
+		tst_res(TPASS, "Access between threads synchronized");
+}
+
+static struct tcase {
+
+	void *(*fn0)(void *);
+	void *(*fn1)(void *);
+	const char *desc;
+
+} tcases[] = {
+
+	{fn_ofd_r,   fn_ofd_w,   "OFD read locks vs OFD write locks"},
+	{fn_ofd_w,   fn_posix_w, "OFD write locks vs POSIX write locks"},
+	{fn_ofd_r,   fn_posix_w, "OFD read locks vs POSIX write locks"},
+	{fn_posix_r, fn_ofd_w,   "OFD write locks vs POSIX read locks"},
+	{fn_ofd_w,   fn_ofd_w,   "OFD write locks vs OFD write locks"},
+};
+
+static void tests(unsigned int i)
+{
+	test_fn(tcases[i].fn0, tcases[i].fn1, tcases[i].desc);
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


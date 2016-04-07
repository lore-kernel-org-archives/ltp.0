From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  7 Apr 2016 11:10:51 +0300
Subject: [LTP] [PATCH v2 2/2] syscalls/fcntl: add new test for open file
	description locks
In-Reply-To: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
References: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1460016651-24181-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

OFD lock is available since Linux 3.15 and new F_OFD_* macros
added to lapi/fcntl.h

Test is based on [1] article and checks that OFD locks can
syncronise access to a file between multiple threads.

[1] https://lwn.net/Articles/586904

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: * correct varibale names
    * use new library API
    * truncate test file before threads start
    * use safe_pthread_*()

 include/lapi/fcntl.h                      |   12 +++
 runtest/syscalls                          |    2 +
 testcases/kernel/syscalls/.gitignore      |    2 +
 testcases/kernel/syscalls/fcntl/Makefile  |    3 +
 testcases/kernel/syscalls/fcntl/fcntl34.c |  149 +++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl34.c

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 1ea3fb4..c4d4fb5 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -43,6 +43,18 @@
 # define F_OWNER_PGRP 2
 #endif
 
+#ifndef F_OFD_GETLK
+# define F_OFD_GETLK	36
+#endif
+
+#ifndef F_OFD_SETLK
+# define F_OFD_SETLK	37
+#endif
+
+#ifndef F_OFD_SETLKW
+# define F_OFD_SETLKW	38
+#endif
+
 #ifndef AT_FDCWD
 # define AT_FDCWD -100
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index f537374..ca922e6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -265,6 +265,8 @@ fcntl32 fcntl32
 fcntl32_64 fcntl32_64
 fcntl33 fcntl33
 fcntl33_64 fcntl33_64
+fcntl34 fcntl34
+fcntl34_64 fcntl34_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index e2fa551..ad2618c 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -228,6 +228,8 @@
 /fcntl/fcntl32_64
 /fcntl/fcntl33
 /fcntl/fcntl33_64
+/fcntl/fcntl34
+/fcntl/fcntl34_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flock/flock01
diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
index 214eeb8..d78dd72 100644
--- a/testcases/kernel/syscalls/fcntl/Makefile
+++ b/testcases/kernel/syscalls/fcntl/Makefile
@@ -21,6 +21,9 @@ top_srcdir		?= ../../../..
 fcntl33: LDLIBS+=-lrt
 fcntl33_64: LDLIBS+=-lrt
 
+fcntl34: LDLIBS += -lpthread
+fcntl34_64: LDLIBS += -lpthread
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
new file mode 100644
index 0000000..de6b285
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -0,0 +1,149 @@
+/*
+ * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <pthread.h>
+
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+
+static int thread_cnt;
+static const int max_thread_cnt = 32;
+static const char fname[] = "tst_ofd_locks";
+const int writes_num = 100;
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
+	tst_res(TINFO, "spawning '%d' threads", thread_cnt);
+	for (i = 0; i < thread_cnt; ++i)
+		SAFE_PTHREAD_CREATE(id + i, NULL, thread_fn, (void *)i);
+}
+
+static void wait_threads(pthread_t *id)
+{
+	int i;
+
+	tst_res(TINFO, "waiting for '%d' threads", thread_cnt);
+	for (i = 0; i < thread_cnt; ++i)
+		SAFE_PTHREAD_JOIN(id[i], NULL);
+}
+
+void *thread_fn_01(void *arg)
+{
+	int i;
+	char buf[write_size];
+	int fd = SAFE_OPEN(fname, O_RDWR);
+
+	memset(buf, (intptr_t)arg, write_size);
+
+	struct flock lck = {
+		.l_whence = SEEK_SET,
+		.l_start  = 0,
+		.l_len    = 1,
+	};
+
+	for (i = 0; i < writes_num; ++i) {
+		lck.l_type = F_WRLCK;
+		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
+			tst_brk(TBROK | TERRNO, "fcntl() failed");
+
+		SAFE_LSEEK(fd, 0, SEEK_END);
+		SAFE_WRITE(1, fd, buf, write_size);
+
+		lck.l_type = F_UNLCK;
+		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
+			tst_brk(TBROK | TERRNO, "fcntl() failed");
+
+		pthread_yield();
+	}
+
+	SAFE_CLOSE(fd);
+
+	return NULL;
+}
+
+static void test01(void)
+{
+	intptr_t i;
+	int k;
+	pthread_t id[thread_cnt];
+	int res[thread_cnt];
+	char buf[write_size];
+
+	tst_res(TINFO, "write to a file inside threads with OFD locks");
+
+	int fd = SAFE_OPEN(fname, O_CREAT | O_TRUNC | O_RDONLY, 0600);
+
+	memset(res, 0, sizeof(res));
+
+	spawn_threads(id, thread_fn_01);
+	wait_threads(id);
+
+	tst_res(TINFO, "verifying file's data");
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	for (i = 0; i < writes_num * thread_cnt; ++i) {
+		SAFE_READ(1, fd, buf, write_size);
+
+		if (buf[0] < 0 || buf[0] > thread_cnt) {
+			tst_res(TFAIL, "unexpected data read");
+			return;
+		}
+
+		++res[(int)buf[0]];
+
+		for (k = 1; k < write_size; ++k) {
+			if (buf[0] != buf[k]) {
+				tst_res(TFAIL, "unexpected data read");
+				return;
+			}
+		}
+	}
+
+	for (i = 0; i < thread_cnt; ++i) {
+		if (res[i] != writes_num) {
+			tst_res(TFAIL, "corrupted data found");
+			return;
+		}
+	}
+	SAFE_CLOSE(fd);
+
+	tst_res(TPASS, "OFD locks synchronized access between threads");
+}
+
+static struct tst_test test = {
+	.tid = "fcntl34",
+	.min_kver = "3.15.0",
+	.needs_tmpdir = 1,
+	.test_all = test01,
+	.setup = setup
+};
-- 
1.7.1


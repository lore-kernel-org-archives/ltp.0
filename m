From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 15 Mar 2016 12:26:28 +0300
Subject: [LTP] [PATCH] syscalls/fcntl: add new test for open file
	description locks
Message-ID: <1458033988-15881-1-git-send-email-alexey.kodanev@oracle.com>
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
 include/lapi/fcntl.h                      |    6 +
 runtest/syscalls                          |    2 +
 testcases/kernel/syscalls/.gitignore      |    2 +
 testcases/kernel/syscalls/fcntl/Makefile  |    3 +
 testcases/kernel/syscalls/fcntl/fcntl34.c |  172 +++++++++++++++++++++++++++++
 5 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl34.c

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 1ea3fb4..946408e 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -43,6 +43,12 @@
 # define F_OWNER_PGRP 2
 #endif
 
+#ifndef F_OFD_GETLK
+#define F_OFD_GETLK	36
+#define F_OFD_SETLK	37
+#define F_OFD_SETLKW	38
+#endif
+
 #ifndef AT_FDCWD
 # define AT_FDCWD -100
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index b41c927..9b4cdaf 100644
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
index 0540928..b3e57a4 100644
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
index 0000000..9413e09
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -0,0 +1,172 @@
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
+#include <errno.h>
+
+#include "lapi/fcntl.h"
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "fcntl34";
+int TST_TOTAL = 1;
+
+static int thread_size;
+static const int max_thread_size = 32;
+static const char fname[] = "tst_ofd_locks";
+const int writes_num = 100;
+const int bytes_num = 4096;
+
+TST_DECLARE_ONCE_FN(cleanup, tst_rmdir)
+
+static void setup(void)
+{
+	tst_tmpdir();
+	thread_size = SAFE_SYSCONF(cleanup, _SC_NPROCESSORS_CONF) * 3;
+	if (thread_size > max_thread_size)
+		thread_size = max_thread_size;
+}
+
+static void spawn_threads(pthread_t *id, int size,
+			  void *(*thread_fn)(void *))
+{
+	intptr_t i;
+
+	tst_resm(TINFO, "spawning '%d' threads", size);
+	for (i = 0; i < size; ++i) {
+		if (pthread_create(id + i, NULL, thread_fn, (void *)i)) {
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "pthread_create() failed");
+		}
+	}
+}
+
+static void wait_threads(pthread_t *id, int size)
+{
+	int i;
+
+	tst_resm(TINFO, "waiting for '%d' threads", size);
+	for (i = 0; i < size; ++i) {
+		if (pthread_join(id[i], NULL) != 0)
+			tst_brkm(TBROK, cleanup, "pthread_join() failed");
+	}
+}
+
+void *thread_fn_01(void *arg)
+{
+	int i;
+	char buf[bytes_num];
+	int fd = SAFE_OPEN(cleanup, fname, O_RDWR, 0600);
+
+	memset(buf, (intptr_t)arg, bytes_num);
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
+			tst_brkm(TBROK | TERRNO, cleanup, "fcntl() failed");
+
+		SAFE_LSEEK(cleanup, fd, 0, SEEK_END);
+		SAFE_WRITE(cleanup, 1, fd, buf, bytes_num);
+
+		lck.l_type = F_UNLCK;
+		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "fcntl() failed");
+
+		pthread_yield();
+	}
+
+	SAFE_CLOSE(cleanup, fd);
+
+	return NULL;
+}
+
+void test01(void)
+{
+	intptr_t i;
+	int k;
+	pthread_t id[thread_size];
+	int res[thread_size];
+	char buf[bytes_num];
+
+	tst_resm(TINFO, "write to a file inside threads with OFD locks");
+
+	int fd = SAFE_OPEN(cleanup, fname, O_CREAT | O_RDONLY, 0600);
+
+	memset(res, 0, sizeof(res));
+
+	spawn_threads(id, thread_size, thread_fn_01);
+	wait_threads(id, thread_size);
+
+	tst_resm(TINFO, "verifying file's data");
+	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+	for (i = 0; i < writes_num * thread_size; ++i) {
+		SAFE_READ(cleanup, 1, fd, buf, bytes_num);
+
+		if (buf[0] < 0 || buf[0] > thread_size)
+			tst_brkm(TFAIL, cleanup, "unexpected data read");
+
+		++res[(int)buf[0]];
+
+		for (k = 1; k < bytes_num; ++k) {
+			if (buf[0] != buf[k]) {
+				tst_brkm(TFAIL, cleanup,
+					 "unexpected data read");
+			}
+		}
+	}
+
+	for (i = 0; i < thread_size; ++i) {
+		if (res[i] != writes_num)
+			tst_brkm(TFAIL, cleanup, "corrupted data found");
+	}
+	SAFE_CLOSE(cleanup, fd);
+
+	tst_resm(TPASS, "OFD locks synchronized access between threads");
+}
+
+int main(int ac, char *av[])
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	if (tst_kvercmp(3, 15, 0) < 0)
+		tst_brkm(TCONF, NULL, "Test must be run with kernel 3.15+");
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
+		test01();
+	}
+
+	cleanup();
+	tst_exit();
+}
-- 
1.7.1


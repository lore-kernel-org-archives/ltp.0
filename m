From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 15 Feb 2019 16:11:02 +0800
Subject: [LTP] [PATCH 2/3] syscalls/pwritev201: Add new testcase
In-Reply-To: <1550218263-5961-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1550218263-5961-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1550218263-5961-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check the basic functionality of the pwritev2().

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 configure.ac                                    |   1 +
 include/lapi/pwritev2.h                         |  26 +++++
 m4/ltp-pwritev2.m4                              |   9 ++
 runtest/syscalls                                |   3 +
 testcases/kernel/syscalls/pwritev2/.gitignore   |   2 +
 testcases/kernel/syscalls/pwritev2/Makefile     |  13 +++
 testcases/kernel/syscalls/pwritev2/pwritev201.c | 120 ++++++++++++++++++++++++
 7 files changed, 174 insertions(+)
 create mode 100644 include/lapi/pwritev2.h
 create mode 100644 m4/ltp-pwritev2.m4
 create mode 100644 testcases/kernel/syscalls/pwritev2/.gitignore
 create mode 100644 testcases/kernel/syscalls/pwritev2/Makefile
 create mode 100644 testcases/kernel/syscalls/pwritev2/pwritev201.c

diff --git a/configure.ac b/configure.ac
index caea344..c5f3d4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -219,6 +219,7 @@ LTP_CHECK_KCMP_TYPE
 LTP_CHECK_PREADV
 LTP_CHECK_PWRITEV
 LTP_CHECK_PREADV2
+LTP_CHECK_PWRITEV2
 LTP_CHECK_EPOLL_PWAIT
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_SYNC_ADD_AND_FETCH
diff --git a/include/lapi/pwritev2.h b/include/lapi/pwritev2.h
new file mode 100644
index 0000000..305e48e
--- /dev/null
+++ b/include/lapi/pwritev2.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
+ */
+
+#ifndef PWRITEV2_H
+#define PWRITEV2_H
+
+#include "config.h"
+#include "lapi/syscalls.h"
+
+#if !defined(HAVE_PWRITEV2)
+
+/* LO_HI_LONG taken from glibc */
+# define LO_HI_LONG(val) (long) (val), (long) (((uint64_t) (val)) >> 32)
+
+ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
+		int flags)
+{
+	return tst_syscall(__NR_pwritev2, fd, iov, iovcnt,
+			   LO_HI_LONG(offset), flags);
+}
+#endif
+
+#endif /* PWRITEV2_H */
diff --git a/m4/ltp-pwritev2.m4 b/m4/ltp-pwritev2.m4
new file mode 100644
index 0000000..38148ac
--- /dev/null
+++ b/m4/ltp-pwritev2.m4
@@ -0,0 +1,9 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+dnl Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
+
+dnl LTP_CHECK_PWRITEV2
+dnl ----------------------------
+AC_DEFUN([LTP_CHECK_PWRITEV2],[
+AC_CHECK_FUNCS(pwritev2,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 668c87c..04f5269 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -907,6 +907,9 @@ pwritev02_64 pwritev02_64
 pwritev03 pwritev03
 pwritev03_64 pwritev03_64
 
+pwritev201 pwritev201
+pwritev201_64 pwritev201_64
+
 quotactl01 quotactl01
 quotactl02 quotactl02
 quotactl03 quotactl03
diff --git a/testcases/kernel/syscalls/pwritev2/.gitignore b/testcases/kernel/syscalls/pwritev2/.gitignore
new file mode 100644
index 0000000..46270c3
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev2/.gitignore
@@ -0,0 +1,2 @@
+/pwritev201
+/pwritev201_64
diff --git a/testcases/kernel/syscalls/pwritev2/Makefile b/testcases/kernel/syscalls/pwritev2/Makefile
new file mode 100644
index 0000000..89756d0
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev2/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+# Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(abs_srcdir)/../utils/newer_64.mk
+
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
new file mode 100644
index 0000000..34067c1
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
+ */
+/*
+ * Description:
+ * Testcase to check the basic functionality of the pwritev2(2).
+ * 1) If the file offset argument is not -1, pwritev2() should succeed
+ *    in writing the expected content of data and the file offset is
+ *    not changed after writing.
+ * 2) If the file offset argument is -1, pwritev2() should succeed in
+ *    writing the expected content of data and the current file offset
+ *    is used and changed after writing.
+ */
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <sys/uio.h>
+
+#include "tst_test.h"
+#include "lapi/pwritev2.h"
+#include "tst_safe_prw.h"
+
+#define CHUNK	64
+
+static int fd;
+static char initbuf[CHUNK * 2];
+static char preadbuf[CHUNK];
+static char buf[CHUNK];
+
+static struct iovec wr_iovec[] = {
+	{buf, CHUNK},
+	{NULL, 0},
+};
+
+static struct tcase {
+	off_t seek_off;
+	int count;
+	off_t write_off;
+	ssize_t size;
+	off_t exp_off;
+} tcases[] = {
+	{0,     1, 0,           CHUNK,     0},
+	{CHUNK, 2, 0,           CHUNK,     CHUNK},
+	{0,     1, CHUNK*3 / 2, CHUNK,     0},
+	{0,     1, -1,          CHUNK,     CHUNK},
+	{0,     2, -1,          CHUNK,     CHUNK},
+	{CHUNK, 1, -1,          CHUNK,     CHUNK * 2},
+};
+
+static void verify_pwritev2(unsigned int n)
+{
+	int i;
+	struct tcase *tc = &tcases[n];
+	off_t read_off = 0;
+
+	SAFE_PWRITE(1, fd, initbuf, sizeof(initbuf), 0);
+
+	SAFE_LSEEK(fd, tc->seek_off, SEEK_SET);
+
+	TEST(pwritev2(fd, wr_iovec, tc->count, tc->write_off, 0));
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TTERRNO, "pwritev() failed");
+		return;
+	}
+
+	if (TST_RET != tc->size) {
+		tst_res(TFAIL, "pwritev2() wrote %li bytes, expected %zi",
+			 TST_RET, tc->size);
+		return;
+	}
+
+	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != tc->exp_off) {
+		tst_res(TFAIL, "pwritev2() had changed file offset");
+		return;
+	}
+	if (tc->write_off != -1)
+		read_off = tc->write_off;
+	else
+		read_off = tc->seek_off;
+
+	SAFE_PREAD(1, fd, preadbuf, tc->size, read_off);
+
+	for (i = 0; i < tc->size; i++) {
+		if (preadbuf[i] != 0x61)
+			break;
+	}
+
+	if (i != tc->size) {
+		tst_res(TFAIL, "buffer wrong at %i have %02x expected 61",
+			 i, preadbuf[i]);
+		return;
+	}
+
+	tst_res(TPASS, "pwritev2() wrote %zi bytes successfully "
+		 "with content 'a' expectedly ", tc->size);
+}
+
+static void setup(void)
+{
+	memset(buf, 0x61, CHUNK);
+	memset(initbuf, 0, CHUNK * 2);
+
+	fd = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_pwritev2,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1




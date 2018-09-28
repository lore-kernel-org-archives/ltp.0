From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 28 Sep 2018 17:10:50 +0800
Subject: [LTP] [PATCH 2/3] syscalls/preadv201: Add new testcase
In-Reply-To: <1538125851-26738-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1538125851-26738-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1538125851-26738-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check the basic functionality of the preadv2(2).

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                  |   1 +
 m4/ltp-preadv2.m4                             |   9 ++
 runtest/ltplite                               |   2 +
 runtest/stress.part3                          |   2 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/preadv2/.gitignore  |   2 +
 testcases/kernel/syscalls/preadv2/Makefile    |  14 +++
 testcases/kernel/syscalls/preadv2/preadv2.h   |  26 ++++++
 testcases/kernel/syscalls/preadv2/preadv201.c | 119 ++++++++++++++++++++++++++
 9 files changed, 178 insertions(+)
 create mode 100644 m4/ltp-preadv2.m4
 create mode 100644 testcases/kernel/syscalls/preadv2/.gitignore
 create mode 100644 testcases/kernel/syscalls/preadv2/Makefile
 create mode 100644 testcases/kernel/syscalls/preadv2/preadv2.h
 create mode 100644 testcases/kernel/syscalls/preadv2/preadv201.c

diff --git a/configure.ac b/configure.ac
index e1ecb32..0f0d8c1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -218,6 +218,7 @@ LTP_CHECK_KCMP
 LTP_CHECK_KCMP_TYPE
 LTP_CHECK_PREADV
 LTP_CHECK_PWRITEV
+LTP_CHECK_PREADV2
 LTP_CHECK_EPOLL_PWAIT
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_SYNC_ADD_AND_FETCH
diff --git a/m4/ltp-preadv2.m4 b/m4/ltp-preadv2.m4
new file mode 100644
index 0000000..a1e5327
--- /dev/null
+++ b/m4/ltp-preadv2.m4
@@ -0,0 +1,9 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+
+dnl LTP_CHECK_PREADV2
+dnl ----------------------------
+AC_DEFUN([LTP_CHECK_PREADV2],[
+AC_CHECK_FUNCS(preadv2,,)
+])
diff --git a/runtest/ltplite b/runtest/ltplite
index 61ab275..6959536 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -586,6 +586,8 @@ preadv01 preadv01
 preadv02 preadv02
 preadv03 preadv03
 
+preadv201 preadv201
+
 profil01 profil01
 
 pselect01 pselect01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 332daa9..525d33b 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -495,6 +495,8 @@ preadv01 preadv01
 preadv02 preadv02
 preadv03 preadv03
 
+preadv201 preadv201
+
 profil01 profil01
 
 pselect01 pselect01
diff --git a/runtest/syscalls b/runtest/syscalls
index 0d0be77..02b02b8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -834,6 +834,9 @@ preadv02_64 preadv02_64
 preadv03 preadv03
 preadv03_64 preadv03_64
 
+preadv201 preadv201
+preadv201_64 preadv201_64
+
 profil01 profil01
 
 process_vm_readv01 process_vm01 -r
diff --git a/testcases/kernel/syscalls/preadv2/.gitignore b/testcases/kernel/syscalls/preadv2/.gitignore
new file mode 100644
index 0000000..0ed1a00
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv2/.gitignore
@@ -0,0 +1,2 @@
+/preadv201
+/preadv201_64
diff --git a/testcases/kernel/syscalls/preadv2/Makefile b/testcases/kernel/syscalls/preadv2/Makefile
new file mode 100644
index 0000000..fc1fbf3
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv2/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(abs_srcdir)/../utils/newer_64.mk
+
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/preadv2/preadv2.h b/testcases/kernel/syscalls/preadv2/preadv2.h
new file mode 100644
index 0000000..aacf96f
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv2/preadv2.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+#ifndef PREADV2_H
+#define PREADV2_H
+
+#include "config.h"
+#include "lapi/syscalls.h"
+
+#if !defined(HAVE_PREADV2)
+
+/* LO_HI_LONG taken from glibc */
+# define LO_HI_LONG(val) (long) (val), (long) (((uint64_t) (val)) >> 32)
+
+ssize_t preadv2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
+		int flags)
+{
+	return tst_syscall(__NR_preadv2, fd, iov, iovcnt,
+			   LO_HI_LONG(offset), flags);
+}
+#endif
+
+#endif /* PREADV2_H */
diff --git a/testcases/kernel/syscalls/preadv2/preadv201.c b/testcases/kernel/syscalls/preadv2/preadv201.c
new file mode 100644
index 0000000..e8e9e6e
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv2/preadv201.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+/*
+ * Description:
+ * Testcase to check the basic functionality of the preadv2(2).
+ * 1) If the file offset argument is not -1, preadv2() should succeed
+ *    in reading the expected content of data and the file offset is
+ *    not changed after reading.
+ * 2) If the file offset argument is -1, preadv2() should succeed in
+ *    reading the expected content of data and the current file offset
+ *    is used and changed after reading.
+ */
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <sys/uio.h>
+
+#include "tst_test.h"
+#include "preadv2.h"
+
+#define CHUNK           64
+
+static int fd;
+static char buf[CHUNK];
+
+static struct iovec rd_iovec[] = {
+	{buf, CHUNK},
+	{NULL, 0},
+};
+
+static struct tcase {
+	off_t seek_off;
+	int count;
+	off_t read_off;
+	ssize_t size;
+	char content;
+	off_t exp_off;
+} tcases[] = {
+	{0, 1, 0, CHUNK, 'a', 0},
+	{CHUNK, 2, 0, CHUNK, 'a', CHUNK},
+	{0, 1, CHUNK * 3 / 2, CHUNK / 2, 'b', 0},
+	{0, 1, -1, CHUNK, 'a', CHUNK},
+	{0, 2, -1, CHUNK, 'a', CHUNK},
+	{CHUNK, 1, -1, CHUNK, 'b', CHUNK * 2},
+};
+
+static void verify_preadv2(unsigned int n)
+{
+	int i;
+	char *vec;
+	struct tcase *tc = &tcases[n];
+
+	vec = rd_iovec[0].iov_base;
+	memset(vec, 0x00, CHUNK);
+
+	SAFE_LSEEK(fd, tc->seek_off, SEEK_SET);
+
+	TEST(preadv2(fd, rd_iovec, tc->count, tc->read_off, 0));
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TTERRNO, "preadv2() failed");
+		return;
+	}
+
+	if (TST_RET != tc->size) {
+		tst_res(TFAIL, "preadv2() read %li bytes, expected %zi",
+			 TST_RET, tc->size);
+		return;
+	}
+
+	for (i = 0; i < tc->size; i++) {
+		if (vec[i] != tc->content)
+			break;
+	}
+
+	if (i < tc->size) {
+		tst_res(TFAIL, "Buffer wrong at %i have %02x expected %02x",
+			 i, vec[i], tc->content);
+		return;
+	}
+
+	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != tc->exp_off) {
+		tst_res(TFAIL, "preadv2() has changed file offset");
+		return;
+	}
+
+	tst_res(TPASS, "preadv2() read %zi bytes with content '%c' expectedly",
+		tc->size, tc->content);
+}
+
+static void setup(void)
+{
+	char buf[CHUNK];
+
+	fd = SAFE_OPEN("file", O_RDWR | O_CREAT, 0644);
+
+	memset(buf, 'a', sizeof(buf));
+	SAFE_WRITE(1, fd, buf, sizeof(buf));
+
+	memset(buf, 'b', sizeof(buf));
+	SAFE_WRITE(1, fd, buf, sizeof(buf));
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
+	.test = verify_preadv2,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1




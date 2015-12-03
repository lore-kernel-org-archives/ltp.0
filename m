From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 3 Dec 2015 19:31:13 +0800
Subject: [LTP] [PATCH v2 2/2] pwritev/pwritev01.c: add new testcase
In-Reply-To: <1449142273-10679-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20151103144613.GE5795@rei>
 <1449142273-10679-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1449142273-10679-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test pwritev(2) with some basic functions.
Pwritev(2) should succeed to write the expected content of data and
the file offset is not changed after writing the file.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                  |   1 +
 m4/ltp-pwritev.m4                             |  23 ++++
 runtest/ltplite                               |   2 +
 runtest/stress.part3                          |   2 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/.gitignore          |   2 +
 testcases/kernel/syscalls/pwritev/Makefile    |  28 +++++
 testcases/kernel/syscalls/pwritev/pwritev.h   |  31 ++++++
 testcases/kernel/syscalls/pwritev/pwritev01.c | 146 ++++++++++++++++++++++++++
 9 files changed, 238 insertions(+)
 create mode 100644 m4/ltp-pwritev.m4
 create mode 100644 testcases/kernel/syscalls/pwritev/Makefile
 create mode 100644 testcases/kernel/syscalls/pwritev/pwritev.h
 create mode 100644 testcases/kernel/syscalls/pwritev/pwritev01.c

diff --git a/configure.ac b/configure.ac
index 609de8f..cc50397 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,5 +182,6 @@ LTP_CHECK_IF_LINK
 LTP_CHECK_KCMP
 LTP_CHECK_KCMP_TYPE
 LTP_CHECK_PREADV
+LTP_CHECK_PWRITEV
 
 AC_OUTPUT
diff --git a/m4/ltp-pwritev.m4 b/m4/ltp-pwritev.m4
new file mode 100644
index 0000000..6565332
--- /dev/null
+++ b/m4/ltp-pwritev.m4
@@ -0,0 +1,23 @@
+dnl
+dnl Copyright (c) 2015 Fujitsu Ltd.
+dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+dnl
+dnl This program is free software; you can redistribute it and/or modify it
+dnl under the terms of version 2 of the GNU General Public License as
+dnl published by the Free Software Foundation.
+dnl
+dnl This program is distributed in the hope that it would be useful, but
+dnl WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl alone with this program.
+dnl
+
+dnl
+dnl LTP_CHECK_PWRITEV
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_PWRITEV],[
+AC_CHECK_FUNCS(pwritev,,)
+])
diff --git a/runtest/ltplite b/runtest/ltplite
index 4eb4233..1aa93e6 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -608,6 +608,8 @@ pwrite01_64 pwrite01_64
 pwrite02_64 pwrite02_64
 pwrite04_64 pwrite04_64
 
+pwritev01 pwritev01
+
 read01 read01
 read02 read02
 read03 read03
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 0718fbc..87f42ea 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -517,6 +517,8 @@ pwrite01_64 pwrite01_64
 pwrite02_64 pwrite02_64
 pwrite04_64 pwrite04_64
 
+pwritev01 pwritev01
+
 read01 read01
 read02 read02
 read03 read03
diff --git a/runtest/syscalls b/runtest/syscalls
index 099dfa7..69b0c8f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -813,6 +813,9 @@ pwrite01_64 pwrite01_64
 pwrite02_64 pwrite02_64
 pwrite04_64 pwrite04_64
 
+pwritev01 pwritev01
+pwritev01_64 pwritev01_64
+
 quotactl01 quotactl01
 quotactl02 quotactl02
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 38e36fb..6b7de17 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -678,6 +678,8 @@
 /pwrite/pwrite02_64
 /pwrite/pwrite04
 /pwrite/pwrite04_64
+/pwritev/pwritev01
+/pwritev/pwritev01_64
 /quotactl/quotactl01
 /quotactl/quotactl02
 /read/read01
diff --git a/testcases/kernel/syscalls/pwritev/Makefile b/testcases/kernel/syscalls/pwritev/Makefile
new file mode 100644
index 0000000..764c956
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/Makefile
@@ -0,0 +1,28 @@
+#
+#  Copyright (c) 2015 Fujitsu Ltd.
+#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program.
+#
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
diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
new file mode 100644
index 0000000..ae9d999
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -0,0 +1,31 @@
+/*
+* Copyright (c) 2015 Fujitsu Ltd.
+* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* You should have received a copy of the GNU General Public License
+* alone with this program.
+*/
+
+#ifndef PWRITEV_H
+#define PWRITEV_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_PWRITEV)
+int pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
+{
+	return ltp_syscall(__NR_pwritev, fd, iov, iovcnt, offset);
+}
+#endif
+
+#endif /* PWRITEV_H */
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
new file mode 100644
index 0000000..6a82e8e
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -0,0 +1,146 @@
+/*
+* Copyright (c) 2015 Fujitsu Ltd.
+* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* You should have received a copy of the GNU General Public License
+* alone with this program.
+*/
+
+/*
+* Test Name: pwritev01
+*
+* Test Description:
+* Testcase to check the basic functionality of the pwritev(2).
+* pwritev(2) should succeed to write the expected content of data
+* and after writing the file, the file offset is not changed.
+*/
+
+#include <errno.h>
+
+#include "test.h"
+#include "pwritev.h"
+#include "safe_macros.h"
+
+#define	CHUNK		64
+
+static char buf[CHUNK];
+static char initbuf[CHUNK];
+static char preadbuf[CHUNK];
+static int fd;
+
+static struct iovec wr_iovec[] = {
+	{buf, CHUNK},
+	{NULL, 0},
+};
+
+static struct test_case_t {
+	int count;
+	off_t offset;
+	ssize_t size;
+} tc[] = {
+	{1, 0, CHUNK},
+	{2, 0, CHUNK},
+};
+
+void verify_pwritev(struct test_case_t *);
+void setup(void);
+void cleanup(void);
+
+char *TCID = "pwritev01";
+int TST_TOTAL =  ARRAY_SIZE(tc);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			verify_pwritev(&tc[i]);
+	}
+	cleanup();
+	tst_exit();
+}
+
+void verify_pwritev(struct test_case_t *tc)
+{
+	int i;
+
+	SAFE_PWRITE(cleanup, 1, fd, initbuf, tc->size, 0);
+
+	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+
+	TEST(pwritev(fd, wr_iovec, tc->count, tc->offset));
+	if (TEST_RETURN < 0) {
+		tst_resm(TFAIL | TTERRNO, "Pwritev(2) failed");
+		return;
+	}
+
+	if (TEST_RETURN != tc->size) {
+		tst_resm(TFAIL, "Pwritev(2) write %li bytes, expected %li",
+			 TEST_RETURN, tc->size);
+		return;
+	}
+
+	if (SAFE_LSEEK(cleanup, fd, 0, SEEK_CUR) != 0) {
+		tst_resm(TFAIL, "Pwritev(2) has changed file offset");
+		return;
+	}
+
+	SAFE_PREAD(cleanup, 1, fd, preadbuf, tc->size, 0);
+
+	for (i = 0; i < tc->size; i++) {
+		if (preadbuf[i] != 0x61)
+			break;
+	}
+
+	if (i != tc->size) {
+		tst_resm(TFAIL, "Buffer wrong at %i have %c expected a",
+			 i, preadbuf[i]);
+		return;
+	}
+
+	tst_resm(TPASS, "Pwritev(2) write %li bytes successfully "
+		 "with content 'a' expectedly ", tc->size);
+}
+
+void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 30)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			"that are 2.6.30 and higher");
+	}
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	memset(&initbuf, 0x00, CHUNK);
+	memset(&buf, 0x61, CHUNK);
+
+	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
+}
+
+void cleanup(void)
+{
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TERRNO, "Failed to close file");
+
+	tst_rmdir();
+}
-- 
1.8.3.1




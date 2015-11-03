From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 3 Nov 2015 17:57:31 -0500
Subject: [LTP] [PATCH 2/2] pwritev/pwritev01.c: add new testcase
In-Reply-To: <1446591451-11075-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1446591451-11075-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1446591451-11075-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This testcase can check the basic functionality of the pwritev(2).
Pwritev(2) should succeed to write the expected content of data and
after writing the file, the file offset is not changed.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                  |   1 +
 m4/ltp-pwritev.m4                             |  23 ++++
 runtest/ltplite                               |   2 +
 runtest/stress.part3                          |   2 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/.gitignore          |   2 +
 testcases/kernel/syscalls/pwritev/Makefile    |  31 ++++++
 testcases/kernel/syscalls/pwritev/pwritev.h   |  31 ++++++
 testcases/kernel/syscalls/pwritev/pwritev01.c | 149 ++++++++++++++++++++++++++
 9 files changed, 244 insertions(+)
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
index 9f02c7d..076007a 100644
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
index f30dc9c..ecb032d 100644
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
index 5eb5034..9e977e4 100644
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
index 2b4a8d9..25e0e46 100644
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
index 0000000..ac9a969
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/Makefile
@@ -0,0 +1,31 @@
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
+# FIXME (garrcoop): more messy format strings.
+CPPFLAGS		+= -Wno-error
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
index 0000000..ce75552
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -0,0 +1,149 @@
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
+
+static char preadbuf[CHUNK*2];
+
+static struct iovec wr_iovec[] = {
+	{buf, CHUNK},
+	{NULL, 0},
+};
+
+static struct test_case_t {
+	off_t offset_cur;
+	int count;
+	off_t offset;
+	int byte;
+} test_cases[] = {
+	{CHUNK, 0, 0, 0},
+	{CHUNK/2, 1, 0, CHUNK},
+	{CHUNK/4, 1, CHUNK, CHUNK},
+	{CHUNK/8, 2, 0, CHUNK},
+};
+
+static int fd;
+
+void verify_pwritev(int);
+void check_file_contents(int, char *, int, off_t, char *);
+void setup(void);
+void l_seek(int, off_t, int, off_t);
+void cleanup(void);
+
+char *TCID = "pwritev01";
+int TST_TOTAL =  ARRAY_SIZE(test_cases);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int tc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (tc = 0; tc < TST_TOTAL; tc++)
+			verify_pwritev(tc);
+	}
+	cleanup();
+	tst_exit();
+}
+
+void verify_pwritev(int i)
+{
+	l_seek(fd, test_cases[i].offset_cur, SEEK_SET,
+		test_cases[i].offset_cur);
+
+	TEST(pwritev(fd, wr_iovec, test_cases[i].count, test_cases[i].offset));
+	if (test_cases[i].byte != TEST_RETURN) {
+		tst_resm(TFAIL, "pwritev failed unexpectedly");
+	} else {
+		l_seek(fd, 0, SEEK_CUR, test_cases[i].offset_cur);
+
+		check_file_contents(fd, preadbuf, test_cases[i].byte,
+			test_cases[i].offset, buf);
+	}
+}
+
+void check_file_contents(int fdes1, char *pread_buf, int pread_byte,
+			 off_t pread_offset, char *iov_buf)
+{
+	if (SAFE_PREAD(cleanup, 1, fdes1, preadbuf, pread_byte,
+		       pread_offset) != pread_byte) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "pread failed reading %d bytes ", pread_byte);
+	} else {
+		if (memcmp(iov_buf, pread_buf, pread_byte) != 0) {
+			tst_resm(TFAIL, "pwritev failed reading %d bytes ",
+				 pread_byte);
+		} else {
+			tst_resm(TPASS, "pwritev passed reading %d bytes ",
+				 pread_byte);
+		}
+	}
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
+	(void)memset(&buf, 0x42, CHUNK);
+
+	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
+}
+
+void l_seek(int fdes, off_t offset, int whence, off_t checkoff)
+{
+	if (SAFE_LSEEK(cleanup, fdes, offset, whence) != checkoff)
+		tst_brkm(TBROK | TERRNO, cleanup, "lseek() on file failed");
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


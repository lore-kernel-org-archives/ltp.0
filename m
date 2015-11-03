From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 3 Nov 2015 11:56:35 -0500
Subject: [LTP] [PATCH] preadv/preadv01.c: add new testcase
Message-ID: <1446569795-28174-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This testcase can check the basic functionality of the preadv(2).
Preadv(2) should succeed to read the expected content of data and
after reading the file, the file offset is not changed.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                |   1 +
 m4/ltp-preadv.m4                            |  23 ++++
 runtest/ltplite                             |   2 +
 runtest/stress.part3                        |   2 +
 runtest/syscalls                            |   3 +
 testcases/kernel/syscalls/.gitignore        |   2 +
 testcases/kernel/syscalls/preadv/Makefile   |  31 ++++++
 testcases/kernel/syscalls/preadv/preadv.h   |  31 ++++++
 testcases/kernel/syscalls/preadv/preadv01.c | 163 ++++++++++++++++++++++++++++
 9 files changed, 258 insertions(+)
 create mode 100644 m4/ltp-preadv.m4
 create mode 100644 testcases/kernel/syscalls/preadv/Makefile
 create mode 100644 testcases/kernel/syscalls/preadv/preadv.h
 create mode 100644 testcases/kernel/syscalls/preadv/preadv01.c

diff --git a/configure.ac b/configure.ac
index cc89273..609de8f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -181,5 +181,6 @@ LTP_CHECK_LINUXRANDOM
 LTP_CHECK_IF_LINK
 LTP_CHECK_KCMP
 LTP_CHECK_KCMP_TYPE
+LTP_CHECK_PREADV
 
 AC_OUTPUT
diff --git a/m4/ltp-preadv.m4 b/m4/ltp-preadv.m4
new file mode 100644
index 0000000..2046902
--- /dev/null
+++ b/m4/ltp-preadv.m4
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
+dnl LTP_CHECK_PREADV
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_PREADV],[
+AC_CHECK_FUNCS(preadv,,)
+])
diff --git a/runtest/ltplite b/runtest/ltplite
index aaa5c73..9f02c7d 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -588,6 +588,8 @@ pread01 pread01
 pread02 pread02
 pread03 pread03
 
+preadv01 preadv01
+
 profil01 profil01
 
 pselect01 pselect01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 63505ec..f30dc9c 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -498,6 +498,8 @@ pread01 pread01
 pread02 pread02
 pread03 pread03
 
+preadv01 preadv01
+
 profil01 profil01
 
 pselect01 pselect01
diff --git a/runtest/syscalls b/runtest/syscalls
index 958f66e..5eb5034 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -779,6 +779,9 @@ pread02_64 pread02_64
 pread03 pread03
 pread03_64 pread03_64
 
+preadv01 preadv01
+preadv01_64 preadv01_64
+
 profil01 profil01
 
 process_vm_readv01 process_vm01 -r
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 6e4894a..2b4a8d9 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -657,6 +657,8 @@
 /pread/pread02_64
 /pread/pread03
 /pread/pread03_64
+/preadv/preadv01
+/preadv/preadv01_64
 /profil/profil01
 /pselect/pselect01
 /pselect/pselect01_64
diff --git a/testcases/kernel/syscalls/preadv/Makefile b/testcases/kernel/syscalls/preadv/Makefile
new file mode 100644
index 0000000..ac9a969
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv/Makefile
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
diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
new file mode 100644
index 0000000..d9243f6
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv/preadv.h
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
+#ifndef PREADV_H
+#define PREADV_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_PREADV)
+int preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
+{
+	return ltp_syscall(__NR_preadv, fd, iov, iovcnt, offset);
+}
+#endif
+
+#endif /* RREADV_H */
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
new file mode 100644
index 0000000..1caf732
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -0,0 +1,163 @@
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
+* Test Name: preadv01
+*
+* Test Description:
+* Testcase to check the basic functionality of the preadv(2).
+* Preadv(2) should succeed to read the expected content of data
+* and after reading the file, the file offset is not changed.
+*/
+
+#include <errno.h>
+
+#include "test.h"
+#include "preadv.h"
+#include "safe_macros.h"
+
+#define CHUNK           64
+
+static int fd;
+
+static void *s1;
+static void *s2;
+static char buf[CHUNK];
+
+static struct iovec rd_iovec[] = {
+	{buf, CHUNK},
+	{NULL, 0},
+};
+
+static struct test_case_t {
+	off_t offset_cur;
+	int count;
+	off_t offset;
+	int byte;
+	char content;
+} test_cases[] = {
+	{CHUNK, 0, 0, 0, 0x00},
+	{CHUNK/2, 1, 0, CHUNK, 0x42},
+	{CHUNK/4, 2, 0, CHUNK, 0x42},
+	{CHUNK/8, 1, CHUNK*3/2, CHUNK/2, 0x41},
+};
+
+void verify_preadv(int);
+void setup(void);
+void *init_buffers(char, size_t);
+void l_seek(int, off_t, int, off_t);
+void cleanup(void);
+
+char *TCID = "preadv01";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
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
+			verify_preadv(tc);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void verify_preadv(int i)
+{
+	int c;
+	int fail = 0;
+	char *vec;
+
+	vec = rd_iovec[0].iov_base;
+
+	l_seek(fd, test_cases[i].offset_cur, SEEK_SET,
+		test_cases[i].offset_cur);
+
+	TEST(preadv(fd, rd_iovec, test_cases[i].count, test_cases[i].offset));
+
+	if (test_cases[i].byte != TEST_RETURN) {
+		tst_resm(TFAIL, "preadv failed reading %d bytes ",
+			 test_cases[i].byte);
+	} else {
+		for (c = 0; c < test_cases[i].byte; c++) {
+			if (vec[c] != test_cases[i].content)
+				fail++;
+		}
+		if (fail) {
+			tst_resm(TFAIL, "Wrong buffer content");
+		} else {
+			tst_resm(TPASS, "preadv passed reading %d bytes ",
+				 test_cases[i].byte);
+		}
+	}
+
+	l_seek(fd, 0, SEEK_CUR, test_cases[i].offset_cur);
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
+	s1 = init_buffers(0x42, CHUNK);
+	s2 = init_buffers(0x41, CHUNK);
+
+	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
+
+	SAFE_WRITE(cleanup, 1, fd, s1, CHUNK);
+	SAFE_WRITE(cleanup, 1, fd, s2, CHUNK);
+}
+
+void *init_buffers(char content, size_t SIZE)
+{
+	void *s;
+
+	s = SAFE_MALLOC(cleanup, SIZE);
+	(void)memset(s, content, SIZE);
+
+	return s;
+}
+
+void l_seek(int fdes, off_t offset, int whence, off_t checkoff)
+{
+	if (SAFE_LSEEK(cleanup, fdes, offset, whence) != checkoff)
+		tst_resm(TFAIL, "file offset has changed after reading");
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


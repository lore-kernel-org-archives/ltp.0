From: Cedric Hnyda <chnyda@suse.com>
Date: Thu,  8 Oct 2015 10:44:46 +0200
Subject: [LTP]  [PATCH] syscall/kcmp: Add tests for kcmp
Message-ID: <1444293886-10391-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests for the syscall kcmp

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 configure.ac                            |   2 +
 m4/ltp-kcmp.m4                          |  23 +++++
 m4/ltp-kcmp_type.m4                     |  23 +++++
 runtest/syscalls                        |   3 +
 testcases/kernel/include/aarch64.in     |   1 +
 testcases/kernel/include/arm.in         |   1 +
 testcases/kernel/include/i386.in        |   1 +
 testcases/kernel/include/powerpc.in     |   1 +
 testcases/kernel/include/powerpc64.in   |   1 +
 testcases/kernel/include/s390.in        |   1 +
 testcases/kernel/include/s390x.in       |   1 +
 testcases/kernel/include/sh.in          |   1 +
 testcases/kernel/include/sparc.in       |   1 +
 testcases/kernel/include/sparc64.in     |   1 +
 testcases/kernel/include/x86_64.in      |   1 +
 testcases/kernel/syscalls/.gitignore    |   2 +
 testcases/kernel/syscalls/kcmp/Makefile |  24 ++++++
 testcases/kernel/syscalls/kcmp/kcmp.h   |  51 ++++++++++++
 testcases/kernel/syscalls/kcmp/kcmp01.c | 143 ++++++++++++++++++++++++++++++++
 testcases/kernel/syscalls/kcmp/kcmp02.c | 137 ++++++++++++++++++++++++++++++
 20 files changed, 419 insertions(+)
 create mode 100644 m4/ltp-kcmp.m4
 create mode 100644 m4/ltp-kcmp_type.m4
 create mode 100644 testcases/kernel/syscalls/kcmp/Makefile
 create mode 100644 testcases/kernel/syscalls/kcmp/kcmp.h
 create mode 100644 testcases/kernel/syscalls/kcmp/kcmp01.c
 create mode 100644 testcases/kernel/syscalls/kcmp/kcmp02.c

diff --git a/configure.ac b/configure.ac
index ce09fbd..b63daa4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -178,5 +178,7 @@ LTP_CHECK_IOVEC
 LTP_CHECK_KEYCTL
 LTP_CHECK_LINUXRANDOM
 LTP_CHECK_IF_LINK
+LTP_CHECK_KCMP
+LTP_CHECK_KCMP_TYPE
 
 AC_OUTPUT
diff --git a/m4/ltp-kcmp.m4 b/m4/ltp-kcmp.m4
new file mode 100644
index 0000000..70bf375
--- /dev/null
+++ b/m4/ltp-kcmp.m4
@@ -0,0 +1,23 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2015
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software Foundation,
+dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+dnl Author: Cedric Hnyda <chnyda@suse.com>
+dnl
+
+AC_DEFUN([LTP_CHECK_KCMP],[
+AC_CHECK_FUNCS(kcmp,,)
+])
diff --git a/m4/ltp-kcmp_type.m4 b/m4/ltp-kcmp_type.m4
new file mode 100644
index 0000000..f4d7e2d
--- /dev/null
+++ b/m4/ltp-kcmp_type.m4
@@ -0,0 +1,23 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2015
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software Foundation,
+dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+dnl Author: Cedric Hnyda <chnyda@suse.com>
+dnl
+
+AC_DEFUN([LTP_CHECK_KCMP_TYPE],[
+AC_CHECK_TYPES([enum kcmp_type],,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index 25d10ac..3427aaa 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -472,6 +472,9 @@ io_submit01 io_submit01
 
 keyctl01 keyctl01
 
+kcmp01 kcmp01
+kcmp02 kcmp02
+
 kill01 kill01
 kill02 kill02
 kill03 kill03
diff --git a/testcases/kernel/include/aarch64.in b/testcases/kernel/include/aarch64.in
index ceb67c6..4dda026 100644
--- a/testcases/kernel/include/aarch64.in
+++ b/testcases/kernel/include/aarch64.in
@@ -253,3 +253,4 @@ clock_adjtime 266
 syncfs 267
 setns 268
 sendmmsg 269
+kcmp 378
diff --git a/testcases/kernel/include/arm.in b/testcases/kernel/include/arm.in
index 841b064..ba6e07e 100644
--- a/testcases/kernel/include/arm.in
+++ b/testcases/kernel/include/arm.in
@@ -333,4 +333,5 @@ accept4 (__NR_SYSCALL_BASE+366)
 fanotify_init (__NR_SYSCALL_BASE+367)
 fanotify_mark (__NR_SYSCALL_BASE+368)
 prlimit64 (__NR_SYSCALL_BASE+369)
+kcmp (__NR_SYSCALL_BASE+378)
 getrandom (__NR_SYSCALL_BASE+384)
diff --git a/testcases/kernel/include/i386.in b/testcases/kernel/include/i386.in
index a4585c2..e4631a3 100644
--- a/testcases/kernel/include/i386.in
+++ b/testcases/kernel/include/i386.in
@@ -333,4 +333,5 @@ recvmmsg 337
 fanotify_init 338
 fanotify_mark 339
 prlimit64 340
+kcmp 349
 getrandom 355
diff --git a/testcases/kernel/include/powerpc.in b/testcases/kernel/include/powerpc.in
index 4025436..450ed39 100644
--- a/testcases/kernel/include/powerpc.in
+++ b/testcases/kernel/include/powerpc.in
@@ -340,4 +340,5 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+kcmp 354
 getrandom 359
diff --git a/testcases/kernel/include/powerpc64.in b/testcases/kernel/include/powerpc64.in
index 4025436..450ed39 100644
--- a/testcases/kernel/include/powerpc64.in
+++ b/testcases/kernel/include/powerpc64.in
@@ -340,4 +340,5 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+kcmp 354
 getrandom 359
diff --git a/testcases/kernel/include/s390.in b/testcases/kernel/include/s390.in
index 9c7cfa1..92b0b94 100644
--- a/testcases/kernel/include/s390.in
+++ b/testcases/kernel/include/s390.in
@@ -324,4 +324,5 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+kcmp 343
 getrandom 349
diff --git a/testcases/kernel/include/s390x.in b/testcases/kernel/include/s390x.in
index 9c7cfa1..92b0b94 100644
--- a/testcases/kernel/include/s390x.in
+++ b/testcases/kernel/include/s390x.in
@@ -324,4 +324,5 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+kcmp 343
 getrandom 349
diff --git a/testcases/kernel/include/sh.in b/testcases/kernel/include/sh.in
index c6e8aa5..3cb7e21 100644
--- a/testcases/kernel/include/sh.in
+++ b/testcases/kernel/include/sh.in
@@ -361,3 +361,4 @@ accept4 366
 fanotify_init 367
 fanotify_mark 368
 prlimit64 369
+kcmp 378
diff --git a/testcases/kernel/include/sparc.in b/testcases/kernel/include/sparc.in
index 697378f..182db25 100644
--- a/testcases/kernel/include/sparc.in
+++ b/testcases/kernel/include/sparc.in
@@ -331,3 +331,4 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+kcmp 341
diff --git a/testcases/kernel/include/sparc64.in b/testcases/kernel/include/sparc64.in
index 83c1792..b5b817b 100644
--- a/testcases/kernel/include/sparc64.in
+++ b/testcases/kernel/include/sparc64.in
@@ -307,3 +307,4 @@ recvmmsg 328
 fanotify_init 329
 fanotify_mark 330
 prlimit64 331
+kcmp 341
diff --git a/testcases/kernel/include/x86_64.in b/testcases/kernel/include/x86_64.in
index 860e726..d4b5756 100644
--- a/testcases/kernel/include/x86_64.in
+++ b/testcases/kernel/include/x86_64.in
@@ -300,4 +300,5 @@ recvmmsg 299
 fanotify_init 300
 fanotify_mark 301
 prlimit64 302
+kcmp 312
 getrandom 318
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f3a18ab..3fb91a3 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -440,6 +440,8 @@
 /ipc/shmget/shmget04
 /ipc/shmget/shmget05
 /keyctl/keyctl01
+/kcmp/kcmp01
+/kcmp/kcmp02
 /kill/kill01
 /kill/kill02
 /kill/kill03
diff --git a/testcases/kernel/syscalls/kcmp/Makefile b/testcases/kernel/syscalls/kcmp/Makefile
new file mode 100644
index 0000000..083a071
--- /dev/null
+++ b/testcases/kernel/syscalls/kcmp/Makefile
@@ -0,0 +1,24 @@
+#
+#  Copyright (C) 2015 Cedric Hnyda chnyda@suse.com
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
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/kcmp/kcmp.h b/testcases/kernel/syscalls/kcmp/kcmp.h
new file mode 100644
index 0000000..013d107
--- /dev/null
+++ b/testcases/kernel/syscalls/kcmp/kcmp.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ */
+
+#ifndef KCMP_H
+#define KCMP_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_ENUM_KCMP_TYPE)
+
+enum kcmp_type {
+	KCMP_FILE,
+	KCMP_VM,
+	KCMP_FILES,
+	KCMP_FS,
+	KCMP_SIGHAND,
+	KCMP_IO,
+	KCMP_SYSVSEM,
+	KCMP_TYPES,
+};
+
+#endif
+
+#if !defined(HAVE_KCMP)
+
+int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
+{
+	return ltp_syscall(__NR_kcmp, pid1, pid2, type, fd1, fd2);
+}
+
+#endif
+
+#endif /* KCMP_H */
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
new file mode 100644
index 0000000..585e89e
--- /dev/null
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ */
+
+ /* Description:
+ *   Verify that:
+ *		1) kcmp returns 0 with two process and two fd refering to the
+ *			same fd
+ *		2) kcmp doesn't return 0 with two process and two fd refering
+ *		    to the same fd
+ */
+
+#define _GNU_SOURCE
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "kcmp.h"
+
+#define TEST_FILE "test_file"
+#define TEST_FILE2 "test_file2"
+
+
+static int fd1;
+static int fd2;
+static int fd3;
+static int pid1;
+static int pid2;
+
+char *TCID = "kcmp01";
+
+static struct test_case {
+	int *pid1;
+	int *pid2;
+	int type;
+	int *fd1;
+	int *fd2;
+	int exp_fail;
+} test_cases[] = {
+	{&pid1, &pid2, KCMP_FILE, &fd1, &fd2, 0},
+	{&pid1, &pid2, KCMP_FILE, &fd1, &fd3, 1},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static void cleanup(void);
+static void setup(void);
+static void do_child(const struct test_case *test);
+static void cleanup_child(void);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; ++i) {
+			pid2 = tst_fork();
+			if (!pid2)
+				do_child(&test_cases[i]);
+			else
+				tst_record_childstatus(cleanup, pid2);
+			tst_count++;
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void do_child(const struct test_case *test)
+{
+	pid2 = getpid();
+	fd2 = dup(fd1);
+	fd3 = SAFE_OPEN(cleanup_child, TEST_FILE2, O_CREAT | O_RDWR, 0666);
+
+	TEST(kcmp(*(test->pid1), *(test->pid2), test->type,
+			  *(test->fd1), *(test->fd2)));
+	cleanup_child();
+
+	if (TEST_RETURN == -1)
+		tst_resm(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
+
+	if ((test->exp_fail && TEST_RETURN == 0)
+		|| (test->exp_fail == 0 && TEST_RETURN))
+		tst_resm(TFAIL, "kcmp() didn't return the expected value");
+
+	if ((test->exp_fail == 0 && TEST_RETURN == 0)
+		|| (test->exp_fail && TEST_RETURN))
+		tst_resm(TPASS, "kcmp() returned the expected value");
+
+	tst_exit();
+}
+
+static void cleanup_child(void)
+{
+	if (fd2 > 0 && close(fd2) < 0)
+		tst_resm(TWARN | TERRNO, "close fd2 failed");
+	fd2 = 0;
+	if (fd3 > 0 && close(fd3) < 0)
+		tst_resm(TWARN | TERRNO, "close fd3 failed");
+	fd3 = 0;
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(3, 5, 0)) < 0) {
+		tst_brkm(TCONF, NULL,
+			"This test can only run on kernels that are 3.5. and higher");
+	}
+
+	tst_tmpdir();
+
+	pid1 = getpid();
+	fd1 = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
+}
+
+static void cleanup(void)
+{
+	if (fd1 > 0 && close(fd1) < 0)
+		tst_resm(TWARN | TERRNO, "close fd1 failed");
+	tst_rmdir();
+}
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
new file mode 100644
index 0000000..0d734ad
--- /dev/null
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -0,0 +1,137 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ */
+
+ /* Description:
+ *   Verify that:
+ *		1) kcmp fails with bad pid
+ *		2) kcmp fails with invalid flag
+ *		3) kcmp fails with invalid fd
+ */
+
+#define _GNU_SOURCE
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "kcmp.h"
+
+#define TEST_FILE "test_file"
+#define TEST_FILE2 "test_file2"
+
+static int fd1;
+static int fd2;
+static int fd_fake;
+static int pid1;
+static int pid_fake = -1;
+static int fd_fake = -1;
+
+char *TCID = "kcmp02";
+
+#include <sys/types.h>
+#include <sys/wait.h>
+
+static struct test_case {
+	int *pid1;
+	int *pid2;
+	int type;
+	int *fd1;
+	int *fd2;
+	int exp_errno;
+} test_cases[] = {
+	{&pid1, &pid_fake, KCMP_FILE, &fd1, &fd2, ESRCH},
+	{&pid1, &pid1, EINVAL, &fd1, &fd2, EINVAL},
+	{&pid1, &pid1, KCMP_FILE, &fd1, &fd_fake, EBADF}
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static void cleanup(void);
+static void setup(void);
+static void kcmp_verify(const struct test_case *test);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			kcmp_verify(&test_cases[i]);
+
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void kcmp_verify(const struct test_case *test)
+{
+	TEST(kcmp(*(test->pid1), *(test->pid2), test->type,
+			  *(test->fd1), *(test->fd2)));
+
+	if (test->exp_errno && TEST_RETURN != -1) {
+		tst_resm(TFAIL, "kcmp() succeeded unexpectedly");
+		return;
+	}
+
+	if (!test->exp_errno && !TEST_RETURN) {
+		tst_resm(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
+		return;
+	}
+
+	if (test->exp_errno == TEST_ERRNO) {
+		tst_resm(TPASS | TTERRNO, "kcmp() returned the expected value");
+		return;
+	}
+
+	tst_resm(TFAIL | TTERRNO,
+		"kcmp() got unexpected return value: expected: %d - %s",
+			test->exp_errno, tst_strerrno(test->exp_errno));
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(3, 5, 0)) < 0) {
+		tst_brkm(TCONF, NULL,
+			"This test can only run on kernels that are 3.5. and higher");
+	}
+
+	tst_tmpdir();
+
+	pid1 = getpid();
+	fd1 = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
+	fd2 = SAFE_OPEN(cleanup, TEST_FILE2, O_CREAT | O_RDWR | O_TRUNC);
+
+}
+
+static void cleanup(void)
+{
+	if (fd1 > 0 && close(fd1) < 0)
+		tst_resm(TWARN | TERRNO, "close fd1 failed");
+
+	if (fd2 > 0 && close(fd2) < 0)
+		tst_resm(TWARN | TERRNO, "close fd2 failed");
+	tst_rmdir();
+
+}
-- 
2.1.4


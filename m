From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 11:59:51 +0100
Subject: [LTP]  [PATCH v3 5/5] flistxattr and listxattr: added tests
In-Reply-To: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1478084391-30192-6-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tests for these two system calls were not present.

flistxattr(), listxattr() and llistxattr() are identical,
the only difference is in the first argument:
    - in listxattr() it refers to the file in the path.
    - in llistxattr() in the case of a symbolic link, the list
    of names of extended attributes associated with the link
    itself is retrieved, not the file that it refers to.
    - in flistxattr() the open file referred to by fd is
    interrogated in place of path.

Because of these similarities, implemented tests for flistxattr()
and listxattr() are based on the existing tests for llistxattr(),
with some adjustments to fit the appropriate system call.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 runtest/syscalls                                   |   8 ++
 testcases/kernel/syscalls/.gitignore               |   6 ++
 testcases/kernel/syscalls/flistxattr/Makefile      |  23 +++++
 .../kernel/syscalls/flistxattr/flistxattr01.c      | 102 ++++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr02.c      | 104 ++++++++++++++++++++
 .../kernel/syscalls/flistxattr/flistxattr03.c      |  97 +++++++++++++++++++
 testcases/kernel/syscalls/listxattr/Makefile       |  23 +++++
 testcases/kernel/syscalls/listxattr/listxattr01.c  |  94 ++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr02.c  | 105 +++++++++++++++++++++
 testcases/kernel/syscalls/listxattr/listxattr03.c  |  89 +++++++++++++++++
 10 files changed, 651 insertions(+)
 create mode 100644 testcases/kernel/syscalls/flistxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/flistxattr/flistxattr01.c
 create mode 100644 testcases/kernel/syscalls/flistxattr/flistxattr02.c
 create mode 100644 testcases/kernel/syscalls/flistxattr/flistxattr03.c
 create mode 100644 testcases/kernel/syscalls/listxattr/Makefile
 create mode 100644 testcases/kernel/syscalls/listxattr/listxattr01.c
 create mode 100644 testcases/kernel/syscalls/listxattr/listxattr02.c
 create mode 100644 testcases/kernel/syscalls/listxattr/listxattr03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7c84296..c56d49d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -272,6 +272,10 @@ fcntl34_64 fcntl34_64
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
 
+flistxattr01 flistxattr01
+flistxattr02 flistxattr02
+flistxattr03 flistxattr03
+
 flock01 flock01
 flock02 flock02
 flock03 flock03
@@ -523,6 +527,10 @@ linkat02 linkat02
 
 listen01 listen01
 
+listxattr01 listxattr01
+listxattr02 listxattr02
+listxattr03 listxattr03
+
 llistxattr01 llistxattr01
 llistxattr02 llistxattr02
 llistxattr03 llistxattr03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f53cc05..aaccbfe 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -233,6 +233,9 @@
 /fcntl/fcntl34_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
+/flistxattr/flistxattr01
+/flistxattr/flistxattr02
+/flistxattr/flistxattr03
 /flock/flock01
 /flock/flock02
 /flock/flock03
@@ -482,6 +485,9 @@
 /linkat/linkat01
 /linkat/linkat02
 /listen/listen01
+/listxattr/listxattr01
+/listxattr/listxattr02
+/listxattr/listxattr03
 /llistxattr/llistxattr01
 /llistxattr/llistxattr02
 /llistxattr/llistxattr03
diff --git a/testcases/kernel/syscalls/flistxattr/Makefile b/testcases/kernel/syscalls/flistxattr/Makefile
new file mode 100644
index 0000000..b794ec0
--- /dev/null
+++ b/testcases/kernel/syscalls/flistxattr/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+#  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr01.c b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
new file mode 100644
index 0000000..5084f7d
--- /dev/null
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
@@ -0,0 +1,102 @@
+/*
+* Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+* Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+* Test Name: verify_flistxattr01
+*
+* Description:
+*     The testcase checks the basic functionality of the flistxattr(2).
+*     flistxattr(2) retrieves the list of extended attribute names
+*     associated with the file itself in the filesystem.
+*
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+#include <string.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define SECURITY_KEY1 "security.ltptest1"
+#define VALUE         "test"
+#define VALUE_SIZE    (sizeof(VALUE) - 1)
+#define KEY_SIZE      (sizeof(SECURITY_KEY1) - 1)
+
+static int fd;
+
+static int has_attribute(const char *list, int llen, const char *attr)
+{
+	int i;
+
+	for (i = 0; i < llen; i += strlen(list + i) + 1) {
+		if (!strcmp(list + i, attr))
+			return 1;
+	}
+	return 0;
+}
+
+static void verify_flistxattr(void)
+{
+	char buf[64];
+
+	TEST(flistxattr(fd, buf, sizeof(buf)));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "flistxattr() failed");
+		return;
+	}
+
+	if (!has_attribute(buf, sizeof(buf), SECURITY_KEY1)) {
+		tst_res(TFAIL, "missing attribute %s",
+			 SECURITY_KEY1);
+		return;
+	}
+
+	tst_res(TPASS, "flistxattr() succeeded");
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
+
+	SAFE_FSETXATTR(fd, SECURITY_KEY1, VALUE, VALUE_SIZE, XATTR_CREATE);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0 && close(fd))
+		tst_res(TWARN | TERRNO, "failed to close file");
+}
+
+static struct tst_test test = {
+	.tid = "flistxattr01",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = verify_flistxattr,
+	.setup = setup,
+	.cleanup = cleanup,
+};
+
+#else
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif /* HAVE_SYS_XATTR_H */
+
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr02.c b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
new file mode 100644
index 0000000..f8a761e
--- /dev/null
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
@@ -0,0 +1,104 @@
+/*
+* Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+* Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+* Test Name: flistxattr02
+*
+* Description:
+*     1) flistxattr(2) fails if the size of the list buffer is too small
+*     to hold the result.
+*     2) flistxattr(2) fails if fd is an invalid file descriptor.
+*
+* Expected Result:
+*     1) flistxattr(2) should return -1 and set errno to ERANGE.
+*     2) flistxattr(2) should return -1 and set errno to EBADF.
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define SECURITY_KEY  "security.ltptest"
+#define VALUE         "test"
+#define VALUE_SIZE    (sizeof(VALUE) - 1)
+
+static int fd1;
+static int fd2 = -1;
+
+static struct test_case {
+	int *fd;
+	size_t size;
+	int exp_err;
+} tc[] = {
+	{&fd1, 1, ERANGE},
+	{&fd2, 20, EBADF}
+};
+
+static void verify_flistxattr(unsigned int n)
+{
+	struct test_case *t = tc + n;
+	char buf[t->size];
+
+	TEST(flistxattr(*t->fd, buf, t->size));
+	if (TEST_RETURN == 0) {
+		tst_res(TFAIL, "flistxattr() succeeded unexpectedly");
+		return;
+	}
+
+	if (t->exp_err != TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO, "flistxattr() failed "
+			 "unexpectedlly, expected %s",
+			 tst_strerrno(t->exp_err));
+	} else {
+		tst_res(TPASS | TTERRNO,
+			 "flistxattr() failed as expected");
+	}
+}
+
+static void setup(void)
+{
+	fd1 = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
+
+	SAFE_FSETXATTR(fd1, SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+}
+
+static void cleanup(void)
+{
+	if (fd1 > 0 && close(fd1))
+		tst_res(TWARN | TERRNO, "failed to close file");
+}
+
+static struct tst_test test = {
+	.tid = "flistxattr02",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_flistxattr,
+	.tcnt = ARRAY_SIZE(tc),
+	.setup = setup,
+	.cleanup = cleanup,
+};
+
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr03.c b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
new file mode 100644
index 0000000..b2745be
--- /dev/null
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
@@ -0,0 +1,97 @@
+/*
+* Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+* Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+* Test Name: flistxattr03
+*
+* Description:
+*     flistxattr is identical to listxattr. an empty buffer of size zero
+*     can return the current size of the list of extended attribute names,
+*     which can be used to estimate a suitable buffer.
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define SECURITY_KEY  "security.ltptest"
+#define VALUE         "test"
+#define VALUE_SIZE    (sizeof(VALUE) - 1)
+
+static int fd[] = {0, 0};
+
+static int check_suitable_buf(const int file, long size)
+{
+	int n;
+	char buf[size];
+
+	n = flistxattr(file, buf, sizeof(buf));
+
+	return n != -1;
+}
+
+static void verify_flistxattr(unsigned int n)
+{
+	TEST(flistxattr(fd[n], NULL, 0));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "flistxattr() failed");
+		return;
+	}
+
+	if (check_suitable_buf(fd[n], TEST_RETURN))
+		tst_res(TPASS, "flistxattr() succeed with suitable buffer");
+	else
+		tst_res(TFAIL, "flistxattr() failed with small buffer");
+}
+
+static void setup(void)
+{
+	fd[0] = SAFE_OPEN("testfile1", O_RDWR | O_CREAT, 0644);
+
+	fd[1] = SAFE_OPEN("testfile2", O_RDWR | O_CREAT, 0644);
+
+	SAFE_FSETXATTR(fd[1], SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+}
+
+static void cleanup(void)
+{
+	if (fd[1] > 0 && close(fd[1]))
+		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd[0] > 0 && close(fd[0]))
+		tst_res(TWARN | TERRNO, "failed to close file");
+}
+
+static struct tst_test test = {
+	.tid = "flistxattr03",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_flistxattr,
+	.tcnt = ARRAY_SIZE(fd),
+	.setup = setup,
+	.cleanup = cleanup,
+};
+
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif
diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
new file mode 100644
index 0000000..b794ec0
--- /dev/null
+++ b/testcases/kernel/syscalls/listxattr/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+#  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/listxattr/listxattr01.c b/testcases/kernel/syscalls/listxattr/listxattr01.c
new file mode 100644
index 0000000..110b6de
--- /dev/null
+++ b/testcases/kernel/syscalls/listxattr/listxattr01.c
@@ -0,0 +1,94 @@
+/*
+* Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+* Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+* Test Name: listxattr01
+*
+* Description:
+*     The testcase checks the basic functionality of the listxattr(2).
+*     listxattr(2) retrieves the list of extended attribute names
+*     associated with the file itself in the filesystem.
+*
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+#include <string.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define SECURITY_KEY1 "security.ltptest1"
+#define VALUE         "test"
+#define VALUE_SIZE    (sizeof(VALUE) - 1)
+#define KEY_SIZE      (sizeof(SECURITY_KEY1) - 1)
+#define TESTFILE      "testfile"
+
+static int has_attribute(const char *list, int llen, const char *attr)
+{
+	int i;
+
+	for (i = 0; i < llen; i += strlen(list + i) + 1) {
+		if (!strcmp(list + i, attr))
+			return 1;
+	}
+	return 0;
+}
+
+static void verify_listxattr(void)
+{
+	char buf[64];
+
+	TEST(listxattr(TESTFILE, buf, sizeof(buf)));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "listxattr() failed");
+		return;
+	}
+
+	if (!has_attribute(buf, sizeof(buf), SECURITY_KEY1)) {
+		tst_res(TFAIL, "missing attribute %s",
+			 SECURITY_KEY1);
+		return;
+	}
+
+	tst_res(TPASS, "listxattr() succeeded");
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
+
+	SAFE_SETXATTR(TESTFILE, SECURITY_KEY1, VALUE, VALUE_SIZE, XATTR_CREATE);
+}
+
+static struct tst_test test = {
+	.tid = "listxattr01",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_all = verify_listxattr,
+	.setup = setup,
+};
+
+#else
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif /* HAVE_SYS_XATTR_H */
+
diff --git a/testcases/kernel/syscalls/listxattr/listxattr02.c b/testcases/kernel/syscalls/listxattr/listxattr02.c
new file mode 100644
index 0000000..6a980f5
--- /dev/null
+++ b/testcases/kernel/syscalls/listxattr/listxattr02.c
@@ -0,0 +1,105 @@
+/*
+* Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+* Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+* Test Name: listxattr02
+*
+* Description:
+*     1) listxattr(2) fails if the size of the list buffer is too small
+*     to hold the result.
+*     2) listxattr(2) fails if path is an empty string.
+*     3) listxattr(2) fails when attempted to read from a invalid address.
+*     4) listxattr(2) fails if path is longer than allowed.
+*
+* Expected Result:
+*     1) listxattr(2) should return -1 and set errno to ERANGE.
+*     2) listxattr(2) should return -1 and set errno to ENOENT.
+*     3) listxattr(2) should return -1 and set errno to EFAULT.
+*     4) listxattr(2) should return -1 and set errno to ENAMETOOLONG.
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define SECURITY_KEY  "security.ltptest"
+#define VALUE         "test"
+#define VALUE_SIZE    (sizeof(VALUE) - 1)
+#define TESTFILE      "testfile"
+
+char longpathname[PATH_MAX + 2];
+
+static struct test_case {
+	const char *path;
+	size_t size;
+	int exp_err;
+} tc[] = {
+	{TESTFILE, 1, ERANGE},
+	{"", 20, ENOENT},
+	{(char *)-1, 20, EFAULT},
+	{longpathname, 20, ENAMETOOLONG}
+};
+
+static void verify_listxattr(unsigned int n)
+{
+	struct test_case *t = tc + n;
+	char buf[t->size];
+
+	TEST(listxattr(t->path, buf, sizeof(buf)));
+	if (TEST_RETURN == 0) {
+		tst_res(TFAIL, "listxattr() succeeded unexpectedly");
+		return;
+	}
+
+	if (t->exp_err != TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO, "listxattr() failed "
+			 "unexpectedlly, expected %s",
+			 tst_strerrno(t->exp_err));
+	} else {
+		tst_res(TPASS | TTERRNO,
+			 "listxattr() failed as expected");
+	}
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
+
+	SAFE_SETXATTR(TESTFILE, SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+
+	memset(&longpathname, 'a', sizeof(longpathname) - 1);
+}
+
+static struct tst_test test = {
+	.tid = "listxattr02",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_listxattr,
+	.tcnt = ARRAY_SIZE(tc),
+	.setup = setup,
+};
+
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif
diff --git a/testcases/kernel/syscalls/listxattr/listxattr03.c b/testcases/kernel/syscalls/listxattr/listxattr03.c
new file mode 100644
index 0000000..d8c0cdc
--- /dev/null
+++ b/testcases/kernel/syscalls/listxattr/listxattr03.c
@@ -0,0 +1,89 @@
+/*
+* Copyright (c) 2016 RT-RK Institute for Computer Based Systems
+* Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
+* Test Name: listxattr03
+*
+* Description:
+*     An empty buffer of size zero can return the current size of the list
+*     of extended attribute names, which can be used to estimate a suitable buffer.
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+
+#ifdef HAVE_SYS_XATTR_H
+# include <sys/xattr.h>
+#endif
+
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_XATTR_H
+
+#define SECURITY_KEY  "security.ltptest"
+#define VALUE         "test"
+#define VALUE_SIZE    (sizeof(VALUE) - 1)
+
+static const char * const filename[] = {"testfile1", "testfile2"};
+
+static int check_suitable_buf(const char *name, long size)
+{
+	int n;
+	char buf[size];
+
+	n = listxattr(name, buf, sizeof(buf));
+
+	return n != -1;
+}
+
+static void verify_listxattr(unsigned int n)
+{
+	const char *name = filename[n];
+
+	TEST(listxattr(name, NULL, 0));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "listxattr() failed");
+		return;
+	}
+
+	if (check_suitable_buf(name, TEST_RETURN))
+		tst_res(TPASS, "listxattr() succeed with suitable buffer");
+	else
+		tst_res(TFAIL, "listxattr() failed with small buffer");
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(filename[0], 0644, NULL);
+
+	SAFE_TOUCH(filename[1], 0644, NULL);
+
+	SAFE_SETXATTR(filename[1], SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+}
+
+static struct tst_test test = {
+	.tid = "listxattr03",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test = verify_listxattr,
+	.tcnt = ARRAY_SIZE(filename),
+	.setup = setup,
+};
+
+#else /* HAVE_SYS_XATTR_H */
+	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
+#endif
-- 
1.9.1


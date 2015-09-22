From: Cedric Hnyda <chnyda@suse.com>
Date: Tue, 22 Sep 2015 16:32:54 +0200
Subject: [LTP] [PATCH] syscall/renameat2: Add tests for the syscall renameat2
Message-ID: <1442932374-28132-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: chnyda <chnyda@suse.com>
---
 include/lapi/fcntl.h                              |  12 ++
 runtest/syscalls                                  |   3 +
 testcases/kernel/syscalls/.gitignore              |   2 +
 testcases/kernel/syscalls/renameat2/Makefile      |  24 ++++
 testcases/kernel/syscalls/renameat2/renameat2.h   |  37 ++++++
 testcases/kernel/syscalls/renameat2/renameat201.c | 152 ++++++++++++++++++++++
 testcases/kernel/syscalls/renameat2/renameat202.c | 129 ++++++++++++++++++
 7 files changed, 359 insertions(+)
 create mode 100644 testcases/kernel/syscalls/renameat2/Makefile
 create mode 100644 testcases/kernel/syscalls/renameat2/renameat2.h
 create mode 100644 testcases/kernel/syscalls/renameat2/renameat201.c
 create mode 100644 testcases/kernel/syscalls/renameat2/renameat202.c

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 3667b5e..0661651 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -67,6 +67,18 @@
 # define FALLOC_FL_KEEP_SIZE 1
 #endif
 
+#ifndef RENAME_NOREPLACE
+# define RENAME_NOREPLACE	(1 << 0)
+#endif
+
+#ifndef RENAME_EXCHANGE
+# define RENAME_EXCHANGE		(1 << 1)
+#endif
+
+#ifndef RENAME_WHITEOUT
+# define RENAME_WHITEOUT		(1 << 2)
+#endif
+
 /* splice, vmsplice, tee */
 
 #ifndef SPLICE_F_NONBLOCK
diff --git a/runtest/syscalls b/runtest/syscalls
index 25d10ac..0d5fdb4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -863,6 +863,9 @@ rename14 rename14
 #renameat test cases
 renameat01 renameat01
 
+renameat201 renameat201
+renameat202 renameat202
+
 rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f3a18ab..2553b2c 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -713,6 +713,8 @@
 /rename/rename13
 /rename/rename14
 /renameat/renameat01
+/renameat2/renameat201
+/renameat2/renameat202
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
diff --git a/testcases/kernel/syscalls/renameat2/Makefile b/testcases/kernel/syscalls/renameat2/Makefile
new file mode 100644
index 0000000..083a071
--- /dev/null
+++ b/testcases/kernel/syscalls/renameat2/Makefile
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
diff --git a/testcases/kernel/syscalls/renameat2/renameat2.h b/testcases/kernel/syscalls/renameat2/renameat2.h
new file mode 100644
index 0000000..8c69746
--- /dev/null
+++ b/testcases/kernel/syscalls/renameat2/renameat2.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2015 Cedric Hnyda chnyda@suse.com
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
+ *
+ */
+
+#ifndef RENAMEAT2_H
+#define RENAMEAT2_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_RENAMEAT2)
+int renameat2(int olddirfd, const char *oldpath, int newdirfd,
+				const char *newpath, unsigned int flags)
+{
+	return ltp_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
+						newpath, flags);
+}
+#endif
+
+#endif /* RENAMEAT2_H */
diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
new file mode 100644
index 0000000..7e677b5
--- /dev/null
+++ b/testcases/kernel/syscalls/renameat2/renameat201.c
@@ -0,0 +1,152 @@
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
+ *   1) renameat2(2) returns -1 and sets errno to EEXIST because newpath
+ *		already exists and the flag RENAME_NOREPLACE is used.
+ *   2) renameat2(2) returns 0.
+ *   3) renameat2(2) returns -1 and sets errno to ENOENT because the flag
+ *		RENAME_EXCHANGE is used and newpath does not exist.
+ *   4) renameat2(2) returns 0 because the flag RENAME_NOREPLACE is used,
+ *		both olddirfd and newdirfd are valid and oldpath exists and
+ *		newpath does not exist.
+ *   5) renameat2(2) returns -1 and sets errno to EINVAL because
+ *		RENAME_NOREPLACE and RENAME_EXCHANGE are used together
+ *   6) renameat2(2) returns -1 and sets errno to EINVAL because
+ *		RENAME_WHITEOUT and RENAME_EXCHANGE are used together
+ */
+
+#define _GNU_SOURCE
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "renameat2.h"
+
+#define TEST_DIR "test_dir/"
+#define TEST_DIR2 "test_dir2/"
+
+#define TEST_FILE "test_file"
+#define TEST_FILE2 "test_file2"
+#define TEST_FILE3 "test_file3"
+#define NON_EXIST "non_exist"
+
+char *TCID = "renameat201";
+
+static int olddirfd;
+static int newdirfd;
+
+
+static struct test_case {
+	int *olddirfd;
+	const char *oldpath;
+	int *newdirfd;
+	const char *newpath;
+	int flags;
+	int exp_errno;
+} test_cases[] = {
+	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_NOREPLACE, EEXIST},
+	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_EXCHANGE, 0},
+	{&olddirfd, TEST_FILE, &newdirfd, NON_EXIST, RENAME_EXCHANGE, ENOENT},
+	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE3, RENAME_NOREPLACE, 0},
+	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_NOREPLACE
+				| RENAME_EXCHANGE, EINVAL},
+	{&olddirfd, TEST_FILE, &newdirfd, TEST_FILE2, RENAME_WHITEOUT
+				| RENAME_EXCHANGE, EINVAL}
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static void setup(void);
+static void cleanup(void);
+static void renameat2_verify(const struct test_case *test);
+
+
+int main(int ac, char **av)
+{
+	int i;
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; lc < TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			renameat2_verify(&test_cases[i]);
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(3, 15, 0)) < 0) {
+		tst_brkm(TCONF, NULL,
+			"This test can only run on kernels that are 3.15. and higher");
+	}
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
+	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
+
+	SAFE_TOUCH(cleanup, TEST_DIR TEST_FILE, 0600, NULL);
+	SAFE_TOUCH(cleanup, TEST_DIR2 TEST_FILE2, 0600, NULL);
+	SAFE_TOUCH(cleanup, TEST_DIR TEST_FILE3, 0600, NULL);
+
+	olddirfd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
+	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
+}
+
+static void cleanup(void)
+{
+	if (olddirfd > 0 && close(olddirfd) < 0)
+		tst_resm(TWARN | TERRNO, "close olddirfd failed");
+
+	if (newdirfd > 0 && close(newdirfd) < 0)
+		tst_resm(TWARN | TERRNO, "close newdirfd failed");
+
+	tst_rmdir();
+
+}
+
+static void renameat2_verify(const struct test_case *test)
+{
+	TEST(renameat2(*(test->olddirfd), test->oldpath,
+			*(test->newdirfd), test->newpath, test->flags));
+
+	if (test->exp_errno && TEST_RETURN != -1) {
+		tst_resm(TFAIL, "renameat2() succeeded unexpectedly");
+	} else if (test->exp_errno == 0 && TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, "renameat2() failed unexpectedly");
+	} else if (test->exp_errno == TEST_ERRNO) {
+		tst_resm(TPASS | TTERRNO,
+		"renameat2() returned the expected value");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"renameat2() got unexpected return value: expected: %d - %s",
+			test->exp_errno,
+			strerror(test->exp_errno));
+	}
+
+}
diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
new file mode 100644
index 0000000..eb32880
--- /dev/null
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -0,0 +1,129 @@
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
+ *   Calls renameat2(2) with the flag RENAME_EXCHANGE and check that
+ *   the content was swapped
+ */
+
+#define _GNU_SOURCE
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "renameat2.h"
+
+#define TEST_DIR "test_dir/"
+#define TEST_DIR2 "test_dir2/"
+
+#define TEST_FILE "test_file"
+#define TEST_FILE2 "test_file2"
+
+char *TCID = "renameat202";
+
+static int olddirfd;
+static int newdirfd;
+static int fd = -1;
+
+static const char *content = "content";
+
+
+int TST_TOTAL = 1;
+
+static void setup(void);
+static void cleanup(void);
+static void renameat2_verify(void);
+
+
+int main(int ac, char **av)
+{
+
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	TEST(renameat2(olddirfd, TEST_FILE,
+			newdirfd, TEST_FILE2, RENAME_EXCHANGE));
+
+	renameat2_verify();
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(3, 15, 0)) < 0) {
+		tst_brkm(TCONF, NULL,
+			"This test can only run on kernels that are 3.15. and higher");
+	}
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
+	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
+
+	SAFE_TOUCH(cleanup, TEST_DIR TEST_FILE, 0600, NULL);
+	SAFE_TOUCH(cleanup, TEST_DIR2 TEST_FILE2, 0600, NULL);
+
+	olddirfd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
+	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
+
+	SAFE_FILE_PRINTF(cleanup, TEST_DIR TEST_FILE, "%s", content);
+
+}
+
+static void cleanup(void)
+{
+	if (olddirfd > 0 && close(olddirfd) < 0)
+		tst_resm(TWARN | TERRNO, "close olddirfd failed");
+
+	if (newdirfd > 0 && close(newdirfd) < 0)
+		tst_resm(TWARN | TERRNO, "close newdirfd failed");
+
+	if (fd > 0 && close(fd) < 0)
+		tst_resm(TWARN | TERRNO, "close fd failed");
+
+	tst_rmdir();
+
+}
+
+static void renameat2_verify(void)
+{
+	char *str;
+
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL, "renameat2() failed unexpectedly");
+		return;
+	}
+
+	fd = SAFE_OPEN(cleanup, TEST_DIR2 TEST_FILE2, O_RDONLY);
+
+	str = malloc(sizeof(char) * strlen(content));
+	SAFE_READ(cleanup, 1, fd, str, strlen(content));
+
+	if (!strcmp(content, str))
+		tst_resm(TPASS,
+			"renameat2() swapped the content of the two files");
+	else
+		tst_resm(TFAIL,
+			"renameat2() didn't swap the content of the two files");
+	free(str);
+}
-- 
2.1.4


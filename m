Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZKho6-0007F3-Io
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 06:59:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZKho4-0005UK-Bd
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 06:59:10 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6U6v8sh001666
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2015 14:57:08 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 30 Jul 2015 14:59:01 +0800
Message-ID: <1438239541-14080-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] open/open13.c: add O_PATH flag test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Basic test for open(2) with the flag O_PATH.
Obtain a file descriptor that can be used to perform operations
that act purely at the file descriptor level, the file itself is
not opened, the operations read(2), write(2), fchmod(2), fchown(2)
and fgetxattr(2) fail with the error EBADF.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/lapi/fcntl.h                    |   4 +
 runtest/ltplite                         |   1 +
 runtest/stress.part3                    |   1 +
 runtest/syscalls                        |   1 +
 testcases/kernel/syscalls/.gitignore    |   1 +
 testcases/kernel/syscalls/open/open13.c | 198 ++++++++++++++++++++++++++++++++
 6 files changed, 206 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open13.c

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 200f574..3667b5e 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -59,6 +59,10 @@
 # define O_NOATIME 01000000
 #endif
 
+#ifndef O_PATH
+# define O_PATH 010000000
+#endif
+
 #ifndef FALLOC_FL_KEEP_SIZE
 # define FALLOC_FL_KEEP_SIZE 1
 #endif
diff --git a/runtest/ltplite b/runtest/ltplite
index 3bc681c..79be778 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -545,6 +545,7 @@ open09 open09
 open10 open10
 open11 open11
 open12 open12
+open13 open13
 
 mincore01 mincore01
 #mincore02 mincore02 currently hangs and does not exit correctly
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 1ceeb8f..ab9af3c 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -467,6 +467,7 @@ open09 open09
 open10 open10
 open11 open11
 open12 open12
+open13 open13
 
 pathconf01 pathconf01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 70d4945..65a9ff2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -711,6 +711,7 @@ open09 open09
 open10 open10
 open11 open11
 open12 open12
+open13 open13
 
 #openat test cases
 openat01 openat01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 172aeec..37c3755 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -615,6 +615,7 @@
 /open/open11
 /open/open12
 /open/open12_child
+/open/open13
 /openat/openat01
 /openat/openat02
 /openat/openat02_child
diff --git a/testcases/kernel/syscalls/open/open13.c b/testcases/kernel/syscalls/open/open13.c
new file mode 100644
index 0000000..9b72e1f
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open13.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ */
+
+/*
+ * DESCRIPTION
+ *  Basic test for open(2) with the flag O_PATH.
+ *  "Obtain a file descriptor that can be used to perform operations
+ *   that act purely at the file descriptor level, the file itself is
+ *   not opened, the operations read(2), write(2), fchmod(2), fchown(2)
+ *   and fgetxattr(2) fail with the error EBADF."
+ *
+ *  The operations include but is not limited to the syscalls above.
+ */
+
+#define _GNU_SOURCE
+
+#include "config.h"
+
+#include <errno.h>
+#ifdef HAVE_ATTR_XATTR_H
+#include <sys/types.h>
+#include <attr/xattr.h>
+#endif
+
+#include "test.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+
+#define TESTFILE	"testfile"
+#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
+#define EXP_ERRNO	EBADF
+
+static void setup(void);
+static void verify_read(void);
+static void verify_write(void);
+static void verify_fchmod(void);
+static void verify_fchown(void);
+#ifdef HAVE_ATTR_XATTR_H
+static void verify_fgetxattr(void);
+#endif
+static void cleanup(void);
+
+static int fd;
+
+static void (*test_func[])(void) = {
+	verify_read,
+	verify_write,
+	verify_fchmod,
+	verify_fchown,
+#ifdef HAVE_ATTR_XATTR_H
+	verify_fgetxattr
+#endif
+};
+
+char *TCID = "open13";
+int TST_TOTAL = ARRAY_SIZE(test_func);
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
+		TEST(open(TESTFILE, O_RDWR | O_PATH));
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO, "open(2) failed");
+			continue;
+		}
+
+		fd = TEST_RETURN;
+
+		for (tc = 0; tc < TST_TOTAL; tc++)
+			(*test_func[tc])();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 39)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			"that are 2.6.39 or higher");
+	}
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	SAFE_TOUCH(cleanup, TESTFILE, FILE_MODE, NULL);
+
+	TEST_PAUSE;
+}
+
+static void verify_read(void)
+{
+	char buf[255];
+
+	TEST(read(fd, buf, 255));
+
+	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
+		tst_resm(TPASS, "read(2) failed as expected");
+	} else {
+		tst_resm(TFAIL, "open(2) O_PATH flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EXP_ERRNO, strerror(EXP_ERRNO));
+	}
+}
+
+static void verify_write(void)
+{
+	TEST(write(fd, "w", 1));
+
+	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
+		tst_resm(TPASS, "write(2) failed as expected");
+	} else {
+		tst_resm(TFAIL, "open(2) O_PATH flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EXP_ERRNO, strerror(EXP_ERRNO));
+	}
+}
+
+static void verify_fchmod(void)
+{
+	TEST(fchmod(fd, 0666));
+
+	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
+		tst_resm(TPASS, "fchmod(2) failed as expected");
+	} else {
+		tst_resm(TFAIL, "open(2) O_PATH flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EXP_ERRNO, strerror(EXP_ERRNO));
+	}
+}
+
+static void verify_fchown(void)
+{
+	uid_t tuid = 1000;
+	gid_t tgid = 1000;
+
+	TEST(fchown(fd, tuid, tgid));
+
+	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
+		tst_resm(TPASS, "fchown(2) failed as expected");
+	} else {
+		tst_resm(TFAIL, "open(2) O_PATH flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EXP_ERRNO, strerror(EXP_ERRNO));
+	}
+}
+
+#ifdef HAVE_ATTR_XATTR_H
+static void verify_fgetxattr(void)
+{
+	TEST(fgetxattr(fd, "tkey", NULL, 1));
+
+	if (TEST_RETURN == -1 && TEST_ERRNO == EXP_ERRNO) {
+		tst_resm(TPASS, "fgetxattr(2) failed as expected");
+	} else {
+		tst_resm(TFAIL, "open(2) O_PATH flag "
+			"performed abnormally "
+			"expected error = %d : %s",
+			EXP_ERRNO, strerror(EXP_ERRNO));
+	}
+}
+#endif
+
+static void cleanup(void)
+{
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TERRNO, "failed to close file");
+
+	tst_rmdir();
+}
-- 
1.8.4.2


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

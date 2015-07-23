Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZIFb6-0007JD-FW
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2015 12:27:36 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZIFb3-0007mB-Vs
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2015 12:27:36 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6NCPce1032563
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Jul 2015 20:25:38 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 23 Jul 2015 20:27:15 +0800
Message-ID: <1437654435-16682-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] fcntl/fcntl32.c: add new test
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

Add new testcase to verify that a write lease may be placed
on a file only if there are no other open file descriptors
for the file.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                           |   1 +
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/fcntl32.c | 129 ++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl32.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 3bc681c..8ce0daa 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -225,6 +225,7 @@ fcntl26 fcntl26
 fcntl29 fcntl29
 fcntl30 fcntl30
 fcntl31 fcntl31
+fcntl32 fcntl32
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/syscalls b/runtest/syscalls
index 70d4945..0d14528 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -258,6 +258,8 @@ fcntl30 fcntl30
 fcntl30_64 fcntl30_64
 fcntl31 fcntl31
 fcntl31_64 fcntl31_64
+fcntl32 fcntl32
+fcntl32_64 fcntl32_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 172aeec..13c7a79 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -221,6 +221,8 @@
 /fcntl/fcntl30_64
 /fcntl/fcntl31
 /fcntl/fcntl31_64
+/fcntl/fcntl32
+/fcntl/fcntl32_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flock/flock01
diff --git a/testcases/kernel/syscalls/fcntl/fcntl32.c b/testcases/kernel/syscalls/fcntl/fcntl32.c
new file mode 100644
index 0000000..46e316f
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl32.c
@@ -0,0 +1,129 @@
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
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
+
+/*
+ * DESCRIPTION
+ *  Basic test for fcntl(2) using F_SETLEASE & F_WRLCK argument.
+ *  "A write lease may be placed on a file only if there are
+ *  no other open file descriptors for the file."
+ */
+
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "tst_fs_type.h"
+
+static void setup(void);
+static void fcntl_verify(int);
+static void cleanup(void);
+
+#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
+
+int fd1;
+int fd2;
+
+static struct test_case_t {
+	int fd1_flag;
+	int fd2_flag;
+} test_cases[] = {
+	{O_RDONLY, O_RDONLY},
+	{O_RDONLY, O_WRONLY},
+	{O_RDONLY, O_RDWR},
+	{O_WRONLY, O_RDONLY},
+	{O_WRONLY, O_WRONLY},
+	{O_WRONLY, O_RDWR},
+	{O_RDWR, O_RDONLY},
+	{O_RDWR, O_WRONLY},
+	{O_RDWR, O_RDWR},
+};
+
+char *TCID = "fcntl32";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int tc;
+	long type;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	switch ((type = tst_fs_type(cleanup, "."))) {
+	case TST_NFS_MAGIC:
+	case TST_RAMFS_MAGIC:
+	case TST_TMPFS_MAGIC:
+		tst_brkm(TCONF, cleanup,
+			"Cannot do fcntl on a file on %s filesystem",
+			tst_fs_type_name(type));
+		break;
+	default:
+		break;
+	}
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (tc = 0; tc < TST_TOTAL; tc++)
+			fcntl_verify(tc);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_TOUCH(cleanup, "file", FILE_MODE, NULL);
+}
+
+static void fcntl_verify(int i)
+{
+	fd1 = SAFE_OPEN(cleanup, "file", test_cases[i].fd1_flag);
+	fd2 = SAFE_OPEN(cleanup, "file", test_cases[i].fd2_flag);
+
+	TEST(fcntl(fd1, F_SETLEASE, F_WRLCK));
+
+	SAFE_CLOSE(cleanup, fd1);
+	fd1 = 0;
+	SAFE_CLOSE(cleanup, fd2);
+	fd2 = 0;
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "fcntl(2) succeeded unexpectedly");
+		return;
+	}
+
+	tst_resm(TPASS | TTERRNO, "fcntl(2) failed as expected");
+}
+
+static void cleanup(void)
+{
+	if (fd1 > 0 && close(fd1))
+		tst_resm(TWARN | TTERRNO, "Failed to close file");
+
+	if (fd2 > 0 && close(fd2))
+		tst_resm(TWARN | TTERRNO, "Failed to close file");
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

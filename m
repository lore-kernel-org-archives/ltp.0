Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WUwck-00080n-J8
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 11:12:58 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WUwch-0001q6-6y
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 11:12:58 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s31BCCpJ016265
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Apr 2014 19:12:12 +0800
Message-ID: <1396350731.10607.12.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 1 Apr 2014 19:12:11 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] readdir/readdir03.c: add new error number testes
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Add ENOENT and ENOTDIR error number testes for readdir(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/readdir/readdir03.c | 151 ++++++++++++++++++++++++++
 5 files changed, 155 insertions(+)
 create mode 100644 testcases/kernel/syscalls/readdir/readdir03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ebe171e..bfa32bb 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -610,6 +610,7 @@ read04 read04
 
 readdir01 readdir01
 readdir02 readdir02
+readdir03 readdir03
 
 readlink01A symlink01 -T readlink01
 readlink01 readlink01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b21e44b..a052240 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -520,6 +520,7 @@ read04 read04
 
 readdir01 readdir01
 readdir02 readdir02
+readdir03 readdir03
 
 readlink01A symlink01 -T readlink01
 readlink01 readlink01
diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..a398083 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -808,6 +808,7 @@ readahead02 readahead02
 
 readdir01 readdir01
 readdir02 readdir02
+readdir03 readdir03
 
 readlink01A symlink01 -T readlink01
 readlink01 readlink01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5c7bac..b73ac7f 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -662,6 +662,7 @@
 /readahead/readahead02
 /readdir/readdir01
 /readdir/readdir02
+/readdir/readdir03
 /readlink/creat_slink
 /readlink/readlink01
 /readlink/readlink02
diff --git a/testcases/kernel/syscalls/readdir/readdir03.c b/testcases/kernel/syscalls/readdir/readdir03.c
new file mode 100644
index 0000000..ab6cd54
--- /dev/null
+++ b/testcases/kernel/syscalls/readdir/readdir03.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Library General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+/*
+ * Test Description:
+ *  Verify that,
+ *   1. Creat a directory and open it, then delete the directory, ENOENT would
+ *	return.
+ *   2. File descriptor does not refer to a directory, ENOTDIR would return.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <limits.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "readdir03";
+
+#if !defined __x86_64__
+
+#define TEST_DIR	"test_dir"
+#define TEST_FILE	"test_file"
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+
+struct old_linux_dirent {
+	long  d_ino;
+	off_t d_off;
+	unsigned short d_reclen;
+	char  d_name[NAME_MAX+1];
+};
+
+static unsigned int del_dir_fd, file_fd;
+static struct old_linux_dirent dirp;
+static void setup(void);
+static void cleanup(void);
+
+static struct test_case_t {
+	unsigned int *fd;
+	struct old_linux_dirent *dirp;
+	unsigned int count;
+	int exp_errno;
+} test_cases[] = {
+	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT},
+	{&file_fd, &dirp, sizeof(struct old_linux_dirent), ENOTDIR},
+};
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { ENOENT, ENOTDIR, 0 };
+static void readdir_verify(const struct test_case_t *);
+
+int main(int argc, char **argv)
+{
+	int i, lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			readdir_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_EXP_ENOS(exp_enos);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
+	del_dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_RDONLY | O_DIRECTORY);
+	if (rmdir(TEST_DIR) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "rmdir failed");
+
+	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0777);
+}
+
+static void readdir_verify(const struct test_case_t *test)
+{
+	TEST(syscall(__NR_readdir, *test->fd, test->dirp, test->count));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "readdir() succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "readdir() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "readdir() failed unexpectedly; expected: %d - %s",
+			 test->exp_errno, strerror(test->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
+
+#else
+
+int TST_TOTAL = 1;
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "test is not available on __x86_64__");
+}
+
+#endif /* if !defined __x86_64__ */
-- 
1.8.4.2




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

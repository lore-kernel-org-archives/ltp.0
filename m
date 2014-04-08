Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WXTTw-0005bf-DN
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 10:42:20 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WXTTu-0005Yz-Jx
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 10:42:20 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s38AfjLw029781
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Apr 2014 18:41:45 +0800
Message-ID: <1396953708.3005.6.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 8 Apr 2014 18:41:48 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] readlinkat/readlinkat02.c: add new errno testes
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

Add EINVAL and ENOTDIR errno testes for readlinkat(2)

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/readlinkat/readlinkat02.c      | 127 +++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 testcases/kernel/syscalls/readlinkat/readlinkat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fb3e59f..93ec2ea 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -817,6 +817,7 @@ readlink04 readlink04
 
 #readlinkat test cases
 readlinkat01 readlinkat01
+readlinkat02 readlinkat02
 
 readv01 readv01
 readv02 readv02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index d5c7bac..24e1707 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -668,6 +668,7 @@
 /readlink/readlink03
 /readlink/readlink04
 /readlinkat/readlinkat01
+/readlinkat/readlinkat02
 /readv/readv01
 /readv/readv02
 /readv/readv03
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat02.c b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
new file mode 100644
index 0000000..c720601
--- /dev/null
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
@@ -0,0 +1,127 @@
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
+ *   1. bufsiz is 0, EINVAL should be returned.
+ *   2. The named file is not a symbolic link, EINVAL should be returned.
+ *   3. The component of the path prefix is not a directory, ENOTDIR should be
+ *	returned.
+ *   4. pathname is relative and dirfd is a file descriptor referring to a file
+ *	other than a directory, ENOTDIR should be returned.
+ */
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+
+#define TEST_FILE	"test_file"
+#define SYMLINK_FILE	"symlink_file"
+#define BUFF_SIZE	256
+
+static int file_fd, dir_fd;
+
+static struct test_case_t {
+	int *dirfd;
+	const char *pathname;
+	size_t bufsiz;
+	int exp_errno;
+} test_cases[] = {
+	{&dir_fd, SYMLINK_FILE, 0, EINVAL},
+	{&dir_fd, TEST_FILE, BUFF_SIZE, EINVAL},
+	{&file_fd, SYMLINK_FILE, BUFF_SIZE, ENOTDIR},
+	{&dir_fd, "test_file/test_file", BUFF_SIZE, ENOTDIR},
+};
+
+char *TCID = "readlinkat02";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EINVAL, ENOTDIR, 0 };
+static void setup(void);
+static void cleanup(void);
+static void readlinkat_verify(const struct test_case_t *);
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
+			readlinkat_verify(&test_cases[i]);
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
+	dir_fd = SAFE_OPEN(cleanup, "./", O_RDONLY);
+
+	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0644);
+
+	SAFE_SYMLINK(cleanup, TEST_FILE, SYMLINK_FILE);
+}
+
+static void readlinkat_verify(const struct test_case_t *test)
+{
+	char buf[BUFF_SIZE];
+	TEST(readlinkat(*test->dirfd, test->pathname, buf, test->bufsiz));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "readlinkat succeeded unexpectedly");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "readlinkat failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			 "readlinkat failed unexpectedly; expected: %d - %s",
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
-- 
1.8.4.2




------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

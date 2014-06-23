Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Wz2D9-0002Of-BH
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 11:14:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wz2D6-00057H-Cf
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 11:14:55 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5NBEiGf005206
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Jun 2014 19:14:44 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 23 Jun 2014 19:13:37 +0800
Message-ID: <1403522017-8189-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] vmsplice/vmsplice02.c: add EBADF and EINVAL error
	value tests
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/.gitignore            |   1 +
 testcases/kernel/syscalls/vmsplice/vmsplice02.c | 167 ++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 testcases/kernel/syscalls/vmsplice/vmsplice02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index adefa49..a69ad15 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1324,6 +1324,7 @@ vhangup02 vhangup02
 
 #vmsplice test cases
 vmsplice01 vmsplice01
+vmsplice02 vmsplice02
 
 wait02 wait02
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 252e3c8..4501174 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1005,6 +1005,7 @@
 /vhangup/vhangup01
 /vhangup/vhangup02
 /vmsplice/vmsplice01
+/vmsplice/vmsplice02
 /wait/wait02
 /wait4/wait401
 /wait4/wait402
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
new file mode 100644
index 0000000..e7c9ce8
--- /dev/null
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -0,0 +1,167 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
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
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+/*
+ * Description:
+ *   Verify that,
+ *   1) vmsplice() returns -1 and sets errno to EBADF if fd
+ *      is not valid.
+ *   2) vmsplice() returns -1 and sets errno to EBADF if fd
+ *      doesn't refer to a pipe.
+ *   3) vmsplice() returns -1 and sets errno to EINVAL if
+ *      nr_segs is greater than IOV_MAX.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/uio.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+#include "tst_fs_type.h"
+#include "lapi/fcntl.h"
+
+#define TESTFILE "testfile"
+
+#define TEST_BLOCK_SIZE 128
+#define VMSPLICE_LEN 10
+
+static char buffer[TEST_BLOCK_SIZE];
+static int notvalidfd = -1;
+static int filefd;
+static int pipes[2];
+static struct iovec ivc;
+
+static struct test_case_t {
+	int *fd;
+	const struct iovec *iov;
+	unsigned long nr_segs;
+	int exp_errno;
+} test_cases[] = {
+	{ &notvalidfd, &ivc, VMSPLICE_LEN, EBADF },
+	{ &filefd, &ivc, VMSPLICE_LEN, EBADF },
+	{ &pipes[1], &ivc, IOV_MAX + 1, EINVAL },
+};
+
+static void setup(void);
+static void cleanup(void);
+static void vmsplice_verify(const struct test_case_t *);
+
+char *TCID = "vmsplice02";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EBADF, EINVAL, 0 };
+
+int main(int ac, char **av)
+{
+	int i, lc;
+	const char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	TEST_EXP_ENOS(exp_enos);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			vmsplice_verify(&test_cases[i]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int i;
+
+	if ((tst_kvercmp(2, 6, 17)) < 0) {
+		tst_brkm(TCONF, cleanup, "This test can only run on "
+			"kernels that are 2.6.17 or higher");
+	}
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
+		tst_brkm(TCONF, cleanup, "Cannot do splice() "
+			"on a file located on an NFS filesystem");
+	}
+
+	for (i = 0; i < TEST_BLOCK_SIZE; i++)
+		buffer[i] = i & 0xff;
+
+
+	filefd = SAFE_OPEN(cleanup, TESTFILE,
+				O_WRONLY | O_CREAT, 0644);
+
+	SAFE_PIPE(cleanup, pipes);
+
+	ivc.iov_base = buffer;
+	ivc.iov_len = TEST_BLOCK_SIZE;
+}
+
+static void vmsplice_verify(const struct test_case_t *tc)
+{
+	TEST(vmsplice(*(tc->fd), tc->iov, tc->nr_segs, 0));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "vmsplice() returned %ld, "
+			"expected -1, errno:%d", TEST_RETURN,
+			tc->exp_errno);
+		return;
+	}
+
+	TEST_ERROR_LOG(TEST_ERRNO);
+
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO, "vmsplice() failed as expected");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"vmsplice() failed unexpectedly; expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
+	}
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (filefd && close(filefd) < 0)
+		tst_resm(TWARN | TERRNO, "close filefd failed");
+
+	if (pipes[0] && close(pipes[0]) < 0)
+		tst_resm(TWARN | TERRNO, "close pipes[0] failed");
+
+	if (pipes[1] && close(pipes[1]) < 0)
+		tst_resm(TWARN | TERRNO, "close pipes[1] failed");
+
+	tst_rmdir();
+}
-- 
1.9.3


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

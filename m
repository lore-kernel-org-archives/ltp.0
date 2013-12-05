Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VoPr2-0008HM-LI
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 03:43:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoPr0-0000Az-W9
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 03:43:56 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rB53hf6r031107
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Dec 2013 11:43:46 +0800
Message-ID: <529FF665.9000004@cn.fujitsu.com>
Date: Thu, 05 Dec 2013 11:43:33 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] fcntl/fcntl29.c: add F_DUPFD_CLOEXEC test for
	fcntl(2)
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

create a new case to test F_DUPFD_CLOEXEC for fcntl(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/fcntl/fcntl29.c | 117 ++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl29.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 717342e..cace2ca 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -251,6 +251,8 @@ fcntl27 fcntl27
 fcntl27_64 fcntl27_64
 fcntl28 fcntl28
 fcntl28_64 fcntl28_64
+fcntl29 fcntl29
+fcntl29_64 fcntl29_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
new file mode 100644
index 0000000..095a316
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (c) 2013 Fujitsu Ltd.
+ * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
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
+
+/*
+ * Description:
+ * Verify that,
+ *   Basic test for fcntl(2) using F_DUPFD_CLOEXEC argument.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <pwd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "fcntl29";
+
+#if defined(F_DUPFD_CLOEXEC)
+static void setup(void);
+static void cleanup(void);
+
+static int test_fd;
+static int dup_fd;
+
+int TST_TOTAL = 1;
+
+int main(int ac, char **av)
+{
+	int lc;
+	char *msg;
+	int i;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+			TEST(fcntl(test_fd, F_DUPFD_CLOEXEC, dup_fd));
+			if (TEST_RETURN < 0) {
+				tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
+					 "test F_DUPFD_CLOEXEC failed");
+			}
+
+			TEST(fcntl(TEST_RETURN, F_GETFD));
+			if (TEST_RETURN < 0) {
+				tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
+					 "test F_GETFD failed");
+			}
+
+			if (TEST_RETURN & FD_CLOEXEC) {
+				tst_resm(TPASS, "fcntl test "
+					 "F_DUPFD_CLOEXEC success");
+			} else {
+				tst_resm(TFAIL, "fcntl test "
+					 "F_DUPFD_CLOEXEC fail");
+			}
+
+			SAFE_CLOSE(cleanup, dup_fd);
+		}
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
+	tst_tmpdir();
+
+	TEST_PAUSE;
+
+	test_fd = SAFE_CREAT(cleanup, "testfile", 0644);
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
+#else
+
+int main(int ac, char **av)
+{
+	tst_brkm(TCONF, NULL, "This test can only run on kernels"
+		 "that are 2.6.24 and higher");
+}
+#endif
-- 
1.8.2.1


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

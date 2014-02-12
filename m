Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WDWJQ-0001ik-13
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 09:41:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WDWJN-000404-5G
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 09:40:59 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1C9eniX010860
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Feb 2014 17:40:50 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 12 Feb 2014 17:39:25 +0800
Message-Id: <1392197965-26132-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <20140203142910.GA3996@rei>
References: <20140203142910.GA3996@rei>
Subject: [LTP] [PATCH v3] fcntl/fcntl29.c: add F_DUPFD_CLOEXEC test for
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

create a new case to test F_DUPFD_CLOEXEC for fcntl(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/lapi/fcntl.h                      |   4 ++
 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/fcntl29.c | 114 ++++++++++++++++++++++++++++++
 6 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl29.c

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 474a447..7e923ab 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -23,4 +23,8 @@
 # define O_CLOEXEC 02000000
 #endif
 
+#ifndef F_DUPFD_CLOEXEC
+# define F_DUPFD_CLOEXEC 1030
+#endif
+
 #endif /* __LAPI_FCNTL_H__ */
diff --git a/runtest/ltplite b/runtest/ltplite
index 2f8f977..f5a58cf 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -223,6 +223,7 @@ fcntl26 fcntl26
 # The tests for these system calls  fcntl27 and fcntl28 are temporarily being disabled
 # fcntl27 fcntl27
 # fcntl28 fcntl28
+fcntl29 fcntl29
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 5703d13..24185f3 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -162,6 +162,7 @@ fcntl26 fcntl26
 # The tests for these system calls  fcntl27 and fcntl28 are temporarily being disabled
 # fcntl27 fcntl27
 # fcntl28 fcntl28
+fcntl29 fcntl29
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/syscalls b/runtest/syscalls
index 083c240..f9c2f55 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -252,6 +252,8 @@ fcntl27 fcntl27
 fcntl27_64 fcntl27_64
 fcntl28 fcntl28
 fcntl28_64 fcntl28_64
+fcntl29 fcntl29
+fcntl29_64 fcntl29_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index b622244..21535ae 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -214,6 +214,8 @@
 /fcntl/fcntl27_64
 /fcntl/fcntl28
 /fcntl/fcntl28_64
+/fcntl/fcntl29
+/fcntl/fcntl29_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flock/flock01
diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
new file mode 100644
index 0000000..f665f03
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
@@ -0,0 +1,114 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
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
+#include "lapi/fcntl.h"
+
+char *TCID = "fcntl29";
+int TST_TOTAL = 1;
+
+static void setup(void);
+static void cleanup(void);
+
+static int test_fd;
+
+int main(int ac, char **av)
+{
+	int lc, dup_fd;
+	char *msg;
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
+		TEST(fcntl(test_fd, F_DUPFD_CLOEXEC, 0));
+		if (TEST_RETURN < 0) {
+			tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
+				 "test F_DUPFD_CLOEXEC failed");
+		}
+		dup_fd = TEST_RETURN;
+
+		TEST(fcntl(dup_fd, F_GETFD));
+		if (TEST_RETURN < 0) {
+			SAFE_CLOSE(cleanup, dup_fd);
+			tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
+				 "test F_GETFD failed");
+		}
+
+		if (TEST_RETURN & FD_CLOEXEC) {
+			tst_resm(TPASS, "fcntl test "
+				 "F_DUPFD_CLOEXEC success");
+		} else {
+			tst_resm(TFAIL, "fcntl test "
+				 "F_DUPFD_CLOEXEC fail");
+		}
+
+		SAFE_CLOSE(cleanup, dup_fd);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 24)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels"
+			 "that are 2.6.24 and higher");
+	}
+
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
+	if (test_fd > 0)
+		SAFE_CLOSE(NULL, test_fd);
+
+	tst_rmdir();
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

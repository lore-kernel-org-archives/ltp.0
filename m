Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W5YCr-00047X-M7
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 10:05:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W5YCq-0002IY-Ek
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 10:05:17 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0LA47v1009875
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 18:04:07 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 21 Jan 2014 18:02:53 +0800
Message-Id: <1390298574-2966-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1390298574-2966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1390298574-2966-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 2/3] fcntl/fcntl30.c: add F_SETPIPE_SZ,
	F_GETPIPE_SZ test for fcntl(2)
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

create a new case to test F_SETPIPE_SZ, F_GETPIPE_SZ for fcntl(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/fcntl30.c | 143 ++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl30.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 196e2a2..80e9527 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -224,6 +224,7 @@ fcntl26 fcntl26
 # fcntl27 fcntl27
 # fcntl28 fcntl28
 fcntl29 fcntl29
+fcntl30 fcntl30
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 946f4ea..d593f92 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -163,6 +163,7 @@ fcntl26 fcntl26
 # fcntl27 fcntl27
 # fcntl28 fcntl28
 fcntl29 fcntl29
+fcntl30 fcntl30
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/syscalls b/runtest/syscalls
index b45faab..eec05a9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -254,6 +254,8 @@ fcntl28 fcntl28
 fcntl28_64 fcntl28_64
 fcntl29 fcntl29
 fcntl29_64 fcntl29_64
+fcntl30 fcntl30
+fcntl30_64 fcntl30_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1ab13d8..a5a999d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -216,6 +216,8 @@
 /fcntl/fcntl28_64
 /fcntl/fcntl29
 /fcntl/fcntl29_64
+/fcntl/fcntl30
+/fcntl/fcntl30_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flock/flock01
diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
new file mode 100644
index 0000000..c522909
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -0,0 +1,143 @@
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
+ *     Basic test for fcntl(2) using F_SETPIPE_SZ, F_GETPIPE_SZ argument.
+ */
+
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <pwd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "fcntl30";
+int TST_TOTAL = 1;
+
+#if defined(F_SETPIPE_SZ) && defined(F_GETPIPE_SZ)
+
+static void setup(void);
+static void cleanup(void);
+
+static int pipe_fds[2];
+static int test_fd;
+static int orig_pipe_size;
+static int new_pipe_size;
+
+
+int main(int ac, char **av)
+{
+	int lc;
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
+		TEST(fcntl(test_fd, F_SETPIPE_SZ, new_pipe_size));
+		if (TEST_RETURN < 0) {
+			tst_brkm(TFAIL | TTERRNO, cleanup,
+				 "fcntl test F_SETPIPE_SZ failed");
+		}
+
+		TEST(fcntl(test_fd, F_GETPIPE_SZ));
+		if (TEST_RETURN < 0) {
+			tst_brkm(TFAIL | TTERRNO, cleanup,
+				 "fcntl test F_GETPIPE_SZ failed");
+		}
+		tst_resm(TINFO, "orig_pipe_size: %d new_pipe_size: %d",
+			 orig_pipe_size, new_pipe_size);
+		if (TEST_RETURN >= new_pipe_size) {
+			tst_resm(TPASS, "fcntl test F_GETPIPE_SZ"
+				 "and F_SETPIPE_SZ success");
+		} else {
+			tst_resm(TFAIL, "fcntl test F_GETPIPE_SZ"
+				 "and F_SETPIPE_SZ fail");
+		}
+
+		/* restore the original pipe size*/
+		TEST(fcntl(test_fd, F_SETPIPE_SZ, orig_pipe_size));
+		if (TEST_RETURN < 0) {
+			tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
+				 "restore orignal pipe size failed");
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 35)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels"
+			 "that are 2.6.35 and higher");
+	}
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	TEST_PAUSE;
+
+	SAFE_PIPE(cleanup, pipe_fds);
+	test_fd = pipe_fds[1];
+
+	TEST(fcntl(test_fd, F_GETPIPE_SZ));
+	if (TEST_RETURN < 0) {
+		tst_brkm(TFAIL | TTERRNO, cleanup,
+			 "fcntl get pipe size failed");
+	}
+
+	orig_pipe_size = TEST_RETURN;
+	new_pipe_size = orig_pipe_size * 2;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	if (pipe_fds[0] > 0)
+		SAFE_CLOSE(NULL, pipe_fds[0]);
+	if (pipe_fds[1] > 0)
+		SAFE_CLOSE(NULL, pipe_fds[1]);
+
+	tst_rmdir();
+}
+#else
+
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "This test can only run on kernels"
+		 "that are 2.6.35 and higher");
+}
+#endif
-- 
1.8.2.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

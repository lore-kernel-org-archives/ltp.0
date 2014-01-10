Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1W1aAW-000065-4v
	for ltp-list@lists.sourceforge.net; Fri, 10 Jan 2014 11:22:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W1aAT-0001GE-E7
	for ltp-list@lists.sourceforge.net; Fri, 10 Jan 2014 11:22:28 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0ABMG9c017833
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jan 2014 19:22:16 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 10 Jan 2014 19:21:15 +0800
Message-Id: <1389352876-28625-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] llseek/llseek03.c: add SEEK_CUR, SEEK_END flag test
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

create a new case to test SEEK_CUR, SEEK_END flag for llseek(2)

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 +
 runtest/stress.part3                        |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/llseek/llseek03.c | 214 ++++++++++++++++++++++++++++
 5 files changed, 218 insertions(+)
 create mode 100644 testcases/kernel/syscalls/llseek/llseek03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 4b5300d..dab0bea 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -386,6 +386,7 @@ listen01 listen01
 
 llseek01 llseek01
 llseek02 llseek02
+llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index bb4807c..98fd57f 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -319,6 +319,7 @@ listen01 listen01
 
 llseek01 llseek01
 llseek02 llseek02
+llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
diff --git a/runtest/syscalls b/runtest/syscalls
index afa7976..bebcca9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -492,6 +492,7 @@ listen01 listen01
 
 llseek01 llseek01
 llseek02 llseek02
+llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 91cf0f1..8e351a3 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -448,6 +448,7 @@
 /listen/listen01
 /llseek/llseek01
 /llseek/llseek02
+/llseek/llseek03
 /lseek/lseek01
 /lseek/lseek02
 /lseek/lseek03
diff --git a/testcases/kernel/syscalls/llseek/llseek03.c b/testcases/kernel/syscalls/llseek/llseek03.c
new file mode 100644
index 0000000..99d0c06
--- /dev/null
+++ b/testcases/kernel/syscalls/llseek/llseek03.c
@@ -0,0 +1,214 @@
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
+ *    1. llseek() succeeds to set the file pointer position to the current
+ *  specified location, when 'whence' value is set to SEEK_CUR and the data
+ *  read from the specified location should match the expected data.
+ *    2. llseek() succeeds to set the file pointer position to the end of
+ *  the file when 'whence' value set to SEEK_END and any attempts to read
+ *  from that position should return 0.
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <utime.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <inttypes.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define TEST_FILE "testfile"
+
+static void setup(int ac, char **av);
+static void cleanup(void);
+
+static void setup_seekcur(void);
+static void testfunc_seekcur(void);
+static void cleanup_seekcur(void);
+
+static void setup_seekend(void);
+static void testfunc_seekend(void);
+static void cleanup_seekend(void);
+
+static struct test_case_t {
+	int whence;
+	void (*setup)(void);
+	void (*testfunc)(void);
+	void (*cleanup)(void);
+} test_cases[] = {
+	{ SEEK_CUR, setup_seekcur, testfunc_seekcur, cleanup_seekcur},
+	{ SEEK_END, setup_seekend, testfunc_seekend, cleanup_seekend},
+};
+
+char *TCID = "llseek03";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static char read_buf[BUFSIZ];
+
+static int fd;
+static size_t file_size;
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i;
+
+	setup(ac, av);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+			if (test_cases[i].setup)
+				test_cases[i].setup();
+			if (test_cases[i].testfunc)
+				test_cases[i].testfunc();
+			if (test_cases[i].cleanup)
+				test_cases[i].cleanup();
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(int ac, char **av)
+{
+	char *msg;
+	char write_buf[BUFSIZ];
+	struct stat stat_buf;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	TEST_PAUSE;
+
+	if (strcpy(write_buf, "abcdefgh") != write_buf)
+		tst_brkm(TBROK | TERRNO, NULL, "strcpy failed");
+
+	fd = SAFE_CREAT(cleanup, TEST_FILE, 0644);
+
+	SAFE_WRITE(cleanup, 1, fd, write_buf, strlen(write_buf));
+
+	if (fstat(fd, &stat_buf) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "fstat of %s failed", TEST_FILE);
+	}
+	file_size = stat_buf.st_size;
+
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void setup_seekcur(void)
+{
+	/* reopen TEST_FILE and file offset will be 0 */
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+
+	/* after read, file offset will be 4 */
+	SAFE_READ(cleanup, 1, fd, read_buf, 4);
+}
+
+static void testfunc_seekcur(void)
+{
+	TEST(lseek64(fd, (loff_t) 1, SEEK_CUR));
+
+	if (TEST_RETURN == (loff_t) -1) {
+		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
+		return;
+	}
+
+	if (TEST_RETURN != 5) {
+		tst_resm(TFAIL, "llseek return a incorrect file offset");
+		return;
+	}
+
+	memset(read_buf, 0, sizeof(read_buf));
+
+	/* the expected characters are "fgh" */
+	SAFE_READ(cleanup, 1, fd, read_buf, 3);
+
+	if (strcmp(read_buf, "fgh"))
+		tst_resm(TFAIL, "test SEEK_SET for llseek failed");
+	else
+		tst_resm(TPASS, "test SEEK_SET for llseek success");
+}
+
+static void cleanup_seekcur(void)
+{
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void setup_seekend(void)
+{
+	/* reopen TEST_FILE and file offset will be 0 */
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+}
+
+static void testfunc_seekend(void)
+{
+	ssize_t nread;
+
+	TEST(lseek64(fd, (loff_t) 0, SEEK_END));
+
+	if (TEST_RETURN == (loff_t) -1) {
+		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
+		return;
+	}
+
+	if (TEST_RETURN != file_size) {
+		tst_resm(TFAIL, "llseek return a incorrect file offset");
+		return;
+	}
+
+	memset(read_buf, 0, sizeof(read_buf));
+
+	nread = SAFE_READ(cleanup, 0, fd, read_buf, file_size);
+	if (nread > 0)
+		tst_resm(TFAIL, "test SEEK_END for llseek failed");
+	else
+		tst_resm(TPASS, "test SEEK_END for llseek success");
+
+}
+static void cleanup_seekend(void)
+{
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
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

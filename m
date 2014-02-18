Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WFehi-0001K3-6n
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 07:02:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WFehf-0001SD-Rl
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 07:02:54 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1I72gxu016642
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Feb 2014 15:02:43 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 18 Feb 2014 15:01:17 +0800
Message-Id: <1392706877-7286-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] llseek/llseek03.c: add SEEK_CUR, SEEK_END flag test
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
 testcases/kernel/syscalls/llseek/llseek03.c | 187 ++++++++++++++++++++++++++++
 5 files changed, 191 insertions(+)
 create mode 100644 testcases/kernel/syscalls/llseek/llseek03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index de01a94..c32a033 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -386,6 +386,7 @@ listen01 listen01
 
 llseek01 llseek01
 llseek02 llseek02
+llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 4114205..276adcb 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -319,6 +319,7 @@ listen01 listen01
 
 llseek01 llseek01
 llseek02 llseek02
+llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
diff --git a/runtest/syscalls b/runtest/syscalls
index b9c1927..010bfd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -492,6 +492,7 @@ listen01 listen01
 
 llseek01 llseek01
 llseek02 llseek02
+llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index b622244..a5214ff 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -450,6 +450,7 @@
 /listen/listen01
 /llseek/llseek01
 /llseek/llseek02
+/llseek/llseek03
 /lseek/lseek01
 /lseek/lseek02
 /lseek/lseek03
diff --git a/testcases/kernel/syscalls/llseek/llseek03.c b/testcases/kernel/syscalls/llseek/llseek03.c
new file mode 100644
index 0000000..02f5d95
--- /dev/null
+++ b/testcases/kernel/syscalls/llseek/llseek03.c
@@ -0,0 +1,187 @@
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
+static void setup(void);
+static void cleanup(void);
+
+static void testfunc_seekcur(void);
+static void testfunc_seekend(void);
+
+static void (*testfunc[])(void) = { testfunc_seekcur, testfunc_seekend };
+
+char *TCID = "llseek03";
+int TST_TOTAL = 2;
+
+static size_t file_size;
+
+int main(int ac, char **av)
+{
+	int i, lc;
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
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int fd;
+	char write_buf[BUFSIZ];
+	struct stat stat_buf;
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
+	SAFE_FSTAT(cleanup, fd, &stat_buf);
+
+	SAFE_CLOSE(cleanup, fd);
+
+	file_size = stat_buf.st_size;
+}
+
+static void testfunc_seekcur(void)
+{
+	int fd;
+	static char read_buf[BUFSIZ];
+
+	/* reopen TEST_FILE and file offset will be 0 */
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+
+	/* after read, file offset will be 4 */
+	SAFE_READ(cleanup, 1, fd, read_buf, 4);
+
+	TEST(lseek64(fd, (loff_t) 1, SEEK_CUR));
+
+	if (TEST_RETURN == (loff_t) -1) {
+		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
+		goto cleanup_seekcur;
+	}
+
+	if (TEST_RETURN != 5) {
+		tst_resm(TFAIL, "llseek return a incorrect file offset");
+		goto cleanup_seekcur;
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
+
+cleanup_seekcur:
+	SAFE_CLOSE(cleanup, fd);
+}
+
+
+static void testfunc_seekend(void)
+{
+	int fd;
+	ssize_t nread;
+	static char read_buf[BUFSIZ];
+
+	/* reopen TEST_FILE and file offset will be 0 */
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+
+	TEST(lseek64(fd, (loff_t) 0, SEEK_END));
+
+	if (TEST_RETURN == (loff_t) -1) {
+		tst_resm(TFAIL | TTERRNO, "llseek failed on %s ", TEST_FILE);
+		goto cleanup_seekend;
+	}
+
+	if (TEST_RETURN != file_size) {
+		tst_resm(TFAIL, "llseek return a incorrect file offset");
+		goto cleanup_seekend;
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
+cleanup_seekend:
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
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

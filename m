Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WMYsI-0000E2-Ke
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 08:14:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WMYsF-000083-Tp
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 08:14:22 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s298ECkD012461
	for <ltp-list@lists.sourceforge.net>; Sun, 9 Mar 2014 16:14:12 +0800
Message-ID: <1394352845.2346.4.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sun, 09 Mar 2014 16:14:05 +0800
In-Reply-To: <1394352758.2346.2.camel@G08JYZSD130126>
References: <1394352758.2346.2.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/2] open/open12.c: add new tests
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

Add new tests for open(2)
O_APPEND
O_CLOEXEC
O_NOATIME

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/open/open12.c       | 196 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/open/test_cloexec.c |  33 +++++
 6 files changed, 233 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open12.c
 create mode 100644 testcases/kernel/syscalls/open/test_cloexec.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f7127fe..6bd72dd 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -543,6 +543,7 @@ open08 open08
 open09 open09
 open10 open10
 open11 open11
+open12 open12 -F $LTPROOT/testcases/bin/test_cloexec
 
 mincore01 mincore01
 #mincore02 mincore02 currently hangs and does not exit correctly
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 2f31e93..e526ed0 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -465,6 +465,7 @@ open08 open08
 open09 open09
 open10 open10
 open11 open11
+open12 open12 -F $LTPROOT/testcases/bin/test_cloexec
 
 pathconf01 pathconf01
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 2a408c4..d63911f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -702,6 +702,7 @@ open08 open08
 open09 open09
 open10 open10
 open11 open11
+open12 open12 -F $LTPROOT/testcases/bin/test_cloexec
 
 #openat test cases
 openat01 openat01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0138ba9..d336772 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -596,6 +596,7 @@
 /open/open09
 /open/open10
 /open/open11
+/open/open12
 /openat/openat01
 /pathconf/pathconf01
 /pause/pause01
diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
new file mode 100644
index 0000000..d2093db
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -0,0 +1,196 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+/*
+ * DESCRIPTION
+ *	This test case will verify basic function of open(2) with the flags
+ *	O_APPEND, O_CLOEXEC and O_NOATIME.
+ */
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+
+#define TEST_FILE	"test_file"
+
+char *TCID = "open12";
+
+static int fd;
+static char *test_app;
+static char test_path[MAXPATHLEN];
+static void setup(void);
+static void cleanup(void);
+static void test_append(void);
+static void test_noatime(void);
+static void test_cloexec(void);
+static void help(void);
+option_t options[] = {
+	{"F:", NULL, &test_app},
+	{NULL, NULL, NULL}
+};
+
+static void (*test_func[])(void) = { test_append, test_noatime, test_cloexec };
+
+int TST_TOTAL = ARRAY_SIZE(test_func);
+
+int main(int argc, char **argv)
+{
+	int lc;
+	char *msg;
+	int i;
+
+	msg = parse_opts(argc, argv, options, &help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (!test_app) {
+		tst_brkm(TBROK, NULL,
+			 "You must specify a test executable with the -F option.");
+	}
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		for (i = 0; i < TST_TOTAL; i++)
+			(*test_func[i])();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	TEST_PAUSE;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	if (test_app[0] != '/') {
+		sprintf(test_path, "%s/%s", get_current_dir_name(),
+			basename(test_app));
+		test_app = test_path;
+	}
+
+	tst_tmpdir();
+
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_WRONLY | O_CREAT, 0777);
+	SAFE_WRITE(cleanup, 1, fd, TEST_FILE, sizeof(TEST_FILE));
+	SAFE_CLOSE(cleanup, fd);
+}
+
+static void test_append(void)
+{
+	unsigned int len;
+
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_APPEND | O_RDWR);
+
+	SAFE_WRITE(cleanup, 1, fd, TEST_FILE, sizeof(TEST_FILE));
+	len = SAFE_LSEEK(cleanup, fd, 0, SEEK_CUR);
+	SAFE_CLOSE(cleanup, fd);
+
+	if (len > sizeof(TEST_FILE))
+		tst_resm(TPASS, "open(%s, O_APPEND) test success", TEST_FILE);
+	else
+		tst_resm(TFAIL, "open(%s, O_APPEND) test failed", TEST_FILE);
+}
+
+static void test_noatime(void)
+{
+	char read_buf;
+	struct stat orignal, flag, no_flag;
+
+	if ((tst_kvercmp(2, 6, 9)) < 0) {
+		tst_resm(TCONF,
+			 "O_NOATIME flags test for open(2) needs kernel 2.6.9 "
+			 "or higher");
+		return;
+	}
+
+	SAFE_STAT(cleanup, TEST_FILE, &orignal);
+
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY | O_NOATIME);
+	sleep(1);
+	SAFE_READ(cleanup, 1, fd, &read_buf, 1);
+	SAFE_CLOSE(cleanup, fd);
+	SAFE_STAT(cleanup, TEST_FILE, &flag);
+
+	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDONLY);
+	sleep(1);
+	SAFE_READ(cleanup, 1, fd, &read_buf, 1);
+	SAFE_CLOSE(cleanup, fd);
+	SAFE_STAT(cleanup, TEST_FILE, &no_flag);
+
+	if (orignal.st_atime == flag.st_atime &&
+	    orignal.st_atime != no_flag.st_atime)
+		tst_resm(TPASS, "open(%s, O_NOATIME) test success", TEST_FILE);
+	else
+		tst_resm(TFAIL, "open(%s, O_NOATIME) test failed", TEST_FILE);
+}
+
+static void test_cloexec(void)
+{
+	int fd2;
+	pid_t pid;
+	int status;
+
+	if ((tst_kvercmp(2, 6, 24)) < 0) {
+		tst_resm(TCONF,
+			 "O_CLOEXEC flags test for open(2) needs kernel 2.6.24 "
+			 "or higher");
+		return;
+	}
+
+	fd2 = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_APPEND | O_CLOEXEC);
+
+	pid = fork();
+	if (pid < 0)
+		tst_brkm(TBROK, cleanup, "fork() failed");
+
+	if (pid == 0) {
+		if (execl(test_app, "test", &fd2, "test O_CLOEXEC\n", NULL)) {
+			printf("execl() error\n");
+			exit(-2);
+		}
+	}
+
+	SAFE_CLOSE(cleanup, fd2);
+
+	if (wait(&status) != pid)
+		tst_resm(TBROK | TERRNO, "wait() error");
+
+	if (WIFEXITED(status) && (char)WEXITSTATUS(status) == -1)
+		tst_resm(TPASS, "open(%s, O_CLOEXEC) test success", TEST_FILE);
+	else
+		tst_resm(TFAIL, "open(%s, O_CLOEXEC) test failed", TEST_FILE);
+}
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	tst_rmdir();
+}
+
+static void help(void)
+{
+	printf("  -F <test file> : for example, 'open12 -F test'\n");
+}
diff --git a/testcases/kernel/syscalls/open/test_cloexec.c b/testcases/kernel/syscalls/open/test_cloexec.c
new file mode 100644
index 0000000..c045cca
--- /dev/null
+++ b/testcases/kernel/syscalls/open/test_cloexec.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) 2014 Fujitsu Ltd.
+ * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	int ret;
+
+	if (argc != 3)
+		printf("Only three arguments: %s fd str", argv[0]);
+
+	ret = write((int)(*argv[1]), argv[2], strlen(argv[2]));
+
+	exit(ret);
+}
-- 
1.8.4.2




------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

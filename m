Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X6zl8-00066t-5V
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 10:14:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X6zl6-0006kW-D4
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 10:14:54 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6FAEftY022001
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Jul 2014 18:14:41 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 15 Jul 2014 18:13:49 +0800
Message-ID: <1405419229-4222-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1405419229-4222-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1405419229-4222-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for getcwd(2)
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

Note: this test has already been in xfstests generic/028 test case,
I just port it to LTP.

Kernel commit '232d2d60aa5469bb097f55728f65146bd49c1d25' introduced a race
condition that causes getcwd(2) to return "/" instead of correct path.
    232d2d6 dcache: Translating dentry into pathname without
            taking rename_lock

And these two kernel commits have fixed this bug:
  ede4cebce16f5643c61aedd6d88d9070a1d23a68
     prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
  f6500801522c61782d4990fa1ad96154cb397cd4
     f650080 __dentry_path() fixes

This test is to check whether this bug exists in the running kernel,
or whether this bug has been fixed.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 +
 runtest/stress.part3                        |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/getcwd/getcwd04.c | 143 ++++++++++++++++++++++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getcwd/getcwd04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 50653a9..1457908 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -275,6 +275,7 @@ getcontext01 getcontext01
 getcwd01 getcwd01
 getcwd02 getcwd02
 getcwd03 getcwd03
+getcwd04 getcwd04
 
 getdents01 getdents01
 getdents02 getdents02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 39ce807..368c640 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -214,6 +214,7 @@ getcontext01 getcontext01
 getcwd01 getcwd01
 getcwd02 getcwd02
 getcwd03 getcwd03
+getcwd04 getcwd04
 
 getdents01 getdents01
 getdents02 getdents02
diff --git a/runtest/syscalls b/runtest/syscalls
index fbed9cb..13218e3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -329,6 +329,7 @@ getcpu01 getcpu01
 getcwd01 getcwd01
 getcwd02 getcwd02
 getcwd03 getcwd03
+getcwd04 getcwd04
 
 getdents01 getdents01
 getdents02 getdents02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index b9d49cf..fd3282b 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -273,6 +273,7 @@
 /getcwd/getcwd01
 /getcwd/getcwd02
 /getcwd/getcwd03
+/getcwd/getcwd04
 /getdents/getdents01
 /getdents/getdents01_64
 /getdents/getdents02
diff --git a/testcases/kernel/syscalls/getcwd/getcwd04.c b/testcases/kernel/syscalls/getcwd/getcwd04.c
new file mode 100644
index 0000000..a0285cb
--- /dev/null
+++ b/testcases/kernel/syscalls/getcwd/getcwd04.c
@@ -0,0 +1,143 @@
+/*
+ *   Copyright (c) 2014 Fujitsu Ltd.
+ *   Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ */
+
+/*
+ * Note: this test has already been in xfstests generic/028 test case,
+ * I just port it to LTP.
+ *
+ * Kernel commit '232d2d60aa5469bb097f55728f65146bd49c1d25' introduced a race
+ * condition that causes getcwd(2) to return "/" instead of correct path.
+ *     232d2d6 dcache: Translating dentry into pathname without
+ *             taking rename_lock
+ *
+ * And these two kernel commits fixed the bug:
+ *   ede4cebce16f5643c61aedd6d88d9070a1d23a68
+ *	prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
+ *   f6500801522c61782d4990fa1ad96154cb397cd4
+ *	f650080 __dentry_path() fixes
+ *
+ * This test is to check whether this bug exists in the running kernel,
+ * or whether this bug has been fixed.
+ *
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "usctest.h"
+#include "test.h"
+#include "safe_macros.h"
+
+#define TIMEOUT	5
+
+static void setup(void);
+static void cleanup(void);
+static void do_child(void);
+static void sigproc(int sig);
+static volatile sig_atomic_t end;
+static char init_cwd[PATH_MAX];
+
+char *TCID = "getcwd04";
+int TST_TOTAL = 1;
+
+int main(int ac, char **av)
+{
+	int status;
+	const char *msg;
+	char cur_cwd[PATH_MAX];
+	pid_t child;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	child = tst_fork();
+	if (child < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
+
+	if (child == 0)
+		do_child();
+
+	 while (1) {
+		SAFE_GETCWD(cleanup, cur_cwd, PATH_MAX);
+		if (strncmp(init_cwd, cur_cwd, PATH_MAX)) {
+			tst_resm(TFAIL, "initial current work directory is "
+				 "%s, now is %s. Bug is reproduced!",
+				 init_cwd, cur_cwd);
+			break;
+		}
+
+		if (end) {
+			tst_resm(TPASS, "Bug is not reproduced!");
+			break;
+		}
+	}
+
+	SAFE_KILL(cleanup, child, SIGKILL);
+	SAFE_WAITPID(cleanup, child, &status, 0);
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	if (signal(SIGALRM, sigproc) == SIG_ERR)
+		tst_brkm(TBROK | TERRNO, cleanup, "signal(SIGALRM) failed");
+
+	alarm(TIMEOUT);
+
+	SAFE_MKDIR(cleanup, "testdir", 0755);
+	SAFE_CHDIR(cleanup, "testdir");
+
+	SAFE_GETCWD(cleanup, init_cwd, PATH_MAX);
+}
+
+static void sigproc(int sig)
+{
+	end = sig;
+}
+
+static void do_child(void)
+{
+	unsigned int i = 0;
+	char c_name[PATH_MAX] = "testfile", n_name[PATH_MAX];
+
+	SAFE_TOUCH(NULL, c_name, 0644, NULL);
+
+	while (1) {
+		snprintf(n_name, PATH_MAX, "testfile%u", i++);
+		SAFE_RENAME(NULL, c_name, n_name);
+		strncpy(c_name, n_name, PATH_MAX);
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
1.8.2.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

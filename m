Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VgoDN-0003Cs-U6
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 04:07:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VgoDL-0005Xc-1s
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 04:07:33 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAE47NDY024919
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 12:07:23 +0800
Message-ID: <1384402041.2191.3.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 14 Nov 2013 12:07:21 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] clone/clone08.c: Add new flags
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

Add new case for clone(2) with CLONE_PARENT, CLONE_CHILD_SETTID,
CLONE_PARENT_SETTID, CLONE_STOPPED, CLONE_THREAD.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/.gitignore      |   1 +
 testcases/kernel/syscalls/clone/clone08.c | 192 ++++++++++++++++++++++++++++++
 5 files changed, 196 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clone/clone08.c

diff --git a/runtest/ltplite b/runtest/ltplite
index f0738c7..71dbb5e 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -126,6 +126,7 @@ clone04 clone04
 clone05 clone05
 clone06 clone06
 clone07 clone07
+clone08 clone08
 
 close01 close01
 close02 close02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 951b00e..8c42e1b 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -67,6 +67,7 @@ clone04 clone04
 clone05 clone05
 clone06 clone06
 clone07 clone07
+clone08 clone08
 
 close01 close01
 close02 close02
diff --git a/runtest/syscalls b/runtest/syscalls
index e5a5508..33cb11c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -84,6 +84,7 @@ clone04 clone04
 clone05 clone05
 clone06 clone06
 clone07 clone07
+clone08 clone08
 
 close01 close01
 close02 close02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0effa6b..35dd2c5 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -64,6 +64,7 @@
 /clone/clone05
 /clone/clone06
 /clone/clone07
+/clone/clone08
 /close/close01
 /close/close02
 /close/close08
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
new file mode 100644
index 0000000..fd82274
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -0,0 +1,192 @@
+/*
+ * Copyright (c) 2013 Fujitsu Ltd.
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
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#if defined UCLINUX && !__THROW
+/* workaround for libc bug */
+#define __THROW
+#endif
+
+#include <errno.h>
+#include <linux/sched.h>
+#include <sys/wait.h>
+#include "test.h"
+#include "usctest.h"
+#include "clone_platform.h"
+#include "linux_syscall_numbers.h"
+
+
+static pid_t parent_ppid;
+static pid_t ptid, ctid;
+static pid_t tgid;
+static void *child_stack;
+
+static void setup(void);
+static void cleanup(void);
+
+static int child_clone_parent();
+static int child_clone_child_settid();
+static int child_clone_parent_settid();
+
+static void test_clone_parent_settid(int tid);
+
+#ifdef CLONE_STOPPED
+static int thread_state;
+static void test_clone_stopped(int tid);
+static int child_clone_stopped();
+#endif
+
+static int notwait_flag = CLONE_PARENT;
+static struct test_case {
+	char *name;
+	int flags;
+	void (*testfunc)(int tid);
+	int (*do_child)();
+} test_cases[] = {
+	{"CLONE_PARENT", CLONE_PARENT, NULL, child_clone_parent},
+	{"CLONE_CHILD_SETTID", CLONE_CHILD_SETTID | SIGCHLD, NULL,
+	 child_clone_child_settid},
+	{"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | SIGCHLD,
+	 test_clone_parent_settid, child_clone_parent_settid},
+#ifdef CLONE_STOPPED
+	{"CLONE_STOPPED", CLONE_STOPPED | SIGCHLD, test_clone_stopped,
+	 child_clone_stopped},
+#endif
+};
+
+char *TCID = "clone08";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int i = 0;
+	int status;
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++) {
+			TEST(ltp_clone(test_cases[i].flags,
+			     test_cases[i].do_child,
+			     NULL, CHILD_STACK_SIZE, child_stack,
+			     &ptid, NULL, &ctid));
+
+			if (TEST_RETURN == -1) {
+				tst_brkm(TFAIL | TERRNO, cleanup,
+					 "%s clone() failed",
+					 test_cases[i].name);
+				continue;
+			}
+
+			if (test_cases[i].testfunc != NULL)
+				test_cases[i].testfunc(TEST_RETURN);
+
+			if ((test_cases[i].flags & notwait_flag) == 0 &&
+			     wait(&status) == -1) {
+				tst_brkm(TBROK | TERRNO, cleanup,
+					 "wait failed, status: %d", status);
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	parent_ppid = getppid();
+	tgid = getpid();
+
+	child_stack = malloc(CHILD_STACK_SIZE);
+	if (child_stack == NULL)
+		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
+}
+
+static void cleanup(void)
+{
+	free(child_stack);
+
+	TEST_CLEANUP;
+}
+
+static int child_clone_parent()
+{
+	if (parent_ppid != getppid())
+		tst_resm(TFAIL, "test CLONE_PARENT fail");
+	else
+		tst_resm(TPASS, "test CLONE_PARENT success");
+
+	exit(0);
+}
+
+static int child_clone_child_settid()
+{
+	if (ctid != getpid())
+		tst_resm(TFAIL, "test CLONE_CHILD_SETTID fail");
+	else
+		tst_resm(TPASS, "test CLONE_CHILD_SETTID success");
+
+	exit(0);
+}
+
+static void test_clone_parent_settid(int tid)
+{
+	if (tid != ptid)
+		tst_resm(TFAIL, "test CLONE_PARENT_SETTID fail");
+	else
+		tst_resm(TPASS, "test CLONE_PARENT_SETTID success");
+}
+
+static int child_clone_parent_settid()
+{
+	exit(0);
+}
+
+
+#ifdef CLONE_STOPPED
+static void test_clone_stopped(int tid)
+{
+	int cnt = 0;
+
+	do {
+		sleep(1);
+	} while (thread_state != 1 && cnt++ < 3);
+
+	/*
+	 * if thread_state isn't changed in 3 seconds by child thread,
+	 * we think the child thread has been stopped.
+	 */
+	if (thread_state == 0)
+		tst_resm(TPASS, "test CLONE_STOPPED success");
+	else
+		tst_resm(TFAIL, "test CLONE_STOPPED fail");
+
+	if (kill(tid, SIGCONT) != 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "kill SIGCONT failed");
+}
+static int child_clone_stopped()
+{
+	thread_state = 1;
+	exit(0);
+}
+#endif
-- 
1.8.2.1




------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

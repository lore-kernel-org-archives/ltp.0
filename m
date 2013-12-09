Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vpzbo-0006sv-JD
	for ltp-list@lists.sourceforge.net; Mon, 09 Dec 2013 12:06:44 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vpzbm-00051i-2P
	for ltp-list@lists.sourceforge.net; Mon, 09 Dec 2013 12:06:44 +0000
Message-ID: <1386590786.2041.6.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Mon, 09 Dec 2013 20:06:26 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH v3 2/2] clone/clone08.c: Add new flags
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

From 0b159a7cf724a698e9ce087932249a6d9f1b701e Mon Sep 17 00:00:00 2001
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 9 Dec 2013 19:37:38 +0800
Subject: [PATCH] clone/clone08.c: Add new flags

Add new case for clone(2)
CLONE_PARENT
CLONE_CHILD_SETTID
CLONE_PARENT_SETTID
CLONE_STOPPED
CLONE_THREAD

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/.gitignore      |   1 +
 testcases/kernel/syscalls/clone/clone08.c | 301 ++++++++++++++++++++++++++++++
 5 files changed, 305 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clone/clone08.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 2382dec..fe6cb04 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -127,6 +127,7 @@ clone04 clone04
 clone05 clone05
 clone06 clone06
 clone07 clone07
+clone08 clone08
 
 close01 close01
 close02 close02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 16247e9..16b08a7 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -68,6 +68,7 @@ clone04 clone04
 clone05 clone05
 clone06 clone06
 clone07 clone07
+clone08 clone08
 
 close01 close01
 close02 close02
diff --git a/runtest/syscalls b/runtest/syscalls
index 12bae10..14bcd88 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -85,6 +85,7 @@ clone04 clone04
 clone05 clone05
 clone06 clone06
 clone07 clone07
+clone08 clone08
 
 close01 close01
 close02 close02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 218ec0c..8c19551 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -65,6 +65,7 @@
 /clone/clone05
 /clone/clone06
 /clone/clone07
+/clone/clone08
 /close/close01
 /close/close02
 /close/close08
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
new file mode 100644
index 0000000..1c49888
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -0,0 +1,301 @@
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
+#include <sched.h>
+#include <sys/wait.h>
+#include "test.h"
+#include "usctest.h"
+#include "clone_platform.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+
+#define PASS		0
+#define FAIL		1
+
+static pid_t parent_ppid;
+static pid_t ptid, ctid;
+static pid_t tgid;
+static void *child_stack;
+static int tst_result;
+
+static void setup(void);
+static void cleanup(void);
+static void do_master_child_setup(void);
+static void do_master_child(void);
+
+static int child_clone_parent(void);
+static void wait_process_terminated(int pid);
+static int child_clone_child_settid(void);
+static int child_clone_parent_settid(void);
+static int child_clone_thread(void);
+
+#ifdef CLONE_STOPPED
+static int stopped_flag;
+static void test_clone_stopped(int tid);
+static int child_clone_stopped(void);
+#endif
+
+static struct test_case {
+	char *name;
+	int flags;
+	void (*testfunc)(int);
+	int (*do_child)();
+} test_cases[] = {
+	{"CLONE_PARENT", CLONE_PARENT | CLONE_VM | SIGCHLD, NULL,
+	 child_clone_parent},
+	{"CLONE_CHILD_SETTID", CLONE_CHILD_SETTID | CLONE_VM | SIGCHLD, NULL,
+	 child_clone_child_settid},
+	{"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | CLONE_VM | SIGCHLD, NULL,
+	 child_clone_parent_settid},
+#ifdef CLONE_STOPPED
+	{"CLONE_STOPPED", CLONE_STOPPED | CLONE_VM | SIGCHLD,
+	 test_clone_stopped, child_clone_stopped},
+#endif
+	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM | SIGCHLD,
+	 NULL, child_clone_thread},
+};
+
+char *TCID = "clone08";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static struct tst_checkpoint checkpoint;
+
+int main(int ac, char **av)
+{
+	char *msg;
+	pid_t child_pid;
+	pid_t exit_child_pid;
+	int status;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	child_pid = FORK_OR_VFORK();
+	if (child_pid < 0) {
+		tst_brkm(TBROK, cleanup, "Fork failed");
+	} else if (child_pid == 0) {
+		do_master_child();
+	} else {
+		/* wait child and CLONE_PARENT */
+		while (1) {
+			exit_child_pid = waitpid(-1, &status, WNOHANG);
+			if (exit_child_pid == -1) {
+				break;
+			} else if (exit_child_pid == 0) {
+				sched_yield();
+				usleep(1000);
+			} else {
+				if (!WIFEXITED(status) ||
+				    (WEXITSTATUS(status) != 0)) {
+					tst_resm(TFAIL,
+						 "son process exits error");
+				}
+			}
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void do_master_child_setup(void)
+{
+	parent_ppid = getppid();
+
+	tgid = getpid();
+
+	TST_CHECKPOINT_INIT(&checkpoint);
+}
+
+static void do_master_child(void)
+{
+	int lc;
+	int i;
+	int status;
+
+	do_master_child_setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+#ifdef CLONE_STOPPED
+		stopped_flag = 0;
+#endif
+		for (i = 0; i < TST_TOTAL; i++) {
+			tst_result = FAIL;
+
+			TEST(ltp_clone(test_cases[i].flags,
+			     test_cases[i].do_child, NULL, CHILD_STACK_SIZE,
+			     child_stack, &ptid, NULL, &ctid));
+
+			if (TEST_RETURN == -1) {
+				tst_resm(TFAIL | TTERRNO, "%s clone() failed",
+					 test_cases[i].name);
+				continue;
+			}
+
+			if (test_cases[i].testfunc != NULL)
+				test_cases[i].testfunc(TEST_RETURN);
+
+			if (test_cases[i].flags & CLONE_PARENT) {
+				wait_process_terminated(TEST_RETURN);
+			} else if (test_cases[i].flags & CLONE_THREAD) {
+				TST_CHECKPOINT_PARENT_WAIT(NULL,
+							   &checkpoint);
+			} else {
+				if (wait(&status) == -1) {
+					tst_brkm(TBROK | TERRNO, NULL,
+						 "wait failed, status: %d",
+						 status);
+				}
+			}
+
+			if (tst_result == PASS) {
+				tst_resm(TPASS, "test %s success",
+					 test_cases[i].name);
+			} else {
+				tst_resm(TFAIL, "test %s fail",
+					 test_cases[i].name);
+			}
+		}
+	}
+
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
+	child_stack = SAFE_MALLOC(cleanup, CHILD_STACK_SIZE);
+}
+
+static void cleanup(void)
+{
+	free(child_stack);
+
+	tst_rmdir();
+
+	TEST_CLEANUP;
+}
+
+static int child_clone_parent(void)
+{
+	if (parent_ppid == getppid())
+		tst_result = PASS;
+	else
+		tst_result = FAIL;
+	exit(0);
+}
+
+/*
+ * for CLONE_PARENT thread, the calling process can't get its
+ * status using wait(2), so here using kill(pid, 0) to ensure
+ * the CLONE_PARENT thread does not exist.
+ */
+static void wait_process_terminated(int pid)
+{
+	int ret;
+
+	while (1) {
+		ret = kill(pid, 0);
+		if (ret == 0) {
+			sched_yield();
+			usleep(1000);
+			continue;
+		}
+		if (errno == ESRCH)
+			break;
+	}
+}
+
+static int child_clone_child_settid(void)
+{
+	if (ctid == getpid())
+		tst_result = PASS;
+	else
+		tst_result = FAIL;
+
+	exit(tst_result);
+}
+
+static int child_clone_parent_settid(void)
+{
+	if (ptid == getpid())
+		tst_result = PASS;
+	else
+		tst_result = FAIL;
+
+	exit(tst_result);
+}
+
+#ifdef CLONE_STOPPED
+static void test_clone_stopped(int tid)
+{
+	int i;
+
+	/* give the kernel scheduler chance to run the CLONE_STOPPED thread*/
+	for (i = 0; i < 100; i++) {
+		sched_yield();
+		usleep(1000);
+	}
+	/*
+	 * if stopped_flag is not changed in the above time interval,
+	 * we think the CLONE_STOPPED thread is stopped.
+	 */
+	if (stopped_flag == 1)
+		tst_result = FAIL;
+	else
+		tst_result = PASS;
+
+	if (kill(tid, SIGCONT) != 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "kill SIGCONT failed");
+}
+
+static int child_clone_stopped(void)
+{
+	stopped_flag = 1;
+	exit(tst_result);
+}
+#endif
+
+static int child_clone_thread(void)
+{
+	if (tgid == getpid())
+		tst_result = PASS;
+	else
+		tst_result = FAIL;
+
+	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
+
+	ltp_syscall(__NR_exit);
+	return 0;
+}
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

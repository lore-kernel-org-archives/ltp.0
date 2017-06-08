From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  8 Jun 2017 12:57:30 +0300
Subject: [LTP] [PATCH v2 1/2] clone08: convert to new LTP API
Message-ID: <1496915851-5222-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In addition:
* use tst_reap_children()

* remove usage of tst_tmpdir()

* change behaviour in CLONE_STOPPED test-case: set flag after
  clone() and before kill() to make sure the thread updated
  this flag after the signal is sent

* define clone functions with 'void *arg'

* exit forked children with _exit()

* add test-case for CLONE_CHILD_CLEARTID flag.
  Set CLONE_CHILD_CLEARTID in 'CLONE_THREAD' test-case to
  clear ctid when the child clone exits. Use futex to wait
  for ctid to be changed.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: * move tst_res() to child function where possible
    * merge the patch with CLEARTID test-case
    * remove TCID field

 testcases/kernel/syscalls/clone/clone08.c |  264 +++++++++++------------------
 1 files changed, 97 insertions(+), 167 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 4c71db4..958755a 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
  * Copyright (c) 2013 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  *
@@ -15,39 +16,36 @@
  */
 
 #define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
 #include <errno.h>
 #include <sched.h>
 #include <sys/wait.h>
-#include "test.h"
+#include <linux/futex.h>
+
+#include "tst_test.h"
 #include "clone_platform.h"
-#include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
-char *TCID = "clone08";
-
 static pid_t ptid, ctid, tgid;
 static void *child_stack;
 
-static void setup(void);
-static void cleanup(void);
-
 static void test_clone_parent(int t);
-static int child_clone_parent(void);
+static int child_clone_parent(void *);
 static pid_t parent_ppid;
 
 static void test_clone_tid(int t);
-static int child_clone_child_settid(void);
-static int child_clone_parent_settid(void);
+static int child_clone_child_settid(void *);
+static int child_clone_parent_settid(void *);
 
 #ifdef CLONE_STOPPED
 static void test_clone_stopped(int t);
-static int child_clone_stopped(void);
+static int child_clone_stopped(void *);
 static int stopped_flag;
 #endif
 
 static void test_clone_thread(int t);
-static int child_clone_thread(void);
-static int tst_result;
+static int child_clone_thread(void *);
 
 /*
  * Children cloned with CLONE_VM should avoid using any functions that
@@ -61,7 +59,7 @@ static struct test_case {
 	char *name;
 	int flags;
 	void (*testfunc)(int);
-	int (*do_child)();
+	int (*do_child)(void *);
 } test_cases[] = {
 	{"CLONE_PARENT", CLONE_PARENT | SIGCHLD,
 	 test_clone_parent, child_clone_parent},
@@ -73,154 +71,91 @@ static struct test_case {
 	{"CLONE_STOPPED", CLONE_STOPPED | CLONE_VM | SIGCHLD,
 	 test_clone_stopped, child_clone_stopped},
 #endif
-	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM | SIGCHLD,
+	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM |
+	 CLONE_CHILD_CLEARTID | SIGCHLD,
 	 test_clone_thread, child_clone_thread},
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
+static void do_test(unsigned int i)
 {
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++) {
-			tst_resm(TINFO, "running %s", test_cases[i].name);
-			test_cases[i].testfunc(i);
-		}
-	}
-	cleanup();
-	tst_exit();
+	tst_res(TINFO, "running %s", test_cases[i].name);
+	test_cases[i].testfunc(i);
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	child_stack = SAFE_MALLOC(cleanup, CHILD_STACK_SIZE);
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
 }
 
 static void cleanup(void)
 {
 	free(child_stack);
-
-	tst_rmdir();
 }
 
-static long clone_child(const struct test_case *t, int use_tst)
+static long clone_child(const struct test_case *t)
 {
 	TEST(ltp_clone7(t->flags, t->do_child, NULL, CHILD_STACK_SIZE,
 		child_stack, &ptid, NULL, &ctid));
 
 	if (TEST_RETURN == -1 && TTERRNO == ENOSYS)
-		tst_brkm(TCONF, cleanup, "clone does not support 7 args");
-
-	if (TEST_RETURN == -1) {
-		if (use_tst) {
-			tst_brkm(TBROK | TTERRNO, cleanup, "%s clone() failed",
-				 t->name);
-		} else {
-			printf("%s clone() failed, errno: %d",
-			       t->name, TEST_ERRNO);
-			exit(1);
-		}
-	}
-	return TEST_RETURN;
-}
+		tst_brk(TCONF, "clone does not support 7 args");
 
-static int wait4child(pid_t child)
-{
-	int status;
+	if (TEST_RETURN == -1)
+		tst_brk(TBROK | TTERRNO, "%s clone() failed", t->name);
 
-	if (waitpid(child, &status, 0) == -1)
-		tst_resm(TBROK|TERRNO, "waitpid");
-	if (WIFEXITED(status))
-		return WEXITSTATUS(status);
-	else
-		return status;
+	return TEST_RETURN;
 }
 
 static void test_clone_parent(int t)
 {
-	int status;
 	pid_t child;
 
-	fflush(stdout);
-	child = FORK_OR_VFORK();
-	switch (child) {
-	case 0:
+	child = SAFE_FORK();
+	if (!child) {
 		parent_ppid = getppid();
-		clone_child(&test_cases[t], 0);
-		exit(0);
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "test_clone_parent fork");
-	default:
-		status = wait4child(child);
-		if (status == 0) {
-			/* wait for CLONE_PARENT child */
-			status = wait4child(-1);
-			if (status == 0) {
-				tst_resm(TPASS, "test %s", test_cases[t].name);
-			} else {
-				tst_resm(TFAIL, "test %s, status: %d",
-					 test_cases[t].name, status);
-			}
-		} else {
-			tst_resm(TFAIL, "test %s, status: %d",
-				 test_cases[t].name, status);
-		}
-	};
+		clone_child(&test_cases[t]);
+		_exit(0);
+	}
+	tst_reap_children();
 }
 
-static int child_clone_parent(void)
+static int child_clone_parent(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	if (parent_ppid == getppid())
-		exit(0);
-	printf("FAIL: getppid != parent_ppid (%d != %d)\n",
-	       parent_ppid, getppid());
-	exit(1);
+	if (parent_ppid == getppid()) {
+		tst_res(TPASS, "clone and forked child has the same parent");
+	} else {
+		tst_res(TFAIL, "getppid != parent_ppid (%d != %d)",
+			parent_ppid, getppid());
+	}
+	tst_syscall(__NR_exit, 0);
+	return 0;
 }
 
 static void test_clone_tid(int t)
 {
-	int status;
 	pid_t child;
 
-	child = clone_child(&test_cases[t], 1);
-	status = wait4child(child);
-	if (status == 0) {
-		tst_resm(TPASS, "test %s", test_cases[t].name);
-	} else {
-		tst_resm(TFAIL, "test %s, status: %d",
-			 test_cases[t].name, status);
-	}
+	child = clone_child(&test_cases[t]);
+	tst_reap_children();
 }
 
-static int child_clone_child_settid(void)
+static int child_clone_child_settid(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	if (ctid == ltp_syscall(__NR_getpid))
-		ltp_syscall(__NR_exit, 0);
-	printf("FAIL: ctid != getpid() (%d != %d)\n",
-	       ctid, getpid());
-	ltp_syscall(__NR_exit, 1);
+	if (ctid == tst_syscall(__NR_getpid))
+		tst_res(TPASS, "clone() correctly set ctid");
+	else
+		tst_res(TFAIL, "ctid != getpid() (%d != %d)", ctid, getpid());
+	tst_syscall(__NR_exit, 0);
 	return 0;
 }
 
-static int child_clone_parent_settid(void)
+static int child_clone_parent_settid(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	if (ptid == ltp_syscall(__NR_getpid))
-		ltp_syscall(__NR_exit, 0);
-	printf("FAIL: ptid != getpid() (%d != %d)\n",
-	       ptid, getpid());
-	ltp_syscall(__NR_exit, 1);
+	if (ptid == tst_syscall(__NR_getpid))
+		tst_res(TPASS, "clone() correctly set ptid");
+	else
+		tst_res(TFAIL, "ptid != getpid() (%d != %d)", ptid, getpid());
+	tst_syscall(__NR_exit, 0);
 	return 0;
 }
 
@@ -228,17 +163,14 @@ static int child_clone_parent_settid(void)
 static void test_clone_stopped(int t)
 {
 	int i;
-	int status;
-	int flag;
 	pid_t child;
 
 	if (tst_kvercmp(2, 6, 38) >= 0) {
-		tst_resm(TINFO, "CLONE_STOPPED skipped for kernels >= 2.6.38");
+		tst_res(TCONF, "CLONE_STOPPED skipped for kernels >= 2.6.38");
 		return;
 	}
 
-	stopped_flag = 0;
-	child = clone_child(&test_cases[t], 1);
+	child = clone_child(&test_cases[t]);
 
 	/* give the kernel scheduler chance to run the CLONE_STOPPED thread*/
 	for (i = 0; i < 100; i++) {
@@ -246,23 +178,22 @@ static void test_clone_stopped(int t)
 		usleep(1000);
 	}
 
-	flag = stopped_flag;
-	if (kill(child, SIGCONT) != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "kill SIGCONT failed");
+	stopped_flag = 0;
 
-	status = wait4child(child);
-	if (status == 0 && flag == 0) {
-		tst_resm(TPASS, "test %s", test_cases[t].name);
-	} else {
-		tst_resm(TFAIL, "test %s, status: %d, flag: %d",
-			 test_cases[t].name, status, flag);
-	}
+	SAFE_KILL(child, SIGCONT);
+
+	tst_reap_children();
+
+	if (stopped_flag == 1)
+		tst_res(TPASS, "clone stopped and resumed as expected");
+	else
+		tst_res(TFAIL, "clone not stopped, flag %d", stopped_flag);
 }
 
-static int child_clone_stopped(void)
+static int child_clone_stopped(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	stopped_flag = 1;
-	ltp_syscall(__NR_exit, 0);
+	tst_syscall(__NR_exit, 0);
 	return 0;
 }
 #endif
@@ -270,42 +201,41 @@ static int child_clone_stopped(void)
 static void test_clone_thread(int t)
 {
 	pid_t child;
-	int i, status;
-
-	fflush(stdout);
-	child = FORK_OR_VFORK();
-	switch (child) {
-	case 0:
-		tgid = ltp_syscall(__NR_getpid);
-		tst_result = -1;
-		clone_child(&test_cases[t], 0);
-
-		for (i = 0; i < 5000; i++) {
-			sched_yield();
-			usleep(1000);
-			if (tst_result != -1)
-				break;
-		}
-		ltp_syscall(__NR_exit, tst_result);
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "test_clone_thread fork");
-	default:
-		status = wait4child(child);
-		if (status == 0) {
-			tst_resm(TPASS, "test %s", test_cases[t].name);
-		} else {
-			tst_resm(TFAIL, "test %s, status: %d",
-				 test_cases[t].name, status);
-		}
-	};
+
+	child = SAFE_FORK();
+	if (!child) {
+		struct timespec timeout = { 5 /* sec */, 0 };
+
+		tgid = tst_syscall(__NR_getpid);
+		ctid = -1;
+
+		clone_child(&test_cases[t]);
+
+		if (syscall(SYS_futex, &ctid, FUTEX_WAIT, -1, &timeout))
+			tst_res(TFAIL | TERRNO, "futex failed");
+		else
+			tst_res(TPASS, "futex exit on ctid change");
+
+		_exit(0);
+	}
+
+	tst_reap_children();
 }
 
-static int child_clone_thread(void)
+static int child_clone_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	if (tgid == ltp_syscall(__NR_getpid))
-		tst_result = TPASS;
+	if (tgid == tst_syscall(__NR_getpid))
+		tst_res(TPASS, "clone has the same thread id");
 	else
-		tst_result = TFAIL;
-	ltp_syscall(__NR_exit, 0);
+		tst_res(TFAIL, "clone's thread id not equal parent's id");
+	tst_syscall(__NR_exit, 0);
 	return 0;
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1
+};
-- 
1.7.1


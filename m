From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 17 Apr 2017 18:44:52 +0300
Subject: [LTP] [PATCH 1/3] clone08: convert to new LTP API
Message-ID: <1492443894-3127-1-git-send-email-alexey.kodanev@oracle.com>
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/clone/clone08.c |  199 +++++++++++------------------
 1 files changed, 77 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 4c71db4..8bc2850 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
  * Copyright (c) 2013 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  *
@@ -15,38 +16,35 @@
  */
 
 #define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
 #include <errno.h>
 #include <sched.h>
 #include <sys/wait.h>
-#include "test.h"
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
+static int child_clone_thread(void *);
 static int tst_result;
 
 /*
@@ -61,7 +59,7 @@ static struct test_case {
 	char *name;
 	int flags;
 	void (*testfunc)(int);
-	int (*do_child)();
+	int (*do_child)(void *);
 } test_cases[] = {
 	{"CLONE_PARENT", CLONE_PARENT | SIGCHLD,
 	 test_clone_parent, child_clone_parent},
@@ -77,42 +75,20 @@ static struct test_case {
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
 
 static long clone_child(const struct test_case *t, int use_tst)
@@ -121,16 +97,16 @@ static long clone_child(const struct test_case *t, int use_tst)
 		child_stack, &ptid, NULL, &ctid));
 
 	if (TEST_RETURN == -1 && TTERRNO == ENOSYS)
-		tst_brkm(TCONF, cleanup, "clone does not support 7 args");
+		tst_brk(TCONF, "clone does not support 7 args");
 
 	if (TEST_RETURN == -1) {
 		if (use_tst) {
-			tst_brkm(TBROK | TTERRNO, cleanup, "%s clone() failed",
+			tst_brk(TBROK | TTERRNO, "%s clone() failed",
 				 t->name);
 		} else {
 			printf("%s clone() failed, errno: %d",
 			       t->name, TEST_ERRNO);
-			exit(1);
+			_exit(1);
 		}
 	}
 	return TEST_RETURN;
@@ -140,8 +116,8 @@ static int wait4child(pid_t child)
 {
 	int status;
 
-	if (waitpid(child, &status, 0) == -1)
-		tst_resm(TBROK|TERRNO, "waitpid");
+	SAFE_WAITPID(child, &status, 0);
+
 	if (WIFEXITED(status))
 		return WEXITSTATUS(status);
 	else
@@ -150,77 +126,55 @@ static int wait4child(pid_t child)
 
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
 		clone_child(&test_cases[t], 0);
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
+		_exit(0);
+	}
+	tst_reap_children();
+	tst_res(TPASS, "clone and forked child has the same parent");
 }
 
-static int child_clone_parent(void)
+static int child_clone_parent(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	if (parent_ppid == getppid())
-		exit(0);
+		tst_syscall(__NR_exit, 0);
 	printf("FAIL: getppid != parent_ppid (%d != %d)\n",
 	       parent_ppid, getppid());
-	exit(1);
+	tst_syscall(__NR_exit, 1);
+	return 0;
 }
 
 static void test_clone_tid(int t)
 {
-	int status;
 	pid_t child;
 
 	child = clone_child(&test_cases[t], 1);
-	status = wait4child(child);
-	if (status == 0) {
-		tst_resm(TPASS, "test %s", test_cases[t].name);
-	} else {
-		tst_resm(TFAIL, "test %s, status: %d",
-			 test_cases[t].name, status);
-	}
+
+	tst_reap_children();
+	tst_res(TPASS, "clone() correctly set ptid/ctid");
 }
 
-static int child_clone_child_settid(void)
+static int child_clone_child_settid(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	if (ctid == ltp_syscall(__NR_getpid))
-		ltp_syscall(__NR_exit, 0);
+	if (ctid == tst_syscall(__NR_getpid))
+		tst_syscall(__NR_exit, 0);
 	printf("FAIL: ctid != getpid() (%d != %d)\n",
 	       ctid, getpid());
-	ltp_syscall(__NR_exit, 1);
+	tst_syscall(__NR_exit, 1);
 	return 0;
 }
 
-static int child_clone_parent_settid(void)
+static int child_clone_parent_settid(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	if (ptid == ltp_syscall(__NR_getpid))
-		ltp_syscall(__NR_exit, 0);
+	if (ptid == tst_syscall(__NR_getpid))
+		tst_syscall(__NR_exit, 0);
 	printf("FAIL: ptid != getpid() (%d != %d)\n",
 	       ptid, getpid());
-	ltp_syscall(__NR_exit, 1);
+	tst_syscall(__NR_exit, 1);
 	return 0;
 }
 
@@ -228,16 +182,13 @@ static int child_clone_parent_settid(void)
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
 	child = clone_child(&test_cases[t], 1);
 
 	/* give the kernel scheduler chance to run the CLONE_STOPPED thread*/
@@ -246,23 +197,22 @@ static void test_clone_stopped(int t)
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
@@ -272,10 +222,8 @@ static void test_clone_thread(int t)
 	pid_t child;
 	int i, status;
 
-	fflush(stdout);
-	child = FORK_OR_VFORK();
-	switch (child) {
-	case 0:
+	child = SAFE_FORK();
+	if (!child) {
 		tgid = ltp_syscall(__NR_getpid);
 		tst_result = -1;
 		clone_child(&test_cases[t], 0);
@@ -286,26 +234,33 @@ static void test_clone_thread(int t)
 			if (tst_result != -1)
 				break;
 		}
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
+		_exit(tst_result);
+	}
+
+	status = wait4child(child);
+	if (status == 0) {
+		tst_res(TPASS, "test %s", test_cases[t].name);
+	} else {
+		tst_res(TFAIL, "test %s, status: %d",
+			test_cases[t].name, status);
+	}
 }
 
-static int child_clone_thread(void)
+static int child_clone_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	if (tgid == ltp_syscall(__NR_getpid))
+	if (tgid == tst_syscall(__NR_getpid))
 		tst_result = TPASS;
 	else
 		tst_result = TFAIL;
-	ltp_syscall(__NR_exit, 0);
+	tst_syscall(__NR_exit, 0);
 	return 0;
 }
+
+static struct tst_test test = {
+	.tid = "clone08",
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1
+};
-- 
1.7.1


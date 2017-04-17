From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 17 Apr 2017 18:44:53 +0300
Subject: [LTP] [PATCH 2/3] clone08: add test-case for CLONE_CHILD_CLEARTID
	flag
In-Reply-To: <1492443894-3127-1-git-send-email-alexey.kodanev@oracle.com>
References: <1492443894-3127-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1492443894-3127-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Set CLONE_CHILD_CLEARTID in 'CLONE_THREAD' test-case to clear ctid
when the child clone exits. Use futex to wait for ctid to be changed.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/clone/clone08.c |   39 ++++++++++++++++++----------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index 8bc2850..dcc87b8 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -21,6 +21,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <sys/wait.h>
+#include <linux/futex.h>
 
 #include "tst_test.h"
 #include "clone_platform.h"
@@ -71,7 +72,8 @@ static struct test_case {
 	{"CLONE_STOPPED", CLONE_STOPPED | CLONE_VM | SIGCHLD,
 	 test_clone_stopped, child_clone_stopped},
 #endif
-	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM | SIGCHLD,
+	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM |
+	 CLONE_CHILD_CLEARTID | SIGCHLD,
 	 test_clone_thread, child_clone_thread},
 };
 
@@ -220,29 +222,38 @@ static int child_clone_stopped(void *arg LTP_ATTRIBUTE_UNUSED)
 static void test_clone_thread(int t)
 {
 	pid_t child;
-	int i, status;
+	int status;
 
 	child = SAFE_FORK();
 	if (!child) {
-		tgid = ltp_syscall(__NR_getpid);
-		tst_result = -1;
+		struct timespec timeout = { 5 /* sec */, 0 };
+
+		tgid = tst_syscall(__NR_getpid);
+		ctid = tst_result = -1;
+
 		clone_child(&test_cases[t], 0);
 
-		for (i = 0; i < 5000; i++) {
-			sched_yield();
-			usleep(1000);
-			if (tst_result != -1)
-				break;
+		if (syscall(SYS_futex, &ctid, FUTEX_WAIT, -1, &timeout) &&
+		    errno == ETIMEDOUT) {
+			_exit(TBROK);
 		}
+
 		_exit(tst_result);
 	}
 
 	status = wait4child(child);
-	if (status == 0) {
-		tst_res(TPASS, "test %s", test_cases[t].name);
-	} else {
-		tst_res(TFAIL, "test %s, status: %d",
-			test_cases[t].name, status);
+	switch (status) {
+	case TPASS:
+		tst_res(TPASS, "clone has the same thread id");
+	break;
+	case TFAIL:
+		tst_res(TFAIL, "clone's thread id not equal parent's id");
+	break;
+	case TBROK:
+		tst_res(TFAIL, "futex returned ETIMEDOUT");
+	break;
+	default:
+		tst_res(TFAIL, "unexpected status received: %d", status);
 	}
 }
 
-- 
1.7.1


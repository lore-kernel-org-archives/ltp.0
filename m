From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Feb 2021 16:37:11 +0100
Subject: [LTP] [PATCH] syscalls/getpid02: Also check the fork() retval
Message-ID: <20210226153711.13645-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The return value from fork() in parent must be equal to getpid() in child.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/getpid/getpid02.c | 40 ++++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 6bd9c946f..815ce985f 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -6,13 +6,17 @@
 /*\
  * [DESCRIPTION]
  *
- * Check that getppid() in child returns the same pid as getpid() in parent.
+ * Check that:
+ * - fork() in parent returns the same pid as getpid() in child
+ * - getppid() in child returns the same pid as getpid() in parent
 \*/
 
 #include <errno.h>
 
 #include "tst_test.h"
 
+static pid_t *child_pid;
+
 static void verify_getpid(void)
 {
 	pid_t proc_id;
@@ -21,18 +25,44 @@ static void verify_getpid(void)
 
 	proc_id = getpid();
 	pid = SAFE_FORK();
+
 	if (pid == 0) {
 		pproc_id = getppid();
 
-		if (pproc_id != proc_id)
-			tst_res(TFAIL, "child's ppid(%d) not equal to parent's pid(%d)",
+		if (pproc_id != proc_id) {
+			tst_res(TFAIL, "child getppid() (%d) != parent getpid() (%d)",
 				pproc_id, proc_id);
-		else
-			tst_res(TPASS, "getpid() functionality is correct");
+		} else {
+			tst_res(TPASS, "child getppid() == parent getpid() (%d)", proc_id);
+		}
+
+		*child_pid = getpid();
+
+		return;
 	}
+
+	tst_reap_children();
+
+	if (*child_pid != pid)
+		tst_res(TFAIL, "child getpid() (%d) != parent fork() (%d)", *child_pid, pid);
+	else
+		tst_res(TPASS, "child getpid() == parent fork() (%d)", pid);
+}
+
+static void setup(void)
+{
+	child_pid = SAFE_MMAP(NULL, sizeof(pid_t), PROT_READ | PROT_WRITE,
+                              MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(child_pid, sizeof(pid_t));
 }
 
 static struct tst_test test = {
 	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = verify_getpid,
 };
-- 
2.26.2


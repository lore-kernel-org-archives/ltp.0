From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue,  7 Sep 2021 19:35:10 +0800
Subject: [LTP] [PATCH v3] syscalls/clone01: Convert to new API
Message-ID: <20210907113510.7431-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/clone/clone01.c b/testcases/kernel/syscalls/clone/clone01.c
index e490b4e77..9601f6670 100644
--- a/testcases/kernel/syscalls/clone/clone01.c
+++ b/testcases/kernel/syscalls/clone/clone01.c
@@ -1,90 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  * Copyright (c) 2012 Wanlong Gao <gaowanlong@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */

-/*
- *	This is a test for the clone(2) system call.
- *	It is intended to provide a limited exposure of the system call.
+/*\
+ * [Description]
+ *
+ * Basic clone() test.
+ *
+ * Use clone() to create a child process, and wait for the child process to exit,
+ * verify that the child process pid is correct.
  */

-#if defined UCLINUX && !__THROW
-/* workaround for libc bug */
-#define __THROW
-#endif
-
-#include <errno.h>
-#include <sched.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
+#include "tst_test.h"
 #include "clone_platform.h"

-static void setup(void);
-static void cleanup(void);
-static int do_child();
+static void *child_stack;

-char *TCID = "clone01";
-int TST_TOTAL = 1;
+static int do_child(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	exit(0);
+}

-int main(int ac, char **av)
+static void verify_clone(void)
 {
-	void *child_stack;
 	int status, child_pid;

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, do_child, NULL,
+		CHILD_STACK_SIZE, child_stack), "clone()");

-	child_stack = malloc(CHILD_STACK_SIZE);
-	if (child_stack == NULL)
-		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
+	child_pid = SAFE_WAIT(&status);

-	tst_count = 0;
-
-	TEST(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE, child_stack));
-	if (TEST_RETURN == -1)
-		tst_resm(TFAIL | TTERRNO, "clone failed");
-
-	child_pid = SAFE_WAIT(cleanup, &status);
-
-	if (TEST_RETURN == child_pid)
-		tst_resm(TPASS, "clone returned %ld", TEST_RETURN);
+	if (child_pid == TST_RET)
+		tst_res(TPASS, "clone returned %ld", TST_RET);
 	else
-		tst_resm(TFAIL, "clone returned %ld, wait returned %d",
-			 TEST_RETURN, child_pid);
-
-	free(child_stack);
-
-	cleanup();
+		tst_res(TFAIL, "clone returned %ld, wait returned %d",
+			 TST_RET, child_pid);

-	tst_exit();
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		tst_res(TPASS, "Child exited with 0");
+	else
+		tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
 }

 static void cleanup(void)
 {
+	free(child_stack);
 }

-static int do_child(void)
-{
-	exit(0);
-}
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_clone,
+	.forks_child = 1,
+};
--
2.20.1




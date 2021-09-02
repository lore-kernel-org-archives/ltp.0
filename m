From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu,  2 Sep 2021 09:09:18 +0800
Subject: [LTP] [PATCH v2 4/7] syscalls/clone05: Convert to new API
Message-ID: <20210902010918.1164-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/clone/clone05.c b/testcases/kernel/syscalls/clone/clone05.c
index 494b772dd..e91602a80 100644
--- a/testcases/kernel/syscalls/clone/clone05.c
+++ b/testcases/kernel/syscalls/clone/clone05.c
@@ -1,103 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  * Copyright (c) 2012 Wanlong Gao <gaowanlong@cn.fujitsu.com>
  * Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
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
+/*\
+ * [Description]
  * Call clone() with CLONE_VFORK flag set. verify that
  * execution of parent is suspended until child finishes
  */

 #define _GNU_SOURCE

-#include <errno.h>
+#include <stdlib.h>
 #include <sched.h>
-#include <sys/wait.h>
-#include "test.h"
+#include "tst_test.h"
 #include "clone_platform.h"

-char *TCID = "clone05";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-static int child_fn(void *);
-
-static int child_exited = 0;
+static int child_exited;
+static void *child_stack;

-int main(int ac, char **av)
+static int child_fn(void *unused __attribute__((unused)))
 {
+	int i;

-	int lc, status;
-	void *child_stack;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	child_stack = malloc(CHILD_STACK_SIZE);
-	if (child_stack == NULL)
-		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
-		               CHILD_STACK_SIZE, child_stack));
-
-		if ((TEST_RETURN != -1) && (child_exited))
-			tst_resm(TPASS, "Test Passed");
-		else
-			tst_resm(TFAIL, "Test Failed");
+	for (i = 0; i < 100; i++) {
+		sched_yield();
+		usleep(1000);
+	}

-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "wait failed, status: %d", status);
+	child_exited = 1;
+	_exit(0);
+}

-		child_exited = 0;
-	}
+static void verify_clone(void)
+{
+	TST_EXP_POSITIVE(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
+					CHILD_STACK_SIZE, child_stack), "clone with vfork");

-	free(child_stack);
+	if (!TST_PASS)
+		return;

-	cleanup();
-	tst_exit();
+	TST_EXP_VAL(child_exited, 1);
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+	child_exited = 0;
 }

 static void cleanup(void)
 {
+	free(child_stack);
 }

-static int child_fn(void *unused __attribute__((unused)))
-{
-	int i;
-
-	/* give the kernel scheduler chance to run the parent */
-	for (i = 0; i < 100; i++) {
-		sched_yield();
-		usleep(1000);
-	}
-
-	child_exited = 1;
-	_exit(1);
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_clone,
+	.cleanup = cleanup,
+};
--
2.20.1




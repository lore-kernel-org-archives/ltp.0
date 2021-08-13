From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Fri, 13 Aug 2021 15:26:47 +0800
Subject: [LTP] [PATCH 4/7] syscalls/clone04: Convert to new API
Message-ID: <20210813072647.21802-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/clone/clone04.c b/testcases/kernel/syscalls/clone/clone04.c
index 647bde560..fba4f186c 100644
--- a/testcases/kernel/syscalls/clone/clone04.c
+++ b/testcases/kernel/syscalls/clone/clone04.c
@@ -1,110 +1,46 @@
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
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
  */
- /*
-  *     Verify that,
-  *      clone(2) returns -1 and sets errno to EINVAL if
-  *     child stack is set to a zero value(NULL)
-  */

-#if defined UCLINUX && !__THROW
-/* workaround for libc bug */
-#define __THROW
-#endif
+/*\
+ * [Description]
+ * Verify that,
+ * clone(2) returns -1 and sets errno to EINVAL if
+ * child stack is set to a zero value(NULL)
+ */

-#include <sched.h>
-#include <errno.h>
-#include <sys/wait.h>
-#include "test.h"
+#include <stdlib.h>
+#include "tst_test.h"
 #include "clone_platform.h"

-static void cleanup(void);
-static void setup(void);
-static int child_fn();
-
-static void *child_stack;
+static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED);

-static struct test_case_t {
-	int (*child_fn) ();
-	void **child_stack;
+static struct tcase {
+	int (*child_fn)(void *arg);
+	void *child_stack;
 	int exp_errno;
 	char err_desc[10];
-} test_cases[] = {
-	{
-child_fn, NULL, EINVAL, "EINVAL"},};
+} tcases[] = {
+	{child_fn, NULL, EINVAL, "EINVAL"},
+};

-char *TCID = "clone04";
-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
-
-int main(int ac, char **av)
+static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	int lc, ind;
-	void *test_stack;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (ind = 0; ind < TST_TOTAL; ind++) {
-			if (test_cases[ind].child_stack == NULL) {
-				test_stack = NULL;
-			} else if (*test_cases[ind].child_stack == NULL) {
-				tst_resm(TWARN, "Can not allocate stack for child, skipping test case");
-				continue;
-			} else {
-				test_stack = child_stack;
-			}
-
-			TEST(ltp_clone(0, test_cases[ind].child_fn, NULL,
-				       CHILD_STACK_SIZE, test_stack));
-
-			if ((TEST_RETURN == -1) &&
-			    (TEST_ERRNO == test_cases[ind].exp_errno)) {
-				tst_resm(TPASS, "expected failure; Got %s",
-					 test_cases[ind].err_desc);
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "Failed to produce expected error, expected errno: %d and result: -1, got result %ld",
-					 test_cases[ind].exp_errno, TEST_RETURN);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	exit(0);
 }

-static void setup(void)
+static void verify_clone(unsigned int nr)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	struct tcase *tc = &tcases[nr];

-	child_stack = malloc(CHILD_STACK_SIZE);
+	TST_EXP_FAIL(ltp_clone(0, tc->child_fn, NULL,
+				CHILD_STACK_SIZE, tc->child_stack),
+				tc->exp_errno, "%s", tc->err_desc);
 }

-static void cleanup(void)
-{
-	free(child_stack);
-}
-
-static int child_fn(void)
-{
-	exit(1);
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_clone,
+};
\ No newline at end of file
--
2.20.1




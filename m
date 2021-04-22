From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 22 Apr 2021 14:57:32 +0800
Subject: [LTP] [PATCH 2/2] syscalls/tkill: Convert tkill02 to the new API
In-Reply-To: <20210422065732.61222-1-xieziyao@huawei.com>
References: <20210422065732.61222-1-xieziyao@huawei.com>
Message-ID: <20210422065732.61222-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleanup and convert tkill02 to the new API.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/tkill/tkill02.c | 105 +++++++---------------
 1 file changed, 32 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
index 48431755b..20b461705 100644
--- a/testcases/kernel/syscalls/tkill/tkill02.c
+++ b/testcases/kernel/syscalls/tkill/tkill02.c
@@ -1,28 +1,18 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007                                   *
- *                                                                            *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or          *
- * (at your option) any later version.                                        *
- *                                                                            *
- * This program is distributed in the hope that it will be useful,            *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
- * the GNU General Public License for more details.                           *
- *                                                                            *
- * You should have received a copy of the GNU General Public License          *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *                                                                            *
- ******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * File:	tkill02.c
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Manas Kumar Nayak maknayak@in.ibm.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic tests for the tkill errors.
  *
- * Description: This tests the tkill() syscall
+ * [Algorithm]
  *
- * History:     Porting from Crackerjack to LTP is done by
- *              Manas Kumar Nayak maknayak@in.ibm.com>
+ * - EINVAL on an invalid thread ID
+ * - ESRCH when no process with the specified thread ID exists
  */

 #include <stdio.h>
@@ -32,66 +22,35 @@
 #include <signal.h>
 #include <sys/syscall.h>

-#include "test.h"
 #include "lapi/syscalls.h"
+#include "tst_test.h"

-char *TCID = "tkill02";
-int testno;
-
+static pid_t expired_pid;
 static pid_t inval_tid = -1;
-static pid_t unused_tid;
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
-
-void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-
-	unused_tid = tst_get_unused_pid(cleanup);
-}

 struct test_case_t {
 	int *tid;
 	int exp_errno;
-} test_cases[] = {
-	{&inval_tid, EINVAL},
-	{&unused_tid, ESRCH}
+	const char *desc;
+} tc[] = {
+	{&inval_tid, EINVAL, "inval_tid"},
+	{&expired_pid, ESRCH, "expired_pid"}
 };

-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int i;
-
-	setup();
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	for (i = 0; i < TST_TOTAL; i++) {
-
-		TEST(ltp_syscall(__NR_tkill, *(test_cases[i].tid), SIGUSR1));
+	expired_pid = tst_get_unused_pid();
+}

-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == test_cases[i].exp_errno) {
-				tst_resm(TPASS | TTERRNO,
-					 "tkill(%d, SIGUSR1) failed as expected",
-					 *(test_cases[i].tid));
-			} else {
-				tst_brkm(TFAIL | TTERRNO, cleanup,
-					 "tkill(%d, SIGUSR1) failed unexpectedly",
-					 *(test_cases[i].tid));
-			}
-		} else {
-			tst_brkm(TFAIL, cleanup,
-				 "tkill(%d) succeeded unexpectedly",
-				 *(test_cases[i].tid));
-		}
-	}
-	cleanup();
-	tst_exit();
+static void run(unsigned int i)
+{
+	TST_EXP_FAIL(tst_syscall(__NR_tkill, *(tc[i].tid), SIGUSR1),
+		     tc[i].exp_errno, "tst_syscall(__NR_tkill, %s)", tc[i].desc);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test = run,
+};
--
2.17.1


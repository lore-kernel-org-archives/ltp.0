From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 16 Jun 2021 17:36:06 +0800
Subject: [LTP] [PATCH 3/3] syscalls/getrusage: Convert getrusage01 to the
 new API
In-Reply-To: <20210616093606.214856-1-xieziyao@huawei.com>
References: <20210616093606.214856-1-xieziyao@huawei.com>
Message-ID: <20210616093606.214856-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert getrusage01 to the new API.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/getrusage/getrusage01.c   | 132 +++---------------
 1 file changed, 23 insertions(+), 109 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage01.c b/testcases/kernel/syscalls/getrusage/getrusage01.c
index ef8df586d..628726907 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage01.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage01.c
@@ -1,120 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
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
+ * AUTHOR: Saji Kumar.V.R <saji.kumar@wipro.com>
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: getrusage01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for getrusage(2)
- *
- *    TEST CASE TOTAL	: 2
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the getrusage(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  if return code == 0
- *		Test Passed
- *	  else
- *		Test Failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  getrusage01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f]
- * 			     [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
- ****************************************************************/
-
-#include <errno.h>
-#include <sched.h>
-#include <sys/resource.h>
-#include "test.h"
-
-static void setup();
-static void cleanup();

-char *TCID = "getrusage01";
-int who[2] = { RUSAGE_SELF, RUSAGE_CHILDREN };
-
-int TST_TOTAL = 2;
-
-int main(int ac, char **av)
-{
-
-	int lc, i;
-	struct rusage usage;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(getrusage(who[i], &usage));
+/*\
+ * [Description]
+ *
+ * Test that getrusage() with RUSAGE_SELF and RUSAGE_CHILDREN succeeds.
+ */

-			if (TEST_RETURN == 0)
-				tst_resm(TPASS, "getrusage passed");
-			else
-				tst_resm(TFAIL | TTERRNO, "getrusage failed");
-		}
-	}
+#include "tst_test.h"

-	cleanup();
-	tst_exit();
+struct rusage usage;

-}
+struct test_case_t {
+	int who;
+	char *desc;
+} tc[] = {
+	{RUSAGE_SELF, "RUSAGE_SELF"},
+	{RUSAGE_CHILDREN, "RUSAGE_CHILDREN"},
+};

-void setup(void)
+static void run(unsigned int i)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
+	TST_EXP_PASS(getrusage(tc[i].who, &usage), "getrusage(%s, &usage)", tc[i].desc);
 }

-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
+};
--
2.17.1


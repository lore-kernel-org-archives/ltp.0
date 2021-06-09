From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Wed,  9 Jun 2021 23:05:54 +0530
Subject: [LTP] [PATCH v2 03/10] getrusage02: Convert getrusage02 to new API
In-Reply-To: <20210609173601.29352-1-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
Message-ID: <20210609173601.29352-3-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/getrusage/getrusage02.c   | 142 ++++--------------
 1 file changed, 27 insertions(+), 115 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c b/testcases/kernel/syscalls/getrusage/getrusage02.c
index 8077606a2..c4b3f0f69 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -1,86 +1,29 @@
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
+ * AUTHOR : Saji Kumar.V.R <saji.kumar@wipro.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: getrusage02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Tests for error conditions
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
- *	Verify that
- *	1) getrusage() fails with errno EINVAL when an invalid value
- *	   is given for who
- *	2) getrusage() fails with errno EFAULT when an invalid address
- *	   is given for usage
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  if call failed with expected errno,
- *		Test Passed
- *	  else
- *		Test Failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
+
+/*\
+ *[Description]
  *
- * USAGE:  <for command-line>
- *  getrusage02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f]
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
+ * Verify that
+ * 1) getrusage() fails with errno EINVAL when an invalid value
+ *   is given for who
+ * 2) getrusage() fails with errno EFAULT when an invalid address
+ *   is given for usage
  *
- ****************************************************************/
+ */
 
 #include <errno.h>
 #include <sched.h>
 #include <sys/resource.h>
-#include "test.h"
+#include "tst_test.h"
 
 #ifndef RUSAGE_BOTH		/* Removed from user space on RHEL4 */
 #define RUSAGE_BOTH (-2)	/* still works on SuSE      */
 #endif /* so this is a work around */
 
-static void setup();
-static void cleanup();
-
-char *TCID = "getrusage02";
-
 static struct rusage usage;
 
 struct test_cases_t {
@@ -90,56 +33,25 @@ struct test_cases_t {
 } test_cases[] = {
 	{
 	RUSAGE_BOTH, &usage, EINVAL},
-#ifndef UCLINUX
 	{
 	RUSAGE_SELF, (struct rusage *)-1, EFAULT}
-#endif
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
+static void verify_getrusage(unsigned int i)
 {
-
-	int lc, i;
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
-			TEST(getrusage(test_cases[i].who, test_cases[i].usage));
-
-			if (TEST_RETURN == -1 &&
-			    TEST_ERRNO == test_cases[i].exp_errno)
-				tst_resm(TPASS | TTERRNO,
-					 "getrusage failed as expected");
-			else
-				tst_resm(TFAIL | TTERRNO,
-					 "getrusage failed unexpectedly");
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-
+		TEST(getrusage(test_cases[i].who, test_cases[i].usage));
+
+		if (TST_RET == -1 &&
+		    TST_ERR == test_cases[i].exp_errno)
+			tst_res(TPASS | TTERRNO,
+				"getrusage failed as expected");
+		else
+			tst_res(TFAIL | TTERRNO,
+				"getrusage failed unexpectedly");
 }
 
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-}
-
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test = verify_getrusage,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.needs_root = 1,
+};
-- 
2.17.1


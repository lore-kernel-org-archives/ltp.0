From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:12 +0300
Subject: [LTP] [PATCH 04/16] syscalls/sched_setparam01: convert to new API
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-5-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_setparam/sched_setparam01.c         | 135 +++---------------
 1 file changed, 18 insertions(+), 117 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
index a2272eb18..d677736a1 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
@@ -1,128 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
+ * Copyright (c) 2021, BELLSOFT. All rights reserved.
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
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: sched_setparam01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for sched_setparam(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the sched_setparam(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
+
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  sched_setparam01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
+ * Basic test for sched_setparam(2)
  *
- ****************************************************************/
-
-#include <errno.h>
-#include <sched.h>
-#include "test.h"
-
-static void setup();
-static void cleanup();
-
-char *TCID = "sched_setparam01";
-int TST_TOTAL = 1;
-
-static struct sched_param param;
-
-int main(int ac, char **av)
-{
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call sched_setparam(2) with pid=0 sothat it will
-		 * set the scheduling parameters for the calling process
-		 */
-		TEST(sched_setparam(0, &param));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TPASS, "sched_setparam() returned %ld",
-				 TEST_RETURN);
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "Test Failed, sched_setparam()" "returned %ld",
-				 TEST_RETURN);
-		}
-	}
+ * Call sched_setparam(2) with pid=0 so that it will
+ * set the scheduling parameters for the calling process
+ */
 
-	cleanup();
-	tst_exit();
-}
+#include "tst_test.h"
+#include "tst_sched.h"
 
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void run(void)
 {
+	struct sched_param p = { .sched_priority = 0 };
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	param.sched_priority = 0;
-
+	TST_EXP_PASS(tst_sched_setparam(0, &p));
 }
 
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.25.1


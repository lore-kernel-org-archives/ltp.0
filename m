Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC73DC433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 06:27:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 344353C8FD2
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 07:27:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79C883C8F38
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 07:26:53 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E0E01000405
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 07:26:49 +0100 (CET)
X-QQ-mid: bizesmtp46t1639722404tdof7avz
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 17 Dec 2021 14:26:39 +0800 (CST)
X-QQ-SSF: 0140000000000070E000B00A0000000
X-QQ-FEAT: xTOTECUEGEz0NQ0tkg69xIlLzYRjJrr5KEnfULsTwleoPUnu0kkoybmPR6UhR
 uDQYzYsB7aySqqUPqXqYheojSfM0UqzG7KxaSZ0QVe8dUVb2RAeyJIqBgMOyXtRmAOeLhNa
 IwWc8N65fwmmB0+6IS80QusLUmiTs/evTIY6JW4spRMPTYyN6ZPoWgs2oMXT/LA7oaPmWpc
 jRZFdRrb6LPs43vXzIutZOt0NwT0qyuoyx+DvPo4YbTdwX6RuQWGsIAMCdJ3OF5zCZ06dUp
 m+z9XZW/faGZL4oWjO77zQorpL4mjfNV6+0hWAbY7NVvVhQAL8cd/fdMwh2aBw7ZLatLy1h
 wJAl7OJg496D9KJiS4=
X-QQ-GoodBg: 2
From: sujiaxun <sujiaxun@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 17 Dec 2021 14:26:37 +0800
Message-Id: <20211217062637.29720-1-sujiaxun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [v2,
 1/2] syscalls/sched_get_priority_max01: Convert to new
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: sujiaxun <sujiaxun@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 .../sched_get_priority_max01.c                | 143 +++---------------
 1 file changed, 22 insertions(+), 121 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index 7d36dbbdb..592168a7e 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -1,142 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: sched_get_priority_max01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for sched_get_priority_max(2)
- *
- *    TEST CASE TOTAL	: 3
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
+
+/*\
+ * [Description]
  *
- *    DESCRIPTION
  *	This is a Phase I test for the sched_get_priority_max(2) system call.
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
- *
- * USAGE:  <for command-line>
- *  sched_get_priority_max01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f]
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
+ *	Obtain different maximum priority scheduling strategies and compare
+ *	them with the expected value.
+ */

 #include <errno.h>
 #include <sched.h>
-#include "test.h"
-
-static void setup();
-static void cleanup();
-
-char *TCID = "sched_get_priority_max01";
+#include "lapi/syscalls.h"
+#include "tst_test.h"

-static struct test_case_t {
+static struct test_case {
 	char *desc;
 	int policy;
 	int retval;
-} test_cases[] = {
-	{
-	"Test for SCHED_OTHER", SCHED_OTHER, 0}, {
-	"Test for SCHED_FIFO", SCHED_FIFO, 99}, {
-	"Test for SCHED_RR", SCHED_RR, 99}
+} tcases[] = {
+	{"SCHED_OTHER", SCHED_OTHER, 0},
+	{"SCHED_FIFO", SCHED_FIFO, 99},
+	{"SCHED_RR", SCHED_RR, 99}
 };

-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
-
-int main(int ac, char **av)
+static void run_test(unsigned int nr)
 {

-	int lc, ind;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
+	struct test_case *tc = &tcases[nr];

-		for (ind = 0; ind < TST_TOTAL; ind++) {
-			/*
-			 * Call sched_get_priority_max(2)
-			 */
-			TEST(sched_get_priority_max(test_cases[ind].policy));
-
-			if (TEST_RETURN == test_cases[ind].retval) {
-				tst_resm(TPASS, "%s Passed",
-					 test_cases[ind].desc);
-			} else {
-				tst_resm(TFAIL | TTERRNO, "%s Failed, "
-					 "sched_get_priority_max() returned %ld",
-					 test_cases[ind].desc, TEST_RETURN);
-			}
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-
-	tst_exit();
+	TST_EXP_VAL(tst_syscall(__NR_sched_get_priority_max, tc->policy),
+			tc->retval, "test for %s", tc->desc);

 }

-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-}
-
-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run_test,
+};

-}
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

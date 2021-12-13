Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90FCC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 03:44:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E656C3C8997
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 04:43:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C297C3C4C32
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 04:43:46 +0100 (CET)
Received: from smtpbg506.qq.com (smtpbg506.qq.com [203.205.250.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8126B60066B
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 04:43:43 +0100 (CET)
X-QQ-mid: bizesmtp35t1639367019tny8nm4a
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 13 Dec 2021 11:43:33 +0800 (CST)
X-QQ-SSF: 0140000000200070E000000B0000000
X-QQ-FEAT: FXvDfBZI5O6jUqyT4CVq0grDLYZxqVy8OGr5DWmLJDZv02CoP/8XmTtFUvZsw
 6m9UylFLY3oEHMFRKT4iXeHyLfwq1Cg4B7jQ0jYAExQqdefKuoLm1u+kRmGWqw6xBUQwGJn
 YvGDX51Zh10+jWrf6hO2F6hA00k+3O9d30WO1iJXboX2awFrHIAzSdZVl372YuPOPpZuzQ/
 WrsDXncH2+qEQbSyuGrOLWK1CB+o0v9R4QlzIZ5DggEWRgTnhrO8gPF2oi87lVwama8GF8x
 MeI7Fu1hjJ34c7gcSCHn+ZhagCB39vKR0dTkEwKu8scleq7BkoQX6kwxqwbl/VamJSQBdcq
 2LESn7deYrrB8lV+Q26ubA47poHIAURaDfahv1L
X-QQ-GoodBg: 2
From: sujiaxun <sujiaxun@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 11:43:30 +0800
Message-Id: <20211213034330.16861-1-sujiaxun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [v1,
 1/2] syscalls/sched_get_priority_min01: Convert to new
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
Cc: sujiauxn <sujiaxun@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: sujiauxn <sujiaxun@uniontech.com>

Signed-off-by: sujiauxn <sujiaxun@uniontech.com>
---
 .../sched_get_priority_min01.c                | 143 +++---------------
 1 file changed, 25 insertions(+), 118 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
index 0893cb79f..84204e213 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
@@ -1,142 +1,49 @@
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
- *    TEST IDENTIFIER	: sched_get_priority_min01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for sched_get_priority_min(2)
- *
- *    TEST CASE TOTAL	: 3
- *
- *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the sched_get_priority_min(2) system call.
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
- *  sched_get_priority_min01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f]
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
+
+/*\
+ * [Description]
  *
- ****************************************************************/
+ *      This is a Phase I test for the sched_get_priority_min(2) system call.
+ *      It is intended to provide a limited exposure of the system call.
+ */

 #include <errno.h>
 #include <sched.h>
-#include "test.h"
-
-static void setup();
-static void cleanup();
+#include "tst_test.h"
+#include "lapi/syscalls.h"

-char *TCID = "sched_get_priority_min01";

-static struct test_case_t {
+static struct test_case {
 	char *desc;
 	int policy;
 	int retval;
-} test_cases[] = {
+} tcases[] = {
 	{
 	"Test for SCHED_OTHER", SCHED_OTHER, 0}, {
 	"Test for SCHED_FIFO", SCHED_FIFO, 1}, {
 	"Test for SCHED_RR", SCHED_RR, 1}
 };

-int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
-
-int main(int ac, char **av)
+static void run_test(unsigned int nr)
 {
+	struct test_case *tc = &tcases[nr];

-	int lc, ind;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	TEST(tst_syscall(__NR_sched_get_priority_min, tc->policy));

-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (ind = 0; ind < TST_TOTAL; ind++) {
-			/*
-			 * Call sched_get_priority_min(2)
-			 */
-			TEST(sched_get_priority_min(test_cases[ind].policy));
-
-			if (TEST_RETURN == test_cases[ind].retval) {
-				tst_resm(TPASS, "%s Passed",
-					 test_cases[ind].desc);
-			} else {
-				tst_resm(TFAIL | TTERRNO, "%s Failed, "
-					 "sched_get_priority_min() returned %ld",
-					 test_cases[ind].desc, TEST_RETURN);
-			}
-		}
+	if (TST_RET == tc->retval) {
+		tst_res(TPASS, "%s Passed",
+			 tc->desc);
+	} else {
+		tst_res(TFAIL | TTERRNO, "%s Failed, "
+			 "sched_get_priority_min() returned %ld",
+			 tc->desc, TST_RET);
 	}
-
-	/* cleanup and exit */
-	cleanup();
-
-	tst_exit();
-
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
-
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run_test,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3F5C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 03:43:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06B563C4C32
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 04:43:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53DD93C1448
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 04:43:31 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1146360065D
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 04:43:28 +0100 (CET)
X-QQ-mid: bizesmtp36t1639366998tvvb2xas
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 13 Dec 2021 11:43:14 +0800 (CST)
X-QQ-SSF: 0140000000200070E000000B0000000
X-QQ-FEAT: a4niRxydalHEEQUMpiOS9F7NK2aakyiV9icdAs1+mE0IapM70JerFEBFw37t+
 iuh18CiKS9OOaRF6g6vMu5Hc6glVXWMzk/G0yYZxpHxl75TFtcLuZBm/nQlog7sOLkwVmOg
 s5GqqNEYK6wLqmx+VG7LGeZgS6Xv72pCjqcl3Eesl3juBKEa94/B2VzZB7laJ3vixYMatG1
 n3SxXIAdrh74Rq+wGRYw88yOQnF3MaexHVXmL8kSyJkDu+AGGaSMlzTzYTsfjtAdklCizbd
 wj9rciX9R6t5shGzs6ZIC5T19Cm5JIVnQQKe639NT+c/LGjZ7hVzHkfFcZRfGAxB2Ykrzod
 mBGc0p7B62QuJeQn1vZZtUZcy2HS5353A5Wzb0YNlVegQGRIxI=
X-QQ-GoodBg: 2
From: sujiaxun <sujiaxun@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 11:43:12 +0800
Message-Id: <20211213034312.15317-1-sujiaxun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [v1,
 2/2] syscalls/sched_get_priority_max02: Convert to new
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
 .../sched_get_priority_max02.c                | 130 ++----------------
 1 file changed, 14 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
index 63b0d8a8e..1bde0e062 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
@@ -1,130 +1,28 @@
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
- *    TEST IDENTIFIER	: sched_get_priority_max02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Test for error conditions
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
+
+/*\
+ * [Description]
+ *
  *	Verify that given an invalid scheduling policy,
  *	sched_get_priority_max() returns -1 with errno EINVAL
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1) & errno=EINVAL
- *		Test Passed
- *	  Otherwise
- *		Test Failed
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  sched_get_priority_max02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f]
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
+ */

-#include <errno.h>
 #include <sched.h>
-#include "test.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"

 #define SCHED_INVALID 1000

-static void setup();
-static void cleanup();
-
-char *TCID = "sched_get_priority_max02";
-
-int TST_TOTAL = 1;
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
-		 * Call sched_get_priority_max(2)
-		 */
-		TEST(sched_get_priority_max(SCHED_INVALID));
-
-		if ((TEST_RETURN == -1) && (TEST_ERRNO == EINVAL)) {
-			tst_resm(TPASS, "Test Passed, Got EINVAL");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "Test Failed, sched_get_priority_max()"
-				 " returned %ld", TEST_RETURN);
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
+static void verif_sched_get_priority_max02(void)
 {

-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
+	TST_EXP_FAIL(tst_syscall(__NR_sched_get_priority_max, SCHED_INVALID), EINVAL);
+
 }

-/*
- *cleanup() -  performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = verif_sched_get_priority_max02,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

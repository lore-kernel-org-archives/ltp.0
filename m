Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652A1C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 02:44:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C99A3C9209
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 03:44:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EC603C0BA7
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:44:11 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BE66600457
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:44:08 +0100 (CET)
X-QQ-mid: bizesmtp48t1640054638txzi30r7
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 21 Dec 2021 10:43:53 +0800 (CST)
X-QQ-SSF: 0140000000200080E000B00A0000000
X-QQ-FEAT: lxznx37Zcyt551/Zyoth+yMliBoJFfPkpAEdqCoRU24t/5cyrk98AhoZrEcBh
 DnqinnZXCGUk51R1Tw/pTFxnH3iG1+I/W9b99KZkwRP6mqVOkiFxts+w2+YqSrLo5drS1iC
 VxenPrQ7Vw4o7vkmoH9hjH1alKZ5eZigH40ecY7AqqHfK+tWeWxSBBdWAqPPqHurPA2CDhs
 acjf5NPlILkl7qntUcjfq7dWl5TQVN0pEUCOc5WWmSLCUXe7FzbjQHDSNhkCDF3vn1UZNk9
 VQ1YL7ICo4Bk3uAuHdZZgF08jkYUo/m1JUhY/mcimCfh4kK3EP3ecPIXsJn4yxYuv6vvzlY
 xuV7JvgFbD/d4QOcp4uUB1AwIYJFQ==
X-QQ-GoodBg: 2
From: sujiaxun <sujiaxun@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 21 Dec 2021 10:43:48 +0800
Message-Id: <20211221024348.23869-1-sujiaxun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [v2,
 2/2] syscalls/sched_get_priority_min02: Convert to new
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
 .../sched_get_priority_min02.c                | 131 ++----------------
 1 file changed, 15 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
index 564c54f4a..ab061e77e 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
@@ -1,130 +1,29 @@
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
+ * Copyright (c) 2021 sujiaxun <sujiaxun@uniontech.com>
  */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: sched_get_priority_min02
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
- *	Verify that given an invalid scheduling policy,
- *	sched_get_priority_min() returns -1 with errno EINVAL
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
- *  sched_get_priority_min02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f]
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
+ * Verify that given an invalid scheduling policy, sched_get_priority_min(2)
+ * returns -1 with errno EINVAL
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
-char *TCID = "sched_get_priority_min02";
-
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verif_sched_get_priority_min02(void)
 {
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
-		 * Call sched_get_priority_min(2)
-		 */
-		TEST(sched_get_priority_min(SCHED_INVALID));
-
-		if ((TEST_RETURN == -1) && (TEST_ERRNO == EINVAL)) {
-			tst_resm(TPASS, "Test Passed, Got EINVAL");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-				 "Test Failed, sched_get_priority_min()"
-				 " returned %ld", TEST_RETURN);
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
+	TST_EXP_FAIL(tst_syscall(__NR_sched_get_priority_min, SCHED_INVALID), EINVAL);
 }

-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+static struct tst_test test = {
+	.test_all = verif_sched_get_priority_min02,
+};

-	TEST_PAUSE;

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
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

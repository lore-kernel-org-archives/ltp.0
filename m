Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D2C433EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 00:20:34 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CAD611C8
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 00:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57CAD611C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EA4A3C72B5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 01:20:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A64B03C5DD9
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 01:20:21 +0100 (CET)
Received: from smtpbg506.qq.com (smtpbg506.qq.com [203.205.250.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B5F436007BB
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 01:20:18 +0100 (CET)
X-QQ-mid: bizesmtp41t1635985213tgs6zy1f
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 04 Nov 2021 08:20:07 +0800 (CST)
X-QQ-SSF: 0140000000200040C000000A0000000
X-QQ-FEAT: CpF3Nc+oRqyLz6cWQXNPpbmRHZSy0C3OPIbX0E3doergRUhxKMt/YyStK2XjU
 Bh+KHas0TkdpCWqIY8Gb0BGbjZl4VXrUNulkz3klyuczlZCJmxJK4Q2uYtZazroRwOwXJ2N
 S8fJu3Fe5QNz0LkyvlyW9xoZA69QMeWu5qH8Xv7D2mGvZnlUiS4dDuYdW8klZIt2OQZ2DFb
 sp0heQbchG2b0ZqzperGm3QAZPJOJPJOB1dVkak4TgtwdkFSq1Lt+8Q9Fa2AYUlg9Ai5L+Y
 POR4s6lgYXOdX5HHynhXJ3nJuWaTFjnl5FmOfqFW9qbyV3mpDKvfcLq8zT9YNGvwlFeD/Yh
 va2GVMidYgD741AO1kfnKe8OmtbjQ==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Thu,  4 Nov 2021 08:20:06 +0800
Message-Id: <20211104002006.11287-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getdomainname/getdomainname01: Convert to new API
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
Cc: tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 .../syscalls/getdomainname/getdomainname01.c  | 141 ++++--------------
 1 file changed, 26 insertions(+), 115 deletions(-)

diff --git a/testcases/kernel/syscalls/getdomainname/getdomainname01.c b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
index d40abc8c9..1ea0cf409 100644
--- a/testcases/kernel/syscalls/getdomainname/getdomainname01.c
+++ b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
@@ -1,132 +1,43 @@
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
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER	: getdomainname01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for getdomainname(2)
- *
- *    TEST CASE TOTAL	: 1
- *
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
+ */
+
+/*\
+ * [Description]
  *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the getdomainname(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  getdomainname01  [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
+ * Basic test for getdomainname(2)
  *
- ****************************************************************/
+ * This is a Phase I test for the getdomainname(2) system call.
+ * It is intended to provide a limited exposure of the system call.
+ */

 #include <errno.h>
 #include <linux/utsname.h>
-#include "test.h"
+#include "tst_test.h"

 #define MAX_NAME_LEN __NEW_UTS_LEN

-static void setup();
-static void cleanup();
-
-char *TCID = "getdomainname01";
-int TST_TOTAL = 1;
-
 static char domain_name[MAX_NAME_LEN];

-int main(int ac, char **av)
+static void verify_getdomainname(void)
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
-		 * Call getdomainname(2)
-		 */
-		TEST(getdomainname(domain_name, sizeof(domain_name)));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "getdomainname() Failed, errno = %d :"
-				 " %s", TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "getdomainname() returned %ld ",
-				 TEST_RETURN);
-		}
-
+	/*
+	 * Call getdomainname(2)
+	 */
+	TEST(getdomainname(domain_name, sizeof(domain_name)));
+
+	/* check return code */
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "getdomainname() Failed, errno = %d :"
+			 " %s", TST_ERR, strerror(TST_ERR));
+	} else {
+		tst_res(TPASS, "getdomainname() returned %ld ",
+			 TST_RET);
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
+        .test_all = verify_getdomainname,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

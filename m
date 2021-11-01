Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23981C433F5
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 03:13:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BAA60FC2
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 03:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00BAA60FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63A493C6D6C
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 04:13:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 764F23C1B3C
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 04:12:59 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7F257601D54
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 04:12:52 +0100 (CET)
X-QQ-mid: bizesmtp39t1635736366tgsk14oe
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 01 Nov 2021 11:12:41 +0800 (CST)
X-QQ-SSF: 0140000000000040C000B00A0000000
X-QQ-FEAT: XFP6IXEuxf4vbdtpz98Rx7arJZHQJxDmbw+PCrPPWSEUYAEoz4Inuho4qFHgI
 ITHOJ0Gwu+iUCHnYrctTOEvR1L2C0uTWOClLv4WvwcZnt3zqKk8q/W+oeXcRQQLMcGOCg/y
 tmQ1+WZqIsg7VbSEltFpxqW3ALg8fcarZipHo25zM1xAT0PdikZglRtBwfERSWZPgMQowAT
 JDJaA3kpYdccvc9UWpAGAy8t4Xoq6Byr2vBXTk9IgFqLpkMHrexH1HfhxxadpO0OVfk+F1m
 VXxLvkJOmWNw57ytvt6YTN9v2dhbNQDdszK5I6r3TX1IWyDBX47oVcgnFrfdI+xND1oZom0
 dii0LhQ4SqAMZdDdJorDu8Ip2tMag==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Mon,  1 Nov 2021 11:12:39 +0800
Message-Id: <20211101031240.29791-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] dup/dup04: Convert to new API
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
 testcases/kernel/syscalls/dup/dup04.c | 204 +++++---------------------
 1 file changed, 34 insertions(+), 170 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index 0b1827c68..8d45f7a9c 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -1,198 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
+ * 06/1994 AUTHOR: Richard Logan CO-PILOT: William Roske
  */
-/* $Id: dup04.c,v 1.6 2009/10/13 14:00:46 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: dup04
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for dup(2) of a system pipe descriptor
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 2
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: William Roske
- *
- *    DATE STARTED	: 06/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) dup(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the dup(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	dup(2).
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
+
+/*\
+ * [DESCRIPTION]
  *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+ * Basic test for dup(2) of a system pipe descriptor.
+ */

 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdio.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();

-char *TCID = "dup04";
-int TST_TOTAL = 2;
+#include "tst_test.h"

 int fd[2];

-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TEST(dup(fd[0]));

-		tst_count = 0;
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO,
+			 "dup of read side of pipe failed");
+	else {
+		tst_res(TPASS,
+			 "dup(%d) read side of syspipe returned %ld",
+			 fd[0], TST_RET);

-		TEST(dup(fd[0]));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO,
-				 "dup of read side of pipe failed");
-		else {
-			tst_resm(TPASS,
-				 "dup(%d) read side of syspipe returned %ld",
-				 fd[0], TEST_RETURN);
-
-			SAFE_CLOSE(cleanup, TEST_RETURN);
-		}
-
-		TEST(dup(fd[1]));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "dup of write side of pipe failed");
-		} else {
-			tst_resm(TPASS,
-				 "dup(%d) write side of syspipe returned %ld",
-				 fd[1], TEST_RETURN);
+		SAFE_CLOSE(TST_RET);
+	}

+	TEST(dup(fd[1]));

-			SAFE_CLOSE(cleanup, TEST_RETURN);
-		}
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO,
+			 "dup of write side of pipe failed");
+	} else {
+		tst_res(TPASS,
+			 "dup(%d) write side of syspipe returned %ld",
+			 fd[1], TST_RET);

+		SAFE_CLOSE(TST_RET);
 	}
-
-	cleanup();
-	tst_exit();
 }

 void setup(void)
 {
 	fd[0] = -1;

-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_PIPE(cleanup, fd);
+	SAFE_PIPE(fd);
 }

-void cleanup(void)
-{
-	int i;
-
-	for (i = 0; i <= 6; i++)
-		close(i);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+        .test_all = run,
+        .setup = setup,
+        .needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

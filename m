Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E5EC433F5
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 05:32:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEE96124D
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 05:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FEE96124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B36A3C77DD
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 06:32:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0D473C185C
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 06:32:41 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EEB4601115
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 06:32:37 +0100 (CET)
X-QQ-mid: bizesmtp52t1636349552t0qs805g
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 08 Nov 2021 13:32:26 +0800 (CST)
X-QQ-SSF: 0140000000200040C000000A0000000
X-QQ-FEAT: dpyQmELDBxFHDAEsxdJYgkjuk9h71TN8o1NCd6NL8VXp8F52UFChn8RlsjBGb
 SfkNp648pmhRm99hrovEj2hREvUSkqLUVC8h4Go7nSY4hsNXxmQjoRrHADEKRmoBmErfYbN
 eQuNJCvP7FYSP+djeRjiCf9CTDHg2PY+5GlsZGzWTLHcXP59dgxjbTEMCyKzkT6s6tWCTsM
 jVurfbGvKrw+IwlFOBNNiSXlUCwLMKn5sj+7VS26lDv3n3i10lotaeVOl/fR9jKfx/oMmLF
 4duorI0XCJZfht4zapt3CxXmTgpZGlGDxBfwnSveNfSmi2WutnKZtLatKSA2+vcSXP/dbKR
 rwgx5Tto7HSgld2Bx3r71nsI5datg==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Mon,  8 Nov 2021 13:32:24 +0800
Message-Id: <20211108053225.23442-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fchdir/fchdir01: Convert to new API
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
 testcases/kernel/syscalls/fchdir/fchdir01.c | 166 ++------------------
 1 file changed, 15 insertions(+), 151 deletions(-)

diff --git a/testcases/kernel/syscalls/fchdir/fchdir01.c b/testcases/kernel/syscalls/fchdir/fchdir01.c
index 526dfcaa2..4d07dd603 100644
--- a/testcases/kernel/syscalls/fchdir/fchdir01.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir01.c
@@ -1,171 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */

 /*
- * NAME
- *	fchdir01.c
- *
  * DESCRIPTION
  *	fchdir01 - create a directory and cd into it.
- *
- * ALGORITHM
- *	create a new directory
- *	open the directory and get a file descriptor
- *	loop if that option was specified
- *	fchdir() into the directory
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing, call check_functionality()
- *	  	if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  fchdir01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */

-#include "test.h"
+#include "tst_test.h"

-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <libgen.h>
-#include <string.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "fchdir01";
-int TST_TOTAL = 1;
-
-int fd;
-char *temp_dir;
-const char *TEST_DIR = "alpha";
+static int fd;
+static const char *TEST_DIR = "alpha";

 #define MODES	S_IRWXU

-int main(int ac, char **av)
-{
-	int lc;
-	void check_functionality(void);
-	int r_val;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/* get the name of the test dirctory */
-		if ((temp_dir = (getcwd(temp_dir, 0))) == NULL)
-			tst_brkm(TBROK, cleanup, "getcwd failed");
-
-		/*
-		 * create a new directory and open it
-		 */
-
-		if ((r_val = mkdir(TEST_DIR, MODES)) == -1)
-			tst_brkm(TBROK, cleanup, "mkdir failed");
-
-		if ((fd = open(TEST_DIR, O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open of directory failed");
-
-		TEST(fchdir(fd));
-
-		if (TEST_RETURN == -1) {
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "fchdir call failed");
-		} else {
-				check_functionality();
-		}
-
-		/*
-		 * clean up things in case we are looping
-		 */
-
-		/*
-		 * NOTE: in case of failure here, we need to use "tst_resm()"
-		 * and not "tst_brkm()".  This is because if we get to this
-		 * point, we have already set a PASS or FAIL for the test
-		 * and "tst_brkm()" won't report as we might expect.
-		 */
-
-		/* chdir back to our temporary work directory */
-		if ((r_val = chdir("..")) == -1)
-			tst_resm(TBROK | TERRNO, "chdir failed");
-
-		if ((r_val = rmdir(TEST_DIR)) == -1)
-			tst_resm(TBROK | TERRNO, "rmdir failed");
-
-		free(temp_dir);
-		temp_dir = NULL;
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void check_functionality(void)
+static void verify_fchdir(void)
 {
-	char *buf = NULL;
-	char *dir;
+	if ((fd = open(TEST_DIR, O_RDONLY)) == -1)
+		tst_brk(TBROK, "open of directory failed");

-	if ((buf = (getcwd(buf, 0))) == NULL) {
-		tst_brkm(TBROK, cleanup, "getcwd failed");
-	}
-
-	if ((dir = basename(buf)) == NULL)
-		tst_brkm(TBROK, cleanup, "basename failed");
-
-	if (strcmp(TEST_DIR, dir) == 0)
-		tst_resm(TPASS, "fchdir call succeeded");
-	else
-		tst_resm(TFAIL, "fchdir call failed");
+	TST_EXP_PASS(fchdir(fd));
 }

-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	SAFE_MKDIR(TEST_DIR, MODES);
 }

-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test_all = verify_fchdir,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

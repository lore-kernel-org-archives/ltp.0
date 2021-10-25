Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE2C433FE
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 07:29:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4625160F9C
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 07:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4625160F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1ED13C65B9
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 09:29:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 441203C26D3
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 04:28:02 +0200 (CEST)
Received: from smtpbg506.qq.com (smtpbg506.qq.com [203.205.250.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 186711000F72
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 04:27:59 +0200 (CEST)
X-QQ-mid: bizesmtp31t1635128872t676oeed
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 25 Oct 2021 10:27:47 +0800 (CST)
X-QQ-SSF: 0140000000000010B000B00A0000000
X-QQ-FEAT: nWwLie5Ka5k4Udw52s0Curu4zKfa9vgZRAyY1DmP0zYdA8k2f3ONEBEPO8eXF
 CGw264ikgniPGfto268sz4hSrJgdInABuugKUup2MK9XQUKSy7wmtZM/tfJ/rCymIvwHljQ
 st+KU+DNrh7DHboST2Yu70RAhYfjwwHHqzBvGXkbo8ymC1Kuc1y+aDPlagM9jm6S4pkGc1I
 dq6kR07kJWs8EFB3PSbCv578qiN7L6pzQzqdean4Im0P6VDdmQIeZteu1+NAbM22BtXgy7c
 MjbCx53bo5VeFrWm9TJfbQK7WzNgOChbvXUYjboHmYgLvmiufeZMsQwsxNV42wCYIx8thiv
 lcO0KVzrU3vlGxJSAU=
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 10:27:45 +0800
Message-Id: <20211025022745.21469-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 25 Oct 2021 09:27:43 +0200
Subject: [LTP] [PATCH] link/link02: Convert to new API
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
 testcases/kernel/syscalls/link/link02.c | 102 ++++++------------------
 1 file changed, 23 insertions(+), 79 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link02.c b/testcases/kernel/syscalls/link/link02.c
index 6ac340c72..f41179f4c 100644
--- a/testcases/kernel/syscalls/link/link02.c
+++ b/testcases/kernel/syscalls/link/link02.c
@@ -1,115 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *  AUTHOR		: William Roske
- *  CO-PILOT		: Dave Fenner
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
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
+ * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  */

-/*
+/*\
+ * [Description]
  * Tests that link(2) succeds.
  */

-#include <sys/types.h>
-#include <fcntl.h>
+#include <unistd.h>
 #include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);

-char *TCID = "link02";
-int TST_TOTAL = 1;
+#include "tst_test.h"

 #define OLDPATH "oldpath"
 #define NEWPATH "newpath"

-static void verify_link(void)
+static void verify_link02(void)
 {
 	struct stat fbuf, lbuf;

 	TEST(link(OLDPATH, NEWPATH));

-	if (TEST_RETURN == 0) {
-		SAFE_STAT(cleanup, OLDPATH, &fbuf);
-		SAFE_STAT(cleanup, NEWPATH, &lbuf);
+	if (TST_RET == 0) {
+		SAFE_STAT(OLDPATH, &fbuf);
+		SAFE_STAT(NEWPATH, &lbuf);
 		if (fbuf.st_nlink > 1 && lbuf.st_nlink > 1 &&
 		    fbuf.st_nlink == lbuf.st_nlink) {
-			tst_resm(TPASS, "link("OLDPATH","NEWPATH") "
+			tst_res(TPASS, "link("OLDPATH","NEWPATH") "
 			         "returned 0 and link counts match");
 		} else {
-			tst_resm(TFAIL, "link("OLDPATH","NEWPATH") returned 0"
+			tst_res(TFAIL, "link("OLDPATH","NEWPATH") returned 0"
 				 " but stat lin count do not match %d %d",
 				 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
 		}
-		SAFE_UNLINK(cleanup, NEWPATH);
 	} else {
-		tst_resm(TFAIL | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 		         "link("OLDPATH","NEWPATH") returned %ld",
-		         TEST_RETURN);
-	}
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		verify_link();
+		         TST_RET);
 	}
-
-	cleanup();
-	tst_exit();
 }

 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_TOUCH(cleanup, OLDPATH, 0700, NULL);
+	SAFE_TOUCH(OLDPATH, 0700, NULL);
 }

 static void cleanup(void)
 {
-	tst_rmdir();
+    SAFE_UNLINK(NEWPATH);
 }
+
+static struct tst_test test = {
+    .test_all = verify_link02,
+    .setup = setup,
+    .cleanup = cleanup,
+    .needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

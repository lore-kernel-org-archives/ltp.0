Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBF4C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:47:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A45A6187F
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A45A6187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDEC23C8709
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 03:47:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3D413C6268
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:47:23 +0100 (CET)
Received: from smtpbg511.qq.com (smtpbg511.qq.com [203.205.250.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 842E9600651
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:47:19 +0100 (CET)
X-QQ-mid: bizesmtp49t1637030834tjmc4mk7
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 16 Nov 2021 10:47:07 +0800 (CST)
X-QQ-SSF: 0140000000200050C000B00A0000000
X-QQ-FEAT: eTtJes0duVu8G7QNwtvK4B19DicYif1i1WJdNGfHdEdDWpxR+v1TcKWmPjXrp
 E+g7TcGUeC86VH04fWGp7LIoy9Ytz0d8c9knKLVYDR/+XKM43KbiICDJ+iEfUhRIqVtmR6R
 J9mBE8bl2vycQp7BGp1qixQtB09PGmjJnusjVk9g0JfaGCQcC29JRyNfK3qIQ5HY48qUusI
 ++Wyg295Z0iqEv1s/dSCVFzK7Mm/wexRtiKgsamvaXdVKVeEPaht/U3pb9biojz5+uTJPii
 gET3p9zGWOxb3q2QTOaSO/5dISpxm3KVBSbR01J5ER+G/zEeYSmojJ0Yv1U/tFwT9j9sG1s
 CJTlL26Mo1FtyHNwLP2BeBtPol/Uay9QbUXheGMvP+qdOlw3lQ=
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Tue, 16 Nov 2021 10:47:05 +0800
Message-Id: <20211116024706.30853-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] getuid/getuid01: Convert to new API
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
 testcases/kernel/syscalls/getuid/getuid01.c | 88 ++++-----------------
 1 file changed, 15 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
index cf8c77424..bad29bd84 100644
--- a/testcases/kernel/syscalls/getuid/getuid01.c
+++ b/testcases/kernel/syscalls/getuid/getuid01.c
@@ -1,84 +1,26 @@
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
- */
-/*
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
+ *    AUTHOR           : William Roske
+ *    CO-PILOT         : Dave Fenner
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>

-#include "test.h"
-#include "compat_16.h"
-
-static void setup(void);
-static void cleanup(void);
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of the getuid() system call.
+ */

-TCID_DEFINE(getuid01);
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "compat_tst_16.h"

-int main(int ac, char **av)
+static void verify_getuid(void)
 {
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
-		TEST(GETUID(cleanup));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "getuid failed");
-		else
-			tst_resm(TPASS, "getuid returned %ld", TEST_RETURN);
-
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_POSITIVE(GETUID(), "getuid()");
 }

-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}

-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_getuid,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

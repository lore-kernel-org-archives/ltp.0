Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5DC433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:58:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3644F61029
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3644F61029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B383C3C07B9
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:58:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BE3E3C0431
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 09:58:04 +0100 (CET)
Received: from smtpbg506.qq.com (smtpbg506.qq.com [203.205.250.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98EE6201744
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 09:57:59 +0100 (CET)
X-QQ-mid: bizesmtp37t1636448273teml2yje
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 09 Nov 2021 16:57:48 +0800 (CST)
X-QQ-SSF: 0140000000200040C000B00A0000000
X-QQ-FEAT: z8a0vINfhrsfZx/pF/hx67t+ZLIB8jfVGkPQ5FyPH4eNOV994k/kgq1aAJCRH
 YpoJjP+R5eZOpuhZY50NZhdK11pp9E3+f2IC4wYQyvhsBvoCye8rNIN8MtHbL4AasUKJ/ZL
 KrxEgs103NM6dx6mYTQ+jl5I9vAghg7hndH5VVye6TPxyC1a8SgPw5yRXNz9bhNPYg8evrx
 cl6b0q+fN08ZAQzLuPNiwpfrQhzGAp3dTw6de1sWR9F0RQlXp9gSqie3YJ8/blGo0pUrBxg
 u4nDwYFhWDQaBrT2Qox2iqks4xxGpLlGsaYYBc/mM517epGh04MKK5Q7bKoO++pDngJ42qy
 PSLFPxrOTU+40kOBXBr38QdP+Q+6Q==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Tue,  9 Nov 2021 16:57:44 +0800
Message-Id: <20211109085745.21531-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] getuid/getuid01: Convert to new API
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
 1 file changed, 17 insertions(+), 71 deletions(-)

diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
index cf8c77424..6e8cee96a 100644
--- a/testcases/kernel/syscalls/getuid/getuid01.c
+++ b/testcases/kernel/syscalls/getuid/getuid01.c
@@ -1,84 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
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
+	TEST(GETUID());

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
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	if (TST_RET == -1)
+		tst_res(TFAIL | TTERRNO, "getuid failed");
+	else
+		tst_res(TPASS, "getuid returned %ld", TST_RET);
 }

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

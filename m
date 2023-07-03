Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D09EB64DA
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 02:41:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 296ED3CE0B4
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 04:41:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69D3A3CC242
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 04:40:56 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DA1AC600152
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 04:40:55 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="110860439"
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; d="scan'208";a="110860439"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 11:40:52 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A2C4EDE63A
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 11:40:50 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C55B9D9464
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 11:40:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 406EE86D09;
 Mon,  3 Jul 2023 11:40:48 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon,  3 Jul 2023 10:40:40 +0800
Message-Id: <1688352041-4945-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27728.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27728.003
X-TMASE-Result: 10--12.018900-10.000000
X-TMASE-MatchedRID: /SZ+U+sA7aWhhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkM+a
 lSM7Pep8aj3ypNjZX+1WTBAeKqaX9Spe4ofkluPsqug9vIA2WODdvovMm13clcPfJfU0tMOF4Xg
 khF5FTCHzbv3mOafziDQOAygP9Dmd0vsjMZhH6s/aHU/pMDSkG9mhsJODizUsvnhgJqkfm0B9Jp
 pVNkb1KxeFELRmbzxEY018kD9GAOHBDRN9OhshUUW5la/dMBNIy6ZbL0nhex5cGuTueJkNItnoq
 uRwHY3BsAxCCQ9WOyt/iseCANV01xk6r7o1Tg7llXePXNM4FjP4uJ1REX4MHZyG1Z7KRwOK5p9T
 GNmpllFvu+EAUOCx0w1+Q0IfceRofOHi+oSjgYSeAiCmPx4NwJuJ+Pb8n/VxLzP5snaeb1Qqtq5
 d3cxkNeAajwyO32wXhto5FBlPsqQtDYE2vPL58njc+3aUHD28+M9fE4NzH0Y=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/geteuid01: Convert into new api
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/geteuid/geteuid01.c | 88 ++++-----------------------
 1 file changed, 13 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/geteuid/geteuid01.c b/testcases/kernel/syscalls/geteuid/geteuid01.c
index d02fb0a..0a20e51 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid01.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid01.c
@@ -1,87 +1,25 @@
+//SPDX-License-Identifier: GPL-2.0-only
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
+ *    AUTHOR            : William Roske
+ *    CO-PILOT          : Dave Fenner
  */
 
 /*
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
+ * [Description]
+ *
+ * Check the basic functionality of the geteuid() system call.
  */
 
-#include <sys/types.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-static void setup(void);
-static void cleanup(void);
-
-TCID_DEFINE(geteuid01);
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_geteuid(void)
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
-		TEST(GETEUID(cleanup));
-
-		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "geteuid failed");
-			continue;	/* next loop for MTKERNEL */
-		}
-
-		tst_resm(TPASS, "geteuid returned %ld", TEST_RETURN);
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
+	TST_EXP_POSITIVE(GETEUID(),"geteuid");
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_geteuid
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

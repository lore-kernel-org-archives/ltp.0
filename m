Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E6EB64D9
	for <ltp@archiver.kernel.org>; Thu,  6 Jul 2023 10:06:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5928F3CC848
	for <ltp@archiver.kernel.org>; Thu,  6 Jul 2023 12:06:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 164C53C88DA
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 12:06:08 +0200 (CEST)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CBB206009EE
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 12:06:07 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="102964134"
X-IronPort-AV: E=Sophos;i="6.01,185,1684767600"; d="scan'208";a="102964134"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 19:06:06 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 40652CA1ED
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 19:06:03 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 55F87BF3C1
 for <ltp@lists.linux.it>; Thu,  6 Jul 2023 19:06:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 47B6C82676;
 Thu,  6 Jul 2023 19:06:01 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu,  6 Jul 2023 18:05:53 +0800
Message-Id: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27734.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27734.005
X-TMASE-Result: 10--9.814900-10.000000
X-TMASE-MatchedRID: dQ64tE6ZdEShhjsqgSuNbxF4zyLyne+AVBDQSDMig9HEosIs7IJbkM+a
 lSM7Pep8aj3ypNjZX+1WTBAeKqaX9Spe4ofkluPsqug9vIA2WODdvovMm13clcPfJfU0tMOF4Xg
 khF5FTCHzbv3mOafziDQOAygP9Dmd0vsjMZhH6s/aHU/pMDSkG9mhsJODizUsvnhgJqkfm0B9Jp
 pVNkb1KxeFELRmbzxEY018kD9GAOHBDRN9OhshUUW5la/dMBNIa9qiaDSLgo3GsuYyb68ajGWPP
 ovHmr49u+jFdzsOreuFbYEMj70WzIRiOzyn0C74pSXVpBS+ilaAaxj78ZrSLmtEzrC9eANpgv4d
 jWvD77Cr+3xFCwdwVITBU3GlBbY0VPVUF2N3LyOGp0fwr2DvF30tCKdnhB58hYfw868k05b3PDi
 XO/tFSY6HM5rqDwqtFgNHbKr2wu/e/x0B21heI7QhL1yfM4wsPb67YTsQ0iXg5k0LTLdyEA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/geteuid01: Convert into new api
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
 testcases/kernel/syscalls/geteuid/geteuid01.c | 91 +++++----------------------
 1 file changed, 14 insertions(+), 77 deletions(-)

diff --git a/testcases/kernel/syscalls/geteuid/geteuid01.c b/testcases/kernel/syscalls/geteuid/geteuid01.c
index d02fb0a..0df8fae 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid01.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid01.c
@@ -1,87 +1,24 @@
+//SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
- *
+ * Copyright (c) Linux Test Project, 2003-2023
+ * AUTHOR: William Roske, Dave Fenne
  */
 
-/*
- *    AUTHOR		: William Roske
- *    CO-PILOT		: Dave Fenner
+/*\
+ *[Description]
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
-
-static void setup(void);
-static void cleanup(void);
-
-TCID_DEFINE(geteuid01);
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
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
+	TST_EXP_POSITIVE(GETEUID(), "geteuid()");
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_geteuid,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

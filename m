Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B04C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6553CF32A
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 09:16:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE6F43C98FA
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:16:32 +0100 (CET)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FF1C600687
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:16:30 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="122549548"
X-IronPort-AV: E=Sophos;i="6.04,284,1695654000"; d="scan'208";a="122549548"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 17:16:28 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D4A363131C
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 17:16:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0BB52D947B
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 17:16:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 99B70202CFE9E
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 17:16:25 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 4B7411A006F;
 Mon, 18 Dec 2023 16:16:25 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 18 Dec 2023 01:21:28 -0500
Message-Id: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28064.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28064.005
X-TMASE-Result: 10--2.949000-10.000000
X-TMASE-MatchedRID: dk3TBobQ8JAB90FcL1q4MKzGfgakLdjaFIuBIWrdOePEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tJhCh8+WImJUkto8AKCDbo7X3j/lf1V8LARryDXHx6oXS1jK4vkKprFj8i
 9T/sSpPK7+RLhghPMDYKaXAKcguz66ju+uRM2btaUl1aQUvopW9avse85ISVqchtWeykcDiuafU
 xjZqZZRW1oKOkluHRwOdco0ccdxs9WKNmKtnvU1hqdH8K9g7xcRMzHw4jihuZsoi2XrUn/Jn6Kd
 MrRsL14qtq5d3cxkNfAxRSAc0OENRqpZoU2fpFKPRlBnfja5ox7rwewsLFxc7eBkPGONjMU2ivq
 g8NpkR9wICHDetXyykZirDYCHFRLrmk73kgEhnr7Ax/NBmKe8+C28kJEn+G/AYLx7rnbR8rDQ8m
 3TqgloelpCXnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] gettimeofday01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../syscalls/gettimeofday/gettimeofday01.c    | 103 ++----------------
 1 file changed, 12 insertions(+), 91 deletions(-)

diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
index f9acb9665..84e98fd9a 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
@@ -1,107 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
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
+ *   Copyright (c) Linux Test Project, 2001-2023
  */
 
-/*
- * NAME
- *	gettimeofday01.c
- *
+/*\
  * DESCRIPTION
- *	Testcase to check that gettimeofday(2) sets errno to EFAULT.
- *
- * ALGORITHM
- *	Call gettimeofday() with an invalid buffer, and expect EFAULT to be
- *	set in errno.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Test for EFAULT error.
  *
- * RESTRICTIONS
- *	NONE
+ * - gettimeofday fail with EFAULT when one of tv or tz pointed outside the accessible
+ *   address space
  */
 
-#include <sys/time.h>
-#include <errno.h>
-#include "test.h"
-#include <unistd.h>
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 
-char *TCID = "gettimeofday01";
-int TST_TOTAL = 1;
-
-#if !defined UCLINUX
-
-void cleanup(void);
-void setup(void);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int ret;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(tst_syscall(__NR_gettimeofday, (void *)-1, (void *)-1));
-
-		/* gettimeofday returns an int, so we need to turn the long
-		 * TEST_RETURN into an int to test with */
-		ret = TEST_RETURN;
-		if (ret != -1) {
-			tst_resm(TFAIL,
-				 "call succeeded unexpectedly (got back %i, wanted -1)",
-				 ret);
-			continue;
-		}
-
-		if (TEST_ERRNO == EFAULT)
-			tst_resm(TPASS,
-				 "gettimeofday(2) set the errno EFAULT correctly");
-		else
-			tst_resm(TFAIL,
-				 "gettimeofday(2) didn't set errno to EFAULT, errno=%i (%s)",
-				 errno, strerror(errno));
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
+static void verify_gettimeofday(void)
 {
+	TST_EXP_FAIL(tst_syscall(__NR_gettimeofday, (void *)-1, (void *)-1), EFAULT);
 }
-#else
 
-int main(void)
-{
-	tst_brkm(TCONF, "gettimeofday EFAULT check disabled on uClinux");
-}
 
-#endif
+static struct tst_test test = {
+	.test_all  = verify_gettimeofday,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

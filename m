Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5A9C77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 05:45:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CB2E3CAD68
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 07:45:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DBDB3CB928
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 07:44:56 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC7BA100023B
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 07:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1682574293; i=@fujitsu.com;
 bh=wC8D/EKbj2qY52X1zcO9q+A+orC8uofwn7ZRoChAswE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=dSC19S1KefBSGhT56DCRQBq7Yc2RraWf/6M6Mp7lRjePMl669vzYQd+pb/ByUBijR
 APi8ApfmFbrIVwxBP8nW5G8NpdURI0Kg/Tz4PbpBhR5l1wdU4cC41CGHgodq8tEsMh
 aFSx0Ixkur2qJyjKVSWxh5+QOQ0OJTCM0z+AXCYpUTkPbRXlaQwRO+ftUWWaqvr2UK
 ASFChOUD1y3c4KXBIUaEcIsfXFNdyCsSeXmByJrLiQ9+yiC7On/gsKcbZLuCEvAwa7
 i9YiJSwDFpZi75bpKM9iPLbz8T26n4ObJVMX82/yoDiSwKYOeO/R62reR9t3iu9lII
 z5Zmx4r5vd6cg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8ORqHuF2yv
 FoPe+pcWK7zsYHRg99v1exxrAGMWamZeUX5HAmtG/chFLwRrlimfTvrA1MK6W7WLk4hASOMso
 8fb1e2YI5yCTxMferawQzj5GiXU7LwJlODnYBDQlnnUuALNFBCQkOhresoPYzALqEssn/WLqY
 uTgEBawk3h3PRUkzCKgKtGzegkjiM0r4ClxbeEbFhBbQkBBYsrD92BjOAW8JHZd+ssGYgsJZE
 o8OrOKGaJeUOLkzCcsEOMlJA6+eMEM0ask0dZ6hRXCrpRo/fALaqaaxNVzm5gnMArOQtI+C0n
 7AkamVYymxalFZalFusZ6SUWZ6RkluYmZOXqJVbqJeqmluuWpxSW6RnqJ5cV6qcXFesWVuck5
 KXp5qSWbGIGhm1KsLLeD8fTOv3qHGCU5mJREeVvSPVOE+JLyUyozEosz4otKc1KLDzHKcHAoS
 fCuZvNKERIsSk1PrUjLzAHGEUxagoNHSYSXjQsozVtckJhbnJkOkTrFqCglzlsLkhAASWSU5s
 G1wWL3EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVhXjVgIhDiycwrgZv+CmgxE9DicgYPkMU
 liQgpqQYmK9aYrQb+3xrbpDsfJVTGH+9xeye2ZdVrl0b+A/JLzps0rw2773NdSM5EVPWpb/z5
 uqm2aZU5R78kf7ukxxM5U7j13ry4W7MuffQ9o8XCs63HMJlrsbKg0jX1s/9uPtySv0jhW0XGZ
 33BvM2sxo0852o4Qh/xuupve33xk8L1sjvT3S6Wv43+NGnxO6aLmjs1/a6tK4tqT1LcmGfuP1
 dIfo/I6+oZc/w36TjrOM8sX/SlJVKz6MiSnBbnLboVE7ea3TApPK3SebI6+m/383n2CU/E8sO
 4rY8/evSjzp9N+mn+mwMexX9WFnxdcXFR4nTjKsvl69vm3Xs2/dQj5jUrbPMb/8WnXeVP1Xhd
 yrNViaU4I9FQi7moOBEAZw8TzVgDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-548.messagelabs.com!1682574292!59995!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32611 invoked from network); 27 Apr 2023 05:44:52 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-20.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Apr 2023 05:44:52 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id A06481001AB
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 06:44:52 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 93CB01001AA
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 06:44:52 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 27 Apr 2023 06:44:50 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 27 Apr 2023 13:44:25 +0800
Message-ID: <1682574265-12953-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1682574265-12953-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1827762.iFF2E32hkL@localhost>
 <1682574265-12953-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/mlock04: Convert into new api
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

Also add linux tag and useful url.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock04.c | 110 ++++++++--------------
 1 file changed, 38 insertions(+), 72 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock04.c b/testcases/kernel/syscalls/mlock/mlock04.c
index 8ac884583..f25460ba1 100644
--- a/testcases/kernel/syscalls/mlock/mlock04.c
+++ b/testcases/kernel/syscalls/mlock/mlock04.c
@@ -1,102 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * This is a reproducer copied from one of LKML patch submission,
+ * Copyright (C) 2010  Red Hat, Inc.
+ */
+
+/*\
+ * [Description]
+ *
+ * This is a reproducer copied from one of LKML patch submission
  * which subject is
  *
  * [PATCH] mlock: revert the optimization for dirtying pages and triggering writeback.
+ * url see https://www.spinics.net/lists/kernel/msg1141090.html
  *
  * "In 5ecfda0, we do some optimization in mlock, but it causes
  * a very basic test case(attached below) of mlock to fail. So
  * this patch revert it with some tiny modification so that it
  * apply successfully with the lastest 38-rc2 kernel."
  *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
+ * This bug was fixed by kernel
+ * commit fdf4c587a7 ("mlock: operate on any regions with protection != PROT_NONE")
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * As this case does, mmaps a file with PROT_WRITE permissions but without
+ * PROT_READ, so attempt to not unnecessarity break COW during mlock ended up
+ * causing mlock to fail with a permission problem on unfixed kernel.
  */
-#include "test.h"
-#include "safe_macros.h"
-#include "config.h"
-
-char *TCID = "mlock04";
-int TST_TOTAL = 1;
 
 #include <sys/mman.h>
 #include <stdio.h>
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <sys/types.h>
-
-int fd, file_len = 40960;
-char *testfile = "test_mlock";
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-static void setup(void);
-static void cleanup(void);
+static int fd = -1, file_len = 40960;
+static char *testfile = "test_mlock";
 
-int main(void)
+static void verify_mlock(void)
 {
 	char *buf;
-	int lc;
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		buf = mmap(NULL, file_len, PROT_WRITE, MAP_SHARED, fd, 0);
-
-		if (buf == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
 
-		if (mlock(buf, file_len) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "mlock");
-
-		tst_resm(TINFO, "locked %d bytes from %p", file_len, buf);
-
-		if (munlock(buf, file_len) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munlock");
-
-		SAFE_MUNMAP(cleanup, buf, file_len);
-	}
-
-	tst_resm(TPASS, "test succeeded.");
-
-	cleanup();
-
-	tst_exit();
+	buf = SAFE_MMAP(NULL, file_len, PROT_WRITE, MAP_SHARED, fd, 0);
+	TST_EXP_PASS(mlock(buf, file_len), "mlock(%p, %d)", buf, file_len);
+	SAFE_MUNLOCK(buf, file_len);
+	SAFE_MUNMAP(buf, file_len);
 }
 
 static void setup(void)
 {
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-
-	SAFE_FTRUNCATE(cleanup, fd, file_len);
-
-	TEST_PAUSE;
+	fd = SAFE_OPEN(testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+	SAFE_FTRUNCATE(fd, file_len);
 }
 
 static void cleanup(void)
 {
-	close(fd);
-
-	tst_rmdir();
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_mlock,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "fdf4c587a793"},
+		{}
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

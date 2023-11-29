Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC74C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 06:12:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F01CA3CD949
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 07:12:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9AA3CD784
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 07:12:29 +0100 (CET)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 402546008EC
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 07:12:27 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="142913393"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; d="scan'208";a="142913393"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 15:12:26 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C7F0D6186
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:12:23 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 442AD1EFBF
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:12:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B404E6B805
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:12:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 581831A0071;
 Wed, 29 Nov 2023 14:12:21 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed, 29 Nov 2023 01:12:12 -0500
Message-Id: <20231129061212.72817-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28026.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28026.005
X-TMASE-Result: 10--9.245700-10.000000
X-TMASE-MatchedRID: /+von0vPuFE5rof3b4z0VKzGfgakLdjawTlc9CcHMZerwqxtE531VL6p
 xbTOjavyeDD58ltWiLljwEW5KMi9WFlDiuV7LjH+Be3KRVyu+k02LwvzxRX0gEZCAhWuYEvkFSU
 V/DOyrJYNUQt57QDCkAb1koAed1u/RzYE8qhFE/i628cXbnOhTz6h7Zt9E7MjmyiLZetSf8mfop
 0ytGwvXiq2rl3dzGQ1M+vPDq7OnbCiQUh1pDwNM9Wq5GHLnx4lHfvDn+NHxvlSgngGlhOfMg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] swapon02: Simplify code, add copyright,
 modify docparse
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

Simplify permission-related test code, making structures look simpler

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon02.c | 66 +++++++--------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index d34c17a80..e5129723e 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -1,56 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2002-2023
  */
 
 /*\
  * [Description]
  *
  * This test case checks whether swapon(2) system call returns
- *  1. ENOENT when the path does not exist
- *  2. EINVAL when the path exists but is invalid
- *  3. EPERM when user is not a superuser
- *  4. EBUSY when the specified path is already being used as a swap area
+ * - ENOENT when the path does not exist
+ * - EINVAL when the path exists but is invalid
+ * - EPERM when user is not a superuser
+ * - EBUSY when the specified path is already being used as a swap area
  */
 
-#include <errno.h>
 #include <pwd.h>
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
-static void setup01(void);
-static void cleanup01(void);
-
 static uid_t nobody_uid;
 static int do_swapoff;
 
 static struct tcase {
 	char *err_desc;
 	int exp_errno;
-	char *exp_errval;
 	char *path;
-	void (*setup)(void);
-	void (*cleanup)(void);
 } tcases[] = {
-	{"Path does not exist", ENOENT, "ENOENT", "./doesnotexist", NULL, NULL},
-	{"Invalid path", EINVAL, "EINVAL", "./notswap", NULL, NULL},
-	{"Permission denied", EPERM, "EPERM", "./swapfile01", setup01, cleanup01},
-	{"File already used", EBUSY, "EBUSY", "./alreadyused", NULL, NULL},
+	{"Path does not exist", ENOENT, "./doesnotexist"},
+	{"Invalid path", EINVAL, "./notswap"},
+	{"Permission denied", EPERM, "./swapfile01"},
+	{"File already used", EBUSY, "./alreadyused"},
 };
 
-static void setup01(void)
-{
-	SAFE_SETEUID(nobody_uid);
-}
-
-static void cleanup01(void)
-{
-	SAFE_SETEUID(0);
-}
-
 static void setup(void)
 {
 	struct passwd *nobody;
@@ -70,7 +53,7 @@ static void setup(void)
 		do_swapoff = 1;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (do_swapoff && tst_syscall(__NR_swapoff, "alreadyused"))
 		tst_res(TWARN | TERRNO, "swapoff(alreadyused) failed");
@@ -79,24 +62,19 @@ void cleanup(void)
 static void verify_swapon(unsigned int i)
 {
 	struct tcase *tc = tcases + i;
-	if (tc->setup)
-		tc->setup();
-
-	TEST(tst_syscall(__NR_swapon, tc->path, 0));
-
-	if (tc->cleanup)
-		tc->cleanup();
-
-	if (TST_RET == -1 && TST_ERR == tc->exp_errno) {
-		tst_res(TPASS, "swapon(2) expected failure;"
-			 " Got errno - %s : %s",
-			 tc->exp_errval, tc->err_desc);
-		return;
+	if (tc->exp_errno == EPERM)
+		SAFE_SETEUID(nobody_uid);
+
+	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, 0), tc->exp_errno,
+		     "swapon(2) fail with %s", tc->err_desc);
+
+	if (tc->exp_errno == EPERM)
+		SAFE_SETEUID(0);
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "swapon(2) failed unexpectedly, expected: %s",
+			tst_strerrno(tc->exp_errno));
 	}
-
-	tst_res(TFAIL, "swapon(2) failed to produce expected error:"
-	         " %d, errno: %s and got %d.", tc->exp_errno,
-	         tc->exp_errval, TST_ERR);
 }
 
 static struct tst_test test = {
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

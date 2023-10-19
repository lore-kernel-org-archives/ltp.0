Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66F9CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 06:47:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7602A3CD06D
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 08:47:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64B193C84BF
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 08:47:34 +0200 (CEST)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 896E9602BDC
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 08:47:32 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="138192999"
X-IronPort-AV: E=Sophos;i="6.03,236,1694703600"; d="scan'208";a="138192999"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 15:47:31 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E2C3ECD7E9
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 15:47:28 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DDE87BCB62
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 15:47:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76592200501A4
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 15:47:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 28D1D1A0071;
 Thu, 19 Oct 2023 14:47:27 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 19 Oct 2023 14:47:09 +0800
Message-Id: <1697698029-31949-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27944.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27944.005
X-TMASE-Result: 10--9.245700-10.000000
X-TMASE-MatchedRID: /+von0vPuFE5rof3b4z0VKzGfgakLdjawTlc9CcHMZerwqxtE531VL6p
 xbTOjavyeDD58ltWiLljwEW5KMi9WFlDiuV7LjH+Be3KRVyu+k02LwvzxRX0gEZCAhWuYEvkFSU
 V/DOyrJYNUQt57QDCkAb1koAed1u/RzYE8qhFE/i628cXbnOhTz6h7Zt9E7MjmyiLZetSf8mfop
 0ytGwvXiq2rl3dzGQ1eqPDNxZp5CwOxerD36n1/EellFFIijkaYEz0b9HPdHBx0PttDAMa8g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapon02: Simplify code, add copyright,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Simplify permission-related test code, making structures look simpler

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon02.c | 57 +++++++--------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index d34c17a80..2c9e39986 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -1,17 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
  */
 
 /*\
  * [Description]
  *
  * This test case checks whether swapon(2) system call returns
- *  1. ENOENT when the path does not exist
- *  2. EINVAL when the path exists but is invalid
- *  3. EPERM when user is not a superuser
- *  4. EBUSY when the specified path is already being used as a swap area
+ * - ENOENT when the path does not exist.
+ * - EINVAL when the path exists but is invalid.
+ * - EPERM when user is not a superuser.
+ * - EBUSY when the specified path is already being used as a swap area.
  */
 
 #include <errno.h>
@@ -21,36 +21,20 @@
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
@@ -79,24 +63,19 @@ void cleanup(void)
 static void verify_swapon(unsigned int i)
 {
 	struct tcase *tc = tcases + i;
-	if (tc->setup)
-		tc->setup();
+	if (tc->exp_errno == EPERM)
+		SAFE_SETEUID(nobody_uid);
 
-	TEST(tst_syscall(__NR_swapon, tc->path, 0));
+	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, 0), tc->exp_errno,
+		     "swapon(2) fail with %s", tc->err_desc);
 
-	if (tc->cleanup)
-		tc->cleanup();
+	if (tc->exp_errno == EPERM)
+		SAFE_SETEUID(0);
 
-	if (TST_RET == -1 && TST_ERR == tc->exp_errno) {
-		tst_res(TPASS, "swapon(2) expected failure;"
-			 " Got errno - %s : %s",
-			 tc->exp_errval, tc->err_desc);
-		return;
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

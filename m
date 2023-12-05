Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD17AC4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 06:17:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F2B03CC3A8
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 07:17:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98DE73CBF77
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:16:57 +0100 (CET)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA6F32009CC
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:16:55 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="121477130"
X-IronPort-AV: E=Sophos;i="6.04,251,1695654000"; d="scan'208";a="121477130"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 15:16:54 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3214BD7AE8
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:51 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D396D88B8
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E8E4E2007B701
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:49 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A00091A0071;
 Tue,  5 Dec 2023 14:16:49 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  5 Dec 2023 01:16:38 -0500
Message-Id: <20231205061639.68656-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
References: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28038.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28038.005
X-TMASE-Result: 10--9.608600-10.000000
X-TMASE-MatchedRID: ojZhuzNjofOPo+6vQMop+qzGfgakLdjawTlc9CcHMZerwqxtE531VIPc
 XuILVCbat52LZu/NbuP5KQEoKNwwIHyAL08NM00eutvHF25zoU8kPki1Yfh9Il/8lGqVstJXXJg
 Pk+dCjq2wDEIJD1Y7K6loc6WqrZaZICxs2SEh5wGIf3m0sUfx5za6AaQm7fhmPHMAbjuhwd9G1Q
 vheJ9Oe7vlPk1VIqp1gDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/s/WxM7wRQia704rMS4XOUcP4j3
 pyGCyOJZr2vw798TI48KQxoBVDnpQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls/swapon03: Use get_maxswapfiles() api
 instead of hard code
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
 testcases/kernel/syscalls/swapon/swapon03.c | 47 +++------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index dc633ebc6..744fca3d1 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -19,14 +19,12 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "swaponoff.h"
 #include "libswap.h"
 
 static int setup_swap(void);
 static int clean_swap(void);
 static int check_and_swapoff(const char *filename);
-
-static int swapfiles;
+static int swapfiles, max_swapfiles;
 
 int testfiles = 3;
 static struct swap_testfile_t {
@@ -57,47 +55,13 @@ static void verify_swapon(void)
 			"(%d). System reboot recommended.",
 			expected_errno);
 	} else {
-		/* Probably the system supports MAX_SWAPFILES > 30,
-		 * let's try with MAX_SWAPFILES == 32 */
-
-		/* Call swapon sys call once again for 32
-		 * now we can't receive an error */
-		TEST(tst_syscall(__NR_swapon, swap_testfiles[1].filename, 0));
-
-		/* Check return code (now we're expecting success) */
-		if (TST_RET < 0) {
-			tst_res(TFAIL | TTERRNO,
-				"swapon(2) got an unexpected failure");
-		} else {
-			/* Call swapon sys call once again for 33
-			 * now we have to receive an error */
-			TEST(tst_syscall(__NR_swapon, swap_testfiles[2].filename, 0));
-
-			/* Check return code (should be an error) */
-			if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
-				tst_res(TPASS,
-					"swapon(2) got expected failure;"
-					" Got errno = %d, probably your"
-					" MAX_SWAPFILES is 32",
-					expected_errno);
-			} else {
-				tst_res(TFAIL,
-					"swapon(2) failed to produce"
-					" expected error: %d, got %s."
-					" System reboot after execution of LTP"
-					" test suite is recommended.",
-					expected_errno, strerror(TST_ERR));
-			}
-		}
+		tst_res(TFAIL, "swapon(2) succeeded unexpectedly");
 	}
 
 	if (clean_swap() < 0)
 		tst_brk(TBROK, "Cleanup failed, quitting the test");
 }
 
-/*
- * Create 33 and activate 30 swapfiles.
- */
 static int setup_swap(void)
 {
 	pid_t pid;
@@ -139,9 +103,10 @@ static int setup_swap(void)
 		tst_brk(TFAIL, "Failed to find existing number of swapfiles");
 
 	/* Determine how many more files are to be created */
-	swapfiles = MAX_SWAPFILES - swapfiles;
-	if (swapfiles > MAX_SWAPFILES)
-		swapfiles = MAX_SWAPFILES;
+	max_swapfiles = (int)get_maxswapfiles();
+	swapfiles = max_swapfiles - swapfiles;
+	if (swapfiles > max_swapfiles)
+		swapfiles = max_swapfiles;
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		/*create and turn on remaining swapfiles */
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

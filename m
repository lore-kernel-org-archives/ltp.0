Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9C9C41535
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 06:56:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DB1D3CEF17
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 07:55:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A67FB3CEEFF
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:55:37 +0100 (CET)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D77E060A77D
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:55:36 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="132299367"
X-IronPort-AV: E=Sophos;i="6.04,294,1695654000"; d="scan'208";a="132299367"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 15:55:34 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 74A61D6188
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:55:32 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BE0FEF9A5
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:55:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 598E96C826
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:55:31 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 09A251A006F;
 Fri, 22 Dec 2023 14:55:31 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 00:00:02 -0500
Message-Id: <20231222050006.148845-3-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.005
X-TMASE-Result: 10--7.893900-10.000000
X-TMASE-MatchedRID: hPnsbxNiy9KPo+6vQMop+qzGfgakLdjawTlc9CcHMZerwqxtE531VIPc
 XuILVCbak2rNDhoFVtmq5anvU2i8LHk5VN4DJHKIh2VzUlo4HVM2LwvzxRX0gEA6+2WeJ60F8/e
 HChOsjzqBx0ShwZLio0dHbFW6uX0ZNYwYTEoASsF1e7Xbb6Im2sLiFiL0BG1umyiLZetSf8nyb6
 HMFK1qe3YJEUfDojP/IAcCikR3vq/9ndWXM3ZW70KIx7dA8DSkGBf59rerE/DUSIohVmB9EUQ9n
 BW9wdMy
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] syscalls/swapon03: use get_maxswapfiles() and
 GET_USED_SWAPFILES() api
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
 testcases/kernel/syscalls/swapon/swapon03.c | 40 ++++-----------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index dc633ebc6..a553dd485 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -19,7 +19,6 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "swaponoff.h"
 #include "libswap.h"
 
 static int setup_swap(void);
@@ -101,47 +100,20 @@ static void verify_swapon(void)
 static int setup_swap(void)
 {
 	pid_t pid;
-	int j, fd;
+	int j, max_swapfiles, used_swapfiles;
 	int status;
 	int res = 0;
 	char filename[FILENAME_MAX];
-	char buf[BUFSIZ + 1];
-
-	/* Find out how many swapfiles (1 line per entry) already exist */
-	swapfiles = 0;
 
 	if (seteuid(0) < 0)
 		tst_brk(TFAIL | TERRNO, "Failed to call seteuid");
 
-	/* This includes the first (header) line */
-	if ((fd = open("/proc/swaps", O_RDONLY)) == -1) {
-		tst_brk(TFAIL | TERRNO,
-			"Failed to find out existing number of swap files");
-	}
-	do {
-		char *p = buf;
-		res = read(fd, buf, BUFSIZ);
-		if (res < 0) {
-			tst_brk(TFAIL | TERRNO,
-				 "Failed to find out existing number of swap files");
-		}
-		buf[res] = '\0';
-		while ((p = strchr(p, '\n'))) {
-			p++;
-			swapfiles++;
-		}
-	} while (BUFSIZ <= res);
-	close(fd);
-	if (swapfiles)
-		swapfiles--;	/* don't count the /proc/swaps header */
-
-	if (swapfiles < 0)
-		tst_brk(TFAIL, "Failed to find existing number of swapfiles");
-
 	/* Determine how many more files are to be created */
-	swapfiles = MAX_SWAPFILES - swapfiles;
-	if (swapfiles > MAX_SWAPFILES)
-		swapfiles = MAX_SWAPFILES;
+	max_swapfiles = (int)get_maxswapfiles();
+	used_swapfiles = GET_USED_SWAPFILES();
+	swapfiles = max_swapfiles - used_swapfiles;
+	if (swapfiles > max_swapfiles)
+		swapfiles = max_swapfiles;
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		/*create and turn on remaining swapfiles */
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

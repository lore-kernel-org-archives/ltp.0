Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E2BC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 06:53:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BDB83C9190
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 07:52:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32CAA3C8FDB
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:52:48 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7DDCB200BB7
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639983166; i=@fujitsu.com;
 bh=rfBRM05lJpqFUY8BQan6dns0pKXxAOTYOlruINzzkZM=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=aa+yWdBsm09lNS3KJPJpv3IRhuqpjEPdbm0YnXaqI62drFkNZPL6p8PO0MA+HATWo
 SKh58hMEoZs+oFaoa9R2qQioRt2ACaHKe12tRbetxVFk1hp7h1CyAx7R4e2TNYgGxm
 N2GSPiwnVVNOQukWtftmuR754NBTca4ORR+/cBrKQR7oov6pl7Y4lRsBABLfMSiDKx
 t902Yv6j3xxopFZxMt62zkLnlhk+1B0WVwSNk4rZkDWg9Zop8FDTgnAO+1QELSq4gO
 8DZ94WqjMGVdfv7dS1O55P/XcUcwn1HhJsqAAq4ob6uIlgrhetzUHUBFu/1UgcgHMC
 pjx05ywTnPKQQ==
Received: from [100.115.34.181] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 65/7A-23453-E3820C16;
 Mon, 20 Dec 2021 06:52:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8ORqGuncSD
 RYMYVRosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPylbOsBU95Kv5eTGtgfMHVxcjFISRwllHi
 5eSDzBDOTiaJW3euMUE4exgl3k1pY+ti5ORgE9CUeNa5gBnEFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFvCQmL20kwXEZhFQlWj/eAishhcofvvvWbA5EgIKElMevmeGiAtKnJz5hAVijoTEwRcvmC
 FqFCUudXxjhLArJGbNamOCsNUkrp7bxDyBkX8WkvZZSNoXMDKtYrROKspMzyjJTczM0TU0MNA
 1NDTVNbYAUoZ6iVW6iXqppbrlqcUlukZ6ieXFeqnFxXrFlbnJOSl6eaklmxiBYZlSrJa/g/Hv
 yp96hxglOZiURHkFuvcmCvEl5adUZiQWZ8QXleakFh9ilOHgUJLglVc/kCgkWJSanlqRlpkDj
 BGYtAQHj5IIr6caUJq3uCAxtzgzHSJ1ilFRSpzXA6RPACSRUZoH1waLy0uMslLCvIwMDAxCPA
 WpRbmZJajyrxjFORiVhHn5QabwZOaVwE1/BbSYCWixUvh+kMUliQgpqQYmcVnZZ5En2S7NktP
 XvRC90UiobtPfH+ncnN+Sfm5a2h1w7FXV3IX5X5S+x02xXK8es737wEuhgzvOLJr6yc3V5vdX
 +0myvP3++VoRHaoKi/vkOepTdOZlOUfsKtR3MJIIKljXwhczRcXmrM6VL8xtxXFesRa3+babS
 bg0xnFWnFuqdcLQMJBzcoeYeubTHq+VQfz//pQw9lSUnV0aFrbG/PcNhdBaNcPDP/8+ms+sL2
 wusD3ISjSX4eDKRA7zBSLrXl3137B6m88jlf32LtM/lDb4fyq4Mau4qiFOX7myIkOQY9+exVd
 1djc9qtzE+OK7p6qgMI9dxNGAzuf3BEySHkctks3+0a9m1FTwXImlOCPRUIu5qDgRANGlPEBG
 AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-565.messagelabs.com!1639983165!219130!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3667 invoked from network); 20 Dec 2021 06:52:46 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-22.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Dec 2021 06:52:46 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id A8486100248
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:52:45 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 9D451100231
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:52:45 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 20 Dec 2021 06:52:23 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 20 Dec 2021 14:52:19 +0800
Message-ID: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/4] swapping01: skip test if zram-swap is being
 used
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

For the swapping test we attempt to allocate 130% of the available RAM and
we make sure that the overflow would fit the swap, but as long as swap is
backed by RAM this obviously false. So skip it if zram-swap is being used.

Also make check happy.

Fixes: #888
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 25 ++++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 392b79d65..498f502c1 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -40,10 +40,10 @@
 
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include "tst_safe_stdio.h"
 #include "lapi/abisize.h"
 #include "mem.h"
 
@@ -67,16 +67,27 @@ static void test_swapping(void)
 #ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
+	FILE *file;
+	char line[PATH_MAX];
+
+	file = SAFE_FOPEN("/proc/swaps", "r");
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, "/dev/zram")) {
+			SAFE_FCLOSE(file);
+			tst_brk(TCONF, "zram-swap is being used!");
+		}
+	}
+	SAFE_FCLOSE(file);
 
 	init_meminfo();
 
 	switch (pid = SAFE_FORK()) {
-		case 0:
-			do_alloc(0);
-			do_alloc(1);
-			exit(0);
-		default:
-			check_swapping();
+	case 0:
+		do_alloc(0);
+		do_alloc(1);
+		exit(0);
+	default:
+		check_swapping();
 	}
 }
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

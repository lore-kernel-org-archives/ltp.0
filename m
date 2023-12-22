Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFACC41535
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 06:57:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E188C3CEF1E
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 07:57:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B65FC3C81C6
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:57:12 +0100 (CET)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D158E1A001C9
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:57:10 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="132679192"
X-IronPort-AV: E=Sophos;i="6.04,294,1695654000"; d="scan'208";a="132679192"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 15:57:09 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1156CD7AC6
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:57:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 39A34D601A
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:57:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id CB350202C9741
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:57:05 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 7DED91A006F;
 Fri, 22 Dec 2023 14:57:05 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 00:00:06 -0500
Message-Id: <20231222050006.148845-7-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.005
X-TMASE-Result: 10--5.234500-10.000000
X-TMASE-MatchedRID: NuUGwdOZh4b5S+IvXI7mDQA+Y0oNaxbQ1QQ6Jx/fflbEWhdVdXNnv4nO
 /I/i7S2AIvrftAIhWmLy9zcRSkKatWk5Fql3Faa7Y1fUkIWBImr0swHSFcVJ6Ls3Yh2IOCYzBv9
 +XtincoPi8zVgXoAltsIJ+4gwXrEtIAcCikR3vq/SIqa+Qv0wq59PtedMEG6K/I4pDH9aHX/YfS
 qYjlK0eBLynu0CNWG7
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] Add fallback for RHEL9
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

Since device number patch and pte number patch have been backported into
RHEL9,  we should add fallback for this distro.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 libs/libltpswap/libswap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index e10a6f5b2..8c7729b8b 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -12,6 +12,7 @@
 #include "libswap.h"
 #include "lapi/syscalls.h"
 #include "tst_kconfig.h"
+#include "tst_kvercmp.h"
 #include "tst_safe_stdio.h"
 
 #define BUFSIZE 1024
@@ -81,6 +82,11 @@ unsigned int get_maxswapfiles(void)
 	struct tst_kconfig_var memory_kconfig = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
 	struct tst_kconfig_var device_kconfig = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
 	struct tst_kconfig_var marker_kconfig = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
+	struct tst_kern_exv kvers[] = {
+		/* RHEL9 kernel has patch 6c287605f and 679d10331 since 5.14.0-179 */
+		{ "RHEL9", "5.14.0-179" },
+		{ NULL, NULL},
+	};
 
 	tst_kconfig_read(&migration_kconfig, 1);
 	tst_kconfig_read(&memory_kconfig, 1);
@@ -88,7 +94,7 @@ unsigned int get_maxswapfiles(void)
 	tst_kconfig_read(&marker_kconfig, 1);
 
 	if (migration_kconfig.choice == 'y') {
-		if (tst_kvercmp(5, 19, 0) < 0)
+		if (tst_kvercmp2(5, 19, 0, kvers) < 0)
 			swp_migration_num = 2;
 		else
 			swp_migration_num = 3;
@@ -105,7 +111,7 @@ unsigned int get_maxswapfiles(void)
 	}
 
 	if (marker_kconfig.choice == 'y') {
-		if (tst_kvercmp(5, 19, 0) >= 0)
+		if (tst_kvercmp2(5, 19, 0, kvers) >= 0)
 			swp_pte_marker_num = 1;
 	}
 
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

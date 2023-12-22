Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B08C41535
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 06:55:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B5D23CEF0B
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 07:55:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09E843CB4D9
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:55:26 +0100 (CET)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 10F5314052CA
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 07:55:25 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="144286465"
X-IronPort-AV: E=Sophos;i="6.04,294,1695654000"; d="scan'208";a="144286465"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 15:55:23 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F177D9DA5
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:55:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A589F969
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:55:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BA7E7200A80C3
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 15:55:19 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6DB761A006F;
 Fri, 22 Dec 2023 14:55:19 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 00:00:01 -0500
Message-Id: <20231222050006.148845-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.005
X-TMASE-Result: 10--5.956400-10.000000
X-TMASE-MatchedRID: TZ/n+46y21jbleHqjUmY36oXHZz/dXlx+VJ6lZyB0s86FHRWx2FGsL8F
 Hrw7frluf146W0iUu2vtrTvo40oHfsIRMxauaS3UutvHF25zoU8WUg/hm489yJ4Q+L3BXIWu5p9
 TGNmpllG+B7lET5qElvJcAJWYjOv3HxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwYBDjMkL7kP34k3
 OUIocnNSI1AwuqsDnmz8U/3YjNOAngm7GE1alzIw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] libltpswap: alter get_used_swapfiles api
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

Like we count the ipc resouce total, we can also add a similar api
for swapfiles, so we can use it for swapon03 case.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libswap.h         |  7 +++++++
 libs/libltpswap/libswap.c | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index 2cab1047d..7f8df1032 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -27,4 +27,11 @@ void is_swap_supported(const char *filename);
  */
 unsigned int get_maxswapfiles(void);
 
+/*
+ * Get the used swapfiles number
+ */
+int get_used_swapfiles(const char *file, const int lineno);
+#define GET_USED_SWAPFILES() \
+	get_used_swapfiles(__FILE__, __LINE__)
+
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 658ecede7..e10a6f5b2 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -14,6 +14,8 @@
 #include "tst_kconfig.h"
 #include "tst_safe_stdio.h"
 
+#define BUFSIZE 1024
+
 /*
  * Make a swap file
  */
@@ -109,3 +111,27 @@ unsigned int get_maxswapfiles(void)
 
 	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
 }
+
+/*
+ * Get the used swapfiles number
+ */
+int get_used_swapfiles(const char *file, const int lineno)
+{
+	FILE *fp;
+	int used = -1;
+	char buf[BUFSIZE];
+
+	fp = safe_fopen(file, lineno, NULL, "/proc/swaps", "r");
+
+	while (fgets(buf, BUFSIZE, fp) != NULL)
+		used++;
+
+	fclose(fp);
+
+	if (used < 0) {
+		tst_brk(TBROK, "can't read /proc/swaps to get used swapfiles resource total "
+			"at %s:%d", file, lineno);
+	}
+
+	return used;
+}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

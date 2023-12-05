Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D31CC4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 06:17:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D8553CF5AB
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 07:17:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 212BC3CBF77
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:16:57 +0100 (CET)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8C76F1A00930
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:16:54 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="142060753"
X-IronPort-AV: E=Sophos;i="6.04,251,1695654000"; d="scan'208";a="142060753"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 15:16:53 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 385BCE8BF9
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:50 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 66A9E28726
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D782820076295
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:48 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8AA8B1A0071;
 Tue,  5 Dec 2023 14:16:48 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  5 Dec 2023 01:16:37 -0500
Message-Id: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28038.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28038.005
X-TMASE-Result: 10--4.742400-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cMJoDeiZ6YZhKzGfgakLdjaFlIP4ZuPPcieEPi9wVyFrtKD
 G5MND8uRxQpkW8mbnN+hH3kE6Tg1fLVQ6XPWwtdyEXjPIvKd74BMkOX0Uoduuc+FtP9CIg3lmpH
 BBD3V5Wy9nMtClKxHtPJcAJWYjOv3HxPMjOKY7A8LbigRnpKlKZx+7GyJjhAUFxiw90guk/tFwX
 YguRPLjGfWzizl3Prbu4EkA2Rg4a2WYzUH0sWt2uJDaybX6It20OYTPaKJ4er/1MEiACvrqiCo1
 uO6LMkOmw0Qaktp+ussz+cQMs/Tnp75MOLIf/j3DF+QsB+Q01JoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] libltpswap: Add get_maxswapfiles api
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

Current, the kernel constant MAX_SWAPFILES value is calculated as below
------------------------------------
//#ifdef CONFIG_DEVICE_PRIVATE
//#define SWP_DEVICE_NUM 4
//#else
//#define SWP_DEVICE_NUM 0
//#endif

//#ifdef CONFIG_MIGRATION
//#define SWP_MIGRATION_NUM 3
//#else
//#define SWP_MIGRATION_NUM 0

//#ifdef CONFIG_MEMORY_FAILURE
//#define SWP_HWPOISON_NUM 1
//#else
//#define SWP_HWPOISON_NUM 0
//#endif

//#define SWP_PTE_MARKER_NUM 1
//#define MAX_SWAPFILES_SHIFT	5

//#define MAX_SWAPFILES \
//	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
//	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
//	SWP_PTE_MARKER_NUM)
------------------------------------

Also, man-pages missed something after 5.14 kernel. I have sent two patches to
add it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libswap.h         |  6 ++++++
 libs/libltpswap/libswap.c | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index d4b5301a5..2cab1047d 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -21,4 +21,10 @@ int make_swapfile(const char *swapfile, int safe);
  * we are testing on.
  */
 void is_swap_supported(const char *filename);
+
+/*
+ * Get kernel constant MAX_SWAPFILES value
+ */
+unsigned int get_maxswapfiles(void);
+
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index a4427736f..54317c627 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -11,6 +11,7 @@
 #include "tst_test.h"
 #include "libswap.h"
 #include "lapi/syscalls.h"
+#include "tst_kconfig.h"
 
 /*
  * Make a swap file
@@ -63,3 +64,43 @@ void is_swap_supported(const char *filename)
 	if (TST_RET == -1)
 		tst_brk(TFAIL | TTERRNO, "swapoff on %s failed", fstype);
 }
+
+/*
+ * Get kernel constant MAX_SWAPFILES value
+ */
+unsigned int get_maxswapfiles(void)
+{
+	unsigned int max_swapfile = 32;
+	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
+	struct tst_kconfig_var migration_kconfig = TST_KCONFIG_INIT("CONFIG_MIGRATION");
+	struct tst_kconfig_var memory_kconfig = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
+	struct tst_kconfig_var device_kconfig = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
+	struct tst_kconfig_var marker_kconfig = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
+
+	tst_kconfig_read(&migration_kconfig, 1);
+	tst_kconfig_read(&memory_kconfig, 1);
+	tst_kconfig_read(&device_kconfig, 1);
+	tst_kconfig_read(&marker_kconfig, 1);
+
+	if (migration_kconfig.choice == 'y') {
+		if (tst_kvercmp(5, 19, 0) < 0)
+			swp_migration_num = 2;
+		else
+			swp_migration_num = 3;
+	}
+
+	if (memory_kconfig.choice == 'y')
+		swp_hwpoison_num = 1;
+
+	if (device_kconfig.choice == 'y') {
+		if (tst_kvercmp(5, 14, 0) >= 0)
+			swp_device_num = 4;
+	}
+
+	if (marker_kconfig.choice == 'y') {
+		if (tst_kvercmp(5, 19, 0) < 0)
+			swp_pte_marker_num = 1;
+	}
+
+	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
+}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

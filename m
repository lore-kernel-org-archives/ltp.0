Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3682DC4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707386752; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=2MCo0NkQvory78jKCzpAUSsBnv9g5dWfV96my/qheuU=;
 b=MsejGA05c1N0ySfQXsDy3ykxS8KmaP0gJXC0G8akwXsgtIc7PqhEKDzYfCh5yywWeAhKJ
 sR9NU8crpvwtSI9+9s6f0boWTJBKFq6nDGwAbofwCJQtt8bXQc5cjS1GkZtP6ioFwi/+5sv
 fzpZa2HrHDdUbjdMhrWU/4dYmHTUDF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 693303CDEA8
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 11:05:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB7783C5AC4
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D593B10007C8
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707386729; x=1738922729;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aoo6e7YB5WUi7e4/CXc3LxRG8k+mnAbenAjM5A2LngU=;
 b=FB32jb5MN6ikL+kvO2+3kpJTFvsRN2Pt7coubsV70fGUlFoHCfP13l4b
 pEJWKYnBH/9Eecpz3D5k/aF7tVK1EpJl0SQ8EHt5P7ZgrSmZyVdnoM7vZ
 chrMOmtdRPNdGpHs5OLo3DTVydxExygdrZZYVT4P/ZOp9EcwC8AzCN2Hf
 OSHpECLb81Ak1Q3k97opj1E6/ZzrxwJEHRv3twqllCd8lWmOGBfk2TeRp
 Ayqp5zbOaKcg9z1LRn8yIonWO1fiLLYMlLBMj48Hem6QF6cgYcVvgyYJi
 LfXQHKZnaDKYpFmvl9E03f2iZxZlzZ/7xh/fTk3u2vemmKkagAS4DQqj1 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="148804453"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; d="scan'208";a="148804453"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 19:05:26 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B79A38BF0F
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:23 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 01FF8F31B0
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 888D341043
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:22 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 16BCA1A009A;
 Thu,  8 Feb 2024 18:05:21 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 05:05:11 -0500
Message-Id: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.003
X-TMASE-Result: 10--8.914200-10.000000
X-TMASE-MatchedRID: toN6SH028bXlWiNI/3lAD79A3Bl1/DcVTFQnI+epPIZCw17cr3HRBx/X
 wLPL3ezhMqXIprsw7E8foWaqRA7iyogrKnsJ1GRgTuctSpiuWyUUi4Ehat05499RlPzeVuQQXfA
 pMkKyKiOTas0OGgVW2UDzPxrZuPWDDPIzF4wRfrAURSScn+QSXt0H8LFZNFG7bkV4e2xSge7mIH
 WMNYTzgK7rh8uDUM1wdgK03GLUbYHoMkReFyp1CsWFcyN1Agmm
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/7] libltpswap: Add tst_max_swapfiles api
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
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
//#define MAX_SWAPFILES_SHIFT   5

//#define MAX_SWAPFILES \
//      ((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
//      SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
//      SWP_PTE_MARKER_NUM)
------------------------------------
Also, man-pages missed something after 5.14 kernel. I have sent two patches[1][2] to
add it. The kernel patches modify this kernel constant in[3][4][5][6].

[1]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=26f3ec74e
[2]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=6bf3937fc
[3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=5042db43cc
[4]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=b756a3b5e
[5]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=679d10331
[6]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=6c287605f

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libswap.h         |  6 ++++++
 libs/libltpswap/libswap.c | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index bdc5aacc6..361d73175 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -21,4 +21,10 @@ int make_swapfile(const char *swapfile, int blocks, int safe);
  * we are testing on.
  */
 bool is_swap_supported(const char *filename);
+
+/*
+ * Get kernel constant MAX_SWAPFILES value
+ */
+int tst_max_swapfiles(void);
+
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index c79de19d7..69273fb33 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -16,6 +16,8 @@
 #include "tst_test.h"
 #include "libswap.h"
 #include "lapi/syscalls.h"
+#include "tst_kconfig.h"
+#include "tst_safe_stdio.h"
 
 static const char *const swap_supported_fs[] = {
 	"btrfs",
@@ -217,3 +219,45 @@ bool is_swap_supported(const char *filename)
 
 	return true;
 }
+
+/*
+ * Get kernel constant MAX_SWAPFILES value
+ */
+int tst_max_swapfiles(void)
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
+		if (tst_kvercmp(4, 14, 0) >= 0)
+			swp_device_num = 2;
+		if (tst_kvercmp(5, 14, 0) >= 0)
+			swp_device_num = 4;
+	}
+
+	if (marker_kconfig.choice == 'y') {
+		if (tst_kvercmp(5, 19, 0) >= 0)
+			swp_pte_marker_num = 1;
+	}
+
+	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
+}
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAA5C48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708955662; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Xtqj9883gBYZsM1rQZmupeZNQscMQvtfuSWj385tNBg=;
 b=JctwtL578u/jf0AvK0qIoGJ5lhyly3buiLSIjkyRKv/O9z49BzlbZaHTWjntbFRtxG0CJ
 c5Ss6c3e7OHL9/y17dzXfoGpw2aTI+nzaTsp8pKDEp05uK6Lpemfmw/pVUfUzFrcfohqu+L
 VS+JXw/bO2xbz87TEikRxQEcWwNSbjg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95C0F3CF005
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 14:54:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE5C83CD0CB
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:01 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB549600FAA
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708955640; x=1740491640;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=izSOIE9YS8u9w4ysvIo79EeeW5jyK2pA/mWdz9bkMxo=;
 b=uI5tHI3pwDBnH/PTJOuyyXQUqxuuC+LCuTBSJjqaNjsgka+MpB2RbTUT
 UncBmuHYhzu3O9d0izLF9P0nbPU4Aclzhl+fdRXJgZoXb/D1q0s/tCEDr
 Q6idjXHu8QP/S5/AoVZ1KL2g26XJweq2SC8j9HMc8o2xXi27UDvFp/f8U
 YLHfO9w8BWq+Q+ijuBkAZODRs1WtYXm8s+ivX9I7QCqQl8jwctujUr1pe
 cb16k6rRmNY06n8K0jGWnZhr73mB7GDwiVDg7VfdRMR4vG1nT8XIsRPeW
 uJ+ToUvsJuC0xebvU8XCTuNqSxdGYmV0hJZDBVx/HhjMXv16LYqpiDxwc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="150722445"
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; d="scan'208";a="150722445"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:53:57 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 77F81D3EA9
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:53:55 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AD8A64B896
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:53:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 387416BC7C
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:53:54 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9A0C61A006B;
 Mon, 26 Feb 2024 21:53:53 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 08:53:30 -0500
Message-Id: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28214.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28214.007
X-TMASE-Result: 10--11.154100-10.000000
X-TMASE-MatchedRID: I6rpFm0lrcPlWiNI/3lAD79A3Bl1/DcVTFQnI+epPIZCw17cr3HRBx/X
 wLPL3ezhWzJZFaSQW7c8yni6U6vewvoLRFtw/0Cmuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUgK6
 qCGa1Z9f+M7N/it0rQx9zrQMqS1FGmv0Xhs8HK82628cXbnOhT3O1oaQ51CuNmyiLZetSf8lBgw
 5G4NYCZIv4ihlXSKxeIAcCikR3vq8zy+GTcaK8vW32IkxOlFX2t2XpWUlnySmc/zwuXh142pdlC
 iWFzSHa
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/7] libltpswap: Add tst_max_swapfiles API
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

Currently, the kernel constant MAX_SWAPFILES value is calculated as below
------------------------------------
 #ifdef CONFIG_DEVICE_PRIVATE
 #define SWP_DEVICE_NUM 4
 #else
 #define SWP_DEVICE_NUM 0
 #endif

 #ifdef CONFIG_MIGRATION
 #define SWP_MIGRATION_NUM 3
 #else
 #define SWP_MIGRATION_NUM 0

 #ifdef CONFIG_MEMORY_FAILURE
 #define SWP_HWPOISON_NUM 1
 #else
 #define SWP_HWPOISON_NUM 0
 #endif

 #define SWP_PTE_MARKER_NUM 1
 #define MAX_SWAPFILES_SHIFT   5

 #define MAX_SWAPFILES \
	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
	SWP_PTE_MARKER_NUM)
------------------------------------
Also, man-pages missed something after 5.14 kernel. I have sent two patches[1][2] to
add it. The kernel patches modify this kernel constant in[3][4][5][6]. Also, after kernel 6.2.0
[7],kernel always compile in pte markers.

[1]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=26f3ec74e
[2]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=6bf3937fc
[3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=5042db43cc
[4]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=b756a3b5e
[5]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=679d10331
[6]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=6c287605f
[7]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=ca92ea3dc5

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libswap.h         |  7 +++++++
 libs/libltpswap/libswap.c | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index bdc5aacc6..cc68d5e6b 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -21,4 +21,11 @@ int make_swapfile(const char *swapfile, int blocks, int safe);
  * we are testing on.
  */
 bool is_swap_supported(const char *filename);
+
+/*
+ * Get kernel constant MAX_SWAPFILES value.
+ *
+ */
+int tst_max_swapfiles(void);
+
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index c79de19d7..3528a3fb9 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -12,10 +12,13 @@
 #include <stdbool.h>
 
 #define TST_NO_DEFAULT_MAIN
+#define DEFAULT_MAX_SWAPFILE 32
 
 #include "tst_test.h"
 #include "libswap.h"
 #include "lapi/syscalls.h"
+#include "tst_kconfig.h"
+#include "tst_safe_stdio.h"
 
 static const char *const swap_supported_fs[] = {
 	"btrfs",
@@ -217,3 +220,44 @@ bool is_swap_supported(const char *filename)
 
 	return true;
 }
+
+/*
+ * Get kernel constant MAX_SWAPFILES value.
+ */
+int tst_max_swapfiles(void)
+{
+	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
+	struct tst_kconfig_var migration = TST_KCONFIG_INIT("CONFIG_MIGRATION");
+	struct tst_kconfig_var memory = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
+	struct tst_kconfig_var device = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
+	struct tst_kconfig_var marker = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
+
+	tst_kconfig_read(&migration, 1);
+	tst_kconfig_read(&memory, 1);
+	tst_kconfig_read(&device, 1);
+	tst_kconfig_read(&marker, 1);
+
+	if (migration.choice == 'y') {
+		if (tst_kvercmp(5, 19, 0) < 0)
+			swp_migration_num = 2;
+		else
+			swp_migration_num = 3;
+	}
+
+	if (memory.choice == 'y')
+		swp_hwpoison_num = 1;
+
+	if (device.choice == 'y') {
+		if (tst_kvercmp(4, 14, 0) >= 0)
+			swp_device_num = 2;
+		if (tst_kvercmp(5, 14, 0) >= 0)
+			swp_device_num = 4;
+	}
+
+	if ((marker.choice == 'y' && tst_kvercmp(5, 19, 0) >= 0) ||
+		tst_kvercmp(6, 2, 0) >= 0) {
+		swp_pte_marker_num = 1;
+	}
+
+	return DEFAULT_MAX_SWAPFILE - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
+}
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

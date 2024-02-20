Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9281FC48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708414999; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=FeVFT7i8NMo7uRn+yjeGpSfQa1g5wj+LLfcXq5T6oQQ=;
 b=kROzPw8fsH0u88adATWuHcky6VuIq4XSB0t/wd5A/EciGxh4u8GQ7OTgjpR9MPvCbfY9U
 FgHHxesnLHWjNhzr4olar0n4BC8t5MPaI3UfIe6FfwRyIaGqGIFY+rGBgwM0SVPF2tH45hW
 31yYDD21Vx/PiErBqtZVjzt+AHZiaYw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AFB13CF1C1
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 08:43:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 937733C62A6
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:42:57 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 54C421000A35
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708414977; x=1739950977;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ixR0L9TPvUcd03qwUO+uTdBqUNWUm/DBEpUI4IaMp6w=;
 b=MVDJEgKETlOl2dbHXdjJm5LKsg+wuNUZsVlmAtNwyza1WcWdwHjoelzc
 9BIyPCxhZPxV/Rc3HJVfnFEXknsXRt+5kcYhAoKArK9/KNXUovv8uF7qk
 6IkOJJr7qJF5w+zkvrp2yr698/Hhatn1Gz3Kt4aJIgMNNqi19yYPHxTcs
 DY7BjPn7a+yBtydmZEP1noBoTARhsmg2UjOJ5uQhzlfcknOgZClPg3VRa
 BjCX5RZwVK+6M2Pq4VMtsxpb2QVck0MbUVG3Of+A8i5n0UNmixqYsqGUn
 MsDfzwlXs6jLmaPFIrE7a0lGzHb8rr4KjFeXi6tBopykOA8gqaNF1vHMj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="129264252"
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; d="scan'208";a="129264252"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 16:42:53 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 46386176148
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:42:50 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76840363A7
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:42:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id DFCC2200989E3
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:42:48 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 90C681A006B;
 Tue, 20 Feb 2024 15:42:48 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 02:42:12 -0500
Message-Id: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28202.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28202.005
X-TMASE-Result: 10--12.293100-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXTlWiNI/3lAD79A3Bl1/DcVTFQnI+epPIZCw17cr3HRBx/X
 wLPL3ezhWzJZFaSQW7c8yni6U6vewvoLRFtw/0Cmuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUgK6
 qCGa1Z9fFBN1AwBTiZMbFCzS1UBluC8OYzF1BQS6eAiCmPx4NwJuJ+Pb8n/VxFFhlCEob7a0qtq
 5d3cxkNQP81d+A0LLVf5GEkqcAgxBYSARJ2hFzgWln3iFvxebTUeKPSUWqNJ0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/7] libltpswap: Add tst_max_swapfiles api
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
add it. The kernel patches modify this kernel constant in[3][4][5][6]. Also, after kernel 6.2.0
[7],kernel always compile in pte markers.

[1]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=26f3ec74e
[2]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=6bf3937fc
[3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=5042db43cc
[4]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=b756a3b5e
[5]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=679d10331
[6]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=6c287605f
[7]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=ca92ea3dc5

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libswap.h         |  6 +++++
 libs/libltpswap/libswap.c | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

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
index c79de19d7..a404a4ada 100644
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
@@ -217,3 +219,49 @@ bool is_swap_supported(const char *filename)
 
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
+	if (tst_kvercmp(6, 2, 0) >= 0) {
+		swp_pte_marker_num = 1;
+	} else {
+		if (marker_kconfig.choice == 'y') {
+			if (tst_kvercmp(5, 19, 0) >= 0)
+				swp_pte_marker_num = 1;
+		}
+	}
+
+	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
+}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

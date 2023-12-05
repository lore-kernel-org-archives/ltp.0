Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5123FC4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 06:17:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A6F3CD8C9
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 07:17:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2D623CBF85
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:16:58 +0100 (CET)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9DB7600CCC
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:16:57 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="130438137"
X-IronPort-AV: E=Sophos;i="6.04,251,1695654000"; d="scan'208";a="130438137"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 15:16:54 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 45C56D64A0
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6D7E1BF4A0
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 040052007B701
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:16:51 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A2C0C1A0071;
 Tue,  5 Dec 2023 14:16:50 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  5 Dec 2023 01:16:39 -0500
Message-Id: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
References: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28038.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28038.005
X-TMASE-Result: 10--9.963700-10.000000
X-TMASE-MatchedRID: uXLKq++rPJdlJTodqNqEzqzGfgakLdjalwT0XposETW+f7ap9DJaDb8F
 Hrw7frluf146W0iUu2tMCgkc3/BmTUwYXRRr2ymnfOaYwP8dcX4ogaQhRNNEvpsoi2XrUn/J8m+
 hzBStansUGm4zriL0oQtuKBGekqUpI/NGWt0UYPArDdi+0UXUjf7DjywJezFAalWSuTFeCDFc6V
 Qb0Hn5VK8e8eBqaP6r
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] swaponoff.h: Remove useless header
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

Since we have use get_maxswapfiles() api in swapon03.c, so this header
is useless and can be removed safely.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swaponoff.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/swapon/swaponoff.h

diff --git a/testcases/kernel/syscalls/swapon/swaponoff.h b/testcases/kernel/syscalls/swapon/swaponoff.h
deleted file mode 100644
index 900761bda..000000000
--- a/testcases/kernel/syscalls/swapon/swaponoff.h
+++ /dev/null
@@ -1,8 +0,0 @@
-
-#ifndef __SWAP_ON_OFF_H_
-#define __SWAP_ON_OFF_H_
-
-#include <linux/version.h>
-#define MAX_SWAPFILES 30
-
-#endif
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC3AC4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707386904; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qTRnZPsnkt8OTyaWuRufUxNdnieeF38TUX5yIQfq6kw=;
 b=J969hUWMzyQ1BuZ5BNh4+284XDZj+/gs+s/4PsPaz/RuvMwdhQBCqsAJ9eRHh1Aqd1Zjf
 85hVNAoEXkkUaAyMwxyZc3QAPMMeIMXH6FXNrk056p3E6n8xI+XEjXm7mggEVlyNDu6cBa/
 EDjY9JX3c3Nik80nS9cRdGAGpD6maVY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08A163C5AC4
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 11:08:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1340B3CDEA8
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:51 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7CB2631D68
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707386747; x=1738922747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a7MuluFDfHG6tWmxwNPQhdi6VZiU+qa17JShBK4DvWE=;
 b=cvX8yE3zAcdOjI7Zzr3P7kpL7RSk54F/NMGM6E95RnUF3zgiLkmMMwTC
 kdFWKe4m8Ph7UmrO5Zn9DFeGlCOJDyv+v5FrRiwfFxcRjRhJMCrFo+siy
 M7AvNDneiX7doYRuqKeITse9HnGKRQGnzTLr0E+7csNEXopsyksydv8Ze
 TkCZrLwsIWbxQ8x9RrpTHEptiK8jYj5x1t10hmMfUJ4lfRTmwLQJzSwOf
 tGor6FRI1cnkGasOiujzzwnveLAAWTc9eNWNM/pTbolqCN9voFxRuXGF+
 oPmmOQwLVSBTwWlBcpdSpRJnYIljAsK/f9nI5kUjItsSTb6NMuFBAIrIg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="137258281"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; d="scan'208";a="137258281"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 19:05:45 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A88AE1F4276
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:43 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id F2D99D561D
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 85A1B20097CDF
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:42 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3C16E1A009A;
 Thu,  8 Feb 2024 18:05:42 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 05:05:17 -0500
Message-Id: <20240208100517.1974-7-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.004
X-TMASE-Result: 10--6.494500-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWP5S+IvXI7mDQA+Y0oNaxbQ1QQ6Jx/fflbEWhdVdXNnv4nO
 /I/i7S2AIvrftAIhWmLy9zcRSkKatcdu/gFP87q2utvHF25zoU+B3MgXjyY30GA+B6CBXAIWGQs
 bWiaS+mxzzWLzuR3HAoAy6p60ZV62fJ5/bZ6npdg7AFczfjr/7CPdgxmK9T6WI/DQJ89r5px7as
 ZtGCaty7HeH/tqOv22BQf5huPIT9E=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/7] Add fallback for RHEL9
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

Since device number patch and pte number patch have been backported into
RHEL9,  we should add fallback for this distro.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 libs/libltpswap/libswap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index fa0d42543..547750948 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -17,6 +17,7 @@
 #include "libswap.h"
 #include "lapi/syscalls.h"
 #include "tst_kconfig.h"
+#include "tst_kvercmp.h"
 #include "tst_safe_stdio.h"
 
 static const char *const swap_supported_fs[] = {
@@ -231,6 +232,11 @@ int tst_max_swapfiles(void)
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
@@ -238,7 +244,7 @@ int tst_max_swapfiles(void)
 	tst_kconfig_read(&marker_kconfig, 1);
 
 	if (migration_kconfig.choice == 'y') {
-		if (tst_kvercmp(5, 19, 0) < 0)
+		if (tst_kvercmp2(5, 19, 0, kvers) < 0)
 			swp_migration_num = 2;
 		else
 			swp_migration_num = 3;
@@ -255,7 +261,7 @@ int tst_max_swapfiles(void)
 	}
 
 	if (marker_kconfig.choice == 'y') {
-		if (tst_kvercmp(5, 19, 0) >= 0)
+		if (tst_kvercmp2(5, 19, 0, kvers) >= 0)
 			swp_pte_marker_num = 1;
 	}
 
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

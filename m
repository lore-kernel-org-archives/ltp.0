Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3260CC48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708955809; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vTNyXGX4ThyowVk61ZsVdE5wO+l3ckj4UQIFMsvZAEI=;
 b=Rej/I8C/0GdZbaivt5UHoVfxkVB87qYVL5LrzGgC08QJ86HDP4acTqF/RSwCru5Wh3Edw
 U5Jtb9WECDZdvX4Hd4moirKF/T4eJ0SAxXCNk/uIdEGVkSWUpz0OLP+qBG5VS1rbksg6CkD
 cVRB+n9sYD92pamUOBnGov999hjTeY8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9E2D3CF00B
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 14:56:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67E633CF006
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:55:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28F4C140123D
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708955703; x=1740491703;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nRob74DUW3EPYxS2qyWDwrDiAnOfxdRrZ4jMQFG1B24=;
 b=Jd/kgandyy+dnRKqmYdiUGEtUb/Ks5EI7iG3EtC9cqH7poEuHSvYDZYu
 MIt4+9oR5EOAHh5T7JYDNoRNc8Ywg+rFPQ3qlyt8Db0lzVyKFeZ7ShSry
 dyEmEg/bwbdpQQr1cqASESoIE5AFkr5CHUt/vtFZIzNHfzvcXlKTH+BeB
 y0BlqnJEIeSKK10/r7zR2J6qXWnvhixJ+wB6A2op5fd3MpkU5rgiZGVZC
 P6WbLo5Ybkf1EG+ykjQIQyDsRYQiEzsjIVd0N4nqAjWWwAl2HMy5noZGa
 +y7bGjMXWIbBA/ueWWTDpNyDSUIqY34pudLOd7HpuSrO8UAvDdv4fyUd/ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="150426199"
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; d="scan'208";a="150426199"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:55:01 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C74EECA145
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:57 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 114684B896
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A6E386B81D
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:56 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2ACB21A006B;
 Mon, 26 Feb 2024 21:54:56 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 08:53:36 -0500
Message-Id: <20240226135336.19733-7-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28214.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28214.007
X-TMASE-Result: 10--6.494500-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWP5S+IvXI7mDQA+Y0oNaxbQ1QQ6Jx/fflbEWhdVdXNnv4nO
 /I/i7S2AIvrftAIhWmLy9zcRSkKatcdu/gFP87q2utvHF25zoU+B3MgXjyY30GA+B6CBXAIWGQs
 bWiaS+mxzzWLzuR3HAoAy6p60ZV62fJ5/bZ6npdg7AFczfjr/7BSzskY6ar07sAHkVVtgyBYXP2
 1xo1gDuiBmeui4Dsu1vhIzKiZ6yV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 7/7] Add fallback for RHEL9
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

Acked-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 libs/libltpswap/libswap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 5e0c79b8f..c8cbb8ea1 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -18,6 +18,7 @@
 #include "libswap.h"
 #include "lapi/syscalls.h"
 #include "tst_kconfig.h"
+#include "tst_kvercmp.h"
 #include "tst_safe_stdio.h"
 
 static const char *const swap_supported_fs[] = {
@@ -231,6 +232,11 @@ int tst_max_swapfiles(void)
 	struct tst_kconfig_var memory = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
 	struct tst_kconfig_var device = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
 	struct tst_kconfig_var marker = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
+	struct tst_kern_exv kvers[] = {
+		/* RHEL9 kernel has patch 6c287605f and 679d10331 since 5.14.0-179 */
+		{ "RHEL9", "5.14.0-179" },
+		{ NULL, NULL},
+	};
 
 	tst_kconfig_read(&migration, 1);
 	tst_kconfig_read(&memory, 1);
@@ -238,7 +244,7 @@ int tst_max_swapfiles(void)
 	tst_kconfig_read(&marker, 1);
 
 	if (migration.choice == 'y') {
-		if (tst_kvercmp(5, 19, 0) < 0)
+		if (tst_kvercmp2(5, 19, 0, kvers) < 0)
 			swp_migration_num = 2;
 		else
 			swp_migration_num = 3;
@@ -254,7 +260,7 @@ int tst_max_swapfiles(void)
 			swp_device_num = 4;
 	}
 
-	if ((marker.choice == 'y' && tst_kvercmp(5, 19, 0) >= 0) ||
+	if ((marker.choice == 'y' && tst_kvercmp2(5, 19, 0, kvers) >= 0) ||
 		tst_kvercmp(6, 2, 0) >= 0) {
 		swp_pte_marker_num = 1;
 	}
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

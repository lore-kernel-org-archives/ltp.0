Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57042C48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 07:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708415151; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=in2Q8XCaasW5QoD0vKJJG+up+0hdbu4URtq6k2ARtqc=;
 b=NnUU1A8rmS68q/AeSWKVXn6nf4UnJ/fRtVVClZbgqc3G5K+5DAj+3K+/K/VE1snA/HfMM
 WmM4rIprJiMPQpoVcnNpo9TGL1SR6IGCc0IATDGNFAAR5m+wMBh+Wg3Yh8Mk5pvTe8kw0ur
 qQ/4jglXT4r70Xs/Q8X5rJYzzOodBhQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D67143CDB9E
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 08:45:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 650EE3CDB93
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:44:29 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC64D1400777
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:44:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708415069; x=1739951069;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NJEQWUyLeaxfjaMFKn7hRmXEt5rrenSioTKclP4V1Q8=;
 b=tjA9DI2nz4Xm6o9bH5VvIQknGuWdkIl/pGyJUUkQCtLF6VRjY2SjO1hZ
 I+xgVrJfaVsBfK9su5TN4hbGRVIGdU4TqmW/DF6msi6Z0mle07DaUcrbK
 s9as6ajukcDrYYFUnlaM2Ltgl3UzT6iGkg0CpO1Adxz33J9gN3aDiVa9N
 8DrRHa0uNnwXBLCgMbMa6qReWVqlehQqVZUo4J1alQ8TAFDFXOWOAfteC
 zPD1B/l46mfMfBtzyLUUu8dXk5cR4GiRM/hYFyNFtLDxRicEV9zgztLIy
 f+DfJJ0Z1BgMk/Y6Bd156UJCB/+JTgFBA5ggzg3z2Xi0RhhKsuekJUoH3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="151641268"
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; d="scan'208";a="151641268"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 16:44:27 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 499F82D320
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:44:25 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 815E8D52EF
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:44:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2331E65FEA
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:44:24 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id CC1261A006B;
 Tue, 20 Feb 2024 15:44:23 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 02:42:18 -0500
Message-Id: <20240220074218.13487-7-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28202.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28202.006
X-TMASE-Result: 10--6.494500-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWP5S+IvXI7mDQA+Y0oNaxbQ1QQ6Jx/fflbEWhdVdXNnv4nO
 /I/i7S2AIvrftAIhWmLy9zcRSkKatcdu/gFP87q2utvHF25zoU+B3MgXjyY30GA+B6CBXAIWGQs
 bWiaS+mxzzWLzuR3HAoAy6p60ZV62fJ5/bZ6npdg7AFczfjr/7JM8gS/LwiF6PJgW3vEU96DRZB
 w3GI3v+pX06/l7xtiS70cgF5ua4AY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 7/7] Add fallback for RHEL9
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
index 1f9235f17..94de4b4e2 100644
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
@@ -258,7 +264,7 @@ int tst_max_swapfiles(void)
 		swp_pte_marker_num = 1;
 	} else {
 		if (marker_kconfig.choice == 'y') {
-			if (tst_kvercmp(5, 19, 0) >= 0)
+			if (tst_kvercmp2(5, 19, 0, kvers) >= 0)
 				swp_pte_marker_num = 1;
 		}
 	}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

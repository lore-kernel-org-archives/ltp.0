Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08578EE209D
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770382768; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=u5sj9Z4xq/sG/TSljI5imgxXjvxr8s/lyygybce+ck4=;
 b=DIFpv76uPrKTxpeZjdpD5NJGsuwrcmrziU3ay1nCtQNHAJTRC7hcTQ5w3JX1/3weuOYtJ
 H9FYfja2tR0IR8toM8biRQXKlBp2x28MsmAhEpu4rR1NLtidX3REdZaM3BCP/3psWwj8yLk
 7L0rg/w4fXp8Lb4ci4NQva6Q2yH1IuA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4CDC3CC7E6
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 13:59:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41A4F3CC8E7
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 13:58:25 +0100 (CET)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD01A1A010E1
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 13:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=IMZraQJRqofW+ZTgOzoFYVuSsc+VgyGz6tO12L6Llmc=; b=qlCfbQb3uNOG
 ncw295W6ZKdkNVcnQKGkHBPyjKTvH0TAdo+OVpkb74oKNpkDI++/UOPyb3+dIBOTRpnnd1ET0B8so
 F15+rVlo+R5u0NN8X3draFwm6UZ1fGRZYVN2A6z9zRP5QfO2xqYt8TjnHQ4Lq8jNA/2oGWI3O/YFU
 zCpp55ta3m/aob0/N0z6tdJZrSQD4GofvtUSJ9S3KpDD+XybrD6+AAY2mDnzijvzViVIaIKsy1rji
 wJ51GOzF/YZaO0tOyj3jWyR/Yk+nUv8kaDzhshUiRrxLLSgpg+bWIoh6MMwWCyrJy+kK03SCd0hK7
 d4unip5/UkKyDmPFP3fDqA==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1voLOr-000BYY-1D for ltp@lists.linux.it;
 Fri, 06 Feb 2026 13:58:19 +0100
To: ltp@lists.linux.it
Date: Fri,  6 Feb 2026 12:51:12 +0000
Message-ID: <20260206125818.319190-2-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206125818.319190-1-vasileios.almpanis@virtuozzo.com>
References: <20260206125818.319190-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] add ETH_P_CAN compat macro to LAPI headers
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 include/lapi/if_ether.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/if_ether.h b/include/lapi/if_ether.h
index 536d1863a..423341c57 100644
--- a/include/lapi/if_ether.h
+++ b/include/lapi/if_ether.h
@@ -16,4 +16,8 @@
 # define ETH_P_ALL 0x0003
 #endif
 
+#ifndef ETH_P_CAN
+# define ETH_P_CAN 0x000C
+#endif
+
 #endif /* LAPI_IF_ETHER_H__ */
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

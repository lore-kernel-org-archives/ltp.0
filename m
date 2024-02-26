Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D785FC48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708955686; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=NWzjHawXDY6DWaByV7IN5xQHg76/biM6aRAdVxNKzXM=;
 b=FjyvI1rroVvsxkQG5Ni8H+g2kH5LreiMOHrr9QSSFSjv2z4QGp4Km9NEnLyfjZg29T/Sr
 3p/I6twbRXDw6U3p2wOd+A8TfVxF6I57tPIEmNJtSRfXdZYDBjdySZ6tkquWBhxiAnyhB0I
 Xmlc5zRrDdl1R4UlSOoytsXrcixXvNk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F71E3CF002
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 14:54:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B9643CF002
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 48729200C19
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708955648; x=1740491648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oMhITlOJcVGzRsUA/kXoPOcn+Fws12AOAqNzK21cMCs=;
 b=UvknI3K1Q290FWdTN0f4MTkhR+Oz05iT/Xcee4huSRUDsGuWJ8vhiLl4
 5QCbNwOoQxqWUjlDNuiykalkD8cNCOUomW1tZVzjl8sqhxf3DMp5usFna
 FS2n3Z374dQyydBn2Ns5I9kLOhRKg2S6rHXZ3GfL76DHafVf6HLRsZYBo
 cnnhzdbdMrzxl+ri2owhhWhkr9+V/Qejl0hGHCn0FK/7FfSR4+RSooJIH
 5OIUfMnx5yY9VszetpY2EeGnQGXF4HDuWWdHOIUB4mgAB6ZzHuagT9VxR
 UYayvieeS3B6aFrb2qIb6CjZUAtQgu59YDmKPW3OYiJl3FYDtoApvFaN9 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="129219443"
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; d="scan'208";a="129219443"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 22:54:05 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id F3DE51CE3EB
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:03 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 35EB94B896
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B22B06B81D
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 22:54:02 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 562A41A006B;
 Mon, 26 Feb 2024 21:54:02 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 26 Feb 2024 08:53:31 -0500
Message-Id: <20240226135336.19733-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28214.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28214.007
X-TMASE-Result: 10--8.325500-10.000000
X-TMASE-MatchedRID: B5ZHvUe1GbC9TGmwrVcPSwXtykVcrvpNCZa9cSpBObnAuQ0xDMaXkH4q
 tYI9sRE/Vztt14qydotC2s0bIz7TOS0+EsApCrRRutvHF25zoU+ZmLDnd2pI354Q+L3BXIWu5p9
 TGNmpllG+B7lET5qElvJcAJWYjOv3HxPMjOKY7A+u65UDD0aDgsRB0bsfrpPIfiAqrjYtFiQJTR
 cQVqH3BlKzfM3zQfXvCFU8uW3sQKpKYW7KRcOGUX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/7] libltpswap: alter tst_count_swaps API
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

Like we count the IPC resource total, we can also add a
similar API for swapfiles, so we can use it for swapon03 case.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libswap.h         |  5 +++++
 libs/libltpswap/libswap.c | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index cc68d5e6b..8c75e20ae 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -28,4 +28,9 @@ bool is_swap_supported(const char *filename);
  */
 int tst_max_swapfiles(void);
 
+/*
+ * Get the used swapfiles number.
+ */
+int tst_count_swaps(void);
+
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 3528a3fb9..5e0c79b8f 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -261,3 +261,28 @@ int tst_max_swapfiles(void)
 
 	return DEFAULT_MAX_SWAPFILE - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
 }
+
+/*
+ * Get the used swapfiles number.
+ */
+int tst_count_swaps(void)
+{
+	FILE *fp;
+	int used = -1;
+	char c;
+
+	fp = SAFE_FOPEN("/proc/swaps", "r");
+	if (fp == NULL)
+		return -1;
+
+	while ((c = fgetc(fp)) != EOF) {
+		if (c == '\n')
+			used++;
+	}
+
+	SAFE_FCLOSE(fp);
+	if (used < 0)
+		tst_brk(TBROK, "can't read /proc/swaps to get used swapfiles resource total");
+
+	return used;
+}
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

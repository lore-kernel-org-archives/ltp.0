Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB923C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707386776; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=hT3JAf1BKTW+hFSVGdPy/ZxsXJwkCc6ORvmRnoAXeYU=;
 b=D3doFPL+Q/mNkwj48QdCt305jpL4Qdd/fVLzqJw/3cdC72xGVPrGB4G5CKrrwBuC/2xXG
 OZktJohTEoXJZyor4bBNx/1NtEkSzCtHCkljXyJN3nBbgZ5A/gi+IEBnGQQaKdpR2WjSgeZ
 FiJuDw36el9zoHDpIeFm/r1o2vzvPvI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 656583CC4AD
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 11:06:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42643CC3F8
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F13B62D1BF
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 11:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707386744; x=1738922744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ktiSQZDyWKq+KTCoyBVIXAF0Qx1vJ+5tvJKqMd+Hu1A=;
 b=KLWapVVfMIgLdVORwljAunqQDel2xTbMRa9uWhrqgkFWNgI7y0NpnJQF
 pcvJizF5if8u5EoL5rGSExIVKNo0w2S8lgtvJ5vdjgsUQeWW+jHZqkMhx
 r8/j7LuPrsAjMz4FqhI7y5aDaKrumlziVDzlDWTi+I+xeM02gdhYfKpZT
 PVgqGl+GDliZ9m55hOLydYP/v3srFoMILcwzNPpbSM/D+PNCu75plWQ+Q
 Hl33CHer6bL3JTVe8sOPxr7bGGORoLho6+ZF+Wcq8PEVn9aJQ3zgPtyfM
 wjHuYSraBuPiF9emzIUnN5uhDybIvuGDFLoGuCgNOCKfL+nwT8UUjuhqK w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="150538907"
X-IronPort-AV: E=Sophos;i="6.05,253,1701097200"; d="scan'208";a="150538907"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 19:05:41 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 036C82EBE5
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:39 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C2C7108615
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id AEA7120097CDF
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 19:05:37 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5EC941A009A;
 Thu,  8 Feb 2024 18:05:37 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 05:05:12 -0500
Message-Id: <20240208100517.1974-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28178.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28178.004
X-TMASE-Result: 10--8.247500-10.000000
X-TMASE-MatchedRID: wrMmQdWyhqi9TGmwrVcPSwXtykVcrvpNCZa9cSpBObnAuQ0xDMaXkH4q
 tYI9sRE/Vztt14qydotC2s0bIz7TOS0+EsApCrRRutvHF25zoU9MVCcj56k8hq25ZjP2hWgveWw
 Yle3v1YxzzWLzuR3HAoAy6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuA5Xvjc0oM39LD/
 cYBN+IRDIHQ2VDQ28kD04nabZL6su+68HqACCvKA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/7] libltpswap: alter tst_count_swaps api
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

Like we count the ipc resource total, we can also add a
similar api for swapfiles, so we can use it for swapon03 case.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libswap.h         |  5 +++++
 libs/libltpswap/libswap.c | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/libswap.h b/include/libswap.h
index 361d73175..76a3ed0c0 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -27,4 +27,9 @@ bool is_swap_supported(const char *filename);
  */
 int tst_max_swapfiles(void);
 
+/*
+ * Get the used swapfiles number
+ */
+int tst_count_swaps(void);
+
 #endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index 69273fb33..fa0d42543 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -261,3 +261,30 @@ int tst_max_swapfiles(void)
 
 	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
 }
+
+/*
+ * Get the used swapfiles number
+ */
+int tst_count_swaps(void)
+{
+	FILE *fp;
+	int used = -1;
+	char c;
+
+	fp = fopen("/proc/swaps", "r");
+	if (fp == NULL) {
+		return -1;
+	}
+
+	while ((c = fgetc(fp)) != EOF) {
+		if (c == '\n')
+			used++;
+	}
+
+	fclose(fp);
+	if (used < 0) {
+		tst_brk(TBROK, "can't read /proc/swaps to get used swapfiles resource total ");
+	}
+
+	return used;
+}
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

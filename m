Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6386DC48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708415023; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vIxMbpOWtd5i8lHwGVFqj+dSiGHe9xt46C2T/n/u4Ic=;
 b=jX6bBsHKuGIEABKC2+5mP49amMKWmFNSvl8uo7c/1qIlJ0uUJ1tSz/Xs1BJbWKmQYdUkt
 qxfiWvkQDy4svcNJ1jgX/NxKP60R+jaPNz/y5ZwKmQR8oLfErRYlyLPen2685unTFgezSeO
 /EyBGPyG14pwnIL20tNOCmCvRMr94/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A07023CCDAE
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 08:43:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02EEB3CF163
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:43:10 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A32C2200914
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 08:43:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708414989; x=1739950989;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G7zwVmiZgw+FwYq4VMuVMdFB74URbJ8cnDGf7wlANxw=;
 b=YA+4PoVqIMzmQkPklaxU/XWeeAMK58CWqsEl1xYM2XQRdqVT+qsUs6kG
 mdhIAISaxZBrkLRafJc+2Vca4+fH2bFtSNtUuRvxbCDOo7VUY+l0MAkKU
 melXUMZ7FDpckv1synukkd2pNiyaHbHxFqygiWVsF7kgS2Elg5Jt/DInX
 BJRfWEXMEIhaqxx5a7cKzkOoTqg6NOhGUadB3bUfLwID3seDWxEXeZxVR
 +iDZKN91LLMV4roE/czLxaWKk2m8Fz+3GF+WqeZEqNbIflRfUKvSImQEU
 R/ajiDS2JUAC0LmjWGq0sN00/q5gplndSHmOyDfZq1wUndG+KDWlFvLPn Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="137512045"
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; d="scan'208";a="137512045"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 16:43:07 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D59B8D9AE2
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:04 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E934BF4A3
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 95BCF20097CE1
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 16:43:03 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 4A9D61A006B;
 Tue, 20 Feb 2024 15:43:03 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 02:42:13 -0500
Message-Id: <20240220074218.13487-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28202.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28202.005
X-TMASE-Result: 10--8.247500-10.000000
X-TMASE-MatchedRID: wrMmQdWyhqi9TGmwrVcPSwXtykVcrvpNCZa9cSpBObnAuQ0xDMaXkH4q
 tYI9sRE/Vztt14qydotC2s0bIz7TOS0+EsApCrRRutvHF25zoU9MVCcj56k8hq25ZjP2hWgveWw
 Yle3v1YxzzWLzuR3HAoAy6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuzujsnLTlnseY/h
 hlFx6P0p8RG48oJjOaYabljj5MfqFoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/7] libltpswap: alter tst_count_swaps api
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
index a404a4ada..1f9235f17 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -265,3 +265,30 @@ int tst_max_swapfiles(void)
 
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
+		tst_brk(TBROK, "can't read /proc/swaps to get used swapfiles resource total");
+	}
+
+	return used;
+}
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

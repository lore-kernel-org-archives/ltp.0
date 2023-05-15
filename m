Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D9EC77B75
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 07:12:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F4C93CDD7D
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 09:12:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1A23CB3B9
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:37 +0200 (CEST)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49B5E1000344
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:36 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="116692091"
X-IronPort-AV: E=Sophos;i="5.99,275,1677510000"; d="scan'208";a="116692091"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 16:11:35 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 21D3AD647F
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:33 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 50039D88B0
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C7D2F37C45;
 Mon, 15 May 2023 16:11:31 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 15 May 2023 15:11:16 +0800
Message-Id: <1684134680-6190-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27626.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27626.005
X-TMASE-Result: 10--0.990700-10.000000
X-TMASE-MatchedRID: a4Q7dosAlP5SuJfEWZSQfE7nLUqYrlslFIuBIWrdOePfUZT83lbkEAfN
 hshqWR17eIe4HQ8ldFZrmmdBZjXYSL1l6SqGVL9pngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
 Wy9W70AEnRE+fI6etkvl4HvdVFMgk+Vglt7qAx85wZG6qfsuFl2qRAba1RBTTG7THnCfdYwstN4
 MMXNHY6X3DfZc9a8FOEE3RH1cDa1TglXxyy4Kz7ku/kTKv9giuqwOHO1Fdn0Kb4tj0DvxRUIs9r
 o6z1cfchCFNTbTJJtE=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/6] lapi/stat.h: Add STATX_DIOALIGN related
 definition
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Also add missing stx_mnt_id.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 590ccd111..6ed4b6637 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -97,7 +97,11 @@ struct statx {
 	uint32_t	stx_dev_major;
 	uint32_t	stx_dev_minor;
 	/* 0x90 */
-	uint64_t	__spare2[14];
+	uint64_t	stx_mnt_id;
+	uint32_t	stx_dio_mem_align;
+	uint32_t	stx_dio_offset_align;
+	/* 0xa0 */
+	uint64_t	__spare3[12];
 	/* 0x100 */
 };
 #endif
@@ -180,6 +184,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_MNT_ID		0x00001000U
 #endif
 
+#ifndef STATX_DIOALIGN
+# define STATX_DIOALIGN		0x00002000U
+#endif
+
 #ifndef STATX_ALL
 # define STATX_ALL		0x00000fffU
 #endif
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAAFEC01A1
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:51:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F0C83E229A
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:51:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDC993C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:51:25 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F3C71400C78
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:51:20 +0100 (CET)
X-UUID: 0f9e8e86268d11f1a21c59e7364eecb8-20260323
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
 SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
 SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:359a2e85-03f7-4775-95e8-558593a361ec, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:30
X-CID-INFO: VERSION:1.3.11, REQID:359a2e85-03f7-4775-95e8-558593a361ec, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:30
X-CID-META: VersionHash:89c9d04, CLOUDID:a35c05b43811b7424350322aa25f16e2,
 BulkI
 D:2603231551131KRFU2CJ,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|898
 ,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
 BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0f9e8e86268d11f1a21c59e7364eecb8-20260323
X-User: gaoxiang@kylinos.cn
Received: from bogon [(117.61.159.238)] by mailgw.kylinos.cn
 (envelope-from <gaoxiang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1103889824; Mon, 23 Mar 2026 15:51:11 +0800
From: Gao Xiang <gaoxiang@kylinos.cn>
To: ltp@lists.linux.it
Date: Mon, 23 Mar 2026 15:49:54 +0800
Message-ID: <20260323074954.3393-1-gaoxiang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mem/tunable:min_free_kbytes: fix disabled
 check_monitor flag
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

From: Xiang Gao <gaoxiang@kylinos.cn>

In min_free_kbytes, check_monitor() is effectively disabled because
the loop condition uses the flag incorrectly.

Fix the condition so the monitor runs during the test and exits after
receiving the signal.

Signed-off-by: Xiang Gao <gaoxiang@kylinos.cn>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index ae0fe9d90..a62e4ae9d 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -184,7 +184,7 @@ static void check_monitor(void)
 	unsigned long tune;
 	unsigned long memfree;
 
-	while (end) {
+	while (!end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
 		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

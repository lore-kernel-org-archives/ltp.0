Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF71BD10376
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 03:11:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EF233CF381
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 04:11:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96E393C9288
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 04:11:28 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 199C81A005EC
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 04:11:14 +0100 (CET)
X-UUID: 86138a68ca7511f0a38c85956e01ac42-20251126
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
 SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:90c4176a-c135-493d-a368-033495fae02c, IP:10,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:30
X-CID-INFO: VERSION:1.3.6, REQID:90c4176a-c135-493d-a368-033495fae02c, IP:10,
 URL
 :0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:30
X-CID-META: VersionHash:a9d874c, CLOUDID:0b258ef1cfd6627c0ddf2b094210d3f0,
 BulkI
 D:251126103048HMNJAQU4,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|850
 |898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
 il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 86138a68ca7511f0a38c85956e01ac42-20251126
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <duanchenghao@kylinos.cn>) (Generic MTA)
 with ESMTP id 968345194; Wed, 26 Nov 2025 11:10:55 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: ltp@lists.linux.it
Date: Wed, 26 Nov 2025 11:10:38 +0800
Message-Id: <20251126031038.443358-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kallsyms: Add the capture of the SIGBUS signal
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

When user-space accesses a kernel virtual address on the LoongArch
architecture, a ade(address error) exception is generated, and the
SIGBUS signal is returned to user-space within the exception handler.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 testcases/kernel/security/kallsyms/kallsyms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/kallsyms/kallsyms.c b/testcases/kernel/security/kallsyms/kallsyms.c
index 45b3e18d4..6a970f8c8 100644
--- a/testcases/kernel/security/kallsyms/kallsyms.c
+++ b/testcases/kernel/security/kallsyms/kallsyms.c
@@ -62,7 +62,7 @@ static int ranges_size, ranges_len;
 
 static void segv_handler(int sig)
 {
-	if (sig == SIGSEGV)
+	if (sig == SIGSEGV || sig == SIGBUS)
 		segv_caught++;
 	else
 		tst_res(TFAIL, "Unexpected signal %s", strsignal(sig));
@@ -143,6 +143,7 @@ static void setup(void)
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_handler = segv_handler;
 	sigaction(SIGSEGV, &sa, NULL);
+	sigaction(SIGBUS, &sa, NULL);
 
 	nr_symbols = read_kallsyms(NULL, 0);
 	sym_table = SAFE_CALLOC(nr_symbols, sizeof(*sym_table));
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

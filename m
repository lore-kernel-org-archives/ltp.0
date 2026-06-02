Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31098CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 09:04:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E63B3CDC08
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:04:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B22243E1EB4
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:03:53 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97B07605637
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 11:03:49 +0200 (CEST)
X-UUID: f43bbdb45e6111f1aa26b74ffac11d73-20260602
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
 SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 UD_TRUSTED, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_COMM
 GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f133bda8-5fe7-4f78-accc-a5c723cb2b41, IP:20,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:15
X-CID-INFO: VERSION:1.3.12, REQID:f133bda8-5fe7-4f78-accc-a5c723cb2b41, IP:20,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:15
X-CID-META: VersionHash:e7bac3a, CLOUDID:8f4223d7e66f314529dcd0d1e82ab5cd,
 BulkI
 D:260602170345RZ8Z2Y68,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
 |865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f43bbdb45e6111f1aa26b74ffac11d73-20260602
X-User: panzhe@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <panzhe@kylinos.cn>) (Generic MTA)
 with ESMTP id 160492917; Tue, 02 Jun 2026 17:03:42 +0800
From: panzhe <panzhe@kylinos.cn>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 17:02:14 +0800
Message-Id: <20260602090214.252840-1-panzhe@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] gethostname02: Accept EOVERFLOW on alpha
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

On alpha glibc's gethostname() directly calls the kernel
syscall and sets errno to EOVERFLOW when the buffer is
too small, because the kernel truncates silently and the
string is not null terminated.

On the other hand, the generic posix implementation used
on x86_64 sets ENAMETOOLONG in this case.

Fix this by accepting both errnos.

Closes: https://github.com/linux-test-project/ltp/issues/1319
Signed-off-by: panzhe <panzhe@kylinos.cn>
---
 testcases/kernel/syscalls/gethostname/gethostname02.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/gethostname/gethostname02.c b/testcases/kernel/syscalls/gethostname/gethostname02.c
index c56fcb800..dd1f4e39e 100644
--- a/testcases/kernel/syscalls/gethostname/gethostname02.c
+++ b/testcases/kernel/syscalls/gethostname/gethostname02.c
@@ -7,7 +7,7 @@
 /*\
  * Verify that gethostname(2) fails with
  *
- * - ENAMETOOLONG when len is smaller than the actual size
+ * - ENAMETOOLONG or EOVERFLOW when len is smaller than the actual size
  */
 
 #include "tst_test.h"
@@ -16,11 +16,13 @@ static void verify_gethostname(void)
 {
 	char hostname[HOST_NAME_MAX + 1];
 	int real_length;
+	const int exp_errnos[] = {ENAMETOOLONG, EOVERFLOW};
 
 	SAFE_GETHOSTNAME(hostname, sizeof(hostname));
 	real_length = strlen(hostname);
 
-	TST_EXP_FAIL(gethostname(hostname, real_length - 1), ENAMETOOLONG,
+	TST_EXP_FAIL_ARR(gethostname(hostname, real_length - 1),
+		exp_errnos, ARRAY_SIZE(exp_errnos),
 		"len is smaller than the actual size");
 }
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

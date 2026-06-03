Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1CECD6E4A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 01:50:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 938893E722C
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 03:50:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB58A3CE107
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 03:49:47 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE6F71400053
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 03:49:44 +0200 (CEST)
X-UUID: 79d51e0c5eee11f1aa26b74ffac11d73-20260603
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
X-CID-O-INFO: VERSION:1.3.12, REQID:03af2997-4ca4-44cf-83ca-be8e75a7408f, IP:20,
 URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-5
X-CID-INFO: VERSION:1.3.12, REQID:03af2997-4ca4-44cf-83ca-be8e75a7408f, IP:20,
 UR
 L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:8392c002763f36bff04a71471ba41bc8,
 BulkI
 D:260603094937SDEFVDSR,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
 |865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79d51e0c5eee11f1aa26b74ffac11d73-20260603
X-User: panzhe@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <panzhe@kylinos.cn>) (Generic MTA)
 with ESMTP id 289596107; Wed, 03 Jun 2026 09:49:36 +0800
From: panzhe <panzhe@kylinos.cn>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 09:49:33 +0800
Message-Id: <20260603014933.30653-1-panzhe@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] gethostname02: Accept EOVERFLOW on alpha
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
 testcases/kernel/syscalls/gethostname/gethostname02.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/gethostname/gethostname02.c b/testcases/kernel/syscalls/gethostname/gethostname02.c
index c56fcb800..23ab25010 100644
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
@@ -16,12 +16,14 @@ static void verify_gethostname(void)
 {
 	char hostname[HOST_NAME_MAX + 1];
 	int real_length;
+	const int exp_errnos[] = {ENAMETOOLONG, EOVERFLOW};
 
 	SAFE_GETHOSTNAME(hostname, sizeof(hostname));
 	real_length = strlen(hostname);
 
-	TST_EXP_FAIL(gethostname(hostname, real_length - 1), ENAMETOOLONG,
-		"len is smaller than the actual size");
+	TST_EXP_FAIL_ARR(gethostname(hostname, real_length - 1),
+			 exp_errnos, ARRAY_SIZE(exp_errnos),
+			 "len is smaller than the actual size");
 }
 
 static struct tst_test test = {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

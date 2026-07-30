Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3A8C55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:26:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F8F53E2D30
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:26:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 217F73E56E7
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:25:50 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C84121000254
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:25:48 +0200 (CEST)
X-UUID: c55a3bf08c1111f1aa26b74ffac11d73-20260730
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
 HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
 SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
 GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:521dd364-03d0-4c10-b080-64132d6032e2, IP:10,
 URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:30
X-CID-INFO: VERSION:1.3.12, REQID:521dd364-03d0-4c10-b080-64132d6032e2, IP:10,
 UR
 L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:30
X-CID-META: VersionHash:e7bac3a, CLOUDID:0b4f588259d00ae59b35c2d4dabd38a7,
 BulkI
 D:26073020254270RZIOE5,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
 850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:
 nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
 RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c55a3bf08c1111f1aa26b74ffac11d73-20260730
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <sunshaojie@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1186667243; Thu, 30 Jul 2026 20:25:37 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 20:25:19 +0800
Message-Id: <20260730122521.1218460-2-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730122521.1218460-1-sunshaojie@kylinos.cn>
References: <20260730122521.1218460-1-sunshaojie@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] tst_cgroup: add cpu.stat and cpu.weight to
 cgroup file table
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

These entries are needed by the upcoming CPU cgroup v2 tests
(cgroup_cpu01 through cgroup_cpu05) to read cpu.stat and set
cpu.weight on cgroups.

Note: cpu.stat also exists in cgroup v1, so the v1 name is
specified as "cpu.stat" (same as v2). cpu.weight is v2-only
(NULL for v1) because its v1 counterpart cpu.shares uses a
different scale and cannot be aliased.

Signed-off-by: Shaojie Sun <sunshaojie@kylinos.cn>
---
 lib/tst_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 7c6ecd4d2..0ab072db7 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -199,6 +199,8 @@ static const struct cgroup_file cpu_ctrl_files[] = {
 	 */
 	{ "cpu.max", "cpu.cfs_quota_us", CTRL_CPU },
 	{ "cpu.cfs_period_us", "cpu.cfs_period_us", CTRL_CPU },
+	{ "cpu.stat", "cpu.stat", CTRL_CPU },
+	{ "cpu.weight", NULL, CTRL_CPU },
 	{ }
 };
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

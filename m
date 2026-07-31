Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F41C55162
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 03:15:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B3883E91BF
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 05:15:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76EF13E985F
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 05:14:16 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 48F9B60086A
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 05:14:14 +0200 (CEST)
X-UUID: e280f86e8c8d11f1aa26b74ffac11d73-20260731
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
X-CID-O-INFO: VERSION:1.3.12, REQID:ee21d990-8a82-4ed8-8eaa-7247a0be8b1c, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:ee21d990-8a82-4ed8-8eaa-7247a0be8b1c, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:9a849f8d2364d8ccee4898f6eb9c0588,
 BulkI
 D:260731111409E0EK4FC4,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
 850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
 :nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
 BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e280f86e8c8d11f1aa26b74ffac11d73-20260731
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <sunshaojie@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 263558535; Fri, 31 Jul 2026 11:14:04 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 11:13:43 +0800
Message-Id: <20260731031343.1298712-4-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260731031343.1298712-1-sunshaojie@kylinos.cn>
References: <20260730122521.1218460-2-sunshaojie@kylinos.cn>
 <20260731031343.1298712-1-sunshaojie@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] runtest/controllers: add CPU cgroup v2 test
 entries
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

Register the new cgroup_cpu01 through cgroup_cpu05 tests in the
controllers runtest file so they are included in test runs.

Signed-off-by: Shaojie Sun <sunshaojie@kylinos.cn>
---
 runtest/controllers | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/runtest/controllers b/runtest/controllers
index 93c52c439..e98ad98cc 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -20,6 +20,11 @@ memcg_stress		memcg_stress_test.sh
 memcg_control		memcg_control_test.sh
 
 # kselftest ports
+cgroup_cpu01 cgroup_cpu01
+cgroup_cpu02 cgroup_cpu02
+cgroup_cpu03 cgroup_cpu03
+cgroup_cpu04 cgroup_cpu04
+cgroup_cpu05 cgroup_cpu05
 memcontrol01 memcontrol01
 memcontrol02 memcontrol02
 memcontrol03 memcontrol03

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

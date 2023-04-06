Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0814FC7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 10:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87FA3CCFE8
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 12:28:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CB903CC73C
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 11:55:11 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B8DF1A009BC
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 11:55:08 +0200 (CEST)
X-UUID: 8b7f16d4783c4a0393ae4511e2f55dab-20230406
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:e214aced-16b3-40e3-95c6-24e102bf214a, IP:10,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-INFO: VERSION:1.1.22, REQID:e214aced-16b3-40e3-95c6-24e102bf214a, IP:10,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:0
X-CID-META: VersionHash:120426c, CLOUDID:b9d965b5-beed-4dfc-bd9c-e1b22fa6ccc4,
 B
 ulkID:230406173345NPWNH7UZ,BulkQuantity:1,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 8b7f16d4783c4a0393ae4511e2f55dab-20230406
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
 (envelope-from <mengfanhui@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
 with ESMTP id 1278158647; Thu, 06 Apr 2023 17:54:58 +0800
From: mengfanhui <mengfanhui@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu,  6 Apr 2023 17:54:04 +0800
Message-Id: <20230406095404.181012-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 06 Apr 2023 12:28:20 +0200
Subject: [LTP] [PATCH] Bug: Handling hugemmap24 test item failure issues
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
Cc: mengfanhui@kylinos.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rootcause:
mmap function start parameter overstep the boundary

Solution:
judge longarch64 macros,execute low start address process

Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index a465aadec..40e94a331 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -30,7 +30,7 @@ static int init_slice_boundary(int fd)
 	unsigned long slice_size;
 	void *p, *heap;
 	int i;
-#if defined(__LP64__) && !defined(__aarch64__)
+#if defined(__LP64__) && !defined(__aarch64__) && defined(__longarch64__)
 	/* powerpc: 1TB slices starting at 1 TB */
 	slice_boundary = 0x10000000000;
 	slice_size = 0x10000000000;
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

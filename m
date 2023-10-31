Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C553EC41535
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 09:50:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BEAA3CE4DF
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 10:50:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D0FD3CEB3C
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 02:53:17 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 80770600750
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 02:53:12 +0100 (CET)
X-UUID: e67e9f41a2914ef2a0357cb28757153b-20231031
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32, REQID:ec9b4dbb-8cf2-476c-b25e-53335b2502db, IP:20,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:30
X-CID-INFO: VERSION:1.1.32, REQID:ec9b4dbb-8cf2-476c-b25e-53335b2502db, IP:20,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:30
X-CID-META: VersionHash:5f78ec9, CLOUDID:39fe80d7-04a0-4e50-8742-3543eab8cb8e,
 B
 ulkID:23103109501841XJK58Q,BulkQuantity:1,Recheck:0,SF:66|24|17|19|44|102,
 TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
 SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e67e9f41a2914ef2a0357cb28757153b-20231031
X-User: wangxuewen@kylinos.cn
Received: from wxw-qitianm428-n000.. [(39.156.73.13)] by mailgw
 (envelope-from <wangxuewen@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1219363071; Tue, 31 Oct 2023 09:53:04 +0800
From: wangxuewen@kylinos.cn
To: ltp@lists.linux.it
Date: Tue, 31 Oct 2023 09:53:01 +0800
Message-Id: <20231031015301.355147-1-wangxuewen@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 14 Nov 2023 10:50:40 +0100
Subject: [LTP] [PATCH] hugemmap24: loongarch:Add __longarch__ for
 compatibility with Loongarch
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
Cc: wangxuewen <wangxuewen@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: wangxuewen <wangxuewen@kylinos.cn>

This allows for a lower address branch on the Longarch platform.

./hugemmap24
tst_hugepage.c:83: TINFO: 4 hugepage(s) reserved
tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x20000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x30000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x40000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x50000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x60000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x70000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x80000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x90000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0xa0000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0xb0000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0xc0000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0xd0000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0xe0000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0xf0000000000: EINVAL (22)
hugemmap24.c:64: TINFO: can't use slice_boundary: 0x100000000000: EINVAL (22)
hugemmap24.c:72: TFAIL: couldn't find 2 free neighbour slices: EINVAL (22)

Signed-off-by: wangxuewen <wangxuewen@kylinos.cn>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 158a03010..431dc1bbf 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -30,7 +30,7 @@ static int init_slice_boundary(int fd)
 	unsigned long slice_size;
 	void *p, *heap;
 	int i;
-#if defined(__LP64__) && !defined(__aarch64__)
+#if defined(__LP64__) && !defined(__aarch64__) && !defined(__loongarch__)
 	/* powerpc: 1TB slices starting at 1 TB */
 	slice_boundary = 0x10000000000;
 	slice_size = 0x10000000000;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

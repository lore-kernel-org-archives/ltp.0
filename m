Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E12EC4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 07:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75D0A3CF5AC
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 08:37:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD9C93CBF60
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 08:37:33 +0100 (CET)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 0B7BF1401243
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 08:37:29 +0100 (CET)
Received: from loongson.cn (unknown [10.180.129.93])
 by gateway (Coremail) with SMTP id _____8AxqOg1025lw_o+AA--.24038S3;
 Tue, 05 Dec 2023 15:37:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.129.93])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx7tw0025lzEBVAA--.57903S2; 
 Tue, 05 Dec 2023 15:37:24 +0800 (CST)
From: Hongchen Zhang <zhanghongchen@loongson.cn>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Tue,  5 Dec 2023 15:37:21 +0800
Message-Id: <20231205073721.1203427-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-CM-TRANSID: AQAAf8Bx7tw0025lzEBVAA--.57903S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAQB2VuiKwDRgABs9
X-Coremail-Antispam: 1Uk129KBj93XoW7AF1UZFWUWry7uFW5Zr4kXwc_yoW8Ar48pF
 ZrJF4qkr4jy3Z8urs8Jwn2va1DZanayw1agwn5Cws29rnxt3ZrArWjgF4DG3Wj93yvgayk
 uF40qrZ2qa45AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap13: use MMAP_GRANULARITY instead of page size
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
Cc: Hongchen Zhang <zhanghongchen@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For some architectures like LoongArch, mmap(MAP_FIXED | MAP_SHARED)
has to be aligned to SHMLBA. So use MMAP_GRANULARITY instead of
page size when mmap, otherwise the test will fail.

Suggested-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index f8c36640d61d..42b80064ef36 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -21,6 +21,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include <sys/types.h>
+#include <lapi/mmap.h>
 
 #include "hugetlb.h"
 
@@ -62,15 +63,15 @@ static void run_test(void)
 	memset(p, 0, hpage_size);
 
 	/* Test just below 4GB to check for off-by-one errors */
-	lowaddr = FOURGB - page_size;
-	q = mmap((void *)lowaddr, page_size, PROT_READ|PROT_WRITE,
+	lowaddr = FOURGB - MMAP_GRANULARITY;
+	q = mmap((void *)lowaddr, MMAP_GRANULARITY, PROT_READ|PROT_WRITE,
 		 MAP_SHARED|MAP_FIXED|MAP_ANONYMOUS, 0, 0);
 	if (q == MAP_FAILED) {
-		below_start = FOURGB - page_size;
+		below_start = FOURGB - MMAP_GRANULARITY;
 		above_end = FOURGB;
 
 		if (range_is_mapped(below_start, above_end) == 1) {
-			tst_res(TINFO|TERRNO, "region (4G-page)-4G is not free & "
+			tst_res(TINFO|TERRNO, "region (4G-MMAP_GRANULARITY)-4G is not free & "
 					"mmap() failed expected");
 			tst_res(TPASS, "Successful but inconclusive");
 		} else
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

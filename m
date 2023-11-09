Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6DAC4332F
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 02:55:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F93D3D0528
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 03:55:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55B913CB917
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:55:13 +0100 (CET)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 17B2260283D
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1tKoR
 B4xwAIhDbVsEVaASjrPLUJ6WqWkOfDHuuIgVyE=; b=DWJA4v7AhZFV840w/mAmJ
 hKyooMas1Oh/WQ4dC6UbNZFraQITIjyUPOECHPSFu7DTkjIoVpbHwFidTkVwwMra
 EGesDUPsRMv/Xjf8bD0uLYiTaZSBz1oRo9MZ4qKhVBEv+ztmWCsPwsTaGktIhpLj
 qsvfvH2vznhHbBIgVeqRIw=
Received: from wxw-QiTianM428-N000.. (unknown [39.156.73.13])
 by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wA3G0sESkxlq6e9Cg--.3439S4; 
 Thu, 09 Nov 2023 10:55:00 +0800 (CST)
From: 18810879172@163.com
To: ltp@lists.linux.it
Date: Thu,  9 Nov 2023 10:54:56 +0800
Message-Id: <20231109025456.71696-1-18810879172@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wA3G0sESkxlq6e9Cg--.3439S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1fuF45XrW8AF1xJF4DCFg_yoW8Kw4Upr
 1fAr1vgrWIyr98Cr4xKr93u34DAwn0va48WrWUGr1jyr9rGFn8JF4UGFs5X34ag3s29a4x
 XF1UZa97t3yrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP9N-UUUUU=
X-Originating-IP: [39.156.73.13]
X-CM-SenderInfo: rprymiyqyxmiixs6il2tof0z/xtbBEQAj9VaEQ1C5hgAAs5
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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

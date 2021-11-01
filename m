Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49604C433F5
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 05:35:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF5460EB8
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 05:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBF5460EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 883373C70A9
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 06:35:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E75FA3C7002
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 06:35:13 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B0329100143B
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 06:35:08 +0100 (CET)
X-QQ-mid: bizesmtp52t1635744903t2k0upbm
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 01 Nov 2021 13:34:57 +0800 (CST)
X-QQ-SSF: 0140000000000040C000000A0000000
X-QQ-FEAT: 3uawQE1sH+0D5kINBQrMLAQvxwZI9dX5UbPH1l178a4HnAltN8CxAKTA+vyaT
 5BZ8GPVla3E0OW7WztMP5b8hKRowcEtbJaEaMh95R3Dw+OjZWlZanxjQ7QTagfvbusdNs/A
 UxDf1V15AbeJu4dNjAkjhRCCNBmKldAfkwgaR5kvOcKDUPxW0IPZVgL1uZIMCw47uQ7jfZ1
 ap3AuQCuBc75wbGY6zCi1+N2Dtr4JRxTmRg8cnErnatHvgaW1jXJyuXqVH1cJegRm2Juhqi
 ZInFxwVID6/owxf22eQves8GQ6dj0QmAEBEzL5x3Lx/qj6CEv+T+VKy+JqhYaQZIGDBzMbK
 xVO3m+AwfOW9Wmu1ijlvGpMRZ9olw==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Mon,  1 Nov 2021 13:34:54 +0800
Message-Id: <20211101053454.11505-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] stime: Add space to make make-check happy
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
Cc: tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 testcases/kernel/syscalls/stime/stime02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/stime/stime02.c b/testcases/kernel/syscalls/stime/stime02.c
index 126a49ade..0b2dc384c 100644
--- a/testcases/kernel/syscalls/stime/stime02.c
+++ b/testcases/kernel/syscalls/stime/stime02.c
@@ -38,7 +38,7 @@ static void run(void)
 		return;
 	}

-	tst_res(TFAIL| TTERRNO,
+	tst_res(TFAIL | TTERRNO,
 		"stime(2) fails, Caller not root, expected errno:%d", EPERM);
 }

--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

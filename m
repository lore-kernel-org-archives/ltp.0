Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E590CC433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:36:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CF933C93CE
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 08:36:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 974E03C2465
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 08:36:14 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 99BB61000D3C
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 08:36:12 +0100 (CET)
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JY2VZ0K0lz8wFC
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 15:33:26 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 15:36:07 +0800
Received: from ubuntu1604.huawei.com (10.67.174.57) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 15:36:06 +0800
To: <ltp@lists.linux.it>
Date: Tue, 11 Jan 2022 15:36:39 +0800
Message-ID: <1641886599-246423-1-git-send-email-wenyehai@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.174.57]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] add several hash algorithms for
 crypto/crypto_user02.c
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
From: wenyehai via ltp <ltp@lists.linux.it>
Reply-To: wenyehai <wenyehai@huawei.com>
Cc: wenyehai <wenyehai@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

crypto/crypto_user02.c: In some cases, only a certain algorithm is
supported(e.g. only enable sha3 algorithm). In order to make crypto_user02 to run in more
cases, we compare with the latest linux kernel crypto/tcrypt.c, add
several hash algorithms which not list in crypto_user02(just list
possible algorithms, but not exhaustive).

Signed-off-by: Yehai Wen <wenyehai@huawei.com>
---
v1->v2: add commit message to introduce why to modify crypto_user02
 testcases/kernel/crypto/crypto_user02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
index 717b297..afaff5d 100644
--- a/testcases/kernel/crypto/crypto_user02.c
+++ b/testcases/kernel/crypto/crypto_user02.c
@@ -40,7 +40,15 @@ static const char * const ALGORITHM_CANDIDATES[] = {
 	"hmac(sha256-generic)",
 	"hmac(sha384-generic)",
 	"hmac(md5-generic)",
-	"hmac(sm3-generic)"
+	"hmac(sm3-generic)",
+	"hmac(sha512-generic)",
+	"hmac(rmd160-generic)",
+	"hmac(sha3-224-generic)",
+	"hmac(sha3-256-generic)",
+	"hmac(sha3-384-generic)",
+	"hmac(sha3-512-generic)",
+	"hmac(streebog256-generic)",
+	"hmac(streebog512-generic)"
 };

 static const char* algorithm = NULL;
--
2.7.4


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

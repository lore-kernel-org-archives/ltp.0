Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D553EECAAA1
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 02:03:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AF3E3CAC4D
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 04:03:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9681C3CA493
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 04:03:34 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6801F1A011D6
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 04:03:32 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTHL31KybzNm57
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 09:58:51 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 10:03:28 +0800
To: <ltp@lists.linux.it>
Date: Fri, 16 Sep 2022 09:59:48 +0800
Message-ID: <20220916015948.156798-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/io_uring.h: Optimization
 io_uring_setup_supported_by_kernel()
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Optimization function io_uring_setup_supported_by_kernel() when
CONFIG_IO_URING is not set.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 include/lapi/io_uring.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 397324511..24e57b069 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -297,13 +297,18 @@ static inline int io_uring_enter(int fd, unsigned int to_submit,
 static inline void io_uring_setup_supported_by_kernel(void)
 {
 	long ret;
-	if ((tst_kvercmp(5, 1, 0)) < 0) {
-		ret = syscall(__NR_io_uring_setup, NULL, 0);
-		if (ret != -1)
-			SAFE_CLOSE(ret);
-		else if (errno == ENOSYS)
+	ret = syscall(__NR_io_uring_setup, NULL, 0);
+	if (ret != -1) {
+		SAFE_CLOSE(ret);
+		return
+	}
+
+	if (errno == ENOSYS) {
+		if ((tst_kvercmp(5, 1, 0)) < 0) {
 			tst_brk(TCONF,
 				"Test not supported on kernel version < v5.1");
+		}
+		tst_brk(TCONF, "CONFIG_IO_URING not set?");
 	}
 }

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

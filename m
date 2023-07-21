Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA1FEB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 04:54:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D18F13CE972
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 06:54:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E95723C950F
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 06:54:21 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5EF0C1A010F9
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 06:54:18 +0200 (CEST)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R60g4441VzVjhX
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 12:52:48 +0800 (CST)
Received: from huawei.com (10.175.100.195) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 12:54:12 +0800
To: <ltp@lists.linux.it>
Date: Fri, 21 Jul 2023 15:18:31 +0800
Message-ID: <20230721071831.83546-1-limin154@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [10.175.100.195]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH]utils/sctp: bugfix for testlib/sctputil.h
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
From: Li Min via ltp <ltp@lists.linux.it>
Reply-To: Li Min <limin154@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The socket is created and bound immediately without waiting for the handshake after close(sk).
"bind(): errno=EADDRINUSE(98): Address already in use" may be reported.
Use SO_REUSEPORT to allow multiple sockets to be bound to the same port.

Signed-off-by: Min Li <limin154@huawei.com>
---
 utils/sctp/testlib/sctputil.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
index 176d623f0..b51a3f9b0 100644
--- a/utils/sctp/testlib/sctputil.h
+++ b/utils/sctp/testlib/sctputil.h
@@ -133,6 +133,15 @@ extern int TST_CNT;
 static inline int test_socket(int domain, int type, int protocol)
 {
 	int sk = socket(domain, type, protocol);
+	int true_const=1;
+
+	if(setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &true_const, sizeof(int))){
+		printf("set addr err\n");
+	}
+
+	if(setsockopt(sk, SOL_SOCKET, SO_REUSEPORT, &true_const, sizeof(int))){
+		printf("set port err\n");
+	}

 	if (sk == -1) {
 		if (errno == EAFNOSUPPORT)
--
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

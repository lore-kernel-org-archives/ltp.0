Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0966ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 06:31:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6EFB3CAC39
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 08:31:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4AC43CAC16
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 08:31:07 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 255E31001277
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 08:31:06 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSnKB5LXQzNmG2
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 14:26:22 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 14:30:56 +0800
To: <ltp@lists.linux.it>
Date: Thu, 15 Sep 2022 14:27:15 +0800
Message-ID: <20220915062715.233884-3-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915062715.233884-1-zhaogongyi@huawei.com>
References: <20220915062715.233884-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] io_uring.h: Remove
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

There is a kernel config CONFIG_IO_URING to control whether
io_uring is supported, so checking of the kernel version seems
redundant.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 include/lapi/io_uring.h                         | 13 -------------
 testcases/kernel/syscalls/io_uring/io_uring01.c |  1 -
 testcases/kernel/syscalls/io_uring/io_uring02.c |  2 --
 3 files changed, 16 deletions(-)

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 397324511..8f1dfd64c 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -294,17 +294,4 @@ static inline int io_uring_enter(int fd, unsigned int to_submit,
 }
 #endif /* HAVE_IO_URING_ENTER */

-static inline void io_uring_setup_supported_by_kernel(void)
-{
-	long ret;
-	if ((tst_kvercmp(5, 1, 0)) < 0) {
-		ret = syscall(__NR_io_uring_setup, NULL, 0);
-		if (ret != -1)
-			SAFE_CLOSE(ret);
-		else if (errno == ENOSYS)
-			tst_brk(TCONF,
-				"Test not supported on kernel version < v5.1");
-	}
-}
-
 #endif /* LAPI_IO_URING_H__ */
diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index cb1cabcb7..41aa05da0 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring01.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -252,7 +252,6 @@ static void run(unsigned int n)

 static void setup(void)
 {
-	io_uring_setup_supported_by_kernel();
 	tst_fill_file(TEST_FILE, 'a', 1024, 1);
 }

diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
index c7ea87ae5..a04e759f8 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring02.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
@@ -75,8 +75,6 @@ static void setup(void)
 	if (ret >= (int)sizeof(addr.sun_path))
 		tst_brk(TBROK, "Tempdir path is too long");

-	io_uring_setup_supported_by_kernel();
-
 	sendsock = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
 	recvsock = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
 	SAFE_BIND(recvsock, (struct sockaddr *)&addr, sizeof(addr));
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

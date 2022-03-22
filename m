Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0798C433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 06:39:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 705AF3C898C
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 07:38:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF97E3C01FD
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 07:38:47 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD5A52009E9
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 07:38:44 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KN1wc0XWgzCrFR
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 14:36:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 14:38:38 +0800
To: <ltp@lists.linux.it>
Date: Tue, 22 Mar 2022 14:37:56 +0800
Message-ID: <20220322063756.14404-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ioctl/ioctl_ns*: Move the SAFE_CLOSE to the suitable
 location
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

If we run the test with the option -i 10000, and the ulimit
of open files little than 10000, the test would fail and report
error of EMFILE.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns02.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns03.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns04.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index 36d2b3b67..f01dd020f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -58,9 +58,9 @@ static void test_ns_get_parent(void)
 		else
 			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
 	} else {
-		SAFE_CLOSE(fd);
 		tst_res(TFAIL, "call to ioctl succeded");
 	}
+	SAFE_CLOSE(fd);
 }

 static int child(void *arg LTP_ATTRIBUTE_UNUSED)
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
index 33ef757a8..e63b56859 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
@@ -40,9 +40,9 @@ static void run(void)
 		else
 			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
 	} else {
-		SAFE_CLOSE(fd);
 		tst_res(TFAIL, "call to ioctl succeded");
 	}
+	SAFE_CLOSE(fd);
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
index 279032d20..8464bcd07 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
@@ -43,9 +43,9 @@ static void run(void)
 		else
 			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
 	} else {
-		SAFE_CLOSE(fd);
 		tst_res(TFAIL, "call to ioctl succeded");
 	}
+	SAFE_CLOSE(fd);
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
index 90035cbeb..a3923f485 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
@@ -39,9 +39,9 @@ static void run(void)
 		else
 			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
 	} else {
-		SAFE_CLOSE(fd);
 		tst_res(TFAIL, "call to ioctl succeded");
 	}
+	SAFE_CLOSE(fd);
 }

 static struct tst_test test = {
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02CC433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 07:34:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42FF23C9043
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 08:34:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 366E73C067B
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 08:34:27 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6A66D2005D8
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 08:34:23 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KPv3c2CcpzcbwW
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 15:34:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 15:34:15 +0800
To: <ltp@lists.linux.it>
Date: Fri, 25 Mar 2022 15:33:33 +0800
Message-ID: <20220325073333.255193-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unlinkat01: Add SAFE_CLOSE before test return
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
 testcases/kernel/syscalls/unlinkat/unlinkat01.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index 9e9a5d7db..4f5a6da1e 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -52,13 +52,14 @@ static struct tcase {

 static void run(unsigned int i)
 {
+	int fd_testfile3 = -1;
 	/* tesfile2 will be unlinked by test0. */
 	if (access(testfile2, F_OK))
 		SAFE_FILE_PRINTF(testfile2, testfile2);

 	/* testfile3 will be unlined by test1. */
 	if (access(testfile3, F_OK))
-		SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
+		fd_testfile3 = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);

 	/* subpathdir will be unlinked by test6. */
 	if (access(subpathdir, F_OK))
@@ -80,6 +81,8 @@ static void run(unsigned int i)

 	if (!tc[i].fd)
 		SAFE_CLOSE(fd);
+	if (fd_testfile3 > 0)
+		SAFE_CLOSE(fd_testfile3);
 }

 static void setup(void)
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

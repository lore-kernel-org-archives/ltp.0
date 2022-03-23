Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD760C433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 09:50:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2D113C942B
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 10:50:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85E923C8C9A
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:50:14 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5CD1E140017D
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:50:11 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KNk4z2txbzBrgH
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 17:46:11 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 17:50:06 +0800
To: <ltp@lists.linux.it>
Date: Wed, 23 Mar 2022 17:49:26 +0800
Message-ID: <20220323094926.65653-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] accept02: Add SAFE_FORK to clean CLOSE_WAIT fds
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

If we run the test with option -i 1000, and the ulimit
of open files little than 1000, the test would fail and
report the error of EMFILE. We can see that the socket
fds are in the status of CLOSE_WAIT.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/accept/accept02.c | 25 ++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 12a1e3ca3..d46293386 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -23,6 +23,8 @@

 #include <errno.h>
 #include <sys/socket.h>
+#include <sys/wait.h>
+#include <stdlib.h>
 #include "tst_test.h"
 #include "tst_safe_net.h"
 #include "tst_safe_pthread.h"
@@ -92,17 +94,23 @@ static void *client_thread(void *arg)

 static void run(void)
 {
-	pthread_t server_thr, client_thr;
+	pid_t child = SAFE_FORK();
+	if (!child) {
+		pthread_t server_thr, client_thr;

-	server_addr->sin_port = server_port;
-	client_addr->sin_port = htons(0);
+		server_addr->sin_port = server_port;
+		client_addr->sin_port = htons(0);

-	SAFE_PTHREAD_CREATE(&server_thr, NULL, server_thread, NULL);
-	TST_CHECKPOINT_WAIT(0);
-	SAFE_PTHREAD_CREATE(&client_thr, NULL, client_thread, NULL);
+		SAFE_PTHREAD_CREATE(&server_thr, NULL, server_thread, NULL);
+		TST_CHECKPOINT_WAIT(0);
+		SAFE_PTHREAD_CREATE(&client_thr, NULL, client_thread, NULL);

-	SAFE_PTHREAD_JOIN(server_thr, NULL);
-	SAFE_PTHREAD_JOIN(client_thr, NULL);
+		SAFE_PTHREAD_JOIN(server_thr, NULL);
+		SAFE_PTHREAD_JOIN(client_thr, NULL);
+		exit(0);
+	}
+
+	SAFE_WAIT(NULL);
 }

 static void setup(void)
@@ -145,6 +153,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_checkpoints = 1,
+	.forks_child = 1,
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2017-8890"},
 		{"linux-git", "657831ff"},
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

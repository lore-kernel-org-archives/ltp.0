Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B790CC433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:20:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 923813C8DBB
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 09:20:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B36A3C8C57
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 09:20:34 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 286A0140115B
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 09:20:32 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HyKp956nLzcbQg
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 16:15:29 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 16:20:28 +0800
To: <ltp@lists.linux.it>
Date: Mon, 22 Nov 2021 16:21:46 +0800
Message-ID: <20211122082146.59895-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/fanotify07: Add stop_children() to
 cleanup()
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

When we run the testcase simultaneously, and the ulimit of open
files is small, the testcase will fail and remain many while(1)
tasks in system, it makes the system very stuck.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v2->v3: replace memset() with assignment statement in loop

 testcases/kernel/syscalls/fanotify/fanotify07.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index cc56d9019..8220213b1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -86,13 +86,19 @@ static int stop_children(void)
 	int child_ret;
 	int i, ret = 0;

-	for (i = 0; i < MAX_CHILDREN; i++)
+	for (i = 0; i < MAX_CHILDREN; i++) {
+		if (!child_pid[i])
+			continue;
 		SAFE_KILL(child_pid[i], SIGKILL);
+	}

 	for (i = 0; i < MAX_CHILDREN; i++) {
+		if (!child_pid[i])
+			continue;
 		SAFE_WAITPID(child_pid[i], &child_ret, 0);
 		if (!WIFSIGNALED(child_ret))
 			ret = 1;
+		child_pid[i] = 0;
 	}

 	return ret;
@@ -190,6 +196,8 @@ static void setup(void)

 static void cleanup(void)
 {
+	stop_children();
+
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
 }
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE3C433FE
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:00:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE3C61268
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEE3C61268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19903C762E
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:00:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 674A43C6F3E
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:00:32 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5BD814011BC
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 10:00:30 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HlvVN0mJ6zbhZK
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 16:55:40 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 5 Nov 2021 17:00:25 +0800
From: Zhao Gongyi <zhaogongyi@huawei.com>
To: <ltp@lists.linux.it>
Date: Fri, 5 Nov 2021 17:02:00 +0800
Message-ID: <20211105090200.103485-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/fanotify07: add stop_children() to
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When we run the testcase simultaneously, and the ulimit of open
files is small, the testcase will fail and remain many while(1)
tasks in system, it makes the system very stuck.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2: add stop_children() to cleanup(),suggested by Amir and Matthew.

 testcases/kernel/syscalls/fanotify/fanotify07.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index cc56d9019..40d1b96ce 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -86,15 +86,21 @@ static int stop_children(void)
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
 	}

+	memset(child_pid, 0, sizeof(pid_t) * MAX_CHILDREN);
 	return ret;
 }

@@ -190,6 +196,8 @@ static void setup(void)

 static void cleanup(void)
 {
+	stop_children();
+
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
 }
@@ -201,6 +209,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.needs_root = 1,
 };

 #else
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

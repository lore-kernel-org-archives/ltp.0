Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDD1C433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 12:18:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76461611C3
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 12:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76461611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 720B53C732F
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 13:18:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 623B93C6A5E
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 13:18:14 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 04B5D140164A
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 13:18:12 +0100 (CET)
Received: from dggeml753-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HlN2F0Htkz90HZ
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 20:17:57 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 dggeml753-chm.china.huawei.com (10.1.199.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Thu, 4 Nov 2021 20:18:06 +0800
From: Zhao Gongyi <zhaogongyi@huawei.com>
To: <ltp@lists.linux.it>
Date: Thu, 4 Nov 2021 20:19:41 +0800
Message-ID: <20211104121941.32957-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeml753-chm.china.huawei.com (10.1.199.152)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fanotify: Kill the child process before exit
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

Before the main process exit abnormally, we need to kill
the child process.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../kernel/syscalls/fanotify/fanotify07.c     | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index cc56d9019..0a0b4f1e4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -108,6 +108,39 @@ static int setup_instance(void)
 	return fd;
 }

+static int setup_another_instance(void)
+{
+	int rval;
+	int fd = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY);
+
+	if (fd == -1) {
+		stop_children();
+		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
+	}
+
+	if (fd < -1) {
+		stop_children();
+		tst_brk(TBROK | TERRNO,
+			"invalid fanotify_init() return %d", fd);
+	}
+
+	rval = fanotify_mark(fd,
+		FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname);
+
+	if (rval == -1) {
+		stop_children();
+		tst_brk(TBROK | TERRNO, "fanotify_mark() failed");
+	}
+
+	if (rval < -1) {
+		stop_children();
+		tst_brk(TBROK | TERRNO,
+			"invalid fanotify_mark() return %d", rval);
+	}
+
+	return fd;
+}
+
 static void loose_fanotify_events(void)
 {
 	int not_responded = 0;
@@ -160,7 +193,7 @@ static void test_fanotify(void)
 	 * Create and destroy another instance. This may hang if
 	 * unanswered fanotify events block notification subsystem.
 	 */
-	newfd = setup_instance();
+	newfd = setup_another_instance();

 	SAFE_CLOSE(newfd);

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

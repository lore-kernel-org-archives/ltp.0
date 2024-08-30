Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B575CA0EE6
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 07:11:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78D063D1ADC
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 09:11:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DD163D1ADC
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 09:11:26 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=18.132.163.193; helo=smtpbg150.qq.com;
 envelope-from=zhaoyouzhi@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5151602987
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 09:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1725001877;
 bh=GkKBsMMVTlHzm8YoIf4YAReGAeIFjFx2YSp1nzODKKY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=QeHVk1yY8xLRQEvyNNp8fMrQhZ7y9VsXUIGNB+y5fYCbFSLnKpXNP86t8kXcekF3p
 j4Yk/zLhhgRmP4Qib6zSUMX3EyIzef3PJEmzHLXp3RIsO0A01KSzAg7jT4JE/HykFW
 u9RKief6S1jqmvLIsGWTktQnB8TLi5a/W4LCD4/I=
X-QQ-mid: bizesmtp90t1725001871td73d410
X-QQ-Originating-IP: Qo/9MXrrqpy2xGbMvpgq9BS/8fYBYVM1owteilKXOfo=
Received: from localhost.localdomain ( [221.226.144.218])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 30 Aug 2024 15:11:09 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6596643690721014894
From: YouZhi Zhao <zhaoyouzhi@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 30 Aug 2024 15:11:01 +0800
Message-ID: <027453D6AD3FFC61+20240830071101.754457-1-zhaoyouzhi@uniontech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fsmount: add coverage for fsmount01.c
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

Can I create a file and write a file verification after adding the setting for MOUNT_STTR_RDONLY

Signed-off-by: Youzhi Zhao <zhaoyouzhi@uniontech.com>
---
 testcases/kernel/syscalls/fsmount/fsmount01.c | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 5f755863f..8bf4a5a0a 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -10,6 +10,7 @@
 #include "lapi/fsmount.h"

 #define MNTPOINT	"mntpoint"
+#define TEST_FILE       MNTPOINT "/testfile"

 #define TCASE_ENTRY(_flags, _attrs)	{.name = "Flag " #_flags ", Attr " #_attrs, .flags = _flags, .attrs = _attrs}

@@ -36,6 +37,24 @@ static struct tcase {
 	TCASE_ENTRY(FSMOUNT_CLOEXEC, MOUNT_ATTR_NODIRATIME),
 };

+static void verify_mount_readonly(void)
+{
+        int fd;
+
+        fd = open(TEST_FILE, O_WRONLY | O_CREAT, 0644);
+        if (fd == -1) {
+                if (errno == EROFS) {
+                        tst_res(TPASS, "MOUNT_ATTR_RDONLY verified: Cannot create file, filesystem is read-only.");
+                } else {
+                        tst_res(TFAIL | TTERRNO, "Failed to create file for unknown reason.");
+                }
+        } else {
+                tst_res(TFAIL, "MOUNT_ATTR_RDONLY verification failed: File created on supposed read-only filesystem.");
+                close(fd);
+                unlink(TEST_FILE);
+        }
+}
+
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -81,10 +100,14 @@ static void run(unsigned int n)
 		return;
 	}

-	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
-		SAFE_UMOUNT(MNTPOINT);
-		tst_res(TPASS, "%s: fsmount() passed", tc->name);
-	}
+        if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
+                if (tc->attrs & MOUNT_ATTR_RDONLY) {
+                        verify_mount_readonly();
+                } else {
+                        tst_res(TPASS, "%s: fsmount() passed", tc->name);
+                }
+                SAFE_UMOUNT(MNTPOINT);
+        }
 }

 static struct tst_test test = {
--
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

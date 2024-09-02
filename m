Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB47CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 06:12:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334AF3C3103
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 08:12:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AEF23C3048
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 08:12:35 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.204.34.130;
 helo=smtpbguseast2.qq.com; envelope-from=zhaoyouzhi@uniontech.com;
 receiver=lists.linux.it)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7729C10007C3
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 08:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1725257547;
 bh=NbKT6mR4t2o0dtxhBiH6hoLLxIzYtgC6fd+Ncpgs5II=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=Z+dDmOrbbX8anwQgtdqdfERI85TaAPSvaMXDBPyE2B0uMIkJJE9elr1qDl6ZAjAcQ
 OekeqOO07eubAe/JHSqU8qKGLDTZYvTk16U1Ct5NNU5RqEDoO/g1gTWeor1exQOxBY
 zBbRRUEC5uif6bnerQKOO0Oe7P2cR1GQ4cUNdMoU=
X-QQ-mid: bizesmtpsz10t1725257544tvx4d4
X-QQ-Originating-IP: iW2t8SvO5eyaiXbrregd3TGte5dknLnjBWHAQDamre8=
Received: from localhost.localdomain ( [221.226.144.218])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 02 Sep 2024 14:12:22 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5910891645126402420
From: YouZhi Zhao <zhaoyouzhi@uniontech.com>
To: ltp@lists.linux.it
Date: Mon,  2 Sep 2024 14:12:17 +0800
Message-ID: <B8632D9169E22850+20240902061218.39040-1-zhaoyouzhi@uniontech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fspick:add coverage for fspick01.c
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

expand the test items after setting FSCONFIG_CMD_RECONFIGURE to include re-fetching the mount point attributes and verifying whether the file system is set to read-only.

Signed-off-by: Youzhi Zhao <zhaoyouzhi@uniontech.com>
---
 testcases/kernel/syscalls/fspick/fspick01.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d3309a912..7aabb1d9e 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -6,6 +6,8 @@
  */
 #include "tst_test.h"
 #include "lapi/fsmount.h"
+#include <sys/statvfs.h>
+

 #define MNTPOINT		"mntpoint"
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
@@ -39,7 +41,7 @@ static void run(unsigned int n)

 	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) ro failed");
 		goto out;
 	}

@@ -48,7 +50,19 @@ static void run(unsigned int n)
 		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_RECONFIGURE) failed");
 		goto out;
 	}
-
+
+	struct statvfs buf;
+    	if (statvfs(MNTPOINT, &buf) == -1) {
+        	tst_res(TFAIL | TTERRNO, "statvfs() failed");
+        	return -1;
+    	}
+    	if(buf.f_flag & ST_RDONLY)
+	{
+		tst_res(TPASS, "%s: fspick() and reconfigure succeeded, filesystem is read-only", tc->name);
+	}else
+	{
+		tst_res(TFAIL, "%s: Filesystem is not read-only after reconfigure", tc->name);
+	}
 	tst_res(TPASS, "%s: fspick() passed", tc->name);

 out:
--
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

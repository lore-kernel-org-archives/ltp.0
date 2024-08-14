Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71E0C52D7B
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 10:11:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B2E03D214B
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 12:11:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54A2D3D20CD
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 12:11:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.204.34.130;
 helo=smtpbguseast2.qq.com; envelope-from=lufei@uniontech.com;
 receiver=lists.linux.it)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 87DD31A00922
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 12:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1723630271;
 bh=QDa+ZMJVxm60wmbzM57DNeZ5vEO/JneINC7H0YQmiFM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=fbY3JLPVTW5P/ftT/PHNbbJVOjPVKSNRfejP4FjfhGLQCnwKeTPyYYTZJM4nqDDOR
 VPOptUlKPR/qhsYqDrlrwy1PRaKe/VWrCbJL4lGKOTliHNunu/07xCGq4s9x0H7qa5
 o6t+oLcHXD4zHroY3n2lBE9ChTTMspVxEMguFTws=
X-QQ-mid: bizesmtpsz14t1723630267tzufff
X-QQ-Originating-IP: hjIVOurL0TE9cDb2Y5Yc0kVxB2ssQgbqv25t1x3WuAs=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 14 Aug 2024 18:11:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16951131966786318759
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 14 Aug 2024 18:11:02 +0800
Message-Id: <20240814101104.1098-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] fix make check errors: replace space with tabs,
 remove unecessary spaces.
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

replace space with tabs, remove unecessary spaces.

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/acct/acct01.c | 6 +++---
 testcases/kernel/syscalls/acct/acct02.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 60cf4681e..b9b08ef67 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -73,8 +73,8 @@ static struct test_case {
 	char **filename;
 	char *desc;
 	int exp_errno;
-	void (*setupfunc) ();
-	void (*cleanfunc) ();
+	void (*setupfunc)();
+	void (*cleanfunc)();
 } tcases[] = {
 	{&file_eisdir,  FILE_EISDIR,  EISDIR,  NULL,   NULL},
 	{&file_eaccess, FILE_EACCESS, EACCES,  NULL,   NULL},
@@ -126,7 +126,7 @@ static void verify_acct(unsigned int nr)
 		tcase->setupfunc();
 
 	TST_EXP_FAIL(acct(*tcase->filename), tcase->exp_errno,
-	             "acct(%s)", tcase->desc);
+		"acct(%s)", tcase->desc);
 
 	if (tcase->cleanfunc)
 		tcase->cleanfunc();
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index d3f3d9d04..74019f430 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -186,7 +186,7 @@ static void run(void)
 
 		if (read_bytes != acct_size) {
 			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
-			        read_bytes, acct_size);
+					read_bytes, acct_size);
 			goto exit;
 		}
 
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

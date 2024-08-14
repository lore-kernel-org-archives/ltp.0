Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B4C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 10:01:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1BB63D213A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 12:01:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D2723CBC79
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 12:01:15 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.254.200.128; helo=smtpbgsg2.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 20E941A00EBB
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 12:01:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1723629671;
 bh=QDa+ZMJVxm60wmbzM57DNeZ5vEO/JneINC7H0YQmiFM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=pJgGzXkKMIhG8IeQuef5rdM7GgpBnF6EYck+guwYxvkvDUVjo7MQSA2B2wRAMU5n+
 0kTRDq/VTjij+6duFGfNgDaT7b74TR5ATMCi597ey20nqEgKT2FRzfxi8vaXM1bkLO
 t4ZGeDkEy7QMc5WfJQrL7p58SmnwItAP1XNMYxpM=
X-QQ-mid: bizesmtp83t1723629667tqkm0u1g
X-QQ-Originating-IP: OIcytaM+Peqfobi/RSo7BbGeRl5OSxqEopNJuiJ2rFw=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 14 Aug 2024 18:01:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9666637479271596458
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 14 Aug 2024 18:00:57 +0800
Message-Id: <20240814100059.4680-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
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

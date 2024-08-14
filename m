Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BC2C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 10:12:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 417913D2137
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 12:12:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 949073D2141
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 12:11:25 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=52.59.177.22; helo=smtpbgeu1.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 407AE1A0092F
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 12:11:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1723630280;
 bh=KLaHBc6LHQreImXe5TYURjYWDLyLh5D3voCTo/z5QNg=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ehVsQggRSdy9UpqkzIBj2yaNGBHrYV1+MJMCYuZq3Wcm9TxJ34npRklobz7JWEZsG
 6eFE4jA6WI36P5gc6QnJxMrvSnD/J0iNLE2H0a8DIPtXTpe4PPAXbd+cO1cJwSUZyq
 SPyBql3kUwFcg32FC5i/7WSLBSk3QiEg1lMC3Cpo=
X-QQ-mid: bizesmtpsz14t1723630276tjbczp
X-QQ-Originating-IP: M/pZgmWkrbML2rLZdDpz6+MFO0UQKi4X4sMRmTkkP/4=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 14 Aug 2024 18:11:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18386344662012193755
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 14 Aug 2024 18:11:04 +0800
Message-Id: <20240814101104.1098-3-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240814101104.1098-1-lufei@uniontech.com>
References: <20240814101104.1098-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] fix make check warning: using .needs_kconfigs
 instead of ENOSYS
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

Replace ENOSYS with .needs_kconfigs `CONFIG_BSD_PROCESS_ACCT=y`

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/acct/acct01.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index de653d810..cfd25c665 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -92,8 +92,6 @@ static void setup(void)
 	int fd;
 
 	TEST(acct(NULL));
-	if (TST_RET == -1 && TST_ERR == ENOSYS)
-		tst_brk(TCONF, "acct() system call isn't configured in kernel");
 
 	ltpuser = SAFE_GETPWNAM("nobody");
 
@@ -148,5 +146,8 @@ static struct tst_test test = {
 		{&file_enametoolong, .size = PATH_MAX+2},
 		{&file_erofs, .str = FILE_EROFS},
 		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_BSD_PROCESS_ACCT=y",
 	}
 };
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

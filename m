Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8C7C43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 16:05:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C40E3CAA54
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 18:05:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45D493CA9DD
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 18:05:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A22A200D13
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 18:05:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9733234CE0
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657814717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u3NIZtenpyfp3a53U9O9+J9xFMppiUhK+sp3vzGAv3c=;
 b=W3vlXLfBJf8OG9QrWMKnSdhdv7ZgWQLi4Z0hW0E9f35DPsoXgTZw8fCFe90z2fqxl+TZ60
 tN6klAACfG7cwwi0wt3C5Pqpoot5/YdoEZsHe53NywzXQTRr5I6IHRaTa+96D445OoBqQh
 ePOfBfnOv9vUNn94DXXxhOw/LJpAwlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657814717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=u3NIZtenpyfp3a53U9O9+J9xFMppiUhK+sp3vzGAv3c=;
 b=cNT96YvPFBK6yzZtDsbWkJNRPaofZY0SlSqIpJif0NSbExF5AP0poO+ZPiPKVUh/z4zFTz
 OfueEAXrVeoHfBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 150F4133A6
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 16:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2gLXMbw+0GLJWwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 16:05:16 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Jul 2022 21:35:14 +0530
Message-Id: <20220714160514.21062-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] write04.c: use TST_EXP_FAIL() macro
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/write/write04.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/write/write04.c b/testcases/kernel/syscalls/write/write04.c
index a765d91b7..565fddfb7 100644
--- a/testcases/kernel/syscalls/write/write04.c
+++ b/testcases/kernel/syscalls/write/write04.c
@@ -30,20 +30,7 @@ static void verify_write(void)
 {
 	char wbuf[8 * page_size];
 
-	TEST(write(wfd, wbuf, sizeof(wbuf)));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "write() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR != EAGAIN) {
-		tst_res(TFAIL | TTERRNO,
-			"write() failed unexpectedly, expected EAGAIN");
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "write() failed expectedly");
+	TST_EXP_FAIL(write(wfd, wbuf, sizeof(wbuf)), EAGAIN);
 }
 
 static void setup(void)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B695FC00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 05:14:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19A513C95D1
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 07:14:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48CDE3C949B
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 07:14:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 96DFF1400506
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 07:14:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CED173431B
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660108480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QIe4Q7cmPB0dT4VlS03X1vaDGrozqkHbVmGRW7hRkVk=;
 b=Kf0SsgZ68VHOdu9ZpEd6yNN4/d27u5ChifG+zMXLBnRiKWM1v9WU7aa/lK/ROz1r1eJhlq
 ceGMJyXfTpzmUCk6Rdzbv370nEZYUPM3ynuSSBvVuPfeiSr0BZzfgWs2s6IZ4R+9dPyGbA
 eSF2titgnwLDa0CpzTtVYeOaeiB+p9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660108480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QIe4Q7cmPB0dT4VlS03X1vaDGrozqkHbVmGRW7hRkVk=;
 b=FamifinVIx6MJV1zo+/Lfklt3yD8Krh68+LO8rc+j6giLmrVOFyz+1UaaSK1ZDAFw8+H5o
 jbXfbyq5DDPZsEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52ABB13AB3
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 05:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Q94WBsA+82KhHgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 05:14:40 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 10 Aug 2022 10:44:37 +0530
Message-Id: <20220810051437.13037-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setuid01: use TST_EXP_PASS() macro,
 docparse comment and reword
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
 testcases/kernel/syscalls/setuid/setuid01.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/setuid/setuid01.c b/testcases/kernel/syscalls/setuid/setuid01.c
index 0a0a03a48..ed42ceda1 100644
--- a/testcases/kernel/syscalls/setuid/setuid01.c
+++ b/testcases/kernel/syscalls/setuid/setuid01.c
@@ -3,10 +3,11 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/* DESCRIPTION
- *	This test will verify that setuid(2) syscall basic functionality.
- *	setuid(2) returns a value of 0 and uid has been set successfully
- *	as a normal or super user.
+/*
+ * [Description]
+ *
+ * Verify that setuid(2) returns 0 and effective uid has
+ * been set successfully as a normal or super user.
  */
 
 #include <errno.h>
@@ -19,15 +20,10 @@ static void verify_setuid(void)
 {
 	uid_t uid;
 
-	/* Set the effective user ID to the current real uid */
 	uid = getuid();
 	UID16_CHECK(uid, setuid);
 
-	TEST(SETUID(uid));
-	if (TST_RET == -1)
-		tst_res(TFAIL | TTERRNO, "setuid(%d) failed", uid);
-	else
-		tst_res(TPASS, "setuid(%d) successfully", uid);
+	TST_EXP_PASS(SETUID(uid), "setuid(%d)", uid);
 }
 
 static struct tst_test test = {
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

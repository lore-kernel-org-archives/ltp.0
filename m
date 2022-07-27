Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B98C04A68
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 16:56:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B53E83C4D7B
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 18:55:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91D613C0F97
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 18:55:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D0C1F1400E65
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 18:55:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DA9920B93
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658940946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s1lO3f+giIzieUY5w0BYr6MbUCMAn/lXsKMCYB0/d7A=;
 b=Up1hlaBZLLsFwrHYg5UrLcAAiEB1ZmVS369ZCqrrT1eQ9GwnqTUNCm+3ONRyN6BVkTyZ6T
 RTUjTHWhMlOfemze2AnXSlqul3r023VQZ5S8mqgeZZyLN6gN9h7BEdVBXvW2WhmkA/IA/2
 xIXv+qOqZMca4htWRXGVI50mHbLfUGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658940946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s1lO3f+giIzieUY5w0BYr6MbUCMAn/lXsKMCYB0/d7A=;
 b=ZZ6TClT+1Lpq5jPDPU6WKc9k0HRa7lf1CugtRJFr12iHQF9Hs9mX46PWRiAO1c9BaHq/kH
 hDLOjJ4xzafHBHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8302213ABC
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 16:55:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RkpHDxFu4WKjEgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 16:55:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 27 Jul 2022 22:25:42 +0530
Message-Id: <20220727165542.2861-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setuid03.c: using TST_EXP_FAIL() and SAFE_SETUID()
 macros
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

use TST_EXP_FAIL() with expected errno code, use SAFE_SETUID() in setup
and turn comment into docparse

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/setuid/setuid03.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index f2e007f8d..61529b1ff 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -3,7 +3,9 @@
  * Copyright (c) International Business Machines Corp., 2001
  */
 
-/* DESCRIPTION
+/*
+ * [Description]
+ *
  * This test will switch to nobody user for correct error code collection.
  * Verify setuid returns errno EPERM when it switches to root_user.
  */
@@ -19,16 +21,7 @@
 
 static void verify_setuid(void)
 {
-	TEST(SETUID(ROOT_USER));
-	if (TST_RET != -1) {
-		tst_res(TFAIL | TTERRNO, "setuid() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == EPERM)
-		tst_res(TPASS, "setuid() returned errno EPERM");
-	else
-		tst_res(TFAIL | TTERRNO, "setuid() returned unexpected errno");
+	TST_EXP_FAIL(SETUID(ROOT_USER), EPERM);
 }
 
 static void setup(void)
@@ -39,10 +32,7 @@ static void setup(void)
 	pw = SAFE_GETPWNAM("nobody");
 	uid = pw->pw_uid;
 
-	if (SETUID(uid) == -1) {
-		tst_brk(TBROK,
-			"setuid() failed to set the effective uid to %d", uid);
-	}
+	SAFE_SETUID(uid);
 
 	umask(0);
 }
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

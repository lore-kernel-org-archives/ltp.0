Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B47C77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:08:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7AE83CE94F
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:08:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73C503CE4A7
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5834140004C
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 00A9A21AFE
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682597291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMy8VmdZ0HDkrkU8zqVfFx7vz/AckULkv+nWb3o7kWQ=;
 b=O62NOhwfhCip19+ho8AF5bvx0ff2cQs1P7wBqr3aa1hcHbbvYwBS44sbn9ozrEiZhLDNPg
 H7rKFU0sf7MnPbscJnEJC+KNBCVHzcFXJSftluBNbOc7NOcT1r6wc5l+MWZ8Bs6Qv20qFt
 uBQT591K8RCNMIYQAF8n3K62QKL3J58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682597291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMy8VmdZ0HDkrkU8zqVfFx7vz/AckULkv+nWb3o7kWQ=;
 b=2eUtbXI0fa3JUALRrh+5+b/FxOS15ACC9hMnUjlnEU+wdV0EG+g2UAkPXrl4EWoIaTXhL5
 6wMAuck3Ru4Kh8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F4FA13910
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1P4+HaplSmSPSwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:10 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Apr 2023 17:37:59 +0530
Message-Id: <20230427120800.27849-4-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427120800.27849-1-akumar@suse.de>
References: <20230427120800.27849-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] dup04.c: use TST_EXP_FD macro and make check fixes
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

+ updade copyright

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/dup/dup04.c | 44 ++++++++-------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index 8d45f7a9c..053fb40c2 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
  * 06/1994 AUTHOR: Richard Logan CO-PILOT: William Roske
+ * Copyright (c) 2023 SUSE LLC
  */
 
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic test for dup(2) of a system pipe descriptor.
  */
@@ -17,38 +17,18 @@
 
 #include "tst_test.h"
 
-int fd[2];
+static int fd[2];
 
 static void run(void)
 {
-	TEST(dup(fd[0]));
-
-	if (TST_RET == -1)
-		tst_res(TFAIL | TTERRNO,
-			 "dup of read side of pipe failed");
-	else {
-		tst_res(TPASS,
-			 "dup(%d) read side of syspipe returned %ld",
-			 fd[0], TST_RET);
-
-		SAFE_CLOSE(TST_RET);
-	}
-
-	TEST(dup(fd[1]));
-
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO,
-			 "dup of write side of pipe failed");
-	} else {
-		tst_res(TPASS,
-			 "dup(%d) write side of syspipe returned %ld",
-			 fd[1], TST_RET);
-
-		SAFE_CLOSE(TST_RET);
-	}
+	TST_EXP_FD(dup(fd[0]), "dup(%d) read end of the pipe", fd[0]);
+	SAFE_CLOSE(TST_RET);
+
+	TST_EXP_FD(dup(fd[1]), "dup(%d) write end of the pipe", fd[1]);
+	SAFE_CLOSE(TST_RET);
 }
 
-void setup(void)
+static void setup(void)
 {
 	fd[0] = -1;
 
@@ -56,7 +36,7 @@ void setup(void)
 }
 
 static struct tst_test test = {
-        .test_all = run,
-        .setup = setup,
-        .needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
 };
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

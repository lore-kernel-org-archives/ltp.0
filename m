Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3D2C25B07
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 06:11:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D28993C955B
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 08:11:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C10EF3C1BEA
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 08:11:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D2161400B74
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 08:11:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DADD437E87
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 06:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660198270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IeQLamlC0H/YwhPvKmJOEgaf62dGX+zZnZCCpJJkLms=;
 b=fE4nxgcrYXg/vwkKDyJVEy5tK3OBsceTN01RMjOriODglJZ9GlBIeckqZAiLPhCxrvHKqQ
 9GbvVFr1eU8EUWZx5xolcrBTHMVi3dAL6sFUv1KRzAkIMKsygBCGZsbjxKG3+uxxl6bV/V
 n9Oho67j8qEQR+RHJojwQrDvDe9KV1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660198270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IeQLamlC0H/YwhPvKmJOEgaf62dGX+zZnZCCpJJkLms=;
 b=2sai01GymeazBivt5EvmtlTe4fOpPl4TW4MhFHZHlTLOCAXK8RYb5n7nnIY4zcSDYNtY4P
 MOej5hIlX2nptFAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CF1613A9B
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 06:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ilFoCH6d9GKkGAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 06:11:10 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 11:41:07 +0530
Message-Id: <20220811061107.30966-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] setuid03.c: using TST_EXP_FAIL() and SAFE_SETUID()
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
 testcases/kernel/syscalls/setuid/setuid03.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index f2e007f8d..06934f142 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2001
+ * Copyright (c) Linux Test Project, 2009-2022
  */
 
-/* DESCRIPTION
+/*\
+ * [Description]
+ *
  * This test will switch to nobody user for correct error code collection.
  * Verify setuid returns errno EPERM when it switches to root_user.
  */
@@ -19,16 +22,7 @@
 
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
@@ -39,10 +33,7 @@ static void setup(void)
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

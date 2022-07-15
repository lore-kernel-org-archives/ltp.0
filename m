Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323F4C433EF
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 06:16:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A48A53CAA9F
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 08:16:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B82F3CA9EA
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 08:15:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 816E2200DD9
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 08:15:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68D93344AF
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657865751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZMosdXDL8rbDQ9ExYp6zC6Rle2O5zx/rJq2lyD6boGk=;
 b=sK4NRhgo5L1UgG0YIs9omp0DMK19eOGSPhVsrXmkkSTyNsIFJtUxxUrmCOopIWOJ+bMbfG
 pAJijZIpheDByvQuoT8UENo4+mX+jfOIKwloaUUKVcJSfdg2wFv/KTC1yORTP1b4WUBU4C
 WjnrCsUt13X7Ie89mujSV7pAgFHZvCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657865751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZMosdXDL8rbDQ9ExYp6zC6Rle2O5zx/rJq2lyD6boGk=;
 b=2lwlH5aCpr9u8XqLgNRRFbEuuF744pS353x+KlE7sQTH3quRwCdkdx2R2Iy35ic8C+AWF5
 yxcVPX1+peJNdbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D479A13AC3
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 06:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XFAHJBYG0WKobgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 06:15:50 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 15 Jul 2022 11:45:48 +0530
Message-Id: <20220715061548.11574-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unlink07: use TST_EXP_FAIL() and turn comment into
 docparse, reword
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
 testcases/kernel/syscalls/unlink/unlink07.c | 38 ++++++++-------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index 869bd5f51..8848c1283 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -3,15 +3,17 @@
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
-/*
- * Description:
- * The testcase checks the various errnos of the unlink(2).
- * 1) unlink() returns ENOENT if file doesn't exist.
- * 2) unlink() returns ENOENT if path is empty.
- * 3) unlink() returns ENOENT if path contains a non-existent file.
- * 4) unlink() returns EFAULT if address is invalid.
- * 5) unlink() returns ENOTDIR if path contains a regular file.
- * 6) unlink() returns ENAMETOOLONG if path contains a regular file.
+/*\
+ * [Description]
+ *
+ * Verify that unlink() fails with
+ * - ENOENT when file does not exist.
+ * - ENOENT when pathname is empty.
+ * - ENOENT when a component in pathname does not exist.
+ * - EFAULT when pathname points outside the accessible address space.
+ * - ENOTDIR when a component used as a directory in pathname is not,
+ * in fact, a directory.
+ * - ENAMETOOLONG when pathname is too long.
  */
 
 #include <errno.h>
@@ -39,21 +41,9 @@ static void verify_unlink(unsigned int n)
 {
 	struct test_case_t *tc = &tcases[n];
 
-	TEST(unlink(tc->name));
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "unlink(<%s>) succeeded unexpectedly",
-			tc->desc);
-		return;
-	}
-
-	if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TTERRNO, "unlink(<%s>) failed as expected",
-			tc->desc);
-	} else {
-		tst_res(TFAIL | TTERRNO,
-			"unlink(<%s>) failed, expected errno: %s",
-			tc->desc, tst_strerrno(tc->exp_errno));
-	}
+	TST_EXP_FAIL(unlink(tc->name),
+				tc->exp_errno,
+				"%s", tc->desc);
 }
 
 static void setup(void)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

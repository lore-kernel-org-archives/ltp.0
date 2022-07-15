Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA08C433EF
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 07:12:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3CCA3CAA86
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 09:12:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B5B83CA9C0
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 09:12:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2B2981A00250
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 09:12:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21D7633F52
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657869139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PTENhFhG5zkRHlfdPMkWeyuDTO+sg8lWyBKW+DDKotI=;
 b=KvTd9lm9DLgb4LEd3824BmiGdx5EImPJxoh9AGYLJb5WFQyfCCAtAttBj+50PbF4mY2ZI+
 did/Q5SP7699U3LjyNINmPJtr8O7l/OXXpfLlzqgids5/MpkBJvW/nAEd3x6F2JOykbfso
 XWdHZym5ePXzJdsVDngXiBPpZZHSNDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657869139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PTENhFhG5zkRHlfdPMkWeyuDTO+sg8lWyBKW+DDKotI=;
 b=NNuogf3RiIzEm3DUFYle3mLm3y+fQjHuekzvp2w+zHAOwaafG1FKDJRpmHbXERFvf0FXI6
 TVyZm34PiFsTt7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9545413B28
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 07:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zJurFFIT0WI4BQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 07:12:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 15 Jul 2022 12:42:16 +0530
Message-Id: <20220715071216.15404-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unlink08: use TST_EXP_FAIL() and turn comment into
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
 testcases/kernel/syscalls/unlink/unlink08.c | 35 +++++++--------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index f3ce46ad8..d16607540 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -3,15 +3,14 @@
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
-/*
- * Description:
- * The testcase checks the various errnos of the unlink(2).
- * 1) unlink() returns EACCES when deleting file in unwritable directory
- *    as an unprivileged user.
- * 2) unlink() returns EACCES when deleting file in "unsearchable directory
- *    as an unprivileged user.
- * 3) unlink() returns EISDIR when deleting directory for root
- * 4) unlink() returns EISDIR when deleting directory for regular user
+/*\
+ * [Description]
+ *
+ * Verify that unlink(2) fails with
+ * - EACCES when no write access to the directory containing pathname.
+ * - EACCES when one of the directories in pathname did not allow search.
+ * - EISDIR when deleting directory as root user.
+ * - EISDIR when deleting directory as non-root user.
  */
 
 #include <errno.h>
@@ -36,21 +35,9 @@ static struct test_case_t {
 
 static void verify_unlink(struct test_case_t *tc)
 {
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
 
 static void do_unlink(unsigned int n)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

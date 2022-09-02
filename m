Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DF9C54EE9
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 06:33:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF4273CA8BF
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 08:33:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C90E43CA4D7
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:33:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 640432003B9
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 08:33:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC9CD2033C
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 06:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662100424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uaXAlxxW0l02oEsoi3TRbI188mqO94MO8B92VtoJ1nw=;
 b=MMfWpYPSm76FCP/Bpf4Eyfyw16+tdjNBdahKqZH47DFTU5mIPzMtq8Fo68Or4viW4u/x8j
 9bipFPEaLwpJTLX4Y5C55/uJgldH/jS0/OVSt8kx0QshnYyzqQS/EGn9s3kUpCg1A7xRF4
 V5eb7Tt3J0XpyaK4hTjtkYtF/ihQjEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662100424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uaXAlxxW0l02oEsoi3TRbI188mqO94MO8B92VtoJ1nw=;
 b=i+evxJIg6Y1ARu7nP30X6s052aL20PKBJTzUepz3khkWXqw/5t13p8f+ToGPFi1mFKljy6
 xPEH7T0MGMB1GtDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 416E91330E
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 06:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ShrYAcijEWO8SAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 02 Sep 2022 06:33:44 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  2 Sep 2022 12:03:41 +0530
Message-Id: <20220902063341.21705-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] unlink08: use TST_EXP_FAIL(),
 turn comment into docparse and reword, copyright update
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
 testcases/kernel/syscalls/unlink/unlink08.c | 37 ++++++---------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index f3ce46ad8..f75ba06e0 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -1,22 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2002-2022
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
+ * - EACCES when no write access to the directory containing pathname
+ * - EACCES when one of the directories in pathname did not allow search
+ * - EISDIR when deleting directory as root user
+ * - EISDIR when deleting directory as non-root user
  */
 
-#include <errno.h>
 #include <stdlib.h>
-#include <sys/types.h>
 #include <pwd.h>
 #include "tst_test.h"
 
@@ -36,21 +34,7 @@ static struct test_case_t {
 
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
+	TST_EXP_FAIL(unlink(tc->name), tc->exp_errno, "%s", tc->desc);
 }
 
 static void do_unlink(unsigned int n)
@@ -65,7 +49,6 @@ static void do_unlink(unsigned int n)
 			verify_unlink(cases);
 			exit(0);
 		}
-
 		SAFE_WAITPID(pid, NULL, 0);
 	} else {
 		verify_unlink(cases);
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

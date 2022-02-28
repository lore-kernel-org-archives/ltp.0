Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F79BC433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 13:33:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B987A3CA275
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 14:33:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 929183C9753
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 14:33:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BBA4E100061D
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 14:33:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 574EC2199F;
 Mon, 28 Feb 2022 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646055180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQKt3SBRFSOdwCd1rfUbuke6marBf11hmysJn153now=;
 b=mDGitCUKFdHlnyTYzw+8cpE4NVUfKp4ZudWmcEJ7svzaqgqspH4ykhfaVk/HZlZTuVaURj
 bdw5QMW5bqSDBrsoqf+QKkSdnbI7PRtboClK+JoeFlWKp806MlTRr2LUJgQiQHRGO9haGG
 KtHbZIdmZk12iYvnomA1vdrtRrL8Whc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646055180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQKt3SBRFSOdwCd1rfUbuke6marBf11hmysJn153now=;
 b=Or4gTV5fdKDTVgUxCmWGFf5hoWaPXZxxxJPokHNAZ6C4kuWyL8tiSAS8DxDdcfBVzWZjOC
 p1fOr/XiJQMk6lBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19B4713C29;
 Mon, 28 Feb 2022 13:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mLWVAwzPHGKhRQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 28 Feb 2022 13:33:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 28 Feb 2022 14:32:54 +0100
Message-Id: <20220228133256.12763-5-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228133256.12763-1-andrea.cervesato@suse.de>
References: <20220228133256.12763-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/6] Rewrite mountns04 test using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 .../kernel/containers/mountns/mountns04.c     | 95 ++++++++-----------
 1 file changed, 39 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
index 1f022a683..b21bf199a 100644
--- a/testcases/kernel/containers/mountns/mountns04.c
+++ b/testcases/kernel/containers/mountns/mountns04.c
@@ -1,89 +1,72 @@
-/* Copyright (c) 2014 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- ***********************************************************************
- * File: mountns04.c
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
  * Tests an unbindable mount: unbindable mount is an unbindable
  * private mount.
- * Description:
+ *
+ * [Algorithm]
+ *
  * 1. Creates directories "A", "B" and files "A/A", "B/B"
  * 2. Unshares mount namespace and makes it private (so mounts/umounts
  *    have no effect on a real system)
  * 3. Bind mounts directory "A" to "A"
- * 4. Makes directory directory "A" unbindable
+ * 4. Makes directory "A" unbindable
  * 5. Tries to bind mount unbindable "A" to "B":
  *    - if it fails, test passes
  *    - if it passes, test fails
- ***********************************************************************/
+ */
 
-#define _GNU_SOURCE
 #include <sys/wait.h>
 #include <sys/mount.h>
-#include <stdio.h>
-#include <errno.h>
-#include "mountns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID	= "mountns04";
-int TST_TOTAL	= 1;
-
-#if defined(MS_SHARED) && defined(MS_PRIVATE) \
-    && defined(MS_REC) && defined(MS_UNBINDABLE)
+#include "mountns.h"
+#include "tst_test.h"
 
-static void test(void)
+static void run(void)
 {
 	/* unshares the mount ns */
-	if (unshare(CLONE_NEWNS) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
+	SAFE_UNSHARE(CLONE_NEWNS);
+
 	/* makes sure mounts/umounts have no effect on a real system */
-	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
+	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);
 
 	/* bind mounts DIRA to itself */
-	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
+	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
+
 	/* makes mount DIRA unbindable */
-	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_UNBINDABLE, NULL);
+	SAFE_MOUNT("none", DIRA, "none", MS_UNBINDABLE, NULL);
 
 	/* tries to bind mount unbindable DIRA to DIRB which should fail */
 	if (mount(DIRA, DIRB, "none", MS_BIND, NULL) == -1) {
-		tst_resm(TPASS, "unbindable mount passed");
+		tst_res(TPASS, "unbindable mount passed");
 	} else {
-		SAFE_UMOUNT(cleanup, DIRB);
-		tst_resm(TFAIL, "unbindable mount faled");
+		SAFE_UMOUNT(DIRB);
+		tst_res(TFAIL, "unbindable mount faled");
 	}
 
-	SAFE_UMOUNT(cleanup, DIRA);
+	SAFE_UMOUNT(DIRA);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		test();
-
-	cleanup();
-	tst_exit();
+	check_newns();
+	create_folders();
 }
 
-#else
-int main(void)
+static void cleanup(void)
 {
-	tst_brkm(TCONF, NULL, "needed mountflags are not defined");
+	umount_folders();
 }
-#endif
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

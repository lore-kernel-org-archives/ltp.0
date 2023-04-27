Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A994FC77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:09:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04C8A3CE948
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:08:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9747F3CE93A
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F0831A006A4
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B11F421AFE
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682597293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HucaRXV7t9xotlziMJUHX6GGLOUBBF7AU4jhY4U0kj0=;
 b=xZmeIZ/Z92skcIT7BOqW1dbP3u0C3ytcaUkF4eAxC8ufzhZepcj/ZPOPU6R3VgCwNkw5xb
 CcF/pXp2gHxrv3JXg+5z2D3KILQBACSwr69eyLlmTkL7opkXKb3rwreri9jJZPpxy5tY2x
 e46c5JFZ3tacQcSOtXdAPRlG9yjyl2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682597293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HucaRXV7t9xotlziMJUHX6GGLOUBBF7AU4jhY4U0kj0=;
 b=h6i/+opxB8YODMlOK88bBfxYtP+r7rX/XmY0rXX5RWfO/44ppcVJRJGax4FoHIiU5UQXad
 VUczMRIKJuChQ7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A76313910
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TZdoCK1lSmSXSwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:13 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Apr 2023 17:38:00 +0530
Message-Id: <20230427120800.27849-5-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427120800.27849-1-akumar@suse.de>
References: <20230427120800.27849-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] dup05.c: use TST_EXP_FD() macro and make check
 fixes
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

+ update copyright.
+ use SAFE_OPEN() and SAFE_CLOSE()

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/dup/dup05.c | 40 ++++++++++-----------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup05.c b/testcases/kernel/syscalls/dup/dup05.c
index 362f3e170..375fa36a7 100644
--- a/testcases/kernel/syscalls/dup/dup05.c
+++ b/testcases/kernel/syscalls/dup/dup05.c
@@ -1,55 +1,45 @@
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
  * Basic test for dup(2) of a named pipe descriptor
  */
-#include <stdio.h>
+
 #include "tst_test.h"
 
-char Fname[255];
-int fd;
+#define Fname "dupfile"
+
+static int fd;
 
 static void run(void)
 {
-	TEST(dup(fd));
-
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "dup failed");
-	} else {
-		tst_res(TPASS, "dup returned %ld",
-			 TST_RET);
-
-		SAFE_CLOSE(TST_RET);
-	}
+	TST_EXP_FD(dup(fd), "dup(%d)", fd);
+	SAFE_CLOSE(TST_RET);
 }
 
-void setup(void)
+static void setup(void)
 {
 	fd = -1;
 
-	sprintf(Fname, "dupfile");
 	SAFE_MKFIFO(Fname, 0777);
-	if ((fd = open(Fname, O_RDWR, 0700)) == -1)
-		tst_brk(TBROK, "open failed");
+	fd = SAFE_OPEN(Fname, O_RDWR, 0700);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (fd != -1)
-		if (close(fd) == -1)
-			tst_res(TWARN | TERRNO, "close failed");
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
-        .test_all = run,
-        .setup = setup,
-        .cleanup = cleanup,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 };
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

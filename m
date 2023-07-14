Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F1FC0015E
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 15:48:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B60153CDE9B
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 17:48:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 650463CB5A1
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 17:48:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89FAB60132F
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 17:48:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B8A522087
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689349685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Oq0kGCc4xK8AxBRzLluzn7x6Cg3SYU0lE0GK5QA04tU=;
 b=SHnyRGpzU7TFg2dmmUhFB67FJx4P9igJfS2TVcTmgwax8V0IuqBVlmTHL6uvEV5UE8oJR+
 et2LX/odpCgWQs+DcT1aEhcoX329yfIM2TEi2L+RMBtBMENiBbosZrGY5igd2W2fGn8Mg0
 f/jwTcWHNkzom3BJ+hnFFffHKdihQK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689349685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Oq0kGCc4xK8AxBRzLluzn7x6Cg3SYU0lE0GK5QA04tU=;
 b=am1oRg5WhJU67YTgO9P4a7fiPLWtx/3CJV3MmddWNwVJWGNhhDFKgpOzvFB9uikoDGfNxi
 t0DKE8bqD48tjoDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01343138F8
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 15:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dLstMzRusWTzQwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 15:48:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 14 Jul 2023 21:18:01 +0530
Message-ID: <20230714154802.27819-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pipe03: Simplify test using TST_ macros
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

+ docparse comment and reword
+ updated copyright

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/pipe/pipe03.c | 51 ++++++++++---------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe03.c b/testcases/kernel/syscalls/pipe/pipe03.c
index 89c0911c1..b786a618e 100644
--- a/testcases/kernel/syscalls/pipe/pipe03.c
+++ b/testcases/kernel/syscalls/pipe/pipe03.c
@@ -1,51 +1,42 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2002
+ * Copyright (c) 2023 Linux Test Project
  */
 
-/*
- * Make sure that writing to the read end of a pipe and reading from
- * the write end of a pipe both fail.
+/*\
+ * [Description]
+ *
+ * Verify that, an attempt to write to the read end of a pipe fails with EBADF
+ * and an attempt to read from the write end of a pipe also fails with EBADF.
  */
 
-#include <unistd.h>
-#include <errno.h>
 #include "tst_test.h"
 
 static int fd[2];
 
 static void verify_pipe(void)
 {
-	char buf[2];
-
-	TEST(pipe(fd));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "pipe() failed unexpectedly");
-		return;
-	}
-
-	TEST(write(fd[0], "A", 1));
-	if (TST_RET == -1 && errno == EBADF) {
-		tst_res(TPASS | TTERRNO, "expected failure writing "
-			"to read end of pipe");
-	} else {
-		tst_res(TFAIL | TTERRNO, "unexpected failure writing "
-			"to read end of pipe");
-	}
-
-	TEST(read(fd[1], buf, 1));
-	if (TST_RET == -1 && errno == EBADF) {
-		tst_res(TPASS | TTERRNO, "expected failure reading "
-			"from write end of pipe");
-	} else {
-		tst_res(TFAIL | TTERRNO, "unexpected failure reading "
-			"from write end of pipe");
-	}
+	char buf[] = "abcdef";
+
+	SAFE_PIPE(fd);
+
+	TST_EXP_FAIL2(write(fd[0], "A", 1), EBADF);
+	TST_EXP_FAIL2(read(fd[1], buf, 1), EBADF);
 
 	SAFE_CLOSE(fd[0]);
 	SAFE_CLOSE(fd[1]);
 }
 
+static void cleanup(void)
+{
+	if (fd[0] > 0)
+		SAFE_CLOSE(fd[0]);
+	if (fd[1] > 0)
+		SAFE_CLOSE(fd[1]);
+}
+
 static struct tst_test test = {
 	.test_all = verify_pipe,
+	.cleanup = cleanup
 };
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

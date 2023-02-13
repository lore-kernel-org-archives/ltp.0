Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D29C636D4
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 09:49:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C211B3CBF8B
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 10:49:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31B643C07B4
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 10:49:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A03110006AE
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 10:49:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E31371F892;
 Mon, 13 Feb 2023 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676281745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eZY3+uoGPxsO8tbtGb7NUjE3XO9qmnHAJRprXHiJdNs=;
 b=R4x+2Ub8cJefBXgzNwqQY5a6Sbn/W7maECy7ryFPJIIKyETVmJWKm19XIJdheEwLXncaXU
 eHsOkDY1UimoJ+d04W+E4OHpt2mrs2iNSX+hA/E/Ng2BCMk8jNZ4dwKSqUWoq8sz0+l5xs
 IlYbpsubslc+jZVdZhfQ8x/rJbezemA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78506138E6;
 Mon, 13 Feb 2023 09:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +0i6F5EH6mPIZQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 13 Feb 2023 09:49:05 +0000
To: ltp@lists.linux.it
Date: Mon, 13 Feb 2023 10:47:03 +0100
Message-Id: <20230213094703.28746-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactor pidns32 test using new LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Using SAFE_CLONE
Using TST_EXP_* macros

 testcases/kernel/containers/pidns/pidns32.c | 41 +++++++++++----------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index 3f7df788e..c9f8db3e5 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*\
@@ -12,32 +12,32 @@
  */
 
 #define _GNU_SOURCE
-
 #include <sys/mman.h>
 #include "tst_test.h"
 #include "lapi/sched.h"
 
 #define MAXNEST 32
 
+static const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 static int *level;
 
-static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
+static void child_func(void)
 {
 	pid_t cpid;
 	int status;
 
 	if (*level == MAXNEST)
-		return 0;
+		return;
 
 	(*level)++;
 
-	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
-	if (cpid < 0)
-		tst_brk(TBROK | TERRNO, "clone failed");
+	cpid = SAFE_CLONE(&args);
+	if (!cpid) {
+		child_func();
+		return;
+	}
 
 	SAFE_WAITPID(cpid, &status, 0);
-
-	return 0;
 }
 
 static void setup(void)
@@ -45,28 +45,29 @@ static void setup(void)
 	level = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
 
-static void run(void)
+static void cleanup(void)
 {
-	int ret, status;
+	SAFE_MUNMAP(level, sizeof(int));
+}
 
+static void run(void)
+{
 	*level = 1;
 
-	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "clone failed");
-
-	SAFE_WAITPID(ret, &status, 0);
-
-	if (*level < MAXNEST) {
-		tst_res(TFAIL, "Nested containers should be %d, but they are %d", MAXNEST, *level);
+	if (!SAFE_CLONE(&args)) {
+		child_func();
 		return;
 	}
 
-	tst_res(TPASS, "All %d containers have been nested", MAXNEST);
+	tst_reap_children();
+
+	TST_EXP_EQ_LI(*level, MAXNEST);
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

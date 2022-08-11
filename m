Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9939BC19F2D
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 11:37:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB4233C95CF
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:37:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263233C954A
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:37:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 17A8A1000A41
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:37:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68F3E5CA62;
 Thu, 11 Aug 2022 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1660217838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HHdLCfNLftFyKZnrlFP3q7ddVo28mQkdU2a2COXezgA=;
 b=SQ1OiCXk/sX3cT3wvqaDkIT//exyZRZWLQ3zzBgQI9vvhDBa14mtdW7kkSalzwi4V6aJRg
 1iOVmn7sJKhX++JnyKiAsIhmYSAjpWkdFLmMCU28UHgE85vSGFMiu1rnYr/h0DHmdFttHa
 X26ILlB5Fpkj3rY+c/Jtl9WFriNRfxk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 414E01342A;
 Thu, 11 Aug 2022 11:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vSXWDe7p9GKzLgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 11 Aug 2022 11:37:18 +0000
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 13:36:40 +0200
Message-Id: <20220811113640.8499-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor pidns32 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns32.c | 118 ++++++++------------
 1 file changed, 44 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index 316c5d195..cbc91df68 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -1,101 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Huawei Technologies Co., Ltd., 2015
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Verify that:
- * The kernel imposes a limit of 32 nested levels of pid namespaces.
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and check for the maxium amount of
+ * nested containers.
  */
 
 #define _GNU_SOURCE
-#include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "pidns_helper.h"
-#include "test.h"
 
-#define MAXNEST 32
-
-char *TCID = "pidns32";
-int TST_TOTAL = 1;
+#include <sys/mman.h>
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
-	tst_tmpdir();
-}
+#define MAXNEST 32
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static int *level;
 
-static int child_fn1(void *arg)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	pid_t cpid1;
-	long level = (long)arg;
+	pid_t cpid;
 	int status;
 
-	if (level == MAXNEST)
+	if (*level == MAXNEST)
 		return 0;
-	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD,
-		(void *)child_fn1, (void *)(level + 1));
-	if (cpid1 < 0) {
-		printf("level %ld:unexpected error: (%d) %s\n",
-			level, errno, strerror(errno));
-		return 1;
-	}
-	if (waitpid(cpid1, &status, 0) == -1)
-		return 1;
-
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
-		printf("child exited abnormally\n");
-		return 1;
-	} else if (WIFSIGNALED(status)) {
-		printf("child was killed with signal = %d", WTERMSIG(status));
-		return 1;
-	}
+
+	(*level)++;
+
+	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
+	if (cpid < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
+
+	SAFE_WAITPID(cpid, &status, 0);
+
 	return 0;
 }
 
-static void test_max_nest(void)
+static void setup(void)
 {
-	pid_t cpid1;
-
-	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD,
-		(void *)child_fn1, (void *)1);
-	if (cpid1 < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
-
-	tst_record_childstatus(cleanup, cpid1);
+	level = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	*level = 1;
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
+	int ret, status;
 
-	setup();
-	tst_parse_opts(argc, argv, NULL, NULL);
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		test_max_nest();
+	SAFE_WAITPID(ret, &status, 0);
+
+	if (*level < MAXNEST) {
+		tst_res(TFAIL, "Nested containers should be %d, but they are %d", MAXNEST, *level);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "All %d containers have been nested", MAXNEST);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.setup = setup,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FA8C433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 143363C9354
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:25:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36CE43C91EA
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9E0D600915
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A3F721902;
 Tue, 15 Mar 2022 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647347035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkuhPEt3LgiG6YxS/ezLRdu3mc0DCRVkdK6Ri62Tx0Y=;
 b=keHe0+GxMr5Q2sFsn4S25SaL/akMUZcDBYF81M9Tr///Q1cgXjq2wI3705MwzcAjQvBfUP
 2CapLhVD3x4PkxoZ4GTSv3XAp7UycP6GuQapS9v8jlkAeZ8o31738ubpsu4H+VvjyGp+O0
 Dd+d2yL5/XZQqVi6K6RDt+7YL3tq++0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647347035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkuhPEt3LgiG6YxS/ezLRdu3mc0DCRVkdK6Ri62Tx0Y=;
 b=ZeB42zNCl79L3cbZ3E9siilyZT67xRW1BFoNO8MFDvDh6DdzL4S7y952A/5lDSRJy7YzRn
 vwSCLmC8U4YWVDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DBBE13B59;
 Tue, 15 Mar 2022 12:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GE9mBVuFMGJ3UAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Mar 2022 12:23:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 13:23:50 +0100
Message-Id: <20220315122351.8556-8-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315122351.8556-1-andrea.cervesato@suse.de>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/8] Rewrite userns07.c using new LTP API
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
 testcases/kernel/containers/userns/userns07.c | 127 +++++++-----------
 1 file changed, 51 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 49915969e..806d103eb 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -1,47 +1,29 @@
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
- * The kernel imposes a limit of at least 32 nested levels on user namespaces.
+/*\
+ * [Description]
+ *
+ * Verify that the kernel imposes a limit of at least 32 nested levels on
+ * user namespaces.
  */
 
 #define _GNU_SOURCE
-#include <sys/wait.h>
-#include <assert.h>
+
 #include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "userns_helper.h"
-#include "test.h"
+#include <stdbool.h>
+#include <sys/wait.h>
+#include "common.h"
+#include "tst_test.h"
 
 #define MAXNEST 32
 
-char *TCID = "userns07";
-int TST_TOTAL = 1;
-
 static void setup(void)
 {
 	check_newuser();
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(NULL);
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
 }
 
 static int child_fn1(void *arg)
@@ -52,40 +34,40 @@ static int child_fn1(void *arg)
 	int parentuid;
 	int parentgid;
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 
-	if (level == MAXNEST)
+	if (level == MAXNEST) {
+		tst_res(TPASS, "nested all children");
 		return 0;
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-		(void *)child_fn1, (void *)(level + 1));
-	if (cpid1 < 0) {
-		printf("level %ld:unexpected error: (%d) %s\n",
-			level, errno, strerror(errno));
+	}
+
+	TEST(ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)(level + 1)));
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TERRNO, "level %ld, unexpected error", level);
 		return 1;
 	}
 
+	cpid1 = (int)TST_RET;
+
 	parentuid = geteuid();
 	parentgid = getegid();
 
-	updatemap(cpid1, UID_MAP, 0, parentuid, NULL);
-	updatemap(cpid1, GID_MAP, 0, parentgid, NULL);
+	updatemap(cpid1, UID_MAP, 0, parentuid);
+	updatemap(cpid1, GID_MAP, 0, parentgid);
 
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+	TST_CHECKPOINT_WAKE(0);
 
-	if (waitpid(cpid1, &status, 0) == -1)
-		return 1;
+	SAFE_WAITPID(cpid1, &status, 0);
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_brk(TBROK | TERRNO, "child exited abnormally %s", tst_strstatus(status));
+	else if (WIFSIGNALED(status))
+		tst_brk(TBROK | TERRNO, "child was killed with signal = %d", WTERMSIG(status));
 
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
-		printf("child exited abnormally\n");
-		return 1;
-	} else if (WIFSIGNALED(status)) {
-		printf("child was killed with signal = %d", WTERMSIG(status));
-		return 1;
-	}
 	return 0;
 }
 
-static void test_max_nest(void)
+static void run(void)
 {
 	pid_t cpid1;
 	int parentuid;
@@ -93,41 +75,34 @@ static void test_max_nest(void)
 	int fd;
 	char path[BUFSIZ];
 
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-		(void *)child_fn1, (void *)0);
+	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)0);
 	if (cpid1 < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+		tst_brk(TBROK | TTERRNO, "clone failed");
 
 	parentuid = geteuid();
 	parentgid = getegid();
 
 	if (access("/proc/self/setgroups", F_OK) == 0) {
 		sprintf(path, "/proc/%d/setgroups", cpid1);
-		fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-		SAFE_WRITE(cleanup, 1, fd, "deny", 4);
-		SAFE_CLOSE(cleanup, fd);
-	}
-
-	updatemap(cpid1, UID_MAP, 0, parentuid, cleanup);
-	updatemap(cpid1, GID_MAP, 0, parentgid, cleanup);
 
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-	tst_record_childstatus(cleanup, cpid1);
-}
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	setup();
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		test_max_nest();
+		fd = SAFE_OPEN(path, O_WRONLY, 0644);
+		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_CLOSE(fd);
 	}
 
-	cleanup();
-	tst_exit();
+	updatemap(cpid1, UID_MAP, 0, parentuid);
+	updatemap(cpid1, GID_MAP, 0, parentgid);
+
+	TST_CHECKPOINT_WAKE(0);
 }
 
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		NULL,
+	},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

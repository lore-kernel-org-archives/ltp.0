Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76F1C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 09:27:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C7473C9F14
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 10:27:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF8CB3C9E46
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA2C91A01523
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CDCC1F385;
 Fri, 11 Feb 2022 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644571612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9plBEJjoueP6/NnSXRf243lAlfuIkEDHiCvxspBaWhE=;
 b=Q/ylx7wdWBdrYbOLLNmOjJUI+8Wkt843N7Eu41/mgLJDHrghyNdnfViRYuNtQY9N/jOY7B
 ueLW8m+fFgjIPT8wrEm+SmbRNcGLGGCH2E0hEGy2N8LmSXd02ScqLozx32DD4QZFqTiYmE
 7XwXc07ZIR56hxSq2VaCnMFG+ZT3azM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644571612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9plBEJjoueP6/NnSXRf243lAlfuIkEDHiCvxspBaWhE=;
 b=SmNbodbP740vsCAjijbvnF83/aTlyTYiz+3JXLBvavhsoVrqtD7lvtaZyb7Rya6EaUo/mP
 2EU01JqY87wnWWDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F81313BCF;
 Fri, 11 Feb 2022 09:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eBZYBdwrBmJ7EwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Feb 2022 09:26:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 10:26:40 +0100
Message-Id: <20220211092646.23748-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211092646.23748-1-andrea.cervesato@suse.de>
References: <20220211092646.23748-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/8] Rewrite userns02.c test using new LTP API
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
 testcases/kernel/containers/userns/userns02.c | 132 ++++++++----------
 1 file changed, 58 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns02.c b/testcases/kernel/containers/userns/userns02.c
index ae49a1599..e3b2d34eb 100644
--- a/testcases/kernel/containers/userns/userns02.c
+++ b/testcases/kernel/containers/userns/userns02.c
@@ -1,58 +1,41 @@
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
+/*\
+ * [Description]
+ *
  * Verify that:
- *  The user ID and group ID, which are inside a container, can be modified
- * by its parent process.
+ * The user ID and group ID, which are inside a container, can be modified by
+ * its parent process.
  */
 
 #define _GNU_SOURCE
-#include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "userns_helper.h"
-#include "test.h"
-
-char *TCID = "user_namespace2";
-int TST_TOTAL = 1;
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+#include <stdio.h>
+#include <stdbool.h>
+#include "common.h"
+#include "tst_test.h"
 
 /*
  * child_fn1() - Inside a new user namespace
  */
 static int child_fn1(void)
 {
-	int exit_val;
+	int exit_val = 0;
 	int uid, gid;
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
+
 	uid = geteuid();
 	gid = getegid();
 
 	if (uid == 100 && gid == 100) {
-		printf("Got expected uid and gid.\n");
-		exit_val = 0;
+		tst_res(TPASS, "got expected uid and gid");
 	} else {
-		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
+		tst_res(TFAIL, "got unexpected uid=%d gid=%d", uid, gid);
 		exit_val = 1;
 	}
 
@@ -62,13 +45,10 @@ static int child_fn1(void)
 static void setup(void)
 {
 	check_newuser();
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(NULL);
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
 	int childpid;
 	int parentuid;
 	int parentgid;
@@ -76,42 +56,46 @@ int main(int argc, char *argv[])
 	char content[BUFSIZ];
 	int fd;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		childpid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-			(void *)child_fn1, NULL);
-
-		if (childpid < 0)
-			tst_brkm(TFAIL | TERRNO, cleanup, "clone failed");
-
-		parentuid = geteuid();
-		parentgid = getegid();
-		sprintf(path, "/proc/%d/uid_map", childpid);
-		sprintf(content, "100 %d 1", parentuid);
-		fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-		SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
-		SAFE_CLOSE(cleanup, fd);
-
-		if (access("/proc/self/setgroups", F_OK) == 0) {
-			sprintf(path, "/proc/%d/setgroups", childpid);
-			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
-			SAFE_CLOSE(cleanup, fd);
-		}
-
-		sprintf(path, "/proc/%d/gid_map", childpid);
-		sprintf(content, "100 %d 1", parentgid);
-		fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-		SAFE_WRITE(cleanup, 1, fd, content, strlen(content));
-		SAFE_CLOSE(cleanup, fd);
-
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-
-		tst_record_childstatus(cleanup, childpid);
+	childpid = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
+	if (childpid < 0)
+		tst_brk(TBROK | TTERRNO, "clone failed");
+
+	parentuid = geteuid();
+	parentgid = getegid();
+
+	sprintf(path, "/proc/%d/uid_map", childpid);
+	sprintf(content, "100 %d 1", parentuid);
+
+	fd = SAFE_OPEN(path, O_WRONLY, 0644);
+	SAFE_WRITE(1, fd, content, strlen(content));
+	SAFE_CLOSE(fd);
+
+	if (access("/proc/self/setgroups", F_OK) == 0) {
+		sprintf(path, "/proc/%d/setgroups", childpid);
+
+		fd = SAFE_OPEN(path, O_WRONLY, 0644);
+		SAFE_WRITE(1, fd, "deny", 4);
+		SAFE_CLOSE(fd);
 	}
-	cleanup();
-	tst_exit();
+
+	sprintf(path, "/proc/%d/gid_map", childpid);
+	sprintf(content, "100 %d 1", parentgid);
+
+	fd = SAFE_OPEN(path, O_WRONLY, 0644);
+	SAFE_WRITE(1, fd, content, strlen(content));
+	SAFE_CLOSE(fd);
+
+	TST_CHECKPOINT_WAKE(0);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.needs_kconfigs =
+		(const char *[]){
+			"CONFIG_USER_NS",
+			NULL,
+		},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

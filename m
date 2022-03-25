Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2DBC433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:36:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9B93C8F91
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:36:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5C13C0595
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8BA11001270
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C32D3210F1;
 Fri, 25 Mar 2022 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648200988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBs3zWEqCmWmn7yahXWBn5UcvKfJlTi1hpwaekk0l60=;
 b=0M9cpBHc78TWUCLw316lUIDghi+cMyrZoEBy8OKw0n0tV6fBOs9wistWyL5uQqhAqniKOE
 D0FufvdJmhLxY1Kc4WGdIsITW+uczycNT7VFAzsBWI4tyXO32h4ThUkdOLtCkOJgI2b2Tf
 7smMkmUby8dccKRm6aCA0mhT8MV09p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648200988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBs3zWEqCmWmn7yahXWBn5UcvKfJlTi1hpwaekk0l60=;
 b=YTZztV+3vh3P2e1r4pTJPFm+vfQ60fux63gdvoPfolLPdugtHFMSV3LFP3FVmmvSua4f3b
 TIoHZBLzYfzplJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99C79132E9;
 Fri, 25 Mar 2022 09:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SLMdIxyNPWI1BQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 09:36:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 10:36:19 +0100
Message-Id: <20220325093626.11114-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325093626.11114-1-andrea.cervesato@suse.de>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/9] Rewrite userns02.c using new LTP API
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
 testcases/kernel/containers/userns/userns02.c | 138 ++++++++----------
 1 file changed, 58 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns02.c b/testcases/kernel/containers/userns/userns02.c
index ae49a1599..1f7cba573 100644
--- a/testcases/kernel/containers/userns/userns02.c
+++ b/testcases/kernel/containers/userns/userns02.c
@@ -1,74 +1,49 @@
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
- *  The user ID and group ID, which are inside a container, can be modified
- * by its parent process.
+/*\
+ * [Description]
+ *
+ * Verify that the user ID and group ID, which are inside a container,
+ * can be modified by its parent process.
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
+#include "common.h"
+#include "tst_test.h"
 
 /*
  * child_fn1() - Inside a new user namespace
  */
 static int child_fn1(void)
 {
-	int exit_val;
 	int uid, gid;
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
+
 	uid = geteuid();
 	gid = getegid();
 
-	if (uid == 100 && gid == 100) {
-		printf("Got expected uid and gid.\n");
-		exit_val = 0;
-	} else {
-		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
-		exit_val = 1;
-	}
+	if (uid == 100 && gid == 100)
+		tst_res(TPASS, "got expected uid and gid");
+	else
+		tst_res(TFAIL, "got unexpected uid=%d gid=%d", uid, gid);
 
-	return exit_val;
+	return 0;
 }
 
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
@@ -76,42 +51,45 @@ int main(int argc, char *argv[])
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
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		NULL,
+	},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

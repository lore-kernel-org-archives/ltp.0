Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FEFC433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:24:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35C783C9357
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:24:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C98443C91EA
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3A63F600788
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFF051F454;
 Tue, 15 Mar 2022 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647347034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbT9oM4hSeJH//9meUWCvQ4KgH4ntQe/KW/W6I3XMB8=;
 b=djoWxXF9WTJeH9ygkT9DQNo+Zbk3Ml3WiLQOwHpi4R9ahPFRDOaHFP1qX8iqsZfBdjrXAK
 yB1eWIWeg/DSap/tMIPoiPRMqd1pQY0GuAhFHbOOL1CtUvxBWgZzdsGjQITkoOF9GIPt2u
 sk9uI+1b0n5BVz3GM/6PnRq2MZYgJR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647347034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbT9oM4hSeJH//9meUWCvQ4KgH4ntQe/KW/W6I3XMB8=;
 b=dR3g0TgSnfv8pfbLZV5GlfrbnYg77kI9kbBSQ8fvPSlNKXK+2b8V1W/Yycs2mgs3qhfwhZ
 892V595KO4HxyiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5DFC13B59;
 Tue, 15 Mar 2022 12:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qHOQJlqFMGJ3UAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Mar 2022 12:23:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 13:23:48 +0100
Message-Id: <20220315122351.8556-6-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315122351.8556-1-andrea.cervesato@suse.de>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/8] Rewrite userns05.c using new LTP API
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
 testcases/kernel/containers/userns/userns05.c | 148 ++++++++----------
 1 file changed, 62 insertions(+), 86 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns05.c b/testcases/kernel/containers/userns/userns05.c
index be77cb7e9..94434043b 100644
--- a/testcases/kernel/containers/userns/userns05.c
+++ b/testcases/kernel/containers/userns/userns05.c
@@ -1,51 +1,31 @@
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
- * A process created via fork(2) or clone(2) without the
- * CLONE_NEWUSER flag is a member of the same user namespace as its
- * parent.
- * When unshare an user namespace, the calling process is moved into
- * a new user namespace which is not shared with any previously
- * existing process.
+/*\
+ * [Description]
+ *
+ * Verify that if a process created via fork(2) or clone(2) without the
+ * CLONE_NEWUSER flag is a member of the same user namespace as its parent.
+ * When unshare an user namespace, the calling process is moved into a new user
+ * namespace which is not shared with any previously existing process.
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
-char *TCID = "user_namespace5";
-int TST_TOTAL = 1;
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+#include <stdio.h>
+#include <stdbool.h>
+#include "tst_test.h"
+#include "common.h"
 
 /*
  * child_fn1() - Inside a new user namespace
  */
 static int child_fn1(void)
 {
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 	return 0;
 }
 
@@ -57,86 +37,82 @@ static unsigned int getusernsidbypid(int pid)
 
 	sprintf(path, "/proc/%d/ns/user", pid);
 
-	if (readlink(path, userid, BUFSIZ) == -1)
-		tst_resm(TFAIL | TERRNO, "readlink failure.");
+	SAFE_READLINK(path, userid, BUFSIZ);
+
+	if (sscanf(userid, "user:[%u]", &id) < 0)
+		tst_brk(TBROK | TERRNO, "sscanf failure");
 
-	if (sscanf(userid, "user:[%u]", &id) != 1)
-		tst_resm(TFAIL, "sscanf failure.");
 	return id;
 }
 
-static void test_userns_id(void)
+static void run(void)
 {
 	int cpid1, cpid2, cpid3;
 	unsigned int parentuserns, cpid1userns, cpid2userns, newparentuserns;
 
 	parentuserns = getusernsidbypid(getpid());
-	cpid1 = ltp_clone_quick(SIGCHLD, (void *)child_fn1,
-		NULL);
+
+	cpid1 = ltp_clone_quick(SIGCHLD, (void *)child_fn1, NULL);
 	if (cpid1 < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+		tst_brk(TBROK | TTERRNO, "clone failed");
+
 	cpid1userns = getusernsidbypid(cpid1);
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+
+	TST_CHECKPOINT_WAKE(0);
 
 	/* A process created via fork(2) or clone(2) without the
-	CLONE_NEWUSER flag is a member of the same user namespace as its
-	parent.*/
+	 * CLONE_NEWUSER flag is a member of the same user namespace as its
+	 * parent
+	 */
 	if (parentuserns != cpid1userns)
-		tst_resm(TFAIL, "userns:parent should be equal to cpid1");
+		tst_res(TFAIL, "userns:parent should be equal to cpid1");
+	else
+		tst_res(TPASS, "userns:parent is equal to cpid1");
 
-	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-		(void *)child_fn1, NULL);
+	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
 	if (cpid2 < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+		tst_brk(TBROK | TTERRNO, "clone failed");
+
 	cpid2userns = getusernsidbypid(cpid2);
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+
+	TST_CHECKPOINT_WAKE(0);
 
 	if (parentuserns == cpid2userns)
-		tst_resm(TFAIL, "userns:parent should be not equal to cpid2");
-
-	switch (cpid3 = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		if (unshare(CLONE_NEWUSER) == -1) {
-			printf("parent pid unshare failure: (%d) %s",
-				errno, strerror(errno));
-			exit(1);
-		}
+		tst_res(TFAIL, "userns:parent should be not equal to cpid2");
+	else
+		tst_res(TPASS, "userns:parent is not equal to cpid2");
+
+	cpid3 = SAFE_FORK();
+	if (!cpid3) {
+		SAFE_UNSHARE(CLONE_NEWUSER);
 		newparentuserns = getusernsidbypid(getpid());
 
 		/* When unshare an user namespace, the calling process
-		is moved into a new user namespace which is not shared
-		with any previously existing process.*/
+		 * is moved into a new user namespace which is not shared
+		 * with any previously existing process
+		 */
 		if (parentuserns == newparentuserns)
-			exit(1);
-		exit(0);
-	}
+			tst_res(TFAIL, "unshared namespaces with same id");
+		else
+			tst_res(TPASS, "unshared namespaces with different id");
 
-	tst_record_childstatus(cleanup, cpid1);
-	tst_record_childstatus(cleanup, cpid2);
-	tst_record_childstatus(cleanup, cpid3);
+		return;
+	}
 }
 
 static void setup(void)
 {
 	check_newuser();
-
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(NULL);
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		test_userns_id();
-	}
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
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

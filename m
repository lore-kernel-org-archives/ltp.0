Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C809C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 09:27:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A587F3C9F07
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 10:27:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 194153C9888
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44AD160043D
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E87691F3A8;
 Fri, 11 Feb 2022 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644571612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ehqqff4d8Y1f+NT9PH/KWA15/QfHzxxyVs/DsNzSds=;
 b=Yd67cSo6ajAh/f11iL2qYvKzeHDXBYsk97WKLTE6uc2Hc22BfNwf6XSYUVNZ06r6b7E8Cs
 G0MiK7ZbyYM43yCHwZ6c8UQzDh2OyIJRdFaD4kto77Ul3kQ+n+5n+LbRvbX/dm9x8Ud8yt
 gp3VQMkj35l4qOPd2rgverDWjZ9W7MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644571612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ehqqff4d8Y1f+NT9PH/KWA15/QfHzxxyVs/DsNzSds=;
 b=ATwPoZ07XHxAiFSUd3bRWPSewiOBfnGEvIyPI9tyc7G92ODS8DZ4sUx4RdGB9DXeOmbO59
 SFdkINN9P9Zau1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1DE113BC3;
 Fri, 11 Feb 2022 09:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qJB2LdwrBmJ7EwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Feb 2022 09:26:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 10:26:43 +0100
Message-Id: <20220211092646.23748-6-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211092646.23748-1-andrea.cervesato@suse.de>
References: <20220211092646.23748-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 5/8] Rewrite userns05.c test using new LTP API
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
 1 file changed, 63 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns05.c b/testcases/kernel/containers/userns/userns05.c
index be77cb7e9..ae5e00240 100644
--- a/testcases/kernel/containers/userns/userns05.c
+++ b/testcases/kernel/containers/userns/userns05.c
@@ -1,51 +1,32 @@
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
- * A process created via fork(2) or clone(2) without the
- * CLONE_NEWUSER flag is a member of the same user namespace as its
- * parent.
- * When unshare an user namespace, the calling process is moved into
- * a new user namespace which is not shared with any previously
- * existing process.
+ * A process created via fork(2) or clone(2) without the CLONE_NEWUSER flag is
+ * a member of the same user namespace as its parent.
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
 
@@ -57,86 +38,83 @@ static unsigned int getusernsidbypid(int pid)
 
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

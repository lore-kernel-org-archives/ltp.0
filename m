Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFACC433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:38:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A113C8C8E
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:38:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE6F3C5A8A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A57BC200D5E
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3972C210FD;
 Fri, 25 Mar 2022 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648200989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrCim5Q3VhoFP5E0+SCJVveQjFcOg3YOjMc/48olrkc=;
 b=ZP6RRvlz4Ytl0p/+YiibA1sSm/iT6RSxb8EkZafCJZUJcO/73ukSm2PWUhODZkBCOCJVRf
 e+YtbQNh23IHftWcwn6fQRjxLQyeqgPrW3cV2roC0o8RNbAO2t3tKGTIFY5+gej6zhFKdE
 gux03EYbqSme6CnegMWkpVTj+nK9V64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648200989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrCim5Q3VhoFP5E0+SCJVveQjFcOg3YOjMc/48olrkc=;
 b=cGXSUh+ZlPWCAjH96o774AQv0iN+KCpf3M6ZfRh3OWMIJXI3hrtA4ivZbzGgejcP9ZFpq1
 OutMH7F6jhgF3CCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FFE6132E9;
 Fri, 25 Mar 2022 09:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gNIFAh2NPWI1BQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 09:36:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 10:36:21 +0100
Message-Id: <20220325093626.11114-5-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325093626.11114-1-andrea.cervesato@suse.de>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/9] Rewrite userns03.c using new LTP API
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
 testcases/kernel/containers/userns/userns04.c | 138 ++++++------------
 1 file changed, 47 insertions(+), 91 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
index 66d3388a9..d8639502e 100644
--- a/testcases/kernel/containers/userns/userns04.c
+++ b/testcases/kernel/containers/userns/userns04.c
@@ -1,131 +1,87 @@
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
- *  If a namespace isn't another namespace's ancestor, the process in
- *  first namespace does not have the CAP_SYS_ADMIN capability in the
- *  second namespace and the setns() call fails.
+/*\
+ * [Description]
+ *
+ * Verify that if a namespace isn't another namespace's ancestor, the process in
+ * first namespace does not have the CAP_SYS_ADMIN capability in the second
+ * namespace and the setns() call fails.
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
 
-char *TCID = "user_namespace4";
-int TST_TOTAL = 1;
+#include <stdio.h>
+#include "common.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
 static void setup(void)
 {
 	check_newuser();
 	tst_syscall(__NR_setns, -1, 0);
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(NULL);
 }
 
-static void cleanup(void)
+static int child_fn1(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	tst_rmdir();
-}
-
-static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
-{
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 	return 0;
 }
 
 static int child_fn2(void *arg)
 {
-	int exit_val = 0;
-	int ret;
-
-	ret = tst_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER);
-	if (ret != -1) {
-		printf("child2 setns() unexpected success\n");
-		exit_val = 1;
-	} else if (errno != EPERM) {
-		printf("child2 setns() unexpected error: (%d) %s\n",
-			errno, strerror(errno));
-		exit_val = 1;
-	}
+	TEST(tst_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER));
+	if (TST_RET != -1 || TST_ERR != EPERM)
+		tst_res(TFAIL | TERRNO, "child2 setns() error");
+	else
+		tst_res(TPASS, "child2 setns() failed as expected");
+
+	TST_CHECKPOINT_WAIT(1);
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 1);
-	return exit_val;
+	return 0;
 }
 
-static void test_cap_sys_admin(void)
+static void run(void)
 {
 	pid_t cpid1, cpid2, cpid3;
 	char path[BUFSIZ];
 	int fd;
 
-	/* child 1 */
-	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-		(void *)child_fn1, NULL);
+	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, NULL);
 	if (cpid1 < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+		tst_brk(TBROK | TTERRNO, "clone failed");
 
-	/* child 2 */
 	sprintf(path, "/proc/%d/ns/user", cpid1);
-	fd = SAFE_OPEN(cleanup, path, O_RDONLY, 0644);
-	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD,
-		(void *)child_fn2, (void *)((long)fd));
+
+	fd = SAFE_OPEN(path, O_RDONLY, 0644);
+	cpid2 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn2, (void *)((long)fd));
 	if (cpid2 < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+		tst_brk(TBROK | TTERRNO, "clone failed");
 
 	/* child 3 - throw-away process changing ns to child1 */
-	switch (cpid3 = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		if (tst_syscall(__NR_setns, fd, CLONE_NEWUSER) == -1) {
-			printf("parent pid setns failure: (%d) %s",
-				errno, strerror(errno));
-			exit(1);
-		}
-		exit(0);
+	cpid3 = SAFE_FORK();
+	if (!cpid3) {
+		TST_EXP_PASS(tst_syscall(__NR_setns, fd, CLONE_NEWUSER));
+		return;
 	}
 
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 1);
-
-	tst_record_childstatus(cleanup, cpid1);
-	tst_record_childstatus(cleanup, cpid2);
-	tst_record_childstatus(cleanup, cpid3);
-
-	SAFE_CLOSE(cleanup, fd);
+	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAKE(1);
 
+	SAFE_CLOSE(fd);
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	setup();
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		test_cap_sys_admin();
-	}
-
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

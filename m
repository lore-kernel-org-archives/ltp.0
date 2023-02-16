Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB8FC636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 08:53:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 555EB3CBEE9
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 09:53:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27ACB3CB1CD
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 09:53:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9B711600054
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 09:53:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC55C208E9;
 Thu, 16 Feb 2023 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676537590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYB3qprJlsSUiRva/7Dl0m2oLr1p9WkSmd1q3p3NZGs=;
 b=HOe06RjnTdTQa794sf5ihu6ISTNCqSRH9AvY0WeEwrQmkeOk769ClDKnhhiEqqSvZG933G
 4L+9U09+wHivGXgAMFjQ2Ao/G02/BwPP5YcYxErpjEmguBfodzRULSqEg+GU1WvQeWj4Xz
 LGxVTHIkrZ/xX86IRZbtkGnxQv5bcXQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AE8F13484;
 Thu, 16 Feb 2023 08:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SLCMG/bu7WNJGAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Feb 2023 08:53:10 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Feb 2023 09:51:02 +0100
Message-Id: <20230216085107.7068-2-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230216085107.7068-1-andrea.cervesato@suse.com>
References: <20230216085107.7068-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/6] Refactor mqns_01 using new LTP API
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
 runtest/containers                         |   3 +-
 testcases/kernel/containers/mqns/mqns_01.c | 180 +++++++--------------
 2 files changed, 57 insertions(+), 126 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 23f394579..5e1b53bfa 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -16,7 +16,8 @@ pidns31 pidns31
 pidns32 pidns32
 
 mqns_01 mqns_01
-mqns_01_clone mqns_01 -clone
+mqns_01_clone mqns_01 -m clone
+mqns_01_unshare mqns_01 -m unshare
 mqns_02 mqns_02
 mqns_02_clone mqns_02 -clone
 mqns_03 mqns_03
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index 1d109e020..27d134cbe 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -1,148 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
-* Copyright (c) International Business Machines Corp., 2009
-* Copyright (c) Nadia Derbey, 2009
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-* Author: Nadia Derbey <Nadia.Derbey@bull.net>
-*
-* Check mqns isolation: father mqns cannot be accessed from newinstance
-*
-* Mount mqueue fs
-* Create a posix mq -->mq1
-* unshare
-* In unshared process:
-*    Mount newinstance mqueuefs
-*    Check that mq1 is not readable from new ns
+ * Copyright (c) International Business Machines Corp., 2009
+ * Copyright (c) Nadia Derbey, 2009 <Nadia.Derbey@bull.net>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-***************************************************************************/
+/*\
+ * [Description]
+ *
+ * Create a mqueue inside the parent and check if it can be accessed from
+ * the isolated/forked child namespace.
+ */
 
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <sys/wait.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include "mqns.h"
-#include "mqns_helper.h"
+#include "tst_test.h"
+#include "lapi/sched.h"
+#include "tst_safe_posix_ipc.h"
 
-char *TCID = "posixmq_namespace_01";
-int TST_TOTAL = 1;
+#define MQNAME "/MQ1"
 
-int p1[2];
-int p2[2];
+static mqd_t mqd;
+static char *str_op;
 
-int check_mqueue(void *vtest)
+static void run(void)
 {
-	char buf[30];
-	mqd_t mqd;
+	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
 
-	(void) vtest;
+	tst_res(TINFO, "Checking namespaces isolation from parent to child");
 
-	close(p1[1]);
-	close(p2[0]);
+	if (str_op && !strcmp(str_op, "clone")) {
+		tst_res(TINFO, "Spawning isolated process");
 
-	if (read(p1[0], buf, strlen("go") + 1) < 0) {
-		printf("read(p1[0], ...) failed: %s\n", strerror(errno));
-		exit(1);
-	}
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
-	if (mqd == -1) {
-		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0) {
-			perror("write(p2[1], ...) failed");
-			exit(1);
+		if (!SAFE_CLONE(&clone_args)) {
+			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
+			return;
+		}
+	} else if (str_op && !strcmp(str_op, "unshare")) {
+		tst_res(TINFO, "Spawning unshared process");
+
+		if (!SAFE_FORK()) {
+			SAFE_UNSHARE(CLONE_NEWIPC);
+			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
+			return;
 		}
 	} else {
-		if (write(p2[1], "exists", strlen("exists") + 1) < 0) {
-			perror("write(p2[1], \"exists\", 7) failed");
-			exit(1);
-		} else if (mq_close(mqd) < 0) {
-			perror("mq_close(mqd) failed");
-			exit(1);
+		tst_res(TINFO, "Spawning plain process");
+
+		if (!SAFE_FORK()) {
+			TST_EXP_POSITIVE(mq_open(MQNAME, O_RDONLY));
+			return;
 		}
 	}
-
-	exit(0);
 }
 
 static void setup(void)
 {
-	tst_require_root();
-	check_mqns();
+	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
 }
 
-int main(int argc, char *argv[])
+static void cleanup(void)
 {
-	int r;
-	mqd_t mqd;
-	char buf[30];
-	int use_clone = T_UNSHARE;
-
-	setup();
-
-	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through clone(2).");
-		use_clone = T_CLONE;
-	} else
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2).");
-
-	if (pipe(p1) == -1 || pipe(p2) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
-	}
-
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
-		0777, NULL);
-	if (mqd == -1) {
-		perror("mq_open");
-		tst_brkm(TFAIL, NULL, "mq_open failed");
+	if (mqd != -1) {
+		SAFE_MQ_CLOSE(mqd);
+		SAFE_MQ_UNLINK(MQNAME);
 	}
-
-	tst_resm(TINFO, "Checking namespaces isolation from parent to child");
-	/* fire off the test */
-	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
-	if (r < 0) {
-		tst_resm(TFAIL, "failed clone/unshare");
-		mq_close(mqd);
-		tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
-		tst_exit();
-	}
-
-	close(p1[0]);
-	close(p2[1]);
-	if (write(p1[1], "go", strlen("go") + 1) < 0)
-		tst_resm(TBROK | TERRNO, "write(p1[1], \"go\", ...) failed");
-	else if (read(p2[0], buf, 7) < 0)
-		tst_resm(TBROK | TERRNO, "read(p2[0], buf, ...) failed");
-	else {
-		if (!strcmp(buf, "exists")) {
-			tst_resm(TFAIL, "child process found mqueue");
-		} else if (!strcmp(buf, "notfnd")) {
-			tst_resm(TPASS, "child process didn't find mqueue");
-		} else {
-			tst_resm(TFAIL, "UNKNOWN RESULT");
-		}
-	}
-
-	/* destroy the mqueue */
-	if (mq_close(mqd) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "mq_close failed");
-	}
-	tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
-
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

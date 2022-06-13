Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17797C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 20:34:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B3153C941F
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 22:34:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5C793C4D12
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23BCF1400173
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5EE921A26;
 Mon, 13 Jun 2022 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655152432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71qm7r3qwRzAGehzlDUZIev/EJvKTdAedeKZvGdXI9Q=;
 b=uMjsN29rseLBuQ00Wr/MiHoYukqRhzPik0m9mvgC+bq1etXnxbngquI2I7JEksLmZZfu4X
 j67WhOLkRrHbPQmOn/0iFC6ah+bLBZUTnCTORvGHH4KBUc1wrzbkB1GR4N1jUm4gUhT0F7
 WEST/KB2fSjHejTLhuve+W4cwOH1/LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655152432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71qm7r3qwRzAGehzlDUZIev/EJvKTdAedeKZvGdXI9Q=;
 b=P2Acf8Zdh3ljRu8IyPBI4LJiYAufqi+qKsWw3Y7d5Wp5hrvpzcvvwh6MTCq3ZCDYg+jVHC
 KhYNgW0uHKdaLTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EC81134CF;
 Mon, 13 Jun 2022 20:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OGi4HzCfp2L3QgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jun 2022 20:33:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 Jun 2022 22:33:30 +0200
Message-Id: <20220613203333.24839-4-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220613203333.24839-1-andrea.cervesato@suse.de>
References: <20220613203333.24839-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/6] Rewrite mqns_03 test using new LTP API
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
 runtest/containers                         |   5 +-
 testcases/kernel/containers/mqns/mqns_03.c | 287 ++++++++-------------
 2 files changed, 106 insertions(+), 186 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 77785edd3..d3de1282d 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -21,8 +21,9 @@ mqns_01_unshare mqns_01 -m unshare
 mqns_02_none mqns_02 -m none
 mqns_02_clone mqns_02 -m clone
 mqns_02_unshare mqns_02 -m unshare
-mqns_03 mqns_03
-mqns_03_clone mqns_03 -clone
+mqns_03_none mqns_03 -m none
+mqns_03_clone mqns_03 -m clone
+mqns_03_unshare mqns_03 -m unshare
 mqns_04 mqns_04
 mqns_04_clone mqns_04 -clone
 
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index a7452b970..51909217d 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -1,207 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
-* Copyright (c) International Business Machines Corp., 2009
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
-* Author: Serge Hallyn <serue@us.ibm.com>
-*
-* Check ipcns+sb longevity
-*
-* Mount mqueue fs
-* unshare
-* In unshared process:
-*    Create "/mq1" with mq_open()
-*    Mount mqueuefs
-*    Check that /mq1 exists
-*    Create /dev/mqueue/mq2 through vfs (create(2))
-*    Umount /dev/mqueue
-*    Remount /dev/mqueue
-*    Check that both /mq1 and /mq2 exist
-
-***************************************************************************/
-
-#ifndef _GNU_SOURCE
+ * Copyright (c) International Business Machines Corp., 2009
+ * Copyright (c) Serge Hallyn <serue@us.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test mqueuefs from an isolated/forked process namespace.
+ *
+ * [Algorithm]
+ *
+ * - create /MQ1
+ * - mount mqueue inside the temporary folder
+ * - check for /MQ1 existance
+ * - create /MQ2 inside the temporary folder
+ * - umount
+ * - mount mqueue inside the temporary folder
+ * - check /MQ1 existance
+ * - check /MQ2 existance
+ * - umount
+ */
 #define _GNU_SOURCE
-#endif
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "mqns.h"
-#include "mqns_helper.h"
 
-char *TCID = "posixmq_namespace_03";
-int TST_TOTAL = 1;
+#include <stdio.h>
+#include <mqueue.h>
+#include "tst_safe_stdio.h"
+#include "common.h"
 
-int p1[2];
-int p2[2];
+#define MQNAME1 "/MQ1"
+#define MQNAME2 "/MQ2"
 
-#define FNAM1 DEV_MQUEUE2 SLASH_MQ1
-#define FNAM2 DEV_MQUEUE2 SLASH_MQ2
+static char *str_op;
+static int use_clone;
+static char *devdir;
+static char *mqueue1;
+static char *mqueue2;
 
-int check_mqueue(void *vtest)
+static int check_mqueue(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	char buf[30];
-	mqd_t mqd;
 	int rc;
+	mqd_t mqd;
 	struct stat statbuf;
 
-	(void) vtest;
+	mqd = mq_open(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
+	if (mqd < 0)
+		tst_brk(TBROK | TERRNO, "mq_open failed");
 
-	close(p1[1]);
-	close(p2[0]);
+	mq_close(mqd);
 
-	if (read(p1[0], buf, 3) != 3) {	/* go */
-		perror("read failed");
-		exit(1);
-	}
+	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
 
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
-		0755, NULL);
-	if (mqd == -1) {
-		write(p2[1], "mqfail", 7);
-		exit(1);
-	}
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s exists at first mount", mqueue1);
 
-	mq_close(mqd);
+	rc = SAFE_CREAT(mqueue2, 0755);
+	SAFE_CLOSE(rc);
+
+	SAFE_UMOUNT(devdir);
+
+	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
+
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s exists at second mount", mqueue1);
+
+	SAFE_STAT(mqueue2, &statbuf);
+	tst_res(TPASS, "%s exists at second mount", mqueue2);
+
+	SAFE_UMOUNT(devdir);
+
+	mq_unlink(MQNAME1);
+	mq_unlink(MQNAME2);
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		write(p2[1], "mount1", 7);
-		exit(1);
-	}
-
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat1", 6);
-		exit(1);
-	}
-
-	rc = creat(FNAM2, 0755);
-	if (rc == -1) {
-		write(p2[1], "creat", 6);
-		exit(1);
-	}
-
-	close(rc);
-
-	rc = umount(DEV_MQUEUE2);
-	if (rc == -1) {
-		write(p2[1], "umount", 7);
-		exit(1);
-	}
-
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		write(p2[1], "mount2", 7);
-		exit(1);
-	}
-
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat2", 7);
-		exit(1);
-	}
-
-	rc = stat(FNAM2, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat3", 7);
-		exit(1);
-	}
-
-	write(p2[1], "done", 5);
-
-	exit(0);
+	return 0;
+}
+
+static void run(void)
+{
+	tst_res(TINFO, "Checking correct umount+remount of mqueuefs");
+
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 }
 
 static void setup(void)
 {
-	tst_require_root();
-	check_mqns();
+	char *tmpdir;
+
+	use_clone = get_clone_unshare_enum(str_op);
+
+	if (use_clone != T_NONE)
+		check_newipc();
+
+	tmpdir = tst_get_tmpdir();
+
+	SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir);
+	SAFE_MKDIR(devdir, 0755);
+
+	SAFE_ASPRINTF(&mqueue1, "%s" MQNAME1, devdir);
+	SAFE_ASPRINTF(&mqueue2, "%s" MQNAME2, devdir);
 }
 
-int main(int argc, char *argv[])
+static void cleanup(void)
 {
-	int r;
-	char buf[30];
-	int use_clone = T_UNSHARE;
-
-	setup();
-
-	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
-		tst_resm(TINFO, "Testing posix mq namespaces through clone(2)");
-		use_clone = T_CLONE;
-	} else
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2)");
-
-	if (pipe(p1) == -1 || pipe(p2) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
-
-	/* fire off the test */
-	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
-	if (r < 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "failed clone/unshare");
-	}
-
-	tst_resm(TINFO, "Checking correct umount+remount of mqueuefs");
-
-	mkdir(DEV_MQUEUE2, 0755);
-
-	close(p1[0]);
-	close(p2[1]);
-	write(p1[1], "go", 3);
-
-	read(p2[0], buf, 7);
-	r = TFAIL;
-	if (!strcmp(buf, "mqfail")) {
-		tst_resm(TFAIL, "child process could not create mqueue");
-		goto fail;
-	} else if (!strcmp(buf, "mount1")) {
-		tst_resm(TFAIL, "child process could not mount mqueue");
-		goto fail;
-	} else if (!strcmp(buf, "stat1x")) {
-		tst_resm(TFAIL, "mq created by child is not in mqueuefs");
-		goto fail;
-	} else if (!strcmp(buf, "creat")) {
-		tst_resm(TFAIL, "child couldn't creat mq through mqueuefs");
-		goto fail;
-	} else if (!strcmp(buf, "umount")) {
-		tst_resm(TFAIL, "child couldn't umount mqueuefs");
-		goto fail;
-	} else if (!strcmp(buf, "mount2")) {
-		tst_resm(TFAIL, "child couldn't remount mqueuefs");
-		goto fail;
-	} else if (!strcmp(buf, "stat2")) {
-		tst_resm(TFAIL,
-			 "mq_open()d file gone after remount of mqueuefs");
-		goto fail;
-	} else if (!strcmp(buf, "stat3")) {
-		tst_resm(TFAIL,
-			 "creat(2)'d file gone after remount of mqueuefs");
-		goto fail;
-	}
-
-	tst_resm(TPASS, "umount+remount of mqueuefs remounted the right fs");
-
-	r = 0;
-fail:
-	umount(DEV_MQUEUE2);
-	rmdir(DEV_MQUEUE2);
-	tst_exit();
+	if (tst_is_mounted(devdir))
+		SAFE_UMOUNT(devdir);
+
+	/* if test ends too early, we need to unlink mqueue(s) */
+	mq_unlink(MQNAME1);
+	mq_unlink(MQNAME2);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.30",
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

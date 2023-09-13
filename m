Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD50CEDEC6A
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 14:47:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2E713CE784
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 16:47:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8DE83CB2FB
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 16:47:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C93B06017D9
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 16:47:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 498D721862;
 Wed, 13 Sep 2023 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694616428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTDeZ60tm4mF87LuSPeeK5DXDhWNxONYt19bDZMMIQg=;
 b=kD2IKDR15e29j/RjOpWd7xO4Gmbc5cyLiCu+60yxPr9/kodDQlAaHfseQ3ONgRoYF2a2iv
 oXvCIiPKh0RkB8XBakbkRDEbS78oJsLsyNr53brBEeG+XJhTOzxypuP+iBZPPC5M1x6IvJ
 H6lyjQbK6SIRMakPFgvEWO9T1xl5Ufs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694616428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTDeZ60tm4mF87LuSPeeK5DXDhWNxONYt19bDZMMIQg=;
 b=11jtwDeoFFhYJ8oEoCLoExy3MSi1pUKD5BAka/b8NC+MyS0HwX0R89BZSMNGu1Rej7NEQj
 TyG++tUJfFJoGNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30E9013440;
 Wed, 13 Sep 2023 14:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ePK8CmzLAWWXbAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 Sep 2023 14:47:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Sep 2023 16:47:03 +0200
Message-Id: <20230913144706.7126-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230913144706.7126-1-andrea.cervesato@suse.de>
References: <20230913144706.7126-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/4] Refactor mqns_03 using new LTP API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Removed absolute path

 testcases/kernel/containers/mqns/mqns_03.c | 309 +++++++++------------
 1 file changed, 132 insertions(+), 177 deletions(-)

diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index a7452b970..469959ed8 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -1,207 +1,162 @@
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
-#define _GNU_SOURCE
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
-
-char *TCID = "posixmq_namespace_03";
-int TST_TOTAL = 1;
-
-int p1[2];
-int p2[2];
-
-#define FNAM1 DEV_MQUEUE2 SLASH_MQ1
-#define FNAM2 DEV_MQUEUE2 SLASH_MQ2
-
-int check_mqueue(void *vtest)
+ * Copyright (c) International Business Machines Corp., 2009
+ * Copyright (c) Serge Hallyn <serue@us.ibm.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
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
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+#include "tst_safe_posix_ipc.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_macros.h"
+
+#define CHECK_MQ_OPEN_RET(x) ((x) >= 0 || ((x) == -1 && errno != EMFILE))
+
+#define DEVDIR "ltp_mqueue"
+#define MQNAME1 "/MQ1"
+#define MQNAME2 "/MQ2"
+
+static char *str_op;
+static char *mqueue1;
+static char *mqueue2;
+static volatile int *mq_freed;
+
+static void check_mqueue(void)
 {
-	char buf[30];
-	mqd_t mqd;
 	int rc;
+	mqd_t mqd;
 	struct stat statbuf;
 
-	(void) vtest;
+	tst_res(TINFO, "Creating %s mqueue from within child process", MQNAME1);
 
-	close(p1[1]);
-	close(p2[0]);
+	mqd = TST_RETRY_FUNC(
+		mq_open(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0777, NULL),
+		CHECK_MQ_OPEN_RET);
+	if (mqd == -1)
+		tst_brk(TBROK | TERRNO, "mq_open failed");
 
-	if (read(p1[0], buf, 3) != 3) {	/* go */
-		perror("read failed");
-		exit(1);
-	}
+	SAFE_MQ_CLOSE(mqd);
+	mq_freed[0] = 1;
 
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
-		0755, NULL);
-	if (mqd == -1) {
-		write(p2[1], "mqfail", 7);
-		exit(1);
-	}
+	tst_res(TINFO, "Mount %s from within child process", DEVDIR);
 
-	mq_close(mqd);
+	SAFE_MOUNT("mqueue", DEVDIR, "mqueue", 0, NULL);
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		write(p2[1], "mount1", 7);
-		exit(1);
-	}
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s exists at first mount", mqueue1);
 
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat1", 6);
-		exit(1);
-	}
+	tst_res(TINFO, "Creating %s from within child process", mqueue2);
 
-	rc = creat(FNAM2, 0755);
-	if (rc == -1) {
-		write(p2[1], "creat", 6);
-		exit(1);
-	}
+	rc = SAFE_CREAT(mqueue2, 0755);
+	SAFE_CLOSE(rc);
+	mq_freed[1] = 1;
 
-	close(rc);
+	tst_res(TINFO, "Mount %s from within child process a second time", DEVDIR);
 
-	rc = umount(DEV_MQUEUE2);
-	if (rc == -1) {
-		write(p2[1], "umount", 7);
-		exit(1);
-	}
+	SAFE_UMOUNT(DEVDIR);
+	SAFE_MOUNT("mqueue", DEVDIR, "mqueue", 0, NULL);
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		write(p2[1], "mount2", 7);
-		exit(1);
-	}
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s exists at second mount", mqueue1);
 
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat2", 7);
-		exit(1);
-	}
+	SAFE_STAT(mqueue2, &statbuf);
+	tst_res(TPASS, "%s exists at second mount", mqueue2);
 
-	rc = stat(FNAM2, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat3", 7);
-		exit(1);
-	}
+	SAFE_UMOUNT(DEVDIR);
 
-	write(p2[1], "done", 5);
+	SAFE_MQ_UNLINK(MQNAME1);
+	mq_freed[0] = 0;
 
-	exit(0);
+	SAFE_MQ_UNLINK(MQNAME2);
+	mq_freed[1] = 0;
+}
+
+static void run(void)
+{
+	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
+
+	if (str_op && !strcmp(str_op, "clone")) {
+		tst_res(TINFO, "Spawning isolated process");
+
+		if (!SAFE_CLONE(&clone_args)) {
+			check_mqueue();
+			return;
+		}
+	} else if (str_op && !strcmp(str_op, "unshare")) {
+		tst_res(TINFO, "Spawning unshared process");
+
+		if (!SAFE_FORK()) {
+			SAFE_UNSHARE(CLONE_NEWIPC);
+			check_mqueue();
+			return;
+		}
+	}
 }
 
 static void setup(void)
 {
-	tst_require_root();
-	check_mqns();
+	if (!str_op || (strcmp(str_op, "clone") && strcmp(str_op, "unshare")))
+		tst_brk(TCONF, "Please specify clone|unshare child isolation");
+
+	SAFE_MKDIR(DEVDIR, 0755);
+
+	SAFE_ASPRINTF(&mqueue1, "%s" MQNAME1, DEVDIR);
+	SAFE_ASPRINTF(&mqueue2, "%s" MQNAME2, DEVDIR);
+
+	mq_freed = SAFE_MMAP(NULL,
+		2 * sizeof(int),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
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
+	if (!access(mqueue1, F_OK))
+		SAFE_MQ_UNLINK(MQNAME1);
 
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
+	if (!access(mqueue2, F_OK))
+		SAFE_MQ_UNLINK(MQNAME2);
 
-	tst_resm(TPASS, "umount+remount of mqueuefs remounted the right fs");
+	if (tst_is_mounted(DEVDIR))
+		SAFE_UMOUNT(DEVDIR);
 
-	r = 0;
-fail:
-	umount(DEV_MQUEUE2);
-	rmdir(DEV_MQUEUE2);
-	tst_exit();
+	if (*mq_freed)
+		SAFE_MUNMAP((void *)mq_freed, 2 * sizeof(int));
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Child process isolation <clone|unshare>" },
+		{},
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		NULL
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

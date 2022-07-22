Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540E2C433EF
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 12:06:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD89D3C9F61
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 14:06:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 602283C9F94
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 14:05:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96DF91A00CA0
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 14:05:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21CFC34888;
 Fri, 22 Jul 2022 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1658491536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCyTVy6ii8ZqOMZSX+hyw5niMaTNviGKgl4MCkix7MQ=;
 b=pSbY96z3fuf1fYi1piE18QshHSwsPOx2vKsVRr0YO6e6LE9zv8Yv0QSzldz/rKRuLPtgo5
 bvWSvVzeb0CBKabavrYSZBAAgZDD9cdQKLTGLv+Rhhc2m+A3bbSMP+zL4qWD9BPKeQZetU
 iXbW/3GQuH2BYMTpoRmKc5o1jptvnWY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2666134A9;
 Fri, 22 Jul 2022 12:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8Pl3NI+S2mJULwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 22 Jul 2022 12:05:35 +0000
To: ltp@lists.linux.it
Date: Fri, 22 Jul 2022 14:04:58 +0200
Message-Id: <20220722120501.28670-5-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722120501.28670-1-andrea.cervesato@suse.com>
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] Refactor mqns_03 using new LTP API
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
 testcases/kernel/containers/mqns/mqns_03.c | 271 ++++++++-------------
 2 files changed, 100 insertions(+), 174 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 4042ced4c..496b47037 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -22,7 +22,8 @@ mqns_02 mqns_02
 mqns_02_clone mqns_02 -m clone
 mqns_02_unshare mqns_02 -m unshare
 mqns_03 mqns_03
-mqns_03_clone mqns_03 -clone
+mqns_03_clone mqns_03 -m clone
+mqns_03_unshare mqns_03 -m unshare
 mqns_04 mqns_04
 mqns_04_clone mqns_04 -clone
 
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index a7452b970..5914a2a9b 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -1,207 +1,132 @@
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
+#include "common.h"
+#include "tst_safe_stdio.h"
 
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
+static int *mq_freed;
 
-int check_mqueue(void *vtest)
+static int check_mqueue(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	char buf[30];
-	mqd_t mqd;
 	int rc;
+	mqd_t mqd;
 	struct stat statbuf;
 
-	(void) vtest;
+	mqd = SAFE_MQ_OPEN(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
 
-	close(p1[1]);
-	close(p2[0]);
+	SAFE_MQ_CLOSE(mqd);
 
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
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		write(p2[1], "mount1", 7);
-		exit(1);
-	}
+	SAFE_UMOUNT(devdir);
 
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat1", 6);
-		exit(1);
-	}
+	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
 
-	rc = creat(FNAM2, 0755);
-	if (rc == -1) {
-		write(p2[1], "creat", 6);
-		exit(1);
-	}
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s exists at second mount", mqueue1);
 
-	close(rc);
+	SAFE_STAT(mqueue2, &statbuf);
+	tst_res(TPASS, "%s exists at second mount", mqueue2);
 
-	rc = umount(DEV_MQUEUE2);
-	if (rc == -1) {
-		write(p2[1], "umount", 7);
-		exit(1);
-	}
+	SAFE_UMOUNT(devdir);
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		write(p2[1], "mount2", 7);
-		exit(1);
-	}
+	SAFE_MQ_UNLINK(MQNAME1);
+	SAFE_MQ_UNLINK(MQNAME2);
 
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat2", 7);
-		exit(1);
-	}
+	*mq_freed = 1;
 
-	rc = stat(FNAM2, &statbuf);
-	if (rc == -1) {
-		write(p2[1], "stat3", 7);
-		exit(1);
-	}
+	return 0;
+}
 
-	write(p2[1], "done", 5);
+static void run(void)
+{
+	tst_res(TINFO, "Checking correct umount+remount of mqueuefs");
 
-	exit(0);
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
+
+	mq_freed = SAFE_MMAP(NULL,
+		sizeof(int),
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
+	if (tst_is_mounted(devdir))
+		SAFE_UMOUNT(devdir);
 
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
+	if (!*mq_freed) {
+		SAFE_MQ_UNLINK(MQNAME1);
+		SAFE_MQ_UNLINK(MQNAME2);
 	}
-
-	tst_resm(TPASS, "umount+remount of mqueuefs remounted the right fs");
-
-	r = 0;
-fail:
-	umount(DEV_MQUEUE2);
-	rmdir(DEV_MQUEUE2);
-	tst_exit();
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
+		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

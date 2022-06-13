Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A53C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 20:34:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84C903C9434
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 22:34:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AA923C91E8
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 60F2114002DE
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F31921A2E;
 Mon, 13 Jun 2022 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655152433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cWcE9yaFMur9eF/tt76YSK7tjFvt9xyd1hpN//QSWY=;
 b=b1t8HGOodKeMK/x+E+Qc967xP7e6FHYAS/p97PRcH0xgv6+SfwqpG1P82K7NR/iHXAPDRo
 E9j3waOitbMGyFNcqPVtv/yQLSTH4Mbq/4ORTCdmWlVXAUvM04Spjgim8Q1K8JUN3shsSz
 +95wWtPbxTVGlTWNf0XDq6bUbI2uyE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655152433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cWcE9yaFMur9eF/tt76YSK7tjFvt9xyd1hpN//QSWY=;
 b=MO48fcWDw/Xy6GWkbpo+Ut8QrvqZEtllO5nyvDYxHi2ulHSJgu2XCyqx/z35zx6Jq50LAX
 N0NRKlJ993z+gxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB190134CF;
 Mon, 13 Jun 2022 20:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sGmBMjCfp2L3QgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jun 2022 20:33:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 Jun 2022 22:33:31 +0200
Message-Id: <20220613203333.24839-5-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220613203333.24839-1-andrea.cervesato@suse.de>
References: <20220613203333.24839-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 4/6] Rewrite mqns_04 test using new LTP API
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
 runtest/containers                         |   4 +-
 testcases/kernel/containers/mqns/mqns_04.c | 275 +++++++++------------
 2 files changed, 116 insertions(+), 163 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index d3de1282d..aac576004 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -24,8 +24,8 @@ mqns_02_unshare mqns_02 -m unshare
 mqns_03_none mqns_03 -m none
 mqns_03_clone mqns_03 -m clone
 mqns_03_unshare mqns_03 -m unshare
-mqns_04 mqns_04
-mqns_04_clone mqns_04 -clone
+mqns_04_clone mqns_04 -m clone
+mqns_04_unshare mqns_04 -m unshare
 
 netns_netlink netns_netlink
 netns_breakns_ip_ipv4_netlink netns_breakns.sh
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index d07a85c04..ce7a86e64 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -1,187 +1,140 @@
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
-* Check mqueuefs lifetime
-* . parent creates /dev/mqueue2
-* . child mounts mqueue there
-* . child does mq_open("/ab")
-* . parent checks for /dev/mqueue2
-* . child exits
-* . parent checks for /dev/mqueue2
-* . parent tries 'touch /dev/mqueue2/dd' -> should fail
-* . parent umounts /dev/mqueue2
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
+ * Test mqueuefs manipulation from child/parent namespaces.
+ *
+ * [Algorithm]
+ *
+ * - parent creates mqueue folder in <tmpdir>
+ * - child mounts mqueue there
+ * - child creates /MQ1 mqueue
+ * - parent checks for <tmpdir>/mqueue/MQ1 existence
+ * - child exits
+ * - parent checks for <tmpdir>/mqueue/MQ1 existence
+ * - parent tries 'touch <tmpdir>/mqueue/MQ2' -> should fail
+ * - parent umount mqueuefs
+ */
 #define _GNU_SOURCE
-#endif
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <assert.h>
+
 #include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "mqns.h"
-#include "mqns_helper.h"
+#include <mqueue.h>
+#include "tst_safe_stdio.h"
+#include "common.h"
 
-char *TCID = "posixmq_namespace_04";
-int TST_TOTAL = 1;
+#define CHECK_MQ_OPEN_RET(x) ((x) >= 0 || ((x) == -1 && errno != EMFILE))
 
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
 	mqd_t mqd;
+
+	mqd = TST_RETRY_FUNC(mq_open(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0755, NULL),
+		CHECK_MQ_OPEN_RET);
+	if (mqd == -1)
+		tst_brk(TBROK | TERRNO, "mq_open failed");
+
+	mq_close(mqd);
+
+	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	return 0;
+}
+
+static void run(void)
+{
 	int rc;
+	int status;
+	struct stat statbuf;
 
-	(void) vtest;
+	tst_res(TINFO, "Checking mqueue filesystem lifetime");
 
-	close(p1[1]);
-	close(p2[0]);
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
 
-	read(p1[0], buf, 3);	/* go */
+	TST_CHECKPOINT_WAIT(0);
 
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
-		0755, NULL);
-	if (mqd == -1) {
-		write(p2[1], "mqfail", 7);
-		tst_exit();
-	}
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s child's mqueue can be accessed from parent", mqueue1);
 
-	mq_close(mqd);
+	TST_CHECKPOINT_WAKE(0);
+
+	tst_res(TINFO, "Waiting child to exit");
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		perror("mount");
-		write(p2[1], "mount", 6);
-		tst_exit();
-	}
+	SAFE_WAIT(&status);
 
-	write(p2[1], "go", 3);
-	read(p1[0], buf, 3);
+	if (!WIFEXITED(status))
+		tst_brk(TBROK, "Child did not exit normally: %s", tst_strstatus(status));
 
-	tst_exit();
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s child's mqueue can be accessed from parent after child's dead", mqueue1);
+
+	rc = creat(mqueue2, 0755);
+	if (rc != -1)
+		tst_res(TFAIL, "Parent was able to create a file in dead child's mqueuefs");
+	else
+		tst_res(TPASS, "Parent is not able to create a file in dead child's mqueuefs");
+
+	SAFE_UMOUNT(devdir);
+
+	mq_unlink(MQNAME1);
+	mq_unlink(MQNAME2);
 }
 
 static void setup(void)
 {
-	tst_require_root();
-	check_mqns();
+	char *tmpdir;
+
+	use_clone = get_clone_unshare_enum(str_op);
+
+	if (use_clone == T_NONE)
+		tst_brk(TBROK, "Plain process is not supported by this test");
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
-	int rc;
-	int status;
-	char buf[30];
-	struct stat statbuf;
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
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-
-	mkdir(DEV_MQUEUE2, 0755);
-
-	tst_resm(TINFO, "Checking mqueue filesystem lifetime");
-
-	/* fire off the test */
-	rc = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
-	if (rc < 0) {
-		tst_resm(TFAIL, "failed clone/unshare");
-		goto fail;
-	}
-
-	close(p1[0]);
-	close(p2[1]);
-	write(p1[1], "go", 3);
-
-	read(p2[0], buf, 7);
-	if (!strcmp(buf, "mqfail")) {
-		tst_resm(TFAIL, "child process could not create mqueue");
-		goto fail;
-	} else if (!strcmp(buf, "mount")) {
-		tst_resm(TFAIL, "child process could not mount mqueue");
-		goto fail;
-	}
-
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		perror("stat");
-		write(p1[1], "go", 3);
-		tst_resm(TFAIL, "parent could not see child's created mq");
-		goto fail;
-	}
-	write(p1[1], "go", 3);
-
-	rc = wait(&status);
-	if (rc == -1) {
-		perror("wait");
-		tst_resm(TFAIL, "error while parent waited on child to exit");
-		goto fail;
-	}
-	if (!WIFEXITED(status)) {
-		tst_resm(TFAIL, "Child did not exit normally (status %d)",
-			 status);
-		goto fail;
-	}
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		tst_resm(TFAIL,
-			 "parent's view of child's mq died with child");
-		goto fail;
-	}
-
-	rc = creat(FNAM2, 0755);
-	if (rc != -1) {
-		tst_resm(TFAIL,
-			 "parent was able to create a file in dead child's mqfs");
-		goto fail;
-	}
-
-	tst_resm(TPASS, "Child mqueue fs still visible for parent");
-
-fail:
-	umount(DEV_MQUEUE2);
-	rmdir(DEV_MQUEUE2);
-
-	tst_exit();
+	/* if test ends too early, we need to unlink mqueue(s) */
+	mq_unlink(MQNAME1);
+	mq_unlink(MQNAME2);
+
+	if (tst_is_mounted(devdir))
+		SAFE_UMOUNT(devdir);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.needs_checkpoints = 1,
+	.min_kver = "2.6.30",
+	.options = (struct tst_option[]) {
+		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC2C7EE22
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 12:45:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22DDB3CD671
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 14:45:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B34E63CB4E4
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:44:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC02D1400B78
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:44:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 199B31F74A;
 Wed, 10 May 2023 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1683722670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QnCNb1w+lE1F+0J0h91RMecozjgzcZRDhQGOFbya8w=;
 b=ttAsI+0N7WSTMXfiY7Lw0BdrIOYMnNN6U9hxT9ELA4KpQ3Od5GR42z6Rq3q2f1zHtnw1P0
 C7pb6BRoYoPDquFsZQKTPCH8ofMCss4tGJmUhwRiZkDkwd0tncVIQbuMpnOCzbfBDapNwQ
 YLG9njtZy3QXuiWKV3H9aSOGUAeaBb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1683722670;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QnCNb1w+lE1F+0J0h91RMecozjgzcZRDhQGOFbya8w=;
 b=6eELKe0Uxe77/oE3BSliD5uXUJ9hRp2kj1ioVskjgXHC5Yj9Q06xL9QRGLRDe+j482sf+E
 y1PZH/iscoBZfRAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED6BB13519;
 Wed, 10 May 2023 12:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sER4OK2RW2TseAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 May 2023 12:44:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 10 May 2023 14:42:04 +0200
Message-Id: <20230510124206.19627-5-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230510124206.19627-1-andrea.cervesato@suse.de>
References: <20230510124206.19627-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 4/6] Refactor mqns_04 using new LTP API
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
 runtest/containers                         |   4 +-
 testcases/kernel/containers/mqns/mqns_04.c | 291 ++++++++++-----------
 2 files changed, 139 insertions(+), 156 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 07bcc8a19..c88e3f777 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -23,8 +23,8 @@ mqns_02_clone mqns_02 -m clone
 mqns_02_unshare mqns_02 -m unshare
 mqns_02_clone mqns_03 -m clone
 mqns_02_unshare mqns_03 -m unshare
-mqns_04 mqns_04
-mqns_04_clone mqns_04 -clone
+mqns_02_clone mqns_04 -m clone
+mqns_02_unshare mqns_04 -m unshare
 
 netns_netlink netns_netlink
 netns_breakns_ip_ipv4_netlink netns_breakns.sh
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index d07a85c04..75c54259c 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -1,187 +1,170 @@
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
-#define _GNU_SOURCE
-#endif
-#include <sys/types.h>
-#include <sys/stat.h>
+ * Copyright (c) International Business Machines Corp., 2009
+ * Copyright (c) Serge Hallyn <serue@us.ibm.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
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
+
 #include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "mqns.h"
-#include "mqns_helper.h"
+#include "tst_test.h"
+#include "lapi/sched.h"
+#include "tst_safe_posix_ipc.h"
+#include "tst_safe_stdio.h"
 
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
+static char *devdir;
+static char *mqueue1;
+static char *mqueue2;
+static int *mq_freed1;
+static int *mq_freed2;
 
-int check_mqueue(void *vtest)
+static void check_mqueue(void)
 {
-	char buf[30];
 	mqd_t mqd;
-	int rc;
 
-	(void) vtest;
+	tst_res(TINFO, "Creating %s mqueue from within child process", MQNAME1);
 
-	close(p1[1]);
-	close(p2[0]);
+	mqd = TST_RETRY_FUNC(
+		mq_open(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0755, NULL),
+		CHECK_MQ_OPEN_RET);
+	if (mqd == -1)
+		tst_brk(TBROK | TERRNO, "mq_open failed");
 
-	read(p1[0], buf, 3);	/* go */
+	SAFE_MQ_CLOSE(mqd);
+	tst_atomic_inc(mq_freed1);
 
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
-		0755, NULL);
-	if (mqd == -1) {
-		write(p2[1], "mqfail", 7);
-		tst_exit();
-	}
+	tst_res(TINFO, "Mount %s from within child process", devdir);
+
+	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+}
 
-	mq_close(mqd);
+static void run(void)
+{
+	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
+	struct stat statbuf;
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		perror("mount");
-		write(p2[1], "mount", 6);
-		tst_exit();
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
 	}
 
-	write(p2[1], "go", 3);
-	read(p1[0], buf, 3);
+	TST_CHECKPOINT_WAIT(0);
 
-	tst_exit();
-}
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s child's mqueue can be accessed from parent", mqueue1);
 
-static void setup(void)
-{
-	tst_require_root();
-	check_mqns();
-}
+	TST_CHECKPOINT_WAKE(0);
 
-int main(int argc, char *argv[])
-{
-	int rc;
-	int status;
-	char buf[30];
-	struct stat statbuf;
-	int use_clone = T_UNSHARE;
+	tst_res(TINFO, "Waiting child to exit");
 
-	setup();
+	tst_reap_children();
+	tst_atomic_dec(mq_freed1);
 
-	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through clone(2).");
-		use_clone = T_CLONE;
-	} else
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2).");
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s child's mqueue can be accessed from parent after child's dead", mqueue1);
 
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
+	tst_res(TINFO, "Try to create %s from parent", mqueue2);
 
-	mkdir(DEV_MQUEUE2, 0755);
+	TST_EXP_FAIL(creat(mqueue2, 0755), EACCES);
+	if (!TST_PASS)
+		tst_atomic_inc(mq_freed2);
 
-	tst_resm(TINFO, "Checking mqueue filesystem lifetime");
+	SAFE_UMOUNT(devdir);
+}
 
-	/* fire off the test */
-	rc = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
-	if (rc < 0) {
-		tst_resm(TFAIL, "failed clone/unshare");
-		goto fail;
-	}
+static void setup(void)
+{
+	char *tmpdir;
 
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
+	if (!str_op)
+		tst_brk(TCONF, "Please specify clone|unshare child isolation");
 
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		perror("stat");
-		write(p1[1], "go", 3);
-		tst_resm(TFAIL, "parent could not see child's created mq");
-		goto fail;
-	}
-	write(p1[1], "go", 3);
+	tmpdir = tst_get_tmpdir();
 
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
+	SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir);
+	SAFE_MKDIR(devdir, 0755);
 
-	rc = creat(FNAM2, 0755);
-	if (rc != -1) {
-		tst_resm(TFAIL,
-			 "parent was able to create a file in dead child's mqfs");
-		goto fail;
-	}
+	SAFE_ASPRINTF(&mqueue1, "%s" MQNAME1, devdir);
+	SAFE_ASPRINTF(&mqueue2, "%s" MQNAME2, devdir);
+
+	mq_freed1 = SAFE_MMAP(NULL,
+		sizeof(int),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
 
-	tst_resm(TPASS, "Child mqueue fs still visible for parent");
+	mq_freed2 = SAFE_MMAP(NULL,
+		sizeof(int),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+}
 
-fail:
-	umount(DEV_MQUEUE2);
-	rmdir(DEV_MQUEUE2);
+static void cleanup(void)
+{
+	if (!devdir)
+		return;
 
-	tst_exit();
+	if (tst_is_mounted(devdir))
+		SAFE_UMOUNT(devdir);
+
+	if (*mq_freed1)
+		SAFE_MQ_UNLINK(MQNAME1);
+
+	if (*mq_freed2)
+		SAFE_MQ_UNLINK(MQNAME2);
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

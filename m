Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD3C636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 08:54:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FD663CBEC3
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 09:54:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D5A53CB464
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 09:53:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DC49E1A00881
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 09:53:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87BC5208EF;
 Thu, 16 Feb 2023 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676537591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZzgZrFcAjit9DFZjHBeqmcTX94UtvFCXy5bH/uCP14=;
 b=aVOwlpmLiSd8eLnF1UsTSKASYGPBhFapHilTZ24divBEkMaNdWZh6ZYy3NhmSIaqa7n0sx
 UvTpwKjXT16L1M92dVDTubhVZoMhccfnqj9emJPy1WbHX87MUVlFMyaskGvjdT3jAJzCfq
 21w9nKvlJOh8zp8FeXdwpxyf1fUqzqY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57E1013484;
 Thu, 16 Feb 2023 08:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IP7EEvfu7WNJGAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Feb 2023 08:53:11 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Feb 2023 09:51:05 +0100
Message-Id: <20230216085107.7068-5-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230216085107.7068-1-andrea.cervesato@suse.com>
References: <20230216085107.7068-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/6] Refactor mqns_04 using new LTP API
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
 runtest/containers                         |   4 +-
 testcases/kernel/containers/mqns/mqns_04.c | 273 +++++++++------------
 2 files changed, 122 insertions(+), 155 deletions(-)

diff --git a/runtest/containers b/runtest/containers
index 1cc6c838d..318113e19 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -24,8 +24,8 @@ mqns_02_unshare mqns_02 -m unshare
 mqns_03 mqns_03
 mqns_03_clone mqns_03 -m clone
 mqns_03_unshare mqns_03 -m unshare
-mqns_04 mqns_04
-mqns_04_clone mqns_04 -clone
+mqns_04_clone mqns_04 -m clone
+mqns_04_unshare mqns_04 -m unshare
 
 netns_netlink netns_netlink
 netns_breakns_ip_ipv4_netlink netns_breakns.sh
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index d07a85c04..93df61ec4 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -1,187 +1,154 @@
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
 #define _GNU_SOURCE
-#endif
-#include <sys/types.h>
-#include <sys/stat.h>
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
+static int *mq_freed;
 
-int check_mqueue(void *vtest)
+static void check_mqueue(void)
 {
-	char buf[30];
 	mqd_t mqd;
-	int rc;
 
-	(void) vtest;
+	mqd = TST_RETRY_FUNC(
+		mq_open(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0755, NULL),
+		CHECK_MQ_OPEN_RET);
+	if (mqd == -1)
+		tst_brk(TBROK | TERRNO, "mq_open failed");
 
-	close(p1[1]);
-	close(p2[0]);
+	SAFE_MQ_CLOSE(mqd);
 
-	read(p1[0], buf, 3);	/* go */
+	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
 
-	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
-		0755, NULL);
-	if (mqd == -1) {
-		write(p2[1], "mqfail", 7);
-		tst_exit();
-	}
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+}
+
+static void run(void)
+{
+	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
+	int status;
+	struct stat statbuf;
+
+	tst_res(TINFO, "Checking mqueue filesystem lifetime");
+
+	if (str_op && !strcmp(str_op, "clone")) {
+		tst_res(TINFO, "Spawning isolated process");
 
-	mq_close(mqd);
+		if (!SAFE_CLONE(&clone_args)) {
+			check_mqueue();
+			return;
+		}
+	} else if (str_op && !strcmp(str_op, "unshare")) {
+		tst_res(TINFO, "Spawning unshared process");
 
-	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
-	if (rc == -1) {
-		perror("mount");
-		write(p2[1], "mount", 6);
-		tst_exit();
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
+	SAFE_WAIT(&status);
 
-	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through clone(2).");
-		use_clone = T_CLONE;
-	} else
-		tst_resm(TINFO,
-			 "Testing posix mq namespaces through unshare(2).");
+	if (!WIFEXITED(status))
+		tst_brk(TBROK, "Child did not exit normally: %s", tst_strstatus(status));
 
-	if (pipe(p1) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror("pipe");
-		exit(EXIT_FAILURE);
-	}
+	SAFE_STAT(mqueue1, &statbuf);
+	tst_res(TPASS, "%s child's mqueue can be accessed from parent after child's dead", mqueue1);
 
-	mkdir(DEV_MQUEUE2, 0755);
+	TST_EXP_FAIL(creat(mqueue2, 0755), EACCES);
 
-	tst_resm(TINFO, "Checking mqueue filesystem lifetime");
+	SAFE_UMOUNT(devdir);
 
-	/* fire off the test */
-	rc = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
-	if (rc < 0) {
-		tst_resm(TFAIL, "failed clone/unshare");
-		goto fail;
-	}
+	*mq_freed = 1;
+}
 
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
+static void setup(void)
+{
+	char *tmpdir;
 
-	rc = stat(FNAM1, &statbuf);
-	if (rc == -1) {
-		perror("stat");
-		write(p1[1], "go", 3);
-		tst_resm(TFAIL, "parent could not see child's created mq");
-		goto fail;
-	}
-	write(p1[1], "go", 3);
+	if (!str_op)
+		tst_brk(TCONF, "Please use clone|unshare execution mode");
 
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
+	tmpdir = tst_get_tmpdir();
 
-	rc = creat(FNAM2, 0755);
-	if (rc != -1) {
-		tst_resm(TFAIL,
-			 "parent was able to create a file in dead child's mqfs");
-		goto fail;
-	}
+	SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir);
+	SAFE_MKDIR(devdir, 0755);
+
+	SAFE_ASPRINTF(&mqueue1, "%s" MQNAME1, devdir);
+	SAFE_ASPRINTF(&mqueue2, "%s" MQNAME2, devdir);
 
-	tst_resm(TPASS, "Child mqueue fs still visible for parent");
+	mq_freed = SAFE_MMAP(NULL,
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
+	if (tst_is_mounted(devdir))
+		SAFE_UMOUNT(devdir);
 
-	tst_exit();
+	if (!*mq_freed) {
+		SAFE_MQ_UNLINK(MQNAME1);
+		SAFE_MQ_UNLINK(MQNAME2);
+	}
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
+		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

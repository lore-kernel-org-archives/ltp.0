Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3EBC433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 12:35:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 668473C9A6D
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 13:35:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D8C83C70EC
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 13:35:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE1521000D39
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 13:35:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B04321100;
 Thu,  3 Feb 2022 12:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643891725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBNEPtnArsFStST1RQfOxyeRvMW5mJDSXX9X96ef7aU=;
 b=mZOdFQ5jlAVGwa/C64QTa9ka4SGamoOykhBmRlvhxVTUZ6BFyLCpIyF0F3LDB62Ag/JOTJ
 wy7DjB+kKnu36Q8LUJSO4+HRB4EEXvSpx/WNS4cRicAwZkQPV0RBOpFbX+x2BIm0eLwS6I
 e+NWyBPE1U/ydIo49G2xty4B9ovrwTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643891725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBNEPtnArsFStST1RQfOxyeRvMW5mJDSXX9X96ef7aU=;
 b=2Wby2wC3VIo3GqHFeoDBIvB3Z+cp/ob85PyZQSuJp9v0gshgdcB+ojm67cIZ1sj7v7iKKh
 2Rofvo7SuXzRkJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52A661348D;
 Thu,  3 Feb 2022 12:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cOAuEg3M+2GkGwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Feb 2022 12:35:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  3 Feb 2022 13:35:20 +0100
Message-Id: <20220203123522.28604-4-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203123522.28604-1-andrea.cervesato@suse.de>
References: <20220203123522.28604-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/5] Rewrite mountns03 test using new LTP API
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
 .../kernel/containers/mountns/mountns03.c     | 161 ++++++++----------
 1 file changed, 73 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 196a36149..5ffd66c4e 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -1,23 +1,17 @@
-/* Copyright (c) 2014 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- ***********************************************************************
- * File: mountns03.c
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
  * Tests a slave mount: slave mount is like a shared mount except that
  * mount and umount events only propagate towards it.
  *
- * Description:
+ * [Algorithm]
+ *
  * 1. Creates directories "A", "B" and files "A/A", "B/B"
  * 2. Unshares mount namespace and makes it private (so mounts/umounts
  *    have no effect on a real system)
@@ -36,131 +30,122 @@
  *	X: must see only the "A/A" and must not see "A/B" (as slave
  *	   mount does not forward propagation)
  *	Y: umounts "A"
- ***********************************************************************/
+ */
 
 #define _GNU_SOURCE
+
 #include <sys/wait.h>
 #include <sys/mount.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include "mountns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
+#include "common.h"
+#include "tst_test.h"
 
-char *TCID	= "mountns03";
-int TST_TOTAL	= 2;
+#if defined(MS_SHARED) && defined(MS_PRIVATE) && defined(MS_REC)               \
+	&& defined(MS_SLAVE)
 
-#if defined(MS_SHARED) && defined(MS_PRIVATE) \
-    && defined(MS_REC) && defined(MS_SLAVE)
-
-int child_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	int ret = 0;
 
-	/* makes mount DIRA a slave of DIRA (all slave mounts have
-	 * a master mount which is a shared mount) */
-	if (mount("none", DIRA, "none", MS_SLAVE, NULL) == -1) {
-		perror("mount");
-		return 1;
-	}
+	/*
+	 * makes mount DIRA a slave of DIRA (all slave mounts have
+	 * a master mount which is a shared mount)
+	 */
+	SAFE_MOUNT("none", DIRA, "none", MS_SLAVE, NULL);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	/* checks that shared mounts propagates to slave mount */
-	if (access(DIRA"/B", F_OK) == -1)
+	if (access(DIRA "/B", F_OK) < 0)
 		ret = 2;
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	/* bind mounts DIRB to DIRA making contents of DIRB visible
-	 * in DIRA */
-	if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
-		perror("mount");
-		return 1;
-	}
+	/* bind mounts DIRB to DIRA making contents of DIRB visible in DIRA */
+	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_UMOUNT(DIRA);
 
-	umount(DIRA);
 	return ret;
 }
 
-static void test(void)
+static void run(void)
 {
-	int status;
+	int status, ret;
 
 	/* unshares the mount ns */
-	if (unshare(CLONE_NEWNS) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
+	SAFE_UNSHARE(CLONE_NEWNS);
+
 	/* makes sure parent mounts/umounts have no effect on a real system */
-	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
+	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);
 
 	/* bind mounts DIRA to itself */
-	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
+	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
 
 	/* makes mount DIRA shared */
-	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_SHARED, NULL);
+	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
 
-	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK, "clone failed");
 
 	/* waits for child to make a slave mount */
-	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
+	TST_CHECKPOINT_WAIT(0);
 
-	/* bind mounts DIRB to DIRA making contents of DIRB visible
-	 * in DIRA */
-	SAFE_MOUNT(cleanup, DIRB, DIRA, "none", MS_BIND, NULL);
+	/* bind mounts DIRB to DIRA making contents of DIRB visible in DIRA */
+	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	SAFE_UMOUNT(cleanup, DIRA);
+	SAFE_UMOUNT(DIRA);
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	/* checks that slave mount doesn't propagate to shared mount */
-	if ((access(DIRA"/A", F_OK) == 0) && (access(DIRA"/B", F_OK) == -1))
-		tst_resm(TPASS, "propagation from slave mount passed");
+	if ((access(DIRA "/A", F_OK) == 0) && (access(DIRA "/B", F_OK) == -1))
+		tst_res(TPASS, "propagation from slave mount passed");
 	else
-		tst_resm(TFAIL, "propagation form slave mount failed");
+		tst_res(TFAIL, "propagation form slave mount failed");
 
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+	TST_CHECKPOINT_WAKE(0);
 
+	SAFE_WAIT(&status);
 
-	SAFE_WAIT(cleanup, &status);
 	if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == 0)
-			tst_resm(TPASS, "propagation to slave mount passed");
+			tst_res(TPASS, "propagation to slave mount passed");
 		else
-			tst_resm(TFAIL, "propagation to slave mount failed");
+			tst_res(TFAIL, "propagation to slave mount failed");
 	}
+
 	if (WIFSIGNALED(status)) {
-		tst_resm(TBROK, "child was killed with signal %s",
-			 tst_strsig(WTERMSIG(status)));
-		return;
+		tst_brk(TBROK, "child was killed with signal %s",
+			tst_strsig(WTERMSIG(status)));
 	}
 
-	SAFE_UMOUNT(cleanup, DIRA);
+	SAFE_UMOUNT(DIRA);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		test();
-
-	cleanup();
-	tst_exit();
+	check_newns();
+	create_folders();
 }
 
-#else
-int main(void)
+static void cleanup(void)
 {
-	tst_brkm(TCONF, NULL, "needed mountflags are not defined");
+	umount_folders();
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
+
+#else
+TST_TEST_TCONF("needed mountflags are not defined");
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

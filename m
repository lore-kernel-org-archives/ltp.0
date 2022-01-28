Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C35C433EF
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 08:44:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A1A3C973B
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 09:44:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A4F63C7FEC
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 09:44:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5729460098C
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 09:44:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A9771F385;
 Fri, 28 Jan 2022 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643359451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ayw3yhdjK6/A0Wdor9rXYCHxjAfhV3yryfmVbgr183k=;
 b=BtMjVMoyAIfB7MlkxZvnm0jG1158qjkC9tYWmwdhkHR0FeXh41D93ANestpGaL2a00bih4
 2H0jviKmbQnY+mhAqzuGRlQRlZo6e93/+mxWFiGhz+2gZgk/PieeB4mMMBzvx5a/3KuuEW
 dCRoKaPygkVpSnJjjAb2DIRUncyj9sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643359451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ayw3yhdjK6/A0Wdor9rXYCHxjAfhV3yryfmVbgr183k=;
 b=NOlE0a09p/EY9GzxohdxW5KDhURUco94mACYk/9Fx5w4i7MWEoqFTVX+ffVo7/gcu8BUMS
 CJBdojKoOecSR8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22475139D0;
 Fri, 28 Jan 2022 08:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7s1kBtus82GmYwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Jan 2022 08:44:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 28 Jan 2022 09:44:09 +0100
Message-Id: <20220128084409.21708-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactoring setpgid03.c test using new LTP API
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

Removed TST_CHECKPOINT_INIT and replaced it with the .needs_checkpoints
LTP test feature. Simplified source code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/syscalls/setpgid/setpgid03.c | 183 ++++++------------
 .../kernel/syscalls/setpgid/setpgid03_child.c |  28 +--
 2 files changed, 61 insertions(+), 150 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 51e0eeb24..6972d6099 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -1,24 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Test to check the error and trivial conditions in setpgid system call
  *
  * EPERM   -  The calling process, process specified by pid and the target
@@ -28,136 +18,73 @@
  *            has performed exec()
  */
 
-#include <sys/wait.h>
-#include <limits.h>
-#include <signal.h>
-#include <errno.h>
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <unistd.h>
-#include "test.h"
+#include <sys/wait.h>
+#include "tst_test.h"
 
 #define TEST_APP "setpgid03_child"
 
-char *TCID = "setpgid03";
-int TST_TOTAL = 1;
-
-static void do_child(void);
-static void setup(void);
-static void cleanup(void);
+static void do_child(void)
+{
+	SAFE_SETSID();
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+}
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int child_pid;
+	pid_t child_pid;
 	int status;
-	int rval;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* Child is in new session we are not alowed to change pgid */
-		if ((child_pid = FORK_OR_VFORK()) == -1)
-			tst_brkm(TBROK, cleanup, "fork() failed");
-
-		if (child_pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0)
-				tst_brkm(TBROK, cleanup, "self_exec failed");
-#else
-			do_child();
-#endif
-		}
-
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
-		rval = setpgid(child_pid, getppid());
-		if (rval == -1 && errno == EPERM) {
-			tst_resm(TPASS, "setpgid failed with EPERM");
-		} else {
-			tst_resm(TFAIL,
-				"retval %d, errno %d, expected errno %d",
-				rval, errno, EPERM);
-		}
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-
-		if (wait(&status) < 0)
-			tst_resm(TFAIL | TERRNO, "wait() for child 1 failed");
-
-		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
-			tst_resm(TFAIL, "child 1 failed with status %d",
-				WEXITSTATUS(status));
-
-		/* Child after exec() we are no longer allowed to set pgid */
-		if ((child_pid = FORK_OR_VFORK()) == -1)
-			tst_resm(TFAIL, "Fork failed");
-
-		if (child_pid == 0) {
-			if (execlp(TEST_APP, TEST_APP, NULL) < 0)
-				perror("exec failed");
-
-			exit(127);
-		}
-
-		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
-		rval = setpgid(child_pid, getppid());
-		if (rval == -1 && errno == EACCES) {
-			tst_resm(TPASS, "setpgid failed with EACCES");
-		} else {
-			tst_resm(TFAIL,
-				"retval %d, errno %d, expected errno %d",
-				rval, errno, EACCES);
-		}
-		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
-
-		if (wait(&status) < 0)
-			tst_resm(TFAIL | TERRNO, "wait() for child 2 failed");
-
-		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
-			tst_resm(TFAIL, "child 2 failed with status %d",
-				WEXITSTATUS(status));
+
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		do_child();
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
+	TST_CHECKPOINT_WAIT(0);
 
-static void do_child(void)
-{
-	if (setsid() < 0) {
-		printf("CHILD: setsid() failed, errno: %d\n", errno);
-		exit(2);
-	}
+	TEST(setpgid(child_pid, getppid()));
+	if (TST_RET == -1 && TST_ERR == EPERM)
+		tst_res(TPASS, "setpgid failed with EPERM");
+	else
+		tst_res(TFAIL, "retval %ld, errno %s, expected EPERM", TST_RET,
+			tst_strerrno(TST_ERR));
 
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	TST_CHECKPOINT_WAKE(0);
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	if (wait(&status) < 0)
+		tst_res(TFAIL, "wait() for child 1 failed");
 
-	exit(0);
-}
+	if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
+		tst_res(TFAIL, "child 1 failed with status %d",
+			WEXITSTATUS(status));
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	/* child after exec() we are no longer allowed to set pgid */
+	child_pid = SAFE_FORK();
+	if (!child_pid)
+		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
 
-	tst_tmpdir();
+	TST_CHECKPOINT_WAIT(0);
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
+	TEST(setpgid(child_pid, getppid()));
+	if (TST_RET == -1 && TST_ERR == EACCES)
+		tst_res(TPASS, "setpgid failed with EACCES");
+	else
+		tst_res(TFAIL, "retval %ld, errno %s, expected EACCES", TST_RET,
+			tst_strerrno(TST_ERR));
 
-	umask(0);
+	TST_CHECKPOINT_WAKE(0);
 
-	TEST_PAUSE;
-}
+	if (wait(&status) < 0)
+		tst_res(TFAIL, "wait() for child 2 failed");
 
-static void cleanup(void)
-{
-	tst_rmdir();
+	if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
+		tst_res(TFAIL, "child 2 failed with status %d",
+			WEXITSTATUS(status));
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
index 2657422a6..fdb22f24d 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03_child.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
@@ -1,32 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-#include "test.h"
-
-char *TCID = "setpgid03_child";
-
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
 
 int main(void)
 {
-	TST_CHECKPOINT_INIT(NULL);
-
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	tst_reinit();
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	return 0;
 }
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

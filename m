Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9854C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:26:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22C1C3CA099
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 14:26:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 232153C93A9
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 14:26:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 83622601C79
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 14:26:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C13911F383;
 Wed, 16 Feb 2022 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645017999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+taj2GhVNTlROiYfP5pJheXfiINW7Zdh3x8CFlq2hUs=;
 b=ZjDxYEF8KcH8u5mfYZwVt6KAgIdfikVO+vtZ8Qy6+ssbUM6XWxK48FnI4jpNrn9yZ7pMNX
 Smj5QK95kimm1EjNl2RoNU7w43TFMPbopkhpCgUC6zw0BJJltPi/RJiEwn8vuUJhLxc1Kv
 DzHsl9JZOEb/u0WFAPfbdzmfjdPzA9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645017999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+taj2GhVNTlROiYfP5pJheXfiINW7Zdh3x8CFlq2hUs=;
 b=CagliObRYIKNlVMWAWL5TQAs0mvgI5E7BJ0HaJjF8XQPxrU4Js9yC4lpEeQ0scEVfkQ+p2
 VxkRK5HWTk7oJRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9944013B15;
 Wed, 16 Feb 2022 13:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xmtJI4/7DGKkbgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 16 Feb 2022 13:26:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 16 Feb 2022 14:26:32 +0100
Message-Id: <20220216132632.24615-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Refactoring setpgid03.c test using new LTP API
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
v3 has removed wait since it's handled by library and TST_EXP_FAIL is now used.

 testcases/kernel/syscalls/setpgid/setpgid03.c | 162 ++++--------------
 .../kernel/syscalls/setpgid/setpgid03_child.c |  28 +--
 2 files changed, 38 insertions(+), 152 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 51e0eeb24..da8a5c65c 100644
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
@@ -28,136 +18,48 @@
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
-
-int main(int ac, char **av)
+static void do_child(void)
 {
-	int child_pid;
-	int status;
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
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_SETSID();
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 }
 
-static void do_child(void)
+static void run(void)
 {
-	if (setsid() < 0) {
-		printf("CHILD: setsid() failed, errno: %d\n", errno);
-		exit(2);
-	}
+	pid_t child_pid;
 
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	child_pid = SAFE_FORK();
+	if (!child_pid) {
+		do_child();
+		return;
+	}
 
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 
-	exit(0);
-}
+	TST_EXP_FAIL(setpgid(child_pid, getppid()), EPERM);
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TST_CHECKPOINT_WAKE(0);
 
-	tst_tmpdir();
+	/* child after exec() we are no longer allowed to set pgid */
+	child_pid = SAFE_FORK();
+	if (!child_pid)
+		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
+	TST_CHECKPOINT_WAIT(0);
 
-	umask(0);
+	TST_EXP_FAIL(setpgid(child_pid, getppid()), EACCES);
 
-	TEST_PAUSE;
+	TST_CHECKPOINT_WAKE(0);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
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
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

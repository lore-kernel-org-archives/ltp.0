Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C40C636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 15:27:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 058203CBFA0
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 16:27:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F4A33CBFA0
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:27:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BAF31A0078A
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:27:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB09E1F7AB;
 Mon, 13 Feb 2023 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676302063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IqhShLNwtZ0irUrLc4xJSPo3L3VWQyDbR5RV0P0nU9o=;
 b=NM16fpnt+0e1dwNJAmQIahpfzCCQ8eThCoG2TVEEEyyc4jVR+NZDbNN2j723hG8FMrxzJM
 fDFkCmVgk0/cQrx4WPcjQ9BVcoXQc9+dU0zlzcgdeIZfUMEGzOp91ntdtyApPj6d/uOlgr
 3ZbyOi9jKXa1J8aS4lcVf3HcAzmGinU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B1F41391B;
 Mon, 13 Feb 2023 15:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dxTEFu9W6mOjIgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 13 Feb 2023 15:27:43 +0000
To: ltp@lists.linux.it
Date: Mon, 13 Feb 2023 16:25:40 +0100
Message-Id: <20230213152540.17916-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactor pidns10 using new LTP API
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
Using SAFE_CLONE
Using TST_EXP_* macros

 testcases/kernel/containers/pidns/pidns10.c | 128 +++++---------------
 1 file changed, 30 insertions(+), 98 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
index b38b9fd18..a35c73f5d 100644
--- a/testcases/kernel/containers/pidns/pidns10.c
+++ b/testcases/kernel/containers/pidns/pidns10.c
@@ -1,112 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
-* Copyright (c) International Business Machines Corp., 2007
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-***************************************************************************
-* File: pidns10.c
-* *
-* * Description:
-* *  The pidns10.c testcase verifies inside the container, if kill(-1, signal)
-* *  fails with ESRCH when there are no processes in container.
-* *
-* * Test Assertion & Strategy:
-* *  Create a PID namespace container.
-* *  Invoke kill(-1, SIGUSR1) inside container and check return code and error.
-* *  kill() should have failed;except swapper & init, no process is inside.
-* *
-* * Usage: <for command-line>
-* *  pidns10
-* *
-* * History:
-* *  DATE      NAME                             DESCRIPTION
-* *  13/11/08  Gowrishankar M 			Creation of this test.
-* *            <gowrishankar.m@in.ibm.com>
-*
-******************************************************************************/
-#define _GNU_SOURCE 1
-#include <sys/wait.h>
-#include <sys/types.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <errno.h>
-#include "pidns_helper.h"
-#include "test.h"
-
-char *TCID = "pidns10";
-int TST_TOTAL = 1;
+ * Copyright (C) International Business Machines Corp., 2008
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-int child_fn(void *);
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and check that killing subprocesses
+ * from child namespace will raise ESRCH error.
+ */
 
-#define CHILD_PID       1
-#define PARENT_PID      0
+#include "tst_test.h"
+#include "lapi/sched.h"
 
-/*
- * child_fn() - Inside container
- */
-int child_fn(void *arg)
+static void child_func(void)
 {
-	int exit_val, ret;
-	pid_t pid, ppid;
+	pid_t cpid = getpid();
+	pid_t ppid = getppid();
 
-	/* Set process id and parent pid */
-	pid = getpid();
-	ppid = getppid();
-	if (pid != CHILD_PID || ppid != PARENT_PID) {
-		printf("cinit: pidns was not created.\n");
-		return 1;
-	}
+	TST_EXP_EQ_LI(cpid, 1);
+	TST_EXP_EQ_LI(ppid, 0);
 
-	if ((ret = kill(-1, SIGUSR1)) == -1 && errno == ESRCH) {
-		printf("cinit: kill(-1, sig) failed with -1 / ESRCH as "
-		       "expected\n");
-		exit_val = 0;
-	} else {
-		printf("cinit: kill(-1, sig) didn't fail with -1 / ESRCH "
-		       "(%d); failed with %d / %d instead", ESRCH, ret, errno);
-		exit_val = 1;
-	}
-	exit(exit_val);
-}
+	tst_res(TINFO, "Trying to kill all subprocesses from within container");
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
+	TST_EXP_FAIL(kill(-1, SIGKILL), ESRCH);
 }
 
-int main(void)
+static void run(void)
 {
-	int status;
-	pid_t pid;
-
-	setup();
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 
-	pid = getpid();
-
-	/* Container creation on PID namespace */
-	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn, NULL));
-	if (TEST_RETURN == -1) {
-		tst_brkm(TBROK | TTERRNO, NULL, "clone failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func();
+		return;
 	}
-
-	sleep(1);
-	if (wait(&status) < 0)
-		tst_resm(TWARN, "parent: waitpid() failed.");
-
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_resm(TBROK, "container was terminated abnormally");
-
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

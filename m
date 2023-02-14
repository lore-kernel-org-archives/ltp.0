Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3618AC6379F
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 09:52:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081713CBF65
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 10:52:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B7B63CB0B8
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 10:52:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AD4E91A00914
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 10:52:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9917D21B19;
 Tue, 14 Feb 2023 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676368359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UjWwZCmQSCijuDa44yz/z4SJzzGTAI/PSIa+/VPFXrk=;
 b=jwYE/Qui4YGPVWHf5XoevZH0byNci1xyp9I5YDWkVtUGjAj9OltDlLTvskep36BHn2NVHt
 J/vXMuDR/cTzWeWhdzpepkYnhh3IAFS5sLTKPQhmuPaSh4AW8rvf6bdVMIH/dM0CixEr1J
 OK4tn/7UJGG7FTbfIekBhxKCiH4ALE8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6697C13A21;
 Tue, 14 Feb 2023 09:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /9BnFudZ62NuUAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 14 Feb 2023 09:52:39 +0000
To: ltp@lists.linux.it
Date: Tue, 14 Feb 2023 10:50:37 +0100
Message-Id: <20230214095037.21581-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Refactor pidns17 test using new LTP API
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
Use TST_EXP_* to check for signaled children

 testcases/kernel/containers/pidns/pidns17.c | 185 +++++---------------
 1 file changed, 46 insertions(+), 139 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index cf0c5826f..c517fa124 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -1,162 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
-* File: pidns17.c
-* *
-* * Description:
-* *  The pidns17.c testcase verifies inside the container, if kill(-1, SIGUSR1)
-* *  terminates all children running inside.
-* *
-* * Test Assertion & Strategy:
-* *  Create a PID namespace container.
-* *  Spawn many children inside it.
-* *  Invoke kill(-1, SIGUSR1) inside container and check if it terminates
-* *  all children.
-* *
-* * Usage: <for command-line>
-* *  pidns17
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
+ * Copyright (c) International Business Machines Corp., 2007
+ *               13/11/08  Gowrishankar M <gowrishankar.m@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-char *TCID = "pidns17";
-int TST_TOTAL = 1;
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and spawn many children inside the
+ * container. Then terminate all children and check if they were signaled.
+ */
 
-int child_fn(void *);
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "lapi/sched.h"
 
-#define CHILD_PID       1
-#define PARENT_PID      0
+#define CHILDREN_NUM 10
 
-/*
- * child_fn() - Inside container
- */
-int child_fn(void *arg)
+static void child_func(void)
 {
-	int children[10], exit_val, i, status;
-	pid_t pid, ppid;
+	int children[CHILDREN_NUM], status;
+	unsigned int i;
+	pid_t cpid, ppid;
 
-	/* Set process id and parent pid */
-	pid = getpid();
+	cpid = getpid();
 	ppid = getppid();
-	if (pid != CHILD_PID || ppid != PARENT_PID) {
-		printf("cinit: pidns was not created\n");
-		exit(1);
-	}
 
-	exit_val = 0;
+	TST_EXP_EQ_LI(cpid, 1);
+	TST_EXP_EQ_LI(ppid, 0);
+
+	tst_res(TINFO, "Spawning %d children", CHILDREN_NUM);
 
-	/* Spawn many children */
-	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		switch ((children[i] = fork())) {
-		case -1:
-			perror("fork failed");
-			exit_val = 1;
-			break;
-		case 0:
+	for (i = 0; i < CHILDREN_NUM; i++) {
+		children[i] = SAFE_FORK();
+		if (!children[i]) {
 			pause();
-			/* XXX (garrcoop): why exit with an exit code of 2? */
-			exit(2);
-			break;
-		default:
-			/* fork succeeded. */
-			break;
+			return;
 		}
 	}
-	/* wait for last child to get scheduled */
-	sleep(1);
 
-	if (kill(-1, SIGUSR1) == -1) {
-		perror("cinit: kill(-1, SIGUSR1) failed");
-		exit_val = 1;
-	}
+	tst_res(TINFO, "Terminate children with SIGUSR1");
 
-	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		if (waitpid(children[i], &status, 0) == -1) {
-			perror("cinit: waitpid failed");
-			kill(children[i], SIGTERM);
-			waitpid(children[i], &status, 0);
-			exit_val = 1;
-		}
-		if (!(WIFSIGNALED(status) || WTERMSIG(status) == SIGUSR1)) {
-			/*
-			 * XXX (garrcoop): this status reporting is overly
-			 * noisy. Someone obviously needs to read the
-			 * constraints documented in wait(2) a bit more
-			 * closely -- in particular the relationship between
-			 * WIFEXITED and WEXITSTATUS, and WIFSIGNALED and
-			 * WTERMSIG.
-			 */
-			printf("cinit: found a child alive still "
-			       "%d exit: %d, %d, signal %d, %d", i,
-			       WIFEXITED(status), WEXITSTATUS(status),
-			       WIFSIGNALED(status), WTERMSIG(status));
-			exit_val = 1;
-		}
-	}
-	if (exit_val == 0)
-		printf("cinit: all children have terminated.\n");
+	SAFE_KILL(-1, SIGUSR1);
 
-	exit(exit_val);
-}
+	for (i = 0; i < CHILDREN_NUM; i++) {
+		SAFE_WAITPID(children[i], &status, 0);
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
+		TST_EXP_EQ_LI(WIFSIGNALED(status), 1);
+		TST_EXP_EQ_LI(WTERMSIG(status), SIGUSR1);
+	}
 }
 
-int main(void)
+static void run(void)
 {
-	int status;
-	pid_t pid;
-
-	setup();
-
-	pid = getpid();
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 
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
-	if (wait(&status) == -1)
-		tst_resm(TFAIL, "waitpid failed");
-
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_resm(TFAIL, "container exited abnormally");
-	else if (WIFSIGNALED(status))
-		tst_resm(TFAIL,
-			 "container was signaled with signal = %d",
-			 WTERMSIG(status));
-
-	tst_exit();
-
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

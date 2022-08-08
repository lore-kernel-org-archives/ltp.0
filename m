Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1F4C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 14:17:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E5703C959E
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 16:17:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 847C33C9453
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 16:17:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC573140074A
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 16:17:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 728DB1F952;
 Mon,  8 Aug 2022 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1659968234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RskHPHLhNn82QzDDODdg3JDaW4mVYvIiHH/8bdTf+U0=;
 b=XPyHLmjrZ6ctNaAvzSyKGV0uQXJFU1UNgTz717ICAseWyVDqtbvfFJkHf1DUMM6hEnSFzP
 GiTrz0YDGRiI7sWXCXUgn36Sdgo3cfWYHTJANVz3tsh3WdpIY+O1jABUUa7G2c9NPWxecZ
 6dDLVzHZvws75lrYF3LvHyOZn0v6fWc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E01613AB3;
 Mon,  8 Aug 2022 14:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aKFlDOoa8WJ+ewAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 08 Aug 2022 14:17:14 +0000
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 16:16:32 +0200
Message-Id: <20220808141632.10056-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor pidns17 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns17.c | 189 ++++++--------------
 1 file changed, 51 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index cf0c5826f..1d3dd53bb 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -1,162 +1,75 @@
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
+ * container. Then terminate all children and check if they ended up.
+ */
 
-int child_fn(void *);
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
-#define CHILD_PID       1
-#define PARENT_PID      0
+#define CHILDREN_NUM 10
 
-/*
- * child_fn() - Inside container
- */
-int child_fn(void *arg)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	int children[10], exit_val, i, status;
-	pid_t pid, ppid;
+	int children[CHILDREN_NUM], status;
+	unsigned int i, counter = 0;
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
+	if (cpid != 1 || ppid != 0) {
+		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
+		return 1;
+	}
 
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
+			return 0;
 		}
 	}
-	/* wait for last child to get scheduled */
-	sleep(1);
 
-	if (kill(-1, SIGUSR1) == -1) {
-		perror("cinit: kill(-1, SIGUSR1) failed");
-		exit_val = 1;
+	SAFE_KILL(-1, SIGUSR1);
+
+	for (i = 0; i < CHILDREN_NUM; i++) {
+		SAFE_WAITPID(children[i], &status, 0);
+
+		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGUSR1)
+			counter++;
 	}
 
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
+	if (counter != CHILDREN_NUM) {
+		tst_res(TFAIL, "%d children didn't end", CHILDREN_NUM - counter);
+		return 1;
 	}
-	if (exit_val == 0)
-		printf("cinit: all children have terminated.\n");
 
-	exit(exit_val);
-}
+	tst_res(TPASS, "All children ended successfuly");
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
+	return 0;
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
-
-	/* Container creation on PID namespace */
-	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn, NULL));
-	if (TEST_RETURN == -1) {
-		tst_brkm(TBROK | TTERRNO, NULL, "clone failed");
-	}
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
+	int ret;
 
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
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

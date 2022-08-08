Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5052C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 08:15:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A3C13C943B
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 10:15:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2E013C0895
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 10:15:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 617E61A003F1
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 10:15:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 48A2120DDD;
 Mon,  8 Aug 2022 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1659946541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhX8ZNOlebOcjjGxxG+t0qDQuI8dc5HuNgTTU9BUjhU=;
 b=CsPYrIKdVwdQFCMAr8pUpdxgn7MFCHJ/BBvS9o9tOwtR8xOkwlx89xZCshhuQkzsH9Qzsc
 MQ8QBbmNSC50JQ9RTbnTH0+6oS/Z2clx7OC+GydQeKZUD//pHua9DR83owt/t2DZb54JhJ
 PTGbeBNvdn02rv7DDFsdGTrSK7zpYxg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0851F13A7C;
 Mon,  8 Aug 2022 08:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YqAIOyzG8GJWSgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 08 Aug 2022 08:15:40 +0000
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 10:15:01 +0200
Message-Id: <20220808081501.21395-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor pidns12 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns12.c | 184 +++++---------------
 1 file changed, 43 insertions(+), 141 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index 5fb13d2a6..1b2e09c15 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -1,169 +1,71 @@
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
-* File: pidns12.c
-* *
-* * Description:
-* *  The pidns12.c testcase verifies that siginfo->si_pid is set to 0
-* *  if sender (parent process) is not in receiver's namespace.
-* *
-* * Test Assertion & Strategy:
-* *  Create a PID namespace container.
-* *  Initialise signal handler for SIGUSR1 in container.
-* *  Let parent send SIGUSR1 to container.
-* *  Check if sender pid is set to 0 from signal info.
-* *
-* * Usage: <for command-line>
-* *  pidns12
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
-#include <signal.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdio.h>
-#include "pidns_helper.h"
-#include "test.h"
+ * Copyright (c) International Business Machines Corp., 2007
+ *               13/11/08  Gowrishankar M <gowrishankar.m@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-char *TCID = "pidns12";
-int TST_TOTAL = 1;
-int pipefd[2];
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and verifies that siginfo->si_pid is
+ * set to 0 if sender (parent process) is not in the receiver's namespace.
+ */
 
-#define CHILD_PID       1
-#define PARENT_PID      0
+#define _GNU_SOURCE 1
+#include <signal.h>
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
-/*
- * child_signal_handler() - dummy function for sigaction()
- */
-static void child_signal_handler(int sig, siginfo_t * si, void *unused)
+static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
 {
-	/* Recieved SIGUSR1. Check sender pid */
 	if (si->si_pid == 0)
-		tst_resm(TPASS, "cinit: signalling PID (from other namespace)"
-			 " is 0 as expected");
+		tst_res(TPASS, "signalling PID (from other namespace) is 0 as expected");
 	else
-		tst_resm(TFAIL, "cinit: signalling PID (from other namespace)"
-			 " is not 0, but %d.", si->si_pid);
+		tst_res(TFAIL, "signalling PID (from other namespace) is not 0, but %d.", si->si_pid);
 }
 
-/*
- * child_fn() - Inside container
- */
-int child_fn(void *arg)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	struct sigaction sa;
-	pid_t pid, ppid;
+	pid_t cpid, ppid;
 
-	/* Set process id and parent pid */
-	pid = getpid();
+	cpid = getpid();
 	ppid = getppid();
-	if (pid != CHILD_PID || ppid != PARENT_PID) {
-		tst_resm(TBROK, "cinit: pidns is not created.");
-	}
 
-	/* Close read end of pipe */
-	close(pipefd[0]);
+	if (cpid != 1 || ppid != 0) {
+		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
+		return 1;
+	}
 
-	/* Set signal handler for SIGUSR1 */
 	sa.sa_flags = SA_SIGINFO;
-	sigfillset(&sa.sa_mask);
+	SAFE_SIGFILLSET(&sa.sa_mask);
 	sa.sa_sigaction = child_signal_handler;
-	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
-		tst_resm(TBROK, "cinit: sigaction() failed(%s).",
-			 strerror(errno));
-	}
-
-	/* Let parent to signal SIGUSR1 */
-	if (write(pipefd[1], "c:go\0", 5) != 5) {
-		tst_resm(TBROK, "cinit: pipe is broken to write");
-	}
-
-	sleep(3);
 
-	/* cleanup and exit */
-	close(pipefd[1]);
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
 
-	/* Control won't reach below */
-	exit(0);
-}
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
+	return 0;
 }
 
-/***********************************************************************
-*   M A I N
-***********************************************************************/
-
-int main(void)
+static void run(void)
 {
-	int status;
-	pid_t pid, cpid;
-	char buf[5];
-
-	setup();
-
-	pid = getpid();
-	tst_resm(TINFO, "parent: PID is %d", pid);
-
-	/* Create pipe for intercommunication */
-	if (pipe(pipefd) == -1) {
-		tst_resm(TBROK, "parent: pipe() failed. aborting!");
-	}
-
-	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
-	if (cpid < 0) {
-		tst_resm(TBROK, "parent: clone() failed(%s).", strerror(errno));
-	}
-
-	/* Close write end of pipe */
-	close(pipefd[1]);
-
-	/* Check if container is ready */
-	read(pipefd[0], buf, 5);
-	if (strcmp(buf, "c:go") != 0) {
-		tst_resm(TBROK, "parent: container did not respond!");
-	}
+	int ret;
 
-	/* Send SIGUSR1 to container init */
-	if (kill(cpid, SIGUSR1) == -1) {
-		tst_resm(TBROK, "parent: kill() failed(%s).", strerror(errno));
-	}
-
-	if (waitpid(cpid, &status, 0) < 0)
-		tst_resm(TWARN, "parent: waitpid() failed(%s).",
-			 strerror(errno));
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
 
-	if (WIFSIGNALED(status) && WTERMSIG(status))
-		tst_resm(TBROK, "child is terminated by signal(%s)",
-			 strsignal(WTERMSIG(status)));
+	TST_CHECKPOINT_WAIT(0);
 
-	/* Cleanup and exit */
-	close(pipefd[0]);
-
-	/* Control won't reach below */
-	exit(0);
+	SAFE_KILL(ret, SIGUSR1);
 
+	TST_CHECKPOINT_WAKE(0);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

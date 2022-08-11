Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2005BC19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 11:30:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E8AC3C9650
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:30:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E81C13C954A
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:30:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D433210005B4
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:30:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82D5A5C443;
 Thu, 11 Aug 2022 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1660217430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NF6rwCHfzna40bvLaT0wv/WgRZzSIzVy8jkWvFzfHQo=;
 b=X6f7xgJ+1cEg1sSQhgF6Ad0De2ltSdDiIXQMgXnrMzYDvnTV9CkLoful6jVJFH5bo5vW9I
 GSlnvE8okoKQxtctaweKYg5fY30zja3ZQuOdBG6hB4MhWAVuNxfjEZF1Jw5woJ3i9zqUm7
 pDdYL+eIaf+IElj9LTP09FZUwMvyC8I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 566B41342A;
 Thu, 11 Aug 2022 11:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Fo/mD1bo9GIlKwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 11 Aug 2022 11:30:30 +0000
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 13:29:52 +0200
Message-Id: <20220811112952.7480-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactor pidns20 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns20.c | 234 +++++---------------
 1 file changed, 59 insertions(+), 175 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index ec2c66bd3..f308eaa11 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -1,207 +1,91 @@
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
-* File: pidns20.c
-* *
-* * Description:
-* *  The pidns20.c testcase verifies that signal handler of SIGUSR1 is called
-* *  (and cinit is NOT terminated) when:
-* *    - container-init blocks SIGUSR1,
-* *    - parent queues SIGUSR1 and
-* *    - a handler is specified for SIGUSR1 before it is unblocked.
-* *
-* * Test Assertion & Strategy:
-* *  Create a PID namespace container.
-* *  Block SIGUSR1 signal inside it.
-* *  Let parent to deliver SIGUSR1 signal to container.
-* *  Redefine SIGUSR1 handler of cinit to user function.
-* *  Unblock SIGUSR1 from blocked queue.
-* *  Check if user function is called.
-* *
-* * Usage: <for command-line>
-* *  pidns20
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
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdio.h>
-#include "pidns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
+ * Copyright (c) International Business Machines Corp., 2007
+ *               13/11/08  Gowrishankar M  <gowrishankar.m@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-char *TCID = "pidns20";
-int TST_TOTAL = 1;
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag, block SIGUSR1 signal before sending
+ * it from parent and check if it's received once SIGUSR1 signal is unblocked.
+ */
 
-int parent_cinit[2];
-int cinit_parent[2];
-int broken = 1;			/* broken should be 0 when test completes properly */
+#define _GNU_SOURCE 1
+#include <signal.h>
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
-#define CHILD_PID       1
-#define PARENT_PID      0
+static int signals;
+static int last_signo;
 
-/*
- * child_signal_handler() - to handle SIGUSR1
- */
-static void child_signal_handler(int sig, siginfo_t * si, void *unused)
+static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
 {
-	if (si->si_signo != SIGUSR1)
-		tst_resm(TBROK, "cinit: received %s unexpectedly!",
-			 strsignal(si->si_signo));
-	else
-		tst_resm(TPASS, "cinit: user function is called as expected");
-
-	/* Disable broken flag */
-	broken = 0;
+	last_signo = si->si_signo;
+	signals++;
 }
 
-/*
- * child_fn() - Inside container
- */
-int child_fn(void *arg)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	pid_t pid, ppid;
-	sigset_t newset;
 	struct sigaction sa;
-	char buf[5];
+	sigset_t newset;
+	pid_t cpid, ppid;
 
-	/* Setup pipe read and write ends */
-	pid = getpid();
+	cpid = getpid();
 	ppid = getppid();
 
-	if (pid != CHILD_PID || ppid != PARENT_PID) {
-		printf("cinit: pidns was not created properly\n");
-		exit(1);
-	}
-
-	/* Setup pipes to communicate with parent */
-	close(cinit_parent[0]);
-	close(parent_cinit[1]);
-
-	/* Block SIGUSR1 signal */
-	sigemptyset(&newset);
-	sigaddset(&newset, SIGUSR1);
-	if (sigprocmask(SIG_BLOCK, &newset, 0) == -1) {
-		perror("cinit: sigprocmask() failed");
-		exit(1);
+	if (cpid != 1 || ppid != 0) {
+		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
+		return 0;
 	}
-	tst_resm(TINFO, "cinit: blocked SIGUSR1");
 
-	/* Let parent to queue SIGUSR1 in pending */
-	if (write(cinit_parent[1], "c:go", 5) != 5) {
-		perror("cinit: pipe is broken to write");
-		exit(1);
-	}
+	SAFE_SIGEMPTYSET(&newset);
+	SAFE_SIGADDSET(&newset, SIGUSR1);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &newset, 0);
 
-	/* Check if parent has queued up SIGUSR1 */
-	read(parent_cinit[0], buf, 5);
-	if (strcmp(buf, "p:go") != 0) {
-		printf("cinit: parent did not respond!\n");
-		exit(1);
-	}
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
-	/* Now redefine handler for SIGUSR1 */
 	sa.sa_flags = SA_SIGINFO;
-	sigfillset(&sa.sa_mask);
+	SAFE_SIGFILLSET(&sa.sa_mask);
 	sa.sa_sigaction = child_signal_handler;
-	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
-		perror("cinit: sigaction failed");
-		exit(1);
-	}
-
-	/* Unblock traffic on SIGUSR1 queue */
-	tst_resm(TINFO, "cinit: unblocking SIGUSR1");
-	sigprocmask(SIG_UNBLOCK, &newset, 0);
 
-	/* Check if new handler is called */
-	if (broken == 1) {
-		printf("cinit: broken flag didn't change\n");
-		exit(1);
-	}
-
-	/* Cleanup and exit */
-	close(cinit_parent[1]);
-	close(parent_cinit[0]);
-	exit(0);
-}
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
-}
-
-int main(void)
-{
-	int status;
-	char buf[5];
-	pid_t cpid;
+	SAFE_SIGPROCMASK(SIG_UNBLOCK, &newset, 0);
 
-	setup();
-
-	/* Create pipes for intercommunication */
-	if (pipe(parent_cinit) == -1 || pipe(cinit_parent) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
+	if (signals != 1) {
+		tst_res(TFAIL, "Received %d signals", signals);
+		return 0;
 	}
 
-	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
-	if (cpid == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "clone failed");
+	if (last_signo != SIGUSR1) {
+		tst_res(TFAIL, "Received %s signal", tst_strsig(last_signo));
+		return 0;
 	}
 
-	/* Setup pipe read and write ends */
-	close(cinit_parent[1]);
-	close(parent_cinit[0]);
+	tst_res(TPASS, "Received SIGUSR1 signal after unblock");
 
-	/* Is container ready */
-	read(cinit_parent[0], buf, 5);
-	if (strcmp(buf, "c:go") != 0) {
-		tst_brkm(TBROK, NULL, "parent: container did not respond!");
-	}
+	return 0;
+}
+
+static void run(void)
+{
+	int ret;
 
-	/* Enqueue SIGUSR1 in pending signal queue of container */
-	SAFE_KILL(NULL, cpid, SIGUSR1);
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
 
-	tst_resm(TINFO, "parent: signalled SIGUSR1 to container");
-	if (write(parent_cinit[1], "p:go", 5) != 5) {
-		tst_brkm(TBROK | TERRNO, NULL, "write failed");
-	}
+	TST_CHECKPOINT_WAIT(0);
 
-	/* collect exit status of child */
-	SAFE_WAIT(NULL, &status);
-
-	if (WIFSIGNALED(status)) {
-		if (WTERMSIG(status) == SIGUSR1)
-			tst_resm(TFAIL,
-				 "user function was not called inside cinit");
-		else
-			tst_resm(TBROK,
-				 "cinit was terminated by %d",
-				 WTERMSIG(status));
-	}
+	SAFE_KILL(ret, SIGUSR1);
 
-	/* Cleanup and exit */
-	close(parent_cinit[1]);
-	close(cinit_parent[0]);
-	tst_exit();
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

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB22AC00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 12:51:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 456483C9482
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 14:51:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1D3B3C712D
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:51:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D660F200747
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:51:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD0141F952;
 Mon,  8 Aug 2022 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1659963067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6BeTs5Ci54YcVywd2ooUvr4b+M1bD2+pgeO8rlIMsck=;
 b=XDgpFnJAWa8ws87ABUi9tO84QhZDQynh6fdNFVC4KyrK938z1gZFOXkCfg5+fjcmJwlNsT
 6vcJM22p0W/izScgOExDBEA7nMxWSTk6d6kj3JBd1lK7D6ng9DltBAUxUNqhdioLWU3do4
 eBBUODO41qDM0fMCnn05fw/P054+pac=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D03513A7C;
 Mon,  8 Aug 2022 12:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 913lI7sG8WJQUQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 08 Aug 2022 12:51:07 +0000
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 14:50:25 +0200
Message-Id: <20220808125025.15167-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor pidns16 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns16.c | 183 +++++++-------------
 1 file changed, 61 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 2ee61065a..e80b4c438 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -1,157 +1,96 @@
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
-
-* * Test Assertion.
-* *----------------
-* * kill -USR1 container_init
-* *	- from the parent process and also inside a container
-* *	- Where init has defined a custom handler for USR1
-* *	- Should call the handler and
-* *	- Verify whether the signal handler is called from the proper process.
-* *
-* * Description:
-* *  Create PID namespace container.
-* *  Container init defines the handler for SIGUSR1 and waits indefinetly.
-* *  Parent sends SIGUSR1 to container init.
-* *  The signal handler is handled and the cont-init resumes normally.
-* *  From the container, again the signal SIGUSR1 is sent.
-* *  In the sig-handler check if it's invoked from correct pid(parent/container)
-* *  If cont-init wakes up properly -
-* *  it will return expected value at exit which is verified at the end.
-* *
-* * History:
-* *  DATE	  NAME				   DESCRIPTION
-* *  04/11/08  Veerendra C  <vechandr@in.ibm.com> Verifying cont init kill -USR1
-*
-*******************************************************************************/
-#include "config.h"
+ * Copyright (c) International Business Machines Corp., 2007
+ *               04/11/08  Veerendra C  <vechandr@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and verifies that siginfo->si_pid is
+ * set to 0 if sender (parent process) sent the signal. Then send signal from
+ * container itself and check if siginfo->si_pid is set to 1.
+ */
 
 #define _GNU_SOURCE 1
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/wait.h>
-#include <sys/types.h>
 #include <signal.h>
-#include <unistd.h>
-#include "pidns_helper.h"
-#include "test.h"
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
-#define CHILD_PID	1
-#define PARENT_PID	0
+static int counter;
 
-char *TCID = "pidns16";
-int TST_TOTAL = 3;
-
-void child_signal_handler(int sig, siginfo_t * si, void *unused)
+static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
 {
-	static int c = 1;
-	pid_t expected_pid;
-
-	/* Verifying from which process the signal handler is signalled */
+	pid_t exp_pid;
 
-	switch (c) {
-	case 1:
-		expected_pid = PARENT_PID;
+	switch (counter) {
+	case 0:
+		exp_pid = 0;
 		break;
-	case 2:
-		expected_pid = CHILD_PID;
+	case 1:
+		exp_pid = 1;
 		break;
 	default:
-		tst_resm(TBROK, "child should NOT be signalled 3+ times");
+		tst_brk(TBROK, "Child should NOT be signalled 3+ times");
 		return;
 	}
 
-	if (si->si_pid == expected_pid)
-		tst_resm(TPASS, "child is signalled from expected pid %d",
-			 expected_pid);
+	if (si->si_pid == exp_pid)
+		tst_res(TPASS, "Signalling PID is %d as expected", exp_pid);
 	else
-		tst_resm(TFAIL, "child is signalled from unexpected pid %d,"
-			 " expecting pid %d", si->si_pid, expected_pid);
+		tst_res(TFAIL, "Signalling PID is not %d, but %d", exp_pid, si->si_pid);
 
-	c++;
+	counter++;
 }
 
-/*
- * child_fn() - Inside container
- */
-int child_fn(void *ttype)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	struct sigaction sa;
-	pid_t pid, ppid;
+	pid_t cpid, ppid;
 
-	/* Set process id and parent pid */
-	pid = getpid();
+	cpid = getpid();
 	ppid = getppid();
 
-	if ((pid != CHILD_PID) || (ppid != PARENT_PID))
-		tst_resm(TBROK, "pidns is not created.");
+	if (cpid != 1 || ppid != 0) {
+		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
+		return 1;
+	}
 
-	/* Set signal handler for SIGUSR1, also mask other signals */
 	sa.sa_flags = SA_SIGINFO;
-	sigemptyset(&sa.sa_mask);
+	SAFE_SIGFILLSET(&sa.sa_mask);
 	sa.sa_sigaction = child_signal_handler;
-	if (sigaction(SIGUSR1, &sa, NULL) == -1)
-		tst_resm(TBROK, "%d: sigaction() failed", pid);
-
-	pause();
-	tst_resm(TINFO, "Container: Resumed after receiving SIGUSR1 "
-		 "from parentNS ");
-	if (kill(pid, SIGUSR1) != 0) {
-		tst_resm(TFAIL, "kill(SIGUSR1) fails.");
-	}
-	tst_resm(TINFO, "Container: Resumed after sending SIGUSR1 "
-		 "from container itself");
-	_exit(10);
-}
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
+	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	tst_res(TINFO, "Container: Resumed after receiving SIGUSR1 from parent namespace");
+
+	SAFE_KILL(cpid, SIGUSR1);
+
+	tst_res(TINFO, "Container: Resumed after sending SIGUSR1 from container itself");
+
+	return 0;
 }
 
-/***********************************************************************
-*   M A I N
-***********************************************************************/
-int main()
+static void run(void)
 {
-	int status;
-	pid_t cpid;
+	int ret;
 
-	setup();
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
 
-	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
+	TST_CHECKPOINT_WAIT(0);
 
-	if (cpid < 0) {
-		tst_resm(TBROK, "clone() failed.");
-	}
-
-	sleep(1);
-	if (kill(cpid, SIGUSR1) != 0) {
-		tst_resm(TFAIL, "kill(SIGUSR1) fails.");
-	}
-	sleep(1);
-	if (waitpid(cpid, &status, 0) < 0)
-		tst_resm(TWARN, "waitpid() failed.");
+	SAFE_KILL(ret, SIGUSR1);
 
-	if ((WIFEXITED(status)) && (WEXITSTATUS(status) == 10))
-		tst_resm(TPASS, "container init continued successfuly, "
-			 "after handling signal -USR1");
-	else
-		tst_resm(TFAIL, "c-init failed to continue after "
-			 "passing kill -USR1");
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

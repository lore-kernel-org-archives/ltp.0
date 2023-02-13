Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA8C636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 15:26:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD71A3CBF94
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 16:26:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB8E03C1D84
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:25:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C58F51A006E8
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:25:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C82B71F45B;
 Mon, 13 Feb 2023 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676301949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IS4tLi5qq5iGtcPye1ZbnV6YIsKnR2cLW10TfRmjoDI=;
 b=dYy0vXBiyLrt6m2s3LEbD80MhkiGsctodw9YT+FjBNeuFn5HdfbqmNvi1IweT/xhIxJYVi
 3V+KGUHJh/fuDD/C/BDX2+2SMljLpagjvynGa4QrefSKYLg30iWYJbRme5Wv8hVg/zLiye
 Wd5iFpcCA5buFTTpgAr1jEUPg+AjDaE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B49011391B;
 Mon, 13 Feb 2023 15:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NrMVI3hW6mOeIQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 13 Feb 2023 15:25:44 +0000
To: ltp@lists.linux.it
Date: Mon, 13 Feb 2023 16:23:37 +0100
Message-Id: <20230213152337.17075-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Refactor pidns06 test using new LTP API
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

 testcases/kernel/containers/pidns/pidns06.c | 148 ++++----------------
 1 file changed, 30 insertions(+), 118 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index d6623941a..ed440f043 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -1,133 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
-* Copyright (c) International Business Machines Corp., 2008
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-* This program is distributed in the hope that it will be useful
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-
-*************************************************************************
-* Description:
-*  Testcase tries killing of the parent namespace pid by the container-init.
-*  It also tries killing of non-existent PID, by the container-init.
-*  Returns Success if Unable to kill, and proper error number is set.
-*  else Returns Failure
-*
-* Steps:
-* 1. Parent process clone a process with flag CLONE_NEWPID
-* 2. The pid of the parent namespace is passed to the container.
-* 3. Container receieves the PID and passes SIGKILL to this PID.
-* 4. If kill() is unsuccessful and the errno is set to 'No Such process'
-*	then sets PASS
-*    else,
-*	sets FAIL
-* 5. It also verifies by passing SIGKILL to FAKE_PID
-* 6. If kill() is unsuccessful and the errno is set to 'No Such process'
-*	then sets PASS
-*    else,
-*	sets FAIL
-*
-*******************************************************************************/
-#define _GNU_SOURCE 1
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/wait.h>
-#include <assert.h>
-#include <unistd.h>
-#include <errno.h>
-#include <signal.h>
-#include "pidns_helper.h"
-#include "test.h"
+ * Copyright (C) International Business Machines Corp., 2008
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-#define CINIT_PID       1
-#define PARENT_PID      0
-#define FAKE_PID	-1
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and check that parent process can't
+ * be killed from child namespace.
+ */
 
-char *TCID = "pidns06";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "lapi/sched.h"
 
-/*
- * kill_pid_in_childfun()
- *      Cont-init tries to kill the parent-process using parent's global Pid.
- *	Also checks passing SIGKILL to non existent PID in the container.
- */
-static int kill_pid_in_childfun(void *vtest)
+static void child_func(int pid)
 {
-	int cpid, ppid, *par_pid;
-	int ret = 0;
-	cpid = getpid();
-	ppid = getppid();
-	par_pid = (int *)vtest;
+	pid_t cpid = getpid();
+	pid_t ppid = getppid();
 
-	/* Checking the values to make sure pidns is created correctly */
-	if (cpid != CINIT_PID || ppid != PARENT_PID) {
-		printf("Unexpected result for Container: init "
-		       "pid=%d ppid=%d\n", cpid, ppid);
-		exit(1);
-	}
+	TST_EXP_EQ_LI(cpid, 1);
+	TST_EXP_EQ_LI(ppid, 0);
 
-	/*
-	 * While trying kill() of the pid of the parent namespace..
-	 * Check to see if the errno was set to the expected, value of 3 : ESRCH
-	 */
-	ret = kill(*par_pid, SIGKILL);
-	if (ret == -1 && errno == ESRCH) {
-		printf("Container: killing parent pid=%d failed as expected "
-		       "with ESRCH\n", *par_pid);
-	} else {
-		printf("Container: killing parent pid=%d, didn't fail as "
-		       "expected with ESRCH (%d) and a return value of -1. Got "
-		       "%d (\"%s\") and a return value of %d instead.\n",
-		       *par_pid, ESRCH, errno, strerror(errno), ret);
-		exit(1);
-	}
-	/*
-	 * While killing non-existent pid in the container,
-	 * Check to see if the errno was set to the expected, value of 3 : ESRCH
-	 */
-	ret = kill(FAKE_PID, SIGKILL);
-	if (ret == -1 && errno == ESRCH) {
-		printf("Container: killing non-existent pid failed as expected "
-		       "with ESRCH\n");
-	} else {
-		printf("Container: killing non-existent pid, didn't fail as "
-		       "expected with ESRCH (%d) and a return value of -1. Got "
-		       "%d (\"%s\") and a return value of %d instead.\n",
-		       ESRCH, errno, strerror(errno), ret);
-		exit(1);
-	}
+	tst_res(TINFO, "Trying to kill parent from within container");
 
-	exit(0);
+	TST_EXP_FAIL(kill(pid, SIGKILL), ESRCH);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
-	check_newpid();
-}
-
-int main(void)
-{
-	int status;
-
-	setup();
-
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
 	pid_t pid = getpid();
 
-	tst_resm(TINFO, "Parent: Passing the pid of the process %d", pid);
-	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, kill_pid_in_childfun,
-				   (void *)&pid));
-	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
-	} else if (wait(&status) == -1) {
-		tst_brkm(TFAIL | TERRNO, NULL, "wait failed");
+	if (!SAFE_CLONE(&args)) {
+		child_func(pid);
+		return;
 	}
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

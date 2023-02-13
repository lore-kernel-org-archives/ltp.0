Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEADC636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 15:23:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04C443CBFA6
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 16:23:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A29983C1D84
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:22:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99ED2200059
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:22:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF50D1F38D;
 Mon, 13 Feb 2023 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676301774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=purlXo6M0p9jKp5xxR0gU92RJhLr/8xGfOML8SSd/os=;
 b=oDQxHMYjScZyyWRgv+6Q4mp0wTm6yygNHbthReaOu7uXUcsiWVRxcFnoaRgxYrgRgnU0lm
 mMz3qj+xiMVajI9icfahIRCcvrWJx+EK2AxmmjAHlGQOoIJPUBclbJ4SDt+mzVM0mtffD4
 7/qO1bh30Fexxnyg8UvU3rQZHpkDPPk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE01A1391B;
 Mon, 13 Feb 2023 15:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ddeMJsdV6mMnIAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 13 Feb 2023 15:22:47 +0000
To: ltp@lists.linux.it
Date: Mon, 13 Feb 2023 16:20:37 +0100
Message-Id: <20230213152037.16285-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Refactor pidns04 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns04.c | 172 +++++---------------
 1 file changed, 38 insertions(+), 134 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index 9ac0e5aca..de4b736d6 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -1,150 +1,54 @@
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
+ * Copyright (C) International Business Machines Corp., 2008
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-* File: pidns04.c
-*
-* Description:
-*  The pidns04.c testcase builds into the ltp framework to verify
-*  the basic functionality of PID Namespace.
-*
-* Verify that:
-* 1. When parent clone a process with flag CLONE_NEWPID, the process ID of
-* child should be one.
-*
-* 2. When parent clone a process with flag CLONE_NEWPID, the parent process ID
-* of should be zero.
-*
-* 3. The container init process (one), should not get killed by the SIGKILL in
-* the childNS
-*
-* Total Tests:
-*
-* Test Name: pidns04
-*
-* Test Assertion & Strategy:
-*
-* From main() clone a new child process with passing the clone_flag as
-* CLONE_NEWPID.
-* The container init, should not get killed by the SIGKILL inside the child NS.
-* Usage: <for command-line>
-* pidns04
-*
-* History:
-*
-* FLAG DATE     	NAME	   			DESCRIPTION
-* 08/10/08      Veerendra C <vechandr@in.ibm.com> Verifies killing of cont init.
-*
-*******************************************************************************/
-#define _GNU_SOURCE 1
-#include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#define CLEANUP cleanup
-#include "pidns_helper.h"
-#include "test.h"
-
-#define INIT_PID	1
-#define CHILD_PID       1
-#define PARENT_PID      0
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and check that child container does
+ * not get kill itself with SIGKILL.
+ */
 
-char *TCID = "pidns04";
-int TST_TOTAL = 1;
-int fd[2];
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "lapi/sched.h"
 
-/*
- * child_fn1() - Inside container
-*/
-static int child_fn1(void *ttype)
+static void child_func(void)
 {
-	int exit_val;
-	pid_t cpid, ppid;
-	cpid = getpid();
-	ppid = getppid();
-	char mesg[] = "I was not killed !";
-	/* Child process closes up read side of pipe */
-	close(fd[0]);
+	pid_t cpid = getpid();
+	pid_t ppid = getppid();
 
-	/* Comparing the values to make sure pidns is created correctly */
-	if ((cpid == CHILD_PID) && (ppid == PARENT_PID)) {
-		printf("PIDNS test is running inside container\n");
-		kill(INIT_PID, SIGKILL);
-		/* Verifying whether the container init is not killed, "
-		   If so writing into the pipe created in the parent NS" */
+	TST_EXP_EQ_LI(cpid, 1);
+	TST_EXP_EQ_LI(ppid, 0);
 
-		/* Send "mesg" through the write side of pipe */
-		write(fd[1], mesg, (strlen(mesg) + 1));
-		exit_val = 0;
-	} else {
-		printf("got unexpected result of cpid=%d ppid=%d\n",
-		       cpid, ppid);
-		exit_val = 1;
-	}
-	exit(exit_val);
-}
+	tst_res(TINFO, "Trying to kill container from within container");
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
+	SAFE_KILL(1, SIGKILL);
+
+	tst_res(TINFO, "Container is up and running");
 }
 
-int main(void)
+static void run(void)
 {
-	int nbytes, status;
-	char readbuffer[80];
-
-	setup();
-
-	pipe(fd);
-	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn1, NULL));
-	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TTERRNO, CLEANUP, "clone failed");
-	} else if (wait(&status) == -1) {
-		tst_brkm(TFAIL | TERRNO, CLEANUP, "wait failed");
-	}
-
-	/* Parent process closes up write side of pipe */
-	close(fd[1]);
-	/* Read in a string from the pipe */
-	nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
-
-	if (0 <= nbytes) {
-		tst_resm(TPASS, "Container init : %s", readbuffer);
-	} else {
-		tst_brkm(TFAIL, CLEANUP,
-			 "Container init is killed by SIGKILL !!!");
+	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
+	int status;
+	pid_t pid;
+
+	pid = SAFE_CLONE(&args);
+	if (!pid) {
+		child_func();
+		return;
 	}
 
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
-		tst_resm(TFAIL, "Container init pid exited abnormally");
-	} else if (WIFSIGNALED(status)) {
-		tst_resm(TFAIL, "Container init pid got killed by signal %d",
-			 WTERMSIG(status));
-	}
-	CLEANUP();
-
-	tst_exit();
+	SAFE_WAITPID(pid, &status, 0);
 
+	TST_EXP_EQ_LI(WTERMSIG(status), 0);
 }
 
-static void cleanup(void)
-{
-	close(fd[0]);
-}
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

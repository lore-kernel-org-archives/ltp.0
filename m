Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ACDC19F2A
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 13:32:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BB4C3C943B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 15:32:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4901B3C4CA9
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 15:31:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 86D901400F97
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 15:31:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6A123783E;
 Thu,  4 Aug 2022 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1659619850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofaaUMk1ew3/5IfEXSJ/kpFylc0sFFATQ4Wb0nAcpjw=;
 b=blj+GKeQHQ1lgUZYR8Vb+tprDTLn75EpHRkr1ebPCxQMUpJeAOFfymV0+dBMRvgcDNa8QZ
 NQPLx8nu9MS8sR7qxFEEXHJYsfqgQYrT7eHxCCOvCTocp8uxmRj78oKCGZGvLEsCgHdSvZ
 In28liDD3jnk3+He1JLqq5fz4vewOU4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89FAF13434;
 Thu,  4 Aug 2022 13:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6PxVHwrK62L3XQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 04 Aug 2022 13:30:50 +0000
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 15:30:15 +0200
Message-Id: <20220804133015.15150-2-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220804133015.15150-1-andrea.cervesato@suse.com>
References: <20220804133015.15150-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] Refactor pidns04 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns04.c | 171 +++++---------------
 1 file changed, 36 insertions(+), 135 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index 9ac0e5aca..02b3f12a2 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -1,150 +1,51 @@
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
-
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
-
-char *TCID = "pidns04";
-int TST_TOTAL = 1;
-int fd[2];
-
-/*
- * child_fn1() - Inside container
-*/
-static int child_fn1(void *ttype)
+ * Copyright (c) International Business Machines Corp., 2007
+ *		08/10/08 Veerendra C <vechandr@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and verify that is not possible to
+ * kill init process by sending SIGKILL from child namespace.
+ */
+
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
+
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	int exit_val;
 	pid_t cpid, ppid;
+
 	cpid = getpid();
 	ppid = getppid();
-	char mesg[] = "I was not killed !";
-	/* Child process closes up read side of pipe */
-	close(fd[0]);
 
-	/* Comparing the values to make sure pidns is created correctly */
-	if ((cpid == CHILD_PID) && (ppid == PARENT_PID)) {
-		printf("PIDNS test is running inside container\n");
-		kill(INIT_PID, SIGKILL);
-		/* Verifying whether the container init is not killed, "
-		   If so writing into the pipe created in the parent NS" */
-
-		/* Send "mesg" through the write side of pipe */
-		write(fd[1], mesg, (strlen(mesg) + 1));
-		exit_val = 0;
-	} else {
-		printf("got unexpected result of cpid=%d ppid=%d\n",
-		       cpid, ppid);
-		exit_val = 1;
+	if (cpid != 1 || ppid != 0) {
+		tst_res(TFAIL, "got unexpected result of cpid=%d ppid=%d", cpid, ppid);
+		return 1;
 	}
-	exit(exit_val);
-}
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
-}
+	tst_res(TINFO, "Sending SIGKILL to container init process from child");
 
-int main(void)
-{
-	int nbytes, status;
-	char readbuffer[80];
+	SAFE_KILL(1, SIGKILL);
 
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
-	}
-
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
-		tst_resm(TFAIL, "Container init pid exited abnormally");
-	} else if (WIFSIGNALED(status)) {
-		tst_resm(TFAIL, "Container init pid got killed by signal %d",
-			 WTERMSIG(status));
-	}
-	CLEANUP();
-
-	tst_exit();
+	tst_res(TPASS, "Child namespace is still alive");
 
+	return 0;
 }
 
-static void cleanup(void)
+static void run(void)
 {
-	close(fd[0]);
+	int ret;
+
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "clone failed");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

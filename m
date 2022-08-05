Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2638AC00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 09:47:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 176523C9427
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 11:47:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D7833C54ED
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 11:47:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D52AE600F53
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 11:47:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16D2B1FA0C;
 Fri,  5 Aug 2022 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1659692825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TUVnG7ls+p3i+ElSSiRoR/KIVdxem016NCfjhavNq+o=;
 b=hKiaS94L/2XFgk9/rdidCr8sZkj9vKQJPiOPeN3r8JJvTd5FfjLsG4ejaTYros8ZObW3sH
 LiywcPyGzjhjNzZmyEEnTouQvH1htd3gYdUHKnIFEllj/I+Yu1EmnE1AGHpSu7VEGI4zXl
 tx0vJqksER+yiI40TE06Pu8uzR7aWts=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3155133B5;
 Fri,  5 Aug 2022 09:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W8pPLhjn7GLtWgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 05 Aug 2022 09:47:04 +0000
To: ltp@lists.linux.it
Date: Fri,  5 Aug 2022 11:46:19 +0200
Message-Id: <20220805094619.663-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor pidns10 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns10.c | 133 ++++++--------------
 1 file changed, 38 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
index b38b9fd18..cbc9d3585 100644
--- a/testcases/kernel/containers/pidns/pidns10.c
+++ b/testcases/kernel/containers/pidns/pidns10.c
@@ -1,112 +1,55 @@
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
+ *               13/11/08  Gowrishankar M <gowrishankar.m@in.ibm.com>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-int child_fn(void *);
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and check if kill(-1, signal) fails
+ * with ESRCH when there are no process in the container.
+ */
 
-#define CHILD_PID       1
-#define PARENT_PID      0
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
-/*
- * child_fn() - Inside container
- */
-int child_fn(void *arg)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	int exit_val, ret;
-	pid_t pid, ppid;
+	pid_t cpid, ppid;
+	int ret;
 
-	/* Set process id and parent pid */
-	pid = getpid();
+	cpid = getpid();
 	ppid = getppid();
-	if (pid != CHILD_PID || ppid != PARENT_PID) {
-		printf("cinit: pidns was not created.\n");
+
+	if (cpid != 1 || ppid != 0) {
+		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
 		return 1;
 	}
 
-	if ((ret = kill(-1, SIGUSR1)) == -1 && errno == ESRCH) {
-		printf("cinit: kill(-1, sig) failed with -1 / ESRCH as "
-		       "expected\n");
-		exit_val = 0;
-	} else {
-		printf("cinit: kill(-1, sig) didn't fail with -1 / ESRCH "
-		       "(%d); failed with %d / %d instead", ESRCH, ret, errno);
-		exit_val = 1;
+	ret = kill(-1, SIGUSR1);
+
+	if (ret != -1 || errno != ESRCH) {
+		tst_res(TFAIL, "kill() didn't fail with ESRCH");
+		return 0;
 	}
-	exit(exit_val);
-}
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newpid();
+	tst_res(TPASS, "Can't kill processes from child namespace");
+
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
-	if (wait(&status) < 0)
-		tst_resm(TWARN, "parent: waitpid() failed.");
+	int ret;
 
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_resm(TBROK, "container was terminated abnormally");
-
-	tst_exit();
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
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

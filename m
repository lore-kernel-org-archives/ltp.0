Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A8EC19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 08:49:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBBE93C931E
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 10:49:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27BCA3C5AA6
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 10:48:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 45B291A011DF
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 10:48:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A89F43760E;
 Thu,  4 Aug 2022 08:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1659602929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1uXtKMRAJs4bIaU3a9HlmfzJu+IJ+1zdhYhpcXpu2M=;
 b=O1pDYnVndLqOPHz4RB07wU2MxfrPQaT2fwtziywHYHXc0YTqnr8D+0hDZPcJ/X0zDF9mwE
 MIYvHIfIxqHcEmuW3uzzWaX5PAKytMDPMyQwE1qipq5s1qJQGrfUr2VvTCa07017usPlmj
 uI5DwaxeX8pfKwNIIOJ3gUjMe5OTuzY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E6641348A;
 Thu,  4 Aug 2022 08:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0AgyCfGH62IWPAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 04 Aug 2022 08:48:49 +0000
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 10:48:12 +0200
Message-Id: <20220804084812.22737-2-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220804084812.22737-1-andrea.cervesato@suse.com>
References: <20220804084812.22737-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] Refactor pidns02 test using new LTP API
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
 testcases/kernel/containers/pidns/pidns02.c | 130 +++++---------------
 1 file changed, 30 insertions(+), 100 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index 2bc9035d8..a106ed8b7 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -1,114 +1,44 @@
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
-* File: pidns02.c
-*
-* Description:
-*	The pidns02.c testcase builds into the ltp framework to verify
-*	the basic functionality of PID Namespace.
-*
-* Verify that:
-* 1. When parent clone a process with flag CLONE_NEWPID, the session ID of
-* child should be always one.
-*
-* 2. When parent clone a process with flag CLONE_NEWPID, the parent process group ID
-* should be always one.
-*
-* Total Tests
-*
-* Test Name: pidns02
-*
-* Test Assertion & Strategy:
-*
-* From main() clone a new child process with passing the clone_flag as CLONE_NEWPID,
-* Call the setid() inside container.
-* Inside the cloned pid check for the getsid(0) and getpgid(0)
-* Verify with global macro defined value for parent pid & child pid.
-*
-* Usage: <for command-line>
-* pidns02
-*/
-
-#define _GNU_SOURCE
-#include <sys/wait.h>
-#include <assert.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include "pidns_helper.h"
-#include "test.h"
+ * Copyright (c) International Business Machines Corp., 2007
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-char *TCID = "pidns02";
-int TST_TOTAL = 1;
+/*\
+ * [Description]
+ *
+ * Clone a process with CLONE_NEWPID flag and check:
+ *
+ * - child session ID must be 1
+ * - parent process group ID must be 1
+ */
 
-#define PGID	1
-#define SID	1
+#include "tst_test.h"
+#include "lapi/namespaces_constants.h"
 
-/*
- * child_fn1() - Inside container
- */
-int child_fn1(void *vtest)
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
-	pid_t pgid, sid;
+	pid_t sid, pgid;
 
-	setsid();
-
-	pgid = getpgid(0);
 	sid = getsid(0);
+	pgid = getpgid(0);
 
-	printf("Checking session id & group id inside container\n");
-	if (pgid == PGID && sid == SID) {
-		printf("Success: Got Group ID = %d & Session ID = %d\n",
-		       pgid, sid);
-		exit(0);
-	} else {
-		printf("Got unexpected result of Group ID = %d & Session ID = "
-		       "%d\n", pgid, sid);
-		exit(1);
-	}
-}
+	TST_EXP_PASS(sid == 1);
+	TST_EXP_PASS(pgid == 1);
 
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
-
-	setup();
-
-	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn1, NULL));
-	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
-	} else if ((wait(&status)) == -1) {
-		tst_brkm(TFAIL | TERRNO, NULL, "wait failed");
-	}
-
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
-		tst_resm(TFAIL | TERRNO, "child exited abnormally");
-	} else if (WIFSIGNALED(status)) {
-		tst_resm(TFAIL | TERRNO, "child exited with signal %d",
-			 WTERMSIG(status));
-	}
-
-	tst_exit();
+	int ret;
 
+	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
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

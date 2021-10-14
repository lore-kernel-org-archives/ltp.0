Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020E3C433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:26:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB2361183
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BB2361183
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E9FF3C12C4
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 03:26:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E6523C0B90
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:25:57 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0562D1000BD4
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:25:54 +0200 (CEST)
X-QQ-mid: bizesmtp39t1634174750t4x3doai
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 14 Oct 2021 09:25:48 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00A0000000
X-QQ-FEAT: jfdGVjI73+QwJrYKFkpRkwor651op69BxGalbMaipUHWZT5XRSotFZ2RZugDt
 3TD92vO6haMfDbRhWIstQBNXsGuIxaZkEMvC9Ta4EHeoOhIAjhE1z5cTkQHq/DoP5jpkgrb
 aEMH7bFUBNURiF1cPwrv3yilPeRqeqtO4P9Dix6tIcdkMO//kCuFRh7EiTIKmcJqAGCmixc
 jJt9OUmZK1eSISqr8iP0HUV6yIBcRebFm8WEMlluDuGq6DBiBn29qIM9lLbaM3F3uT66eiW
 zCcEgZW6bIb3vpSet6RpBMGa03Z5mDL3XOZNXxxXT+3NiVAZFzGZ0XoN7wV3X+CsqhVHUpu
 3fX4QZviY1MtEC1u7Eia7+5fUMSLfKNzXw4KCMG
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 14 Oct 2021 09:25:32 +0800
Message-Id: <20211014012533.18205-4-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211014012533.18205-1-zhanglianjie@uniontech.com>
References: <20211014012533.18205-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/5] syscalls/clone06: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
index 99e7f3864..8337b5d90 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -1,140 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  * Copyright (c) 2012 Wanlong Gao <gaowanlong@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */

-/*
- *	Test to verify inheritance of environment variables by child.
+/*\
+ * [Description]
+ * Test to verify inheritance of environment variables by child.
  */

-#if defined UCLINUX && !__THROW
-/* workaround for libc bug */
-#define __THROW
-#endif
-
-#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <sched.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-#include "test.h"
+#include "tst_test.h"
 #include "clone_platform.h"

 #define MAX_LINE_LENGTH 256
+#define ENV_VAL "LTP test variable value"
+#define ENV_ID "LTP_CLONE_TEST"

-static void setup(void);
-static void cleanup(void);
-static int child_environ();
-
-static int pfd[2];
+static void *child_stack;

-char *TCID = "clone06";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static int child_environ(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-
-	int lc, status;
-	void *child_stack;
-	char *parent_env;
-	char buff[MAX_LINE_LENGTH];
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	child_stack = malloc(CHILD_STACK_SIZE);
-	if (child_stack == NULL)
-		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((pipe(pfd)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "pipe() failed");
-
-		TEST(ltp_clone(SIGCHLD, child_environ, NULL, CHILD_STACK_SIZE,
-			       child_stack));
-
-		if (TEST_RETURN == -1)
-			tst_brkm(TFAIL | TTERRNO, cleanup, "clone failed");
-
-		/* close write end from parent */
-		if ((close(pfd[1])) == -1)
-			tst_resm(TWARN | TERRNO, "close(pfd[1]) failed");
-
-		/* Read env var from read end */
-		if ((read(pfd[0], buff, sizeof(buff))) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "read from pipe failed");
-
-		/* Close read end from parent */
-		if ((close(pfd[0])) == -1)
-			tst_resm(TWARN | TERRNO, "close(pfd[0]) failed");
-
-		parent_env = getenv("TERM") ? : "";
-
-		if ((strcmp(buff, parent_env)) == 0)
-			tst_resm(TPASS, "Test Passed");
-		else
-			tst_resm(TFAIL, "Test Failed");
-
-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "wait failed, status: %d", status);
+	const char *env_val = getenv(ENV_ID);
+	if (!env_val) {
+		tst_res(TFAIL, "Variable " ENV_ID " not defined in child");
+		exit(-1);
 	}

-	free(child_stack);
+	if (strcmp(env_val, ENV_VAL)) {
+		tst_res(TFAIL, "Variable value is different");
+		exit(-1);
+	}
+
+	tst_res(TPASS, "The environment variables of the child and the parent are the same ");

-	cleanup();
-	tst_exit();
+	exit(0);
 }

-static void setup(void)
+static void verify_clone(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, child_environ, NULL, CHILD_STACK_SIZE,
+				child_stack));

-static void cleanup(void)
-{
+	if (!TST_PASS)
+		return;
+
+	tst_reap_children();
 }

-/*
- *	Function executed by child.
- *	Gets the value for environment variable,TERM &
- *	writes it to  a pipe.
- */
-static int child_environ(void)
+static void setup(void)
 {
-
-	char var[MAX_LINE_LENGTH];
-
-	/* Close read end from child */
-	if ((close(pfd[0])) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(pfd[0]) failed");
-
-	if ((sprintf(var, "%s", getenv("TERM") ? : "")) < 0)
-		tst_resm(TWARN | TERRNO, "sprintf() failed");
-
-	if ((write(pfd[1], var, MAX_LINE_LENGTH)) == -1)
-		tst_resm(TWARN | TERRNO, "write to pipe failed");
-
-	/* Close write end of pipe from child */
-	if ((close(pfd[1])) == -1)
-		tst_resm(TWARN | TERRNO, "close(pfd[1]) failed");
-
-	exit(0);
+	SAFE_SETENV(ENV_ID, ENV_VAL, 0);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_clone,
+	.bufs = (struct tst_buffers []) {
+		{&child_stack, .size = CHILD_STACK_SIZE},
+		{},
+	},
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE86C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7DB6126A
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B7DB6126A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27FEE3C1C6E
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:53:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04B3E3C8F63
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:12 +0200 (CEST)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E4AE200DEC
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:10 +0200 (CEST)
X-QQ-mid: bizesmtp51t1632387186t7ebxqmw
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 23 Sep 2021 16:53:05 +0800 (CST)
X-QQ-SSF: 0140000000000040C000B00B0000000
X-QQ-FEAT: TazazapxPapBGEu8bll1Xjkpg0TbKIvdDVIdygiCjxHhzQx7Jd3/3dEUqllvg
 60zAWiKHYnNMGWhfBV6o9L+qL29JnOuVVyE68o/a1yc5XMq5Mz+Dz2JRvQuhsFRXsHVRQyd
 /uHxj5CbwFcwTKX3tmOUOymN9nUivBfmLe95WW7VPtx51paAlBHq50ZOteYOHESb+73Ixvc
 BXmpO9fr+Jf6FOsuPErvoIxvu80wG7r7a9GQ85Lx0IcvZi3iBcubL7WdoC7BTqgLSh3Nonn
 0k4OLS0pFPNR1+goKnJ+cfcO8GHX5RE5wUhPJkmon65EUUZK3R2yrqFX0M2Nq1qEJqNuqqN
 Ks7iCMdaAeGZ30NazHBgvA1C1D5ew==
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 23 Sep 2021 16:52:23 +0800
Message-Id: <20210923085224.868-4-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923085224.868-1-zhanglianjie@uniontech.com>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/5] syscalls/clone06: Convert to new API
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
index 99e7f3864..868fba4a5 100644
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

-static void setup(void);
-static void cleanup(void);
-static int child_environ();
-
-static int pfd[2];
-
-char *TCID = "clone06";
-int TST_TOTAL = 1;
+static char *buff;
+static void *child_stack;

-int main(int ac, char **av)
+static int child_environ(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	sprintf(buff, "%s", getenv("TERM") ? : "");
+	exit(0);
+}

-	int lc, status;
-	void *child_stack;
+static void verify_clone(void)
+{
 	char *parent_env;
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

-		/* Close read end from parent */
-		if ((close(pfd[0])) == -1)
-			tst_resm(TWARN | TERRNO, "close(pfd[0]) failed");
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, child_environ, NULL, CHILD_STACK_SIZE,
+				child_stack));

-		parent_env = getenv("TERM") ? : "";
+	if (!TST_PASS)
+		return;

-		if ((strcmp(buff, parent_env)) == 0)
-			tst_resm(TPASS, "Test Passed");
-		else
-			tst_resm(TFAIL, "Test Failed");
+	tst_reap_children();

-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "wait failed, status: %d", status);
-	}
-
-	free(child_stack);
-
-	cleanup();
-	tst_exit();
+	parent_env = getenv("TERM") ? : "";
+	TST_EXP_VAL(strcmp(buff, parent_env), 0,
+				"verify environment variables by child");
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+	buff = SAFE_MMAP(NULL, MAX_LINE_LENGTH, PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }

 static void cleanup(void)
 {
-}
-
-/*
- *	Function executed by child.
- *	Gets the value for environment variable,TERM &
- *	writes it to  a pipe.
- */
-static int child_environ(void)
-{
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
+	free(child_stack);

-	exit(0);
+	if (buff)
+		SAFE_MUNMAP(buff, MAX_LINE_LENGTH);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_clone,
+	.cleanup = cleanup,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

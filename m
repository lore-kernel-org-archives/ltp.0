Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD2AC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:27:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C76C60D43
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C76C60D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61F53C12F9
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 03:27:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C53E23C0B90
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:26:51 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 953581A017C2
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:26:49 +0200 (CEST)
X-QQ-mid: bizesmtp39t1634174745txa8f2sf
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 14 Oct 2021 09:25:41 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00A0000000
X-QQ-FEAT: lC5HeAtE+yb+CFINW3PwIK/2tR4ON6VxDohsZjKzbD6Uy2NswR6Jo9SrAKhCW
 X+1Z9G8Qi8MeTJI0CgzRhDOa7ovQiupabSpM1Yn5R+WGH5Qqh2vMKzrWsTbZ2KO4HD2EKgz
 uE8s/r/ZzdwF+BQqEiEj6fDBBy1+C3dXCmlQlhTCma5wQFkmnGN5u9pE2Nfiiwvrs0QzaI7
 DW8rYtbWqOlDCpentSNN+sdhu0MgH6yjFtvyYTEetid3BjJFhhmVn5xA18hKuGngpaw0Wg4
 ENc4Vv+70MfEC3c9pxM8koMiDzXo7vgtX6Mo9AsloKupkM2mAVb26RjN7J8bW8ZUVRR9lkG
 McFTYY8qMaXEmg70ZJjdz7NOfuNhiyahyH7+lvO
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 14 Oct 2021 09:25:30 +0800
Message-Id: <20211014012533.18205-2-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211014012533.18205-1-zhanglianjie@uniontech.com>
References: <20211014012533.18205-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/5] syscalls/clone03: Convert to new API
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

diff --git a/testcases/kernel/syscalls/clone/clone03.c b/testcases/kernel/syscalls/clone/clone03.c
index f4216ead8..70c37d495 100644
--- a/testcases/kernel/syscalls/clone/clone03.c
+++ b/testcases/kernel/syscalls/clone/clone03.c
@@ -1,147 +1,59 @@
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
+
+/*\
+ * [Description]
  *	Check for equality of pid of child & return value of clone(2)
- *	Test:
- *	 Open a pipe.
- *	 Loop if the proper options are given.
- *	  Call clone(2) called without SIGCHLD
- *
- *	  CHILD:
- *		writes the pid to pipe
- *	  PARENT:
- *		reads child'd pid from pipe
- *		if child's pid == return value from clone(2)
- *			Test passed
- *		else
- *			test failed
  */
-
-#if defined UCLINUX && !__THROW
-/* workaround for libc bug */
-#define __THROW
-#endif
-
-#include <errno.h>
-#include <sched.h>
-#include <sys/wait.h>
-#include "test.h"
-
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_test.h"
 #include "clone_platform.h"

-static void setup(void);
-static void cleanup(void);
-static int child_fn();
-
-static int pfd[2];
-
-char *TCID = "clone03";
-int TST_TOTAL = 1;
+static void *child_stack;
+static int *child_pid;

-int main(int ac, char **av)
+static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	*child_pid = getpid();
+	exit(0);
+}

-	int lc;
-	void *child_stack;
-	char buff[10];
-	int child_pid, status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* Allocate stack for child */
-	child_stack = malloc(CHILD_STACK_SIZE);
-	if (child_stack == NULL)
-		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if ((pipe(pfd)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
-
-		TEST(ltp_clone(SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE,
-			       child_stack));
-
-		if (TEST_RETURN == -1)
-			tst_brkm(TFAIL | TTERRNO, cleanup, "clone() failed");
-
-		/* close write end from parent */
-		if ((close(pfd[1])) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "close(pfd[1]) failed");
-
-		/* Read pid from read end */
-		if ((read(pfd[0], buff, sizeof(buff))) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "read from pipe failed");
-
-		/* Close read end from parent */
-		if ((close(pfd[0])) == -1)
-			tst_resm(TWARN | TERRNO, "close(pfd[0]) failed");
-
-		/* Get child's pid from pid string */
-		child_pid = atoi(buff);
+static void verify_clone(void)
+{

-		if (TEST_RETURN == child_pid)
-			tst_resm(TPASS, "Test passed");
-		else
-			tst_resm(TFAIL, "Test failed");
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE,
+				child_stack));

-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "wait failed, status: %d", status);
-	}
+	if (!TST_PASS)
+		return;

-	free(child_stack);
+	tst_reap_children();

-	cleanup();
-	tst_exit();
+	TST_EXP_VAL(TST_RET, *child_pid, "pid(%d)", *child_pid);
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	child_pid = SAFE_MMAP(NULL, sizeof(*child_pid), PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }

 static void cleanup(void)
 {
+	if (child_pid)
+		SAFE_MUNMAP(child_pid, sizeof(*child_pid));
 }

-static int child_fn(void)
-{
-	char pid[10];
-
-	/* Close read end from child */
-	if ((close(pfd[0])) == -1)
-		perror("close(pfd[0]) failed");
-
-	sprintf(pid, "%d", getpid());
-
-	/* Write pid string to pipe */
-	if ((write(pfd[1], pid, sizeof(pid))) == -1)
-		perror("write to pipe failed");
-
-	/* Close write end of pipe from child */
-	if ((close(pfd[1])) == -1)
-		perror("close(pfd[1]) failed");
-
-	exit(1);
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_clone,
+	.bufs = (struct tst_buffers []) {
+		{&child_stack, .size = CHILD_STACK_SIZE},
+		{},
+	},
+	.cleanup = cleanup,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

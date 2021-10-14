Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C01C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:26:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF525611AD
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF525611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3963C12BF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 03:26:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 571393C12CF
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:26:00 +0200 (CEST)
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6C33A14013A5
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:25:57 +0200 (CEST)
X-QQ-mid: bizesmtp39t1634174752tnur10j7
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 14 Oct 2021 09:25:51 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00A0000000
X-QQ-FEAT: jfdGVjI73+SdQ5BqPkUEZLp/coFRC7kp52qVKlk3oxnEFtXyCobyYNP6b4hBe
 p6Xa/kuk/r2oQzIzpA6DvcoY7Y3s8piVwlMepdYrvn0FzIxifO4rjHy9wYSoECnsHjl9Scd
 dIjb11GeQurWqPuaIl8BC13pekm6tiB3Z8YYLsYp6Qm+AQFNgMuzgMLgZhfnxBD2dgVnTLP
 Yz/Hw7hJtWRdADOEDsT1bLhN6MifjRgYAu+qZQ9ICsOVLjncjSSWaHKISf3HEdYcmMWKYrQ
 fVWd3QBC+bjmOHrTvM/l61fwnVHdbE0+qivS0beZL7QNHmxg0fiKFXIeQzOH459IvIQnXKB
 wnHoOp5GMOAclxT3rLHvOfXJT2CsQ==
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 14 Oct 2021 09:25:33 +0800
Message-Id: <20211014012533.18205-5-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211014012533.18205-1-zhanglianjie@uniontech.com>
References: <20211014012533.18205-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/5] syscalls/clone07: Convert to new API
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

diff --git a/testcases/kernel/syscalls/clone/clone07.c b/testcases/kernel/syscalls/clone/clone07.c
index 4b2e04ee7..2c5931907 100644
--- a/testcases/kernel/syscalls/clone/clone07.c
+++ b/testcases/kernel/syscalls/clone/clone07.c
@@ -1,128 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) International Business Machines  Corp., 2003.
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
- */
-/*
- *	This is a test for a glibc bug for the clone(2) system call.
  */

-#if defined UCLINUX && !__THROW
-/* workaround for libc bug */
-#define __THROW
-#endif
+/*\
+ * [Description]
+ * Test for a libc bug where exitting child function by returning from
+ * it caused SIGSEGV.
+ */

-#include <errno.h>
 #include <sched.h>
-#include <sys/wait.h>
-#include "test.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 #include "clone_platform.h"

-#define TRUE 1
-#define FALSE 0
-
-static void setup();
-static int do_child();
+static void *child_stack;

-char *TCID = "clone07";
-int TST_TOTAL = 1;
-
-static void sigsegv_handler(int);
-static void sigusr2_handler(int);
-static int child_pid;
-static int fail = FALSE;
-
-int main(int ac, char **av)
+static int do_child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-
-	int lc, status;
-	void *child_stack;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		child_stack = malloc(CHILD_STACK_SIZE);
-		if (child_stack == NULL)
-			tst_brkm(TBROK, NULL,
-				 "Cannot allocate stack for child");
-
-		child_pid = ltp_clone(SIGCHLD, do_child, NULL,
-				      CHILD_STACK_SIZE, child_stack);
-
-		if (child_pid < 0)
-			tst_brkm(TBROK | TERRNO, NULL, "clone failed");
-
-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "wait failed, status: %d", status);
-
-		free(child_stack);
-	}
-
-	if (fail == FALSE)
-		tst_resm(TPASS,
-			 "Use of return() in child did not cause SIGSEGV");
-	else
-		tst_resm(TFAIL, "Use of return() in child caused SIGSEGV");
-
-	tst_exit();
+	return 0;
 }

-static void setup(void)
+static void verify_clone(void)
 {
-	struct sigaction def_act;
-	struct sigaction act;
+	int status;
+	pid_t pid = 0;

-	TEST_PAUSE;
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE,
+				child_stack));

-	act.sa_handler = sigsegv_handler;
-	act.sa_flags = SA_RESTART;
-	sigemptyset(&act.sa_mask);
-	if ((sigaction(SIGSEGV, &act, NULL)) == -1)
-		tst_resm(TWARN | TERRNO,
-			 "sigaction() for SIGSEGV failed in test_setup()");
+	if (!TST_PASS)
+		return;

-	/* Setup signal handler for SIGUSR2 */
-	def_act.sa_handler = sigusr2_handler;
-	def_act.sa_flags = SA_RESTART | SA_RESETHAND;
-	sigemptyset(&def_act.sa_mask);
+	SAFE_WAITPID(pid, &status, 0);

-	if ((sigaction(SIGUSR2, &def_act, NULL)) == -1)
-		tst_resm(TWARN | TERRNO,
-			 "sigaction() for SIGUSR2 failed in test_setup()");
-}
-
-static int do_child(void)
-{
-	return 0;
-}
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		tst_res(TPASS, "Using return() in child will not cause abnormal exit");
+	else
+		tst_res(TFAIL, "Using return() in child will cause abnormal exit");

-static void sigsegv_handler(int sig)
-{
-	if (child_pid == 0) {
-		kill(getppid(), SIGUSR2);
-		_exit(42);
-	}
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
+		tst_res(TFAIL, "Use of return() in child caused SIGSEGV");
 }

-/* sig_default_handler() - Default handler for parent */
-static void sigusr2_handler(int sig)
-{
-	if (child_pid != 0)
-		fail = TRUE;
-}
+static struct tst_test test = {
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

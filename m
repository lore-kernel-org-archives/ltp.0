Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F986C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EEC61269
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1EEC61269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DD8B3C8FA5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:53:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D84D3C8F64
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:18 +0200 (CEST)
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 51F051001295
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:15 +0200 (CEST)
X-QQ-mid: bizesmtp51t1632387191t8h0mgb3
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 23 Sep 2021 16:53:07 +0800 (CST)
X-QQ-SSF: 0140000000000040C000B00B0000000
X-QQ-FEAT: SCIwIIlHPKlIoWDZuATvthFXW/WQRh5j0d8lG9WG3FEmtjfNA1tsbivs5XflI
 IdwEQAIvpUdzGknLUT5wF+iw0e2/13b6BzxQaG74EVna/AN9HjzL3m51M8bwt12RyW0cMK9
 Bz0ynvXp6K7dSdf0uKdeuUsczwvFHowsGU22uzC6vyERxsekvB5LDLYqdg8BhF9sJ+rvk11
 rzhXfjRe+7xHVnQRn6MjQYdKb13sHi7kno3nZraeIi2hkQjLINYidTHMrA1zoYabG9uFE0B
 LOyiDLUs0yspDQGymOiuJMDI0KU4DBUPHuAQeMQal6YXRBBis3raxNKn8zLvvtPvGDtid8i
 aSb4Nm1Qe+pMPS4frgUTCl9Llqdng==
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 23 Sep 2021 16:52:24 +0800
Message-Id: <20210923085224.868-5-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923085224.868-1-zhanglianjie@uniontech.com>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] syscalls/clone07: Convert to new API
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
index 4b2e04ee7..304810c40 100644
--- a/testcases/kernel/syscalls/clone/clone07.c
+++ b/testcases/kernel/syscalls/clone/clone07.c
@@ -1,86 +1,58 @@
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
+ * This is a test for a glibc bug for the clone(2) system call.
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
-
-char *TCID = "clone07";
-int TST_TOTAL = 1;
-
-static void sigsegv_handler(int);
-static void sigusr2_handler(int);
 static int child_pid;
-static int fail = FALSE;
+static int fail;
+static void *child_stack;

-int main(int ac, char **av)
+static int do_child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	return 0;
+}

-	int lc, status;
-	void *child_stack;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+static void sigsegv_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	if (child_pid == 0) {
+		kill(getppid(), SIGUSR2);
+		_exit(42);
+	}
+}

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		child_stack = malloc(CHILD_STACK_SIZE);
-		if (child_stack == NULL)
-			tst_brkm(TBROK, NULL,
-				 "Cannot allocate stack for child");
+static void sigusr2_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	if (child_pid != 0)
+		fail = 1;
+}

-		child_pid = ltp_clone(SIGCHLD, do_child, NULL,
-				      CHILD_STACK_SIZE, child_stack);
+static void verify_clone(void)
+{
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE,
+				child_stack));

-		if (child_pid < 0)
-			tst_brkm(TBROK | TERRNO, NULL, "clone failed");
+	child_pid = TST_RET;

-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "wait failed, status: %d", status);
+	if (!TST_PASS)
+		return;

-		free(child_stack);
-	}
+	tst_reap_children();

-	if (fail == FALSE)
-		tst_resm(TPASS,
-			 "Use of return() in child did not cause SIGSEGV");
-	else
-		tst_resm(TFAIL, "Use of return() in child caused SIGSEGV");
+	TST_EXP_VAL(fail, 0, "Use of return() in child did not cause SIGSEGV");

-	tst_exit();
 }

 static void setup(void)
@@ -88,41 +60,26 @@ static void setup(void)
 	struct sigaction def_act;
 	struct sigaction act;

-	TEST_PAUSE;
-
 	act.sa_handler = sigsegv_handler;
 	act.sa_flags = SA_RESTART;
-	sigemptyset(&act.sa_mask);
-	if ((sigaction(SIGSEGV, &act, NULL)) == -1)
-		tst_resm(TWARN | TERRNO,
-			 "sigaction() for SIGSEGV failed in test_setup()");
+	SAFE_SIGEMPTYSET(&act.sa_mask);
+	SAFE_SIGACTION(SIGSEGV, &act, NULL);

-	/* Setup signal handler for SIGUSR2 */
 	def_act.sa_handler = sigusr2_handler;
 	def_act.sa_flags = SA_RESTART | SA_RESETHAND;
-	sigemptyset(&def_act.sa_mask);
-
-	if ((sigaction(SIGUSR2, &def_act, NULL)) == -1)
-		tst_resm(TWARN | TERRNO,
-			 "sigaction() for SIGUSR2 failed in test_setup()");
-}
+	SAFE_SIGEMPTYSET(&def_act.sa_mask);
+	SAFE_SIGACTION(SIGUSR2, &def_act, NULL);

-static int do_child(void)
-{
-	return 0;
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
 }

-static void sigsegv_handler(int sig)
+static void cleanup(void)
 {
-	if (child_pid == 0) {
-		kill(getppid(), SIGUSR2);
-		_exit(42);
-	}
+	free(child_stack);
 }

-/* sig_default_handler() - Default handler for parent */
-static void sigusr2_handler(int sig)
-{
-	if (child_pid != 0)
-		fail = TRUE;
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_clone,
+	.cleanup = cleanup,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

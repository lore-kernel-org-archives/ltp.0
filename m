Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7296DC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:35:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF1C6109F
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FF1C6109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9DE3C4E34
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 13:35:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B02583C05A0
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 13:35:23 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55B581401121
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 13:35:20 +0200 (CEST)
X-QQ-mid: bizesmtp42t1631014515t2uapkir
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 07 Sep 2021 19:35:11 +0800 (CST)
X-QQ-SSF: 0140000000200040C000B00C0000000
X-QQ-FEAT: jXjag1m6xl6LPmd4Vz/RKOT/XwkhtCESqGlhDXTecr7ZrEyhCXvbbMrGSoITy
 9fHYaW+ZG5r5jkcq2C0DSOTeP8oD6ZjUVCxOYvJ8K0Tijes6/k3MCEKjv4TGx5BIkE+yka3
 gfS6m0vD/JQucQ2lS9ERAUxIeVYB/X8U4vu5fX50/jhGAFS32MvUDEV/TtKBXn6Hw/OEEFe
 DCT1bLFaX52yYqpKCikN70eWoX7ORs3SwaQkda1oGtx2izoAADSe+gpGeiFQMn4TXO5MDb3
 sf/JA+fPZFn0x3pLddgpAyyBrMbS4YZ831gtu1txiH+JR26MRO1Rt5F0JOxVZJceE65H5jt
 JFIqSg1I2oaovhsPGKP30tc90KDNRpMsq7gwgzO
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Tue,  7 Sep 2021 19:35:10 +0800
Message-ID: <20210907113510.7431-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/clone01: Convert to new API
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
Message-ID: <20210907113510.mvDRTUMzHQalgVvdjK75v6oQViY9N3muui2hqwf9UcQ@z>

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/clone/clone01.c b/testcases/kernel/syscalls/clone/clone01.c
index e490b4e77..9601f6670 100644
--- a/testcases/kernel/syscalls/clone/clone01.c
+++ b/testcases/kernel/syscalls/clone/clone01.c
@@ -1,90 +1,63 @@
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
- *	This is a test for the clone(2) system call.
- *	It is intended to provide a limited exposure of the system call.
+/*\
+ * [Description]
+ *
+ * Basic clone() test.
+ *
+ * Use clone() to create a child process, and wait for the child process to exit,
+ * verify that the child process pid is correct.
  */

-#if defined UCLINUX && !__THROW
-/* workaround for libc bug */
-#define __THROW
-#endif
-
-#include <errno.h>
-#include <sched.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
+#include "tst_test.h"
 #include "clone_platform.h"

-static void setup(void);
-static void cleanup(void);
-static int do_child();
+static void *child_stack;

-char *TCID = "clone01";
-int TST_TOTAL = 1;
+static int do_child(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	exit(0);
+}

-int main(int ac, char **av)
+static void verify_clone(void)
 {
-	void *child_stack;
 	int status, child_pid;

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, do_child, NULL,
+		CHILD_STACK_SIZE, child_stack), "clone()");

-	child_stack = malloc(CHILD_STACK_SIZE);
-	if (child_stack == NULL)
-		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
+	child_pid = SAFE_WAIT(&status);

-	tst_count = 0;
-
-	TEST(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE, child_stack));
-	if (TEST_RETURN == -1)
-		tst_resm(TFAIL | TTERRNO, "clone failed");
-
-	child_pid = SAFE_WAIT(cleanup, &status);
-
-	if (TEST_RETURN == child_pid)
-		tst_resm(TPASS, "clone returned %ld", TEST_RETURN);
+	if (child_pid == TST_RET)
+		tst_res(TPASS, "clone returned %ld", TST_RET);
 	else
-		tst_resm(TFAIL, "clone returned %ld, wait returned %d",
-			 TEST_RETURN, child_pid);
-
-	free(child_stack);
-
-	cleanup();
+		tst_res(TFAIL, "clone returned %ld, wait returned %d",
+			 TST_RET, child_pid);

-	tst_exit();
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		tst_res(TPASS, "Child exited with 0");
+	else
+		tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
 }

 static void cleanup(void)
 {
+	free(child_stack);
 }

-static int do_child(void)
-{
-	exit(0);
-}
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_clone,
+	.forks_child = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

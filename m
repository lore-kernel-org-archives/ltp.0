Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3968FC433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9AA6126A
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F9AA6126A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ACE73C8F98
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:53:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D54D43C8F9D
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:12 +0200 (CEST)
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B22CA6008C0
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:10 +0200 (CEST)
X-QQ-mid: bizesmtp51t1632387183tkvkja78
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 23 Sep 2021 16:52:55 +0800 (CST)
X-QQ-SSF: 0140000000000040C000B00B0000000
X-QQ-FEAT: GtF2qqK1Zcu1PDYVldFyYV52XQ3q9p2t+6/BAjsVDH7ePQKFJn/EYcFNQxrMG
 CbcXkWG+0JHL3ltxD7p0ex0MiRWAk7K+8dqqj05xNz6rLatR8dqT/QVH7z9NeOrf6LtryKD
 rU0hfkpC4Gf9TdTrf0Xm6bl05B2B/kFgfzEzlpJ5CRKr6xMFg1TzDuQNYYwKY6BpDGsUb81
 ZTj3228IbAEOQ5pbc4PX/RCGMdYXn/hdDdh2AsJPNM8sg1DgusW/dZ/HXD7eHpL3qr5RYl/
 raW7sOxHpScYvCt8MNQEAiwBcHFSaC/DgbpSudqXdUR9JkW3yCTjNsy+xBpzoS33RhRA0No
 KRQ4jJmvsp5CVJcRM32tn7zp4GarA==
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 23 Sep 2021 16:52:22 +0800
Message-Id: <20210923085224.868-3-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923085224.868-1-zhanglianjie@uniontech.com>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/5] syscalls/clone05: Convert to new API
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

diff --git a/testcases/kernel/syscalls/clone/clone05.c b/testcases/kernel/syscalls/clone/clone05.c
index 494b772dd..79e08b925 100644
--- a/testcases/kernel/syscalls/clone/clone05.c
+++ b/testcases/kernel/syscalls/clone/clone05.c
@@ -1,103 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  * Copyright (c) 2012 Wanlong Gao <gaowanlong@cn.fujitsu.com>
  * Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
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
+/*\
+ * [Description]
  * Call clone() with CLONE_VFORK flag set. verify that
  * execution of parent is suspended until child finishes
  */

 #define _GNU_SOURCE

-#include <errno.h>
+#include <stdlib.h>
 #include <sched.h>
-#include <sys/wait.h>
-#include "test.h"
+#include "tst_test.h"
 #include "clone_platform.h"

-char *TCID = "clone05";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-static int child_fn(void *);
-
-static int child_exited = 0;
+static int child_exited;
+static void *child_stack;

-int main(int ac, char **av)
+static int child_fn(void *unused LTP_ATTRIBUTE_UNUSED)
 {
+	int i;

-	int lc, status;
-	void *child_stack;
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
-		TEST(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
-		               CHILD_STACK_SIZE, child_stack));
-
-		if ((TEST_RETURN != -1) && (child_exited))
-			tst_resm(TPASS, "Test Passed");
-		else
-			tst_resm(TFAIL, "Test Failed");
+	for (i = 0; i < 100; i++) {
+		sched_yield();
+		usleep(1000);
+	}

-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "wait failed, status: %d", status);
+	child_exited = 1;
+	_exit(0);
+}

-		child_exited = 0;
-	}
+static void verify_clone(void)
+{
+	TST_EXP_PID_SILENT(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
+					CHILD_STACK_SIZE, child_stack), "clone with vfork");

-	free(child_stack);
+	if (!TST_PASS)
+		return;

-	cleanup();
-	tst_exit();
+	TST_EXP_VAL(child_exited, 1);
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+	child_exited = 0;
 }

 static void cleanup(void)
 {
+	free(child_stack);
 }

-static int child_fn(void *unused __attribute__((unused)))
-{
-	int i;
-
-	/* give the kernel scheduler chance to run the parent */
-	for (i = 0; i < 100; i++) {
-		sched_yield();
-		usleep(1000);
-	}
-
-	child_exited = 1;
-	_exit(1);
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

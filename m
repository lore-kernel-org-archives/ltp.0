Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDCC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:26:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9211C61181
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 01:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9211C61181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76A3E3C12F7
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 03:26:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F1D93C0B90
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:25:58 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70B45201128
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 03:25:54 +0200 (CEST)
X-QQ-mid: bizesmtp39t1634174747t2anz27a
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 14 Oct 2021 09:25:46 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00A0000000
X-QQ-FEAT: 0VgNaGdhy9id1dE1vi/KVwarrnS2Etpv9JwGEgYyBBWLLtePdOFYfQBlbfPSM
 M/NFzAQeXVwfYxaPGyyaxy4vMT/ha8jI5HwVqN+dp9gO5EW03Oi5mgCWZnyBHZivW/g/uXR
 pVWcrpT712kdtqplfMep1SlBOsuFyGMNFfPRzrLe9fQgWX7U/tCTQHhTrE9fmu42iyfeUh4
 6n8wIho2BJMoD6Y9GR5fIA50HKYtS+YZHFX7nrLonposP2NljYz3i5OjgXFaQEtex9flgS1
 E3KyuKyJFVzwOB/7QdnL30Y4BEgtsOEy/qv03GFewa5Vc8TRQST4q70pIpGH4yvzJTCTDI3
 JGUZTUAjqFg0R7UaED2J0JxjVEQGQ==
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 14 Oct 2021 09:25:31 +0800
Message-Id: <20211014012533.18205-3-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211014012533.18205-1-zhanglianjie@uniontech.com>
References: <20211014012533.18205-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/5] syscalls/clone05: Convert to new API
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
index 494b772dd..69816ece6 100644
--- a/testcases/kernel/syscalls/clone/clone05.c
+++ b/testcases/kernel/syscalls/clone/clone05.c
@@ -1,103 +1,56 @@
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
+static volatile int child_exited;
+static void *child_stack;

-static int child_exited = 0;
-
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
-
-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "wait failed, status: %d", status);
-
-		child_exited = 0;
+	for (i = 0; i < 100; i++) {
+		sched_yield();
+		usleep(1000);
 	}

-	free(child_stack);
-
-	cleanup();
-	tst_exit();
+	child_exited = 1;
+	_exit(0);
 }

-static void setup(void)
+static void verify_clone(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	child_exited = 0;
+
+	TST_EXP_PID_SILENT(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
+					CHILD_STACK_SIZE, child_stack), "clone with vfork");

-	TEST_PAUSE;
-}
+	if (!TST_PASS)
+		return;

-static void cleanup(void)
-{
+	TST_EXP_VAL(child_exited, 1);
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

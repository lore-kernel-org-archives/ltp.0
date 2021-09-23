Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8D2C433EF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E952A6126A
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E952A6126A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CAA23C8F62
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:53:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AB613C8F5E
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:04 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B3ED91001285
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 10:53:01 +0200 (CEST)
X-QQ-mid: bizesmtp51t1632387174tvl61swz
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 23 Sep 2021 16:52:44 +0800 (CST)
X-QQ-SSF: 0140000000000040C000B00B0000000
X-QQ-FEAT: soIjdELXxCKpHyXG6E225tCqTPXQSTxoYB+1dWMwgNmhE1QYWaTy9W5ewNJgm
 OGDQh9pQlpZ3Ca8inJa25Dm/1DPb22CuR13JF2OMFpS/G0i2tlEqHnSxEOTwxsEPTZWpe6o
 oTEqUqoGmRDDfMeqYesyDlyZZrb+BIk+kDZS6EqqJu7L8zjytXWl8LD3WTAaKOxdYzam256
 WMEaa2nccyDDxutmejnsYfTGQ6zQOeyuQe9p+Z+EAi1ijWA7utO5/bYYC344hQ6T7QuuHQt
 rqQplp4dsIJC8JRHFcztEmoY8Pg+HrohR8D3eLsafsIl25VK5ro+md0qvkYqOSAnXzVk7n3
 wVwxUzMV1q82TexS0bS520ly45SWQ==
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Thu, 23 Sep 2021 16:52:21 +0800
Message-Id: <20210923085224.868-2-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923085224.868-1-zhanglianjie@uniontech.com>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/5] syscalls/clone03: Convert to new API
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
index f4216ead8..81d6ee649 100644
--- a/testcases/kernel/syscalls/clone/clone03.c
+++ b/testcases/kernel/syscalls/clone/clone03.c
@@ -1,147 +1,61 @@
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
+static void *child_stack;
+static char *channel;

-char *TCID = "clone03";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static int child_fn(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	sprintf(channel, "%d", getpid());
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
+static void verify_clone(void)
+{
+	int child_pid;

-		/* Close read end from parent */
-		if ((close(pfd[0])) == -1)
-			tst_resm(TWARN | TERRNO, "close(pfd[0]) failed");
+	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE,
+				child_stack));

-		/* Get child's pid from pid string */
-		child_pid = atoi(buff);
+	if (!TST_PASS)
+		return;

-		if (TEST_RETURN == child_pid)
-			tst_resm(TPASS, "Test passed");
-		else
-			tst_resm(TFAIL, "Test failed");
+	tst_reap_children();

-		if ((wait(&status)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "wait failed, status: %d", status);
-	}
+	child_pid = atoi(channel);

-	free(child_stack);
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(!(TST_RET == child_pid), "pid(%d)", child_pid);
 }

 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+	channel = SAFE_MMAP(NULL, 10, PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }

 static void cleanup(void)
 {
-}
-
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
+	free(child_stack);

-	exit(1);
+	if (channel)
+		SAFE_MUNMAP(channel, 10);
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

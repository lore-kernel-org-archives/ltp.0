Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223B7C83F01
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 12:09:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00FF63CBF03
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 14:09:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B40213C527F
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 14:09:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C75E51400459
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 14:09:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 134921F8D6;
 Thu, 31 Aug 2023 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693483743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/orWJTuTcZ/FLcUDxfo3GGZC2LTBAiUq3MovGbl79wo=;
 b=ZkwSEI72HdmILRF+jJa5+ud7W5BSphxZOiiJymhj3IBwfd8eE6Y0szdL/Qd14nNfdaX6vC
 Qy8FN4xIzbXQ3AYnnnmLRqEGmlLM51bCOo8C/KxyNK6kMbNW9xtGfzlNipwtZSBNaLfnGx
 z48Wfu8ijjZ77r7gN9IV9aL6ycqTdwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693483743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/orWJTuTcZ/FLcUDxfo3GGZC2LTBAiUq3MovGbl79wo=;
 b=dlqZ294QHjiStzIRra4Mw9SXu6XEk2MpeQHDZv7qrZPcOMLKsE0dGa5e2Ia1LWD0rVq8dX
 +Mxw2cD0y/ujbTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6E8113587;
 Thu, 31 Aug 2023 12:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WlSfNt6C8GShcgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 31 Aug 2023 12:09:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 31 Aug 2023 14:09:02 +0200
Message-Id: <20230831120902.31502-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor mq_notify02 using new LTP API
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/mq_notify/mq_notify02.c   | 93 ++++---------------
 1 file changed, 19 insertions(+), 74 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify02.c b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
index 3109fe345..d979a4e9d 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify02.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
@@ -1,91 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
- * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
- * with this program.
+ *   Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/*
- * ALGORITHM
- *	test 1:
- *		sevp->sigev_notify = -1, EINVAL should be returned.
- *	test 2:
- *		sevp->sigev_notify = SIGEV_SIGNAL and sevp->sigev_signo > _NSG,
- *		EINVAL should be returned.
+
+/*\
+ * [Description]
+ *
+ * This test verifies that mq_notify() fails with EINVAL when invalid input
+ * arguments are given.
  */
 
-#include <errno.h>
 #include <mqueue.h>
-#include "test.h"
-
-char *TCID = "mq_notify02";
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
 
 static struct test_case_t {
 	struct sigevent sevp;
 	int exp_errno;
-} test_cases[] = {
+} tcase[] = {
 	{{.sigev_notify = -1}, EINVAL},
-	{{.sigev_notify = SIGEV_SIGNAL, .sigev_signo = _NSIG+1}, EINVAL},
+	{{.sigev_notify = SIGEV_SIGNAL, .sigev_signo = _NSIG + 1}, EINVAL},
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void mq_notify_verify(struct test_case_t *);
-
-int main(int argc, char **argv)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			mq_notify_verify(&test_cases[i]);
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
+static void run(unsigned int i)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct test_case_t *test = &tcase[i];
 
-	TEST_PAUSE;
+	TST_EXP_FAIL(mq_notify(0, &(test->sevp)), test->exp_errno);
 }
 
-static void mq_notify_verify(struct test_case_t *test)
-{
-	TEST(mq_notify(0, &(test->sevp)));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "mq_notify() succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "mq_notify failed as expected");
-	} else if (TEST_ERRNO == ENOSYS) {
-		tst_resm(TCONF | TTERRNO, "mq_notify not available");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "mq_notify failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A03C71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 11:00:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25CF43CEBFD
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 13:00:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430F13CB821
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 13:00:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B1B9601285
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 13:00:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4726A1F38C;
 Mon,  4 Sep 2023 11:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693825231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x/ySB2CEBDESxHzLZ71fcWBwfif/xd3nZ5m7p4vC3xU=;
 b=bZROLU1LQoo2U1gkW8csva79Z2wwBw+tFvtIN4OO5OehVGkf7UGSRMcA7GaopfPy7c7zqM
 TRj7pOcJ+JvEgZcLa7zDEXc8hLLtKHyCygeEnD+2bQt35PQU/9G5StcW/m4kbekCixvJao
 Fd51nUqwZvmi5qV5FYeCKEadmoxsraU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693825231;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x/ySB2CEBDESxHzLZ71fcWBwfif/xd3nZ5m7p4vC3xU=;
 b=zhpjdYmwXbTaf9C8/KeVWdaKlm/Y9QUSW5V5SA3fYG/2XaNKxC3F9Th+wG2WWoQPwJVYrd
 33H2Aq2lNVJ7ZwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B269913585;
 Mon,  4 Sep 2023 11:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vTS/Ic649WSIMgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Sep 2023 11:00:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 13:00:28 +0200
Message-Id: <20230904110028.23393-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor timer_getoverrun test using new LTP API
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
 .../kernel/syscalls/timer_getoverrun/Makefile |   2 +
 .../timer_getoverrun/timer_getoverrun01.c     | 106 +++++-------------
 2 files changed, 32 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_getoverrun/Makefile b/testcases/kernel/syscalls/timer_getoverrun/Makefile
index 1273a4e9c..58376e379 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/Makefile
+++ b/testcases/kernel/syscalls/timer_getoverrun/Makefile
@@ -5,4 +5,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+LDLIBS			:= -lrt $(LDLIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index aa9881f27..cb221268d 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -1,88 +1,42 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007                                   *
- * Porting from Crackerjack to LTP is done by:                                *
- *              Manas Kumar Nayak <maknayak@in.ibm.com>                       *
- * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>                          *
- *                                                                            *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or          *
- * (at your option) any later version.                                        *
- *                                                                            *
- * This program is distributed in the hope that it will be useful,            *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
- * the GNU General Public License for more details.                           *
- *                                                                            *
- * You should have received a copy of the GNU General Public License          *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *                                                                            *
- ******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2001
+ * Porting from Crackerjack to LTP is done by:
+ *              Manas Kumar Nayak <maknayak@in.ibm.com>
+ *
+ * Copyright (c) Linux Test Project, 2009-2023
+ * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test checks base timer_getoverrun() functionality.
+ */
 
-#include <stdio.h>
-#include <errno.h>
-#include <time.h>
 #include <signal.h>
-#include <sys/syscall.h>
-
-#include "test.h"
+#include "tst_test.h"
+#include "tst_safe_clocks.h"
 #include "lapi/syscalls.h"
 
-char *TCID = "timer_getoverrun01";
-int TST_TOTAL = 1;
-
-static void cleanup(void)
-{
-
-	tst_rmdir();
-}
-
-static void setup(void)
+static void run(void)
 {
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	int timer;
+	timer_t timer;
 	struct sigevent ev;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
 	ev.sigev_value = (union sigval) 0;
-	ev.sigev_signo = SIGALRM;
 	ev.sigev_notify = SIGEV_SIGNAL;
-	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
-
-	if (TEST_RETURN != 0)
-		tst_brkm(TBROK | TTERRNO, cleanup, "Failed to create timer");
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-
-		TEST(tst_syscall(__NR_timer_getoverrun, timer));
-		if (TEST_RETURN == 0) {
-			tst_resm(TPASS,
-			         "timer_getoverrun(CLOCK_REALTIME) Passed");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-			         "timer_getoverrun(CLOCK_REALTIME) Failed");
-		}
+	ev.sigev_signo = SIGALRM;
 
-		TEST(tst_syscall(__NR_timer_getoverrun, -1));
-		if (TEST_RETURN == -1 && TEST_ERRNO == EINVAL) {
-			tst_resm(TPASS,	"timer_gettime(-1) Failed: EINVAL");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-			         "timer_gettime(-1) = %li", TEST_RETURN);
-		}
-	}
+	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
+	if (TST_RET)
+		tst_brk(TBROK | TERRNO, "timer_create() error");
 
-	cleanup();
-	tst_exit();
+	TST_EXP_POSITIVE(tst_syscall(__NR_timer_getoverrun, timer));
+	TST_EXP_FAIL(tst_syscall(__NR_timer_getoverrun, -1), EINVAL);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

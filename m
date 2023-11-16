Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C387C197A0
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 15:21:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9960C3CE3B8
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 16:21:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D1D93CC1C9
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:21:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F900100B7A1
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:21:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 754D322940;
 Thu, 16 Nov 2023 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700148069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1K1Hm57rhprH2YnUe92Kk+tEeYp2urhtO6v4tPz6RCA=;
 b=tFZcs/mjgAynk6WrktrN8p82v3snJUyWS7uUkXiFCSOPG0VxsbOoBAZ0+k+JXuAPJGc8pq
 kgcuHwelcq4V5zsU6eW0ie1bLmVNsfPw4i9c5EJDqmsvF0bLgJwCJ3YFx0eYMx7UscERtJ
 ydZ9Syer7wdkTg6ZAp9yJ/N8CZvgJvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700148069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1K1Hm57rhprH2YnUe92Kk+tEeYp2urhtO6v4tPz6RCA=;
 b=XoGl07U0nifp8XoKrOmelJQAylzonWSvqBjkIVlufetxQbTvlhdT7IDryeMAgtjCxoFYAD
 7JHKJkguVcL2A2BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DC881377E;
 Thu, 16 Nov 2023 15:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nzEkEWUzVmWMUAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Nov 2023 15:21:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 16 Nov 2023 16:21:08 +0100
Message-Id: <20231116152108.10155-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Refactor timer_getoverrun test using new LTP API
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
Removed variants and use timer_delete before checking for EINVAL

 .../kernel/syscalls/timer_getoverrun/Makefile |   2 +
 .../timer_getoverrun/timer_getoverrun01.c     | 105 ++++++------------
 2 files changed, 33 insertions(+), 74 deletions(-)

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
index aa9881f27..74138c44d 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -1,88 +1,45 @@
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
+	ev.sigev_signo = SIGALRM;
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
+	if (tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer))
+		tst_brk(TBROK | TERRNO, "timer_create() failed");
 
-		TEST(tst_syscall(__NR_timer_getoverrun, timer));
-		if (TEST_RETURN == 0) {
-			tst_resm(TPASS,
-			         "timer_getoverrun(CLOCK_REALTIME) Passed");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-			         "timer_getoverrun(CLOCK_REALTIME) Failed");
-		}
+	TST_EXP_POSITIVE(tst_syscall(__NR_timer_getoverrun, timer));
 
-		TEST(tst_syscall(__NR_timer_getoverrun, -1));
-		if (TEST_RETURN == -1 && TEST_ERRNO == EINVAL) {
-			tst_resm(TPASS,	"timer_gettime(-1) Failed: EINVAL");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-			         "timer_gettime(-1) = %li", TEST_RETURN);
-		}
-	}
+	if (tst_syscall(__NR_timer_delete, timer))
+		tst_brk(TBROK | TERRNO, "timer_delete() failed");
 
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(tst_syscall(__NR_timer_getoverrun, timer), EINVAL);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

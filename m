Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEE2C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 14:55:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C045D3CA099
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 15:55:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80D893C9564
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 15:55:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E4D4601CC6
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 15:55:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97D88212C1;
 Wed, 16 Feb 2022 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645023299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yRMkezugf/kB3lTQjUhT2YbQUjEYHsjNThzLhXTlNYw=;
 b=w6w3SWPBsRwXyyt8VltoqAZgfcapJHDcxRUIes2Rb+mX8A56+hTVOMLy1556tYwU6R0OcI
 eK9giJJuQK0IUnrDqwdYgQmwfAu9+v8m2kjihnon33tm9PXtpxLosu5qRkd5Hi1orldowL
 tBaqIXMRynbegaCzpYPbbpynhhksQx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645023299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yRMkezugf/kB3lTQjUhT2YbQUjEYHsjNThzLhXTlNYw=;
 b=eMYpkn8cLx5b4baB4Z1r1P89pxtbb+fVKP66+Y0B+kXJGy59Y5D9JYB4dl/7OJ6nyXM+vK
 cnlgF6ycd62kzeDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7270313B24;
 Wed, 16 Feb 2022 14:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id urPiGUMQDWLkIAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 16 Feb 2022 14:54:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 16 Feb 2022 15:54:58 +0100
Message-Id: <20220216145458.18505-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Rewrite sighold02.c using new LTP API
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

Removed TST_CHECKPOINT_INIT and replaced it with the .needs_checkpoints
LTP test feature. Simplified source code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/syscalls/sighold/sighold02.c | 180 +++++-------------
 1 file changed, 48 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index b763142df..212e6e78c 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -1,74 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *  AUTHOR          : Bob Clark
  *  CO-PILOT        : Barrie Kletscher
  *  DATE STARTED    : 9/26/86
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/*
- * TEST ITEMS
- *	1. sighold action to turn off the receipt of all signals was done
- *	   without error.
+
+/*\
+ * [Description]
+ *
+ * This test checks following conditions:
+ *	1. sighold action to turn off the receipt of all signals was done without error.
  *	2. After signals were held, and sent, no signals were trapped.
  */
-#define _XOPEN_SOURCE 500
-#include <errno.h>
+
+#define _XOPEN_SOURCE 600
 #include <signal.h>
-#include <string.h>
-#include <fcntl.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/signal.h"
+#include "tst_test.h"
 
 /* _XOPEN_SOURCE disables NSIG */
 #ifndef NSIG
-# define NSIG _NSIG
+#	define NSIG _NSIG
 #endif
 
 /* ensure NUMSIGS is defined */
 #ifndef NUMSIGS
-# define NUMSIGS NSIG
+#	define NUMSIGS NSIG
 #endif
 
-char *TCID = "sighold02";
-int TST_TOTAL = 2;
-
-static int pid;
-static void do_child(void);
-static void setup(void);
-static void cleanup(void);
-
 static int sigs_catched;
 static int sigs_map[NUMSIGS];
 
@@ -88,115 +49,70 @@ static int skip_sig(int sig)
 	}
 }
 
-int main(int ac, char **av)
-{
-	int sig;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-		} else if (pid > 0) {
-			TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
-
-			for (sig = 1; sig < NUMSIGS; sig++) {
-				if (skip_sig(sig))
-					continue;
-				SAFE_KILL(NULL, pid, sig);
-			}
-
-			TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-			tst_record_childstatus(cleanup, pid);
-		} else {
-
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0) {
-				tst_brkm(TBROK | TERRNO, NULL,
-					 "self_exec() failed");
-			}
-#else
-			do_child();
-#endif
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void handle_sigs(int sig)
 {
 	sigs_map[sig] = 1;
 	sigs_catched++;
 }
 
-void do_child(void)
+static void do_child(void)
 {
-	int cnt;
 	int sig;
 
-	/* set up signal handler routine */
 	for (sig = 1; sig < NUMSIGS; sig++) {
 		if (skip_sig(sig))
 			continue;
 
-		if (signal(sig, handle_sigs) == SIG_ERR) {
-			tst_resm(TBROK | TERRNO, "signal() %i(%s) failed",
-				 sig, tst_strsig(sig));
-		}
+		SAFE_SIGNAL(sig, handle_sigs);
 	}
 
-	/* all set up to catch signals, now hold them */
-	for (cnt = 0, sig = 1; sig < NUMSIGS; sig++) {
+	for (sig = 1; sig < NUMSIGS; sig++) {
 		if (skip_sig(sig))
 			continue;
-		cnt++;
-		TEST(sighold(sig));
-		if (TEST_RETURN != 0) {
-			tst_resm(TBROK | TTERRNO, "sighold() %i(%s) failed",
-				 sig, tst_strsig(sig));
-		}
+
+		if (sighold(sig))
+			tst_brk(TBROK | TERRNO, "sighold(%s %i)", tst_strsig(sig), sig);
 	}
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	if (!sigs_catched) {
-		tst_resm(TPASS, "All signals were hold");
-		tst_exit();
+		tst_res(TPASS, "all signals were hold");
+		return;
 	}
 
-	tst_resm(TFAIL, "Signal handler was executed");
-
-	for (sig = 1; sig < NUMSIGS; sig++) {
-		if (sigs_map[sig]) {
-			tst_resm(TINFO, "Signal %i(%s) catched",
-			         sig, tst_strsig(sig));
-		}
-	}
+	tst_res(TFAIL, "signal handler was executed");
 
-	tst_exit();
+	for (sig = 1; sig < NUMSIGS; sig++)
+		if (sigs_map[sig])
+			tst_res(TINFO, "Signal %i(%s) catched", sig, tst_strsig(sig));
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_sig(FORK, DEF_HANDLER, NULL);
+	pid_t pid_child;
+	int signal;
 
-	tst_tmpdir();
+	pid_child = SAFE_FORK();
+	if (!pid_child) {
+		do_child();
+		return;
+	}
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
+	TST_CHECKPOINT_WAIT(0);
 
-	TEST_PAUSE;
-}
+	for (signal = 1; signal < NUMSIGS; signal++) {
+		if (skip_sig(signal))
+			continue;
 
-static void cleanup(void)
-{
-	tst_rmdir();
+		SAFE_KILL(pid_child, signal);
+	}
+
+	TST_CHECKPOINT_WAKE(0);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

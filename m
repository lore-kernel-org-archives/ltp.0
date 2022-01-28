Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69EDC433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 09:47:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 971A23C976A
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 10:47:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F6653C9736
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 10:46:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 443D3100099A
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 10:46:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32BCB1F391;
 Fri, 28 Jan 2022 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643363215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjioJ4YVhUPxPbSIcDl3AxnAduYv8xTfGlkAlkUt4VY=;
 b=Eop01+hM1dpY9qhOh512w9u1SlUk3fAHcTDCw6kw1wHlV6rNwgRQYNuSD+QBII9Rben0w+
 COFVE3kX+VJSDHnLmwAWTJSUyeO38ZyZK5d8JHoTg1MHCnQ/8hKsXZ93A+RgBmZ8yEIsHd
 NYDQuL92fn+xaJcu2UhhaBZBMoTUkqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643363215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjioJ4YVhUPxPbSIcDl3AxnAduYv8xTfGlkAlkUt4VY=;
 b=M8GVeZJJwBtdfwSx9+0/dhxgIkP3qD/JZyiG/6y94xt/Jf/LO6DdFwoTQBzbxlqU/Squeb
 668F3Y8A5VXUlMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A81E13A83;
 Fri, 28 Jan 2022 09:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z/R4AI+782G2BAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Jan 2022 09:46:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 28 Jan 2022 10:46:53 +0100
Message-Id: <20220128094653.18500-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Rewrite sighold02.c using new LTP API
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
 testcases/kernel/syscalls/sighold/sighold02.c | 175 +++++-------------
 1 file changed, 49 insertions(+), 126 deletions(-)

diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index b763142df..cf6cc58f3 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -1,74 +1,36 @@
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
+
+/*\
+ * [Description]
+ *
+ * This test checks following conditions:
  *	1. sighold action to turn off the receipt of all signals was done
  *	   without error.
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
+#define NSIG _NSIG
 #endif
 
 /* ensure NUMSIGS is defined */
 #ifndef NUMSIGS
-# define NUMSIGS NSIG
+#define NUMSIGS NSIG
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
 
@@ -88,57 +50,13 @@ static int skip_sig(int sig)
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
 	int cnt;
 	int sig;
@@ -148,55 +66,60 @@ void do_child(void)
 		if (skip_sig(sig))
 			continue;
 
-		if (signal(sig, handle_sigs) == SIG_ERR) {
-			tst_resm(TBROK | TERRNO, "signal() %i(%s) failed",
-				 sig, tst_strsig(sig));
-		}
+		SAFE_SIGNAL(sig, handle_sigs);
 	}
 
 	/* all set up to catch signals, now hold them */
 	for (cnt = 0, sig = 1; sig < NUMSIGS; sig++) {
 		if (skip_sig(sig))
 			continue;
+
 		cnt++;
-		TEST(sighold(sig));
-		if (TEST_RETURN != 0) {
-			tst_resm(TBROK | TTERRNO, "sighold() %i(%s) failed",
-				 sig, tst_strsig(sig));
-		}
+
+		if (sighold(sig))
+			tst_brk(TBROK, "sighold() %i(%s) failed", sig,
+				tst_strsig(sig));
 	}
 
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
 
 	if (!sigs_catched) {
-		tst_resm(TPASS, "All signals were hold");
-		tst_exit();
+		tst_res(TPASS, "all signals were hold");
+	} else {
+		tst_res(TFAIL, "signal handler was executed");
+
+		for (sig = 1; sig < NUMSIGS; sig++)
+			if (sigs_map[sig])
+				tst_res(TINFO, "Signal %i(%s) catched", sig,
+					tst_strsig(sig));
 	}
+}
 
-	tst_resm(TFAIL, "Signal handler was executed");
+static void run(void)
+{
+	pid_t pid_child;
+	int signal;
 
-	for (sig = 1; sig < NUMSIGS; sig++) {
-		if (sigs_map[sig]) {
-			tst_resm(TINFO, "Signal %i(%s) catched",
-			         sig, tst_strsig(sig));
-		}
+	pid_child = SAFE_FORK();
+	if (!pid_child) {
+		do_child();
+		return;
 	}
 
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
+	TST_CHECKPOINT_WAIT(0);
 
-	tst_tmpdir();
+	for (signal = 1; signal < NUMSIGS; signal++) {
+		if (skip_sig(signal))
+			continue;
 
-	TST_CHECKPOINT_INIT(tst_rmdir);
+		SAFE_KILL(pid_child, signal);
+	}
 
-	TEST_PAUSE;
+	TST_CHECKPOINT_WAKE(0);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

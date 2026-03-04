Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E761BEF8FF3
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:02:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8149B3DC8BB
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 16:02:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDB433DAD37
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:02:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2482560013D
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:02:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEBD65BE7A;
 Wed,  4 Mar 2026 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772636548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5/bmXnXaZDoPyhIMRFbGHCN73DPZ6wvcW9q9VTIDjg=;
 b=Zta5sBO6ba97vEgNN7nPgsT9zLZPKH/KfvnwdxPzUsNCU3OtaixQimvZJQhdIX6ZWSMuDe
 YE9v2eCnp54T6ATnh/LdvPsuwlBtGS1VBpDHN6RXoU0JwaiG43S/ipcR26xpn66CmFqdvn
 TgxCQFYYxdoHq11wueR2uaVNDtaU7fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772636548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5/bmXnXaZDoPyhIMRFbGHCN73DPZ6wvcW9q9VTIDjg=;
 b=18eosFpxqVHyXk0POYm8sBDgMI0TBdw8Xj9MLNE7iijpnjh0T2XPt8B9MtZunXi6Serwa2
 wxe2cIQZ7D8zAsDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772636547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5/bmXnXaZDoPyhIMRFbGHCN73DPZ6wvcW9q9VTIDjg=;
 b=ksAKseS/uZ8JtAX/qcBoI7vHwWygUTGJfI/5j4q2ivBgmDvpksoScev6j4R3FImAZWkDkI
 rc2xiJxgpIWedrMuOirIfZ6Y2TuQkJ9Et9RdFMaXRtmclzfaWz/zZBA7Bp6XtYwI5Dnlib
 7QJygo6Kv5A/u6XjoSyC0S+UZeXZ8Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772636547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5/bmXnXaZDoPyhIMRFbGHCN73DPZ6wvcW9q9VTIDjg=;
 b=uAJlF1xlH746GFY2LMdsrnaPnpVaGqG4soYBFLY2DJ7w5JxxN+NmEbpeXRnT1woMIk4q0Z
 PWxJzT/K1+rE0QDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C529D3EA6E;
 Wed,  4 Mar 2026 15:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OAEHLoNJqGkJNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Mar 2026 15:02:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Mar 2026 16:02:28 +0100
MIME-Version: 1.0
Message-Id: <20260304-fork_refactoring-v2-3-016c47c90bc1@suse.com>
References: <20260304-fork_refactoring-v2-0-016c47c90bc1@suse.com>
In-Reply-To: <20260304-fork_refactoring-v2-0-016c47c90bc1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772636547; l=8567;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=J4Rp11hb/VK3Upbo4CjAfsXgyYwOWCiinI6cXbrx81A=;
 b=0bNcx9tKkS8k1rqFOM/hf5LpIk/KN/UMRW517BG3H7IIUyg21JF13t4Inn09Dv2wpEmuA4KLm
 l0wdsBF8aOHBs2oL95tnP48aNx8H5Jr1F8XGBGWCwbprRNpAGtUvarQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] syscalls: refactor vfork02 using new API
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

Replace the deprecated sigrelse/sighold usage and replace them with
sigprocmask/sigaction.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/vfork/vfork02.c | 248 ++++++------------------------
 1 file changed, 48 insertions(+), 200 deletions(-)

diff --git a/testcases/kernel/syscalls/vfork/vfork02.c b/testcases/kernel/syscalls/vfork/vfork02.c
index f630c9572b609d2af18e8852c1e5a0dcb16172ff..26d5f1bb9c897afe1121cfe3ed4d5a70456d17b8 100644
--- a/testcases/kernel/syscalls/vfork/vfork02.c
+++ b/testcases/kernel/syscalls/vfork/vfork02.c
@@ -1,229 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Test Name: vfork02
- *
- * Test Description:
+/*\
  *  Fork a process using vfork() and verify that, the pending signals in
  *  the parent are not pending in the child process.
- * $
- * Expected Result:
- *  The signal which is pending in the parent should not be pending in the
- *  child process.
- *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  vfork02 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  None.
- *
  */
-#define _GNU_SOURCE 1
 
-#include <stdio.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "tso_safe_macros.h"
+static sigset_t mask;
 
-char *TCID = "vfork02";
-int TST_TOTAL = 1;
+static void run(void)
+{
+	if (!vfork()) {
+		sigset_t signal;
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void sig_handler();		/* signal catching function */
+		tst_res(TINFO, "child: verify if SIGUSR1 signal is not on hold");
 
-int main(int ac, char **av)
-{
-	int lc;
-	pid_t cpid;		/* process id of the child process */
-	int exit_status;	/* exit status of child process */
-	sigset_t PendSig;	/* variable to hold pending signal */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call vfork(2) to create a child process without
-		 * fully copying the address space of parent.
-		 */
-		TEST(vfork());
-
-		if ((cpid = TEST_RETURN) == -1) {
-			tst_resm(TFAIL, "vfork() Failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else if (cpid == 0) {	/* Child process */
-			/*
-			 * Check whether the pending signal SIGUSR1
-			 * in the parent is also pending in the child
-			 * process by storing it in a variable.
-			 */
-			if (sigpending(&PendSig) == -1) {
-				tst_resm(TFAIL, "sigpending function "
-					 "failed in child");
-				_exit(1);
-			}
-
-			/* Check if SIGUSR1 is pending in child */
-			if (sigismember(&PendSig, SIGUSR1) != 0) {
-				tst_resm(TFAIL, "SIGUSR1 also pending "
-					 "in child process");
-				_exit(1);
-			}
-
-			/*
-			 * Exit with normal exit code if everything
-			 * fine
-			 */
-			_exit(0);
-		} else {	/* parent process */
-			/*
-			 * Let the parent process wait till child completes
-			 * its execution.
-			 */
-			wait(&exit_status);
-
-			/* Check for the exit status of child process */
-			if (WEXITSTATUS(exit_status) == 0) {
-				tst_resm(TPASS, "Call to vfork() "
-					 "successful");
-			} else if (WEXITSTATUS(exit_status) == 1) {
-				tst_resm(TFAIL,
-					 "Child process exited abnormally");
-			}
-		}
-		tst_count++;	/* incr. TEST_LOOP counter */
-	}
+		if (sigpending(&signal) == -1)
+			tst_brk(TBROK | TERRNO, "sigpending() error");
 
-	cleanup();
-	tst_exit();
+		TST_EXP_EQ_LI(sigismember(&signal, SIGUSR1), 0);
 
+		_exit(0);
+	}
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *   This function installs signal handler for SIGUSR1, puts signal SIGUSR1
- *   on hold and then sends the signal SIGUSR1 to itself so that it is in
- *   pending state.
- */
-void setup(void)
+static void sig_handler(LTP_ATTRIBUTE_UNUSED int signo)
 {
-	sigset_t PendSig;	/* variable to hold pending signal */
+}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+static void setup(void)
+{
+	struct sigaction action;
+	sigset_t signal;
 
-	TEST_PAUSE;
+	tst_res(TINFO, "parent: hold SIGUSR1 signal");
 
-	/* Install the signal handler */
-	if (signal(SIGUSR1, sig_handler) == SIG_ERR) {
-		tst_brkm(TBROK, cleanup, "Fails to catch the signal SIGUSR1");
-	}
+	memset(&action, 0, sizeof(action));
+	action.sa_handler = sig_handler;
+	SAFE_SIGACTION(SIGUSR1, &action, NULL);
 
-	/* Hold the signal SIGUSR1 */
-	if (sighold(SIGUSR1) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "sighold failed to hold the signal SIGUSR1");
-	}
+	SAFE_SIGEMPTYSET(&mask);
+	SAFE_SIGADDSET(&mask, SIGUSR1);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask, NULL);
 
-	/* Send the signal SIGUSR1 to itself so that SIGUSR1 is pending */
-	SAFE_KILL(cleanup, getpid(), SIGUSR1);
+	SAFE_KILL(getpid(), SIGUSR1);
 
-	/* If SIGUSR1 is not pending in the parent, fail */
-	if (sigpending(&PendSig) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "sigpending function failed in parent");
-	}
+	if (sigpending(&signal) == -1)
+		tst_brk(TBROK | TERRNO, "sigpending() error");
+
+	TEST(sigismember(&signal, SIGUSR1));
+	if (TST_RET != 1) {
+		if (TST_RET == -1)
+			tst_brk(TBROK | TERRNO, "sigismember() error");
 
-	/* Check if SIGUSR1 is pending in parent */
-	if (sigismember(&PendSig, SIGUSR1) != 1) {
-		tst_brkm(TBROK, cleanup,
-			 "SIGUSR1 signal is not pending in parent");
+		tst_brk(TBROK, "SIGUSR1 is not on hold");
 	}
 }
 
-/*
- * void
- * sig_handler() - signal catching function for 'SIGUSR1' signal.
- *		 $
- *   This is a null function and used only to catch the above signal
- *   generated in parent process.
- */
-void sig_handler(void)
+static void cleanup(void)
 {
+	SAFE_SIGEMPTYSET(&mask);
+	SAFE_SIGADDSET(&mask, SIGUSR1);
+	SAFE_SIGPROCMASK(SIG_UNBLOCK, &mask, NULL);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Release the signal 'SIGUSR1'  if still in pending state.
- */
-void cleanup(void)
-{
-
-	/* Release the signal 'SIGUSR1' if in pending state */
-	if (sigrelse(SIGUSR1) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to release 'SIGUSR1' in cleanup");
-	}
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

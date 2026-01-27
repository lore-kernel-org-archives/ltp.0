Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783ABD2F000
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 12:50:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4BD63CA152
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:50:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6E753C93D2
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:50:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6AC851400DB9
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:50:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDCB5337D4;
 Tue, 27 Jan 2026 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769518211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQPJNOmyvcGs7px7KNymnRCsHkHsV4mRfPv/pI84UdQ=;
 b=XHFVNi4+gOZoTrm5XPVNLRQ18nd6v9bAezyPQnE9CWUjBNhNH4F6uX9gKzWpo+03t1mR+Z
 3fynSsE6tUL4mIf9C2RKBIjvJThHPuVeSUGYiNgB3pY6OghA6ffrx8SvGG2sJUs74pEM9m
 NRPZ6ow+SdfYufa+jfeP5cdu/U4JfVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769518211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQPJNOmyvcGs7px7KNymnRCsHkHsV4mRfPv/pI84UdQ=;
 b=AYv9q8FbdFHCpLm1uWAT66WlOy4fCIED1xtkuQfU8IkC+76wr+Vm2kM8TQzO6OPcHLdroH
 CwCfR8eR22bKRbCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qm60mTnt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7DwGgWyk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769518210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQPJNOmyvcGs7px7KNymnRCsHkHsV4mRfPv/pI84UdQ=;
 b=qm60mTntpxqZz+ykTEJn2RdabqCWrfITDwk0oCywnfbjkG96tJNGQd1oYml2rBEG89zHw9
 FUbc2nB18d2XEjcWb2KPPW6qUK7uB6FM4+SM3Q9acQu9uE3aI6W4sHVfi23Qw+TMtEL8xf
 z0b+6PgnSf4/sSGoYzaaJl7ZBKIUrwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769518210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQPJNOmyvcGs7px7KNymnRCsHkHsV4mRfPv/pI84UdQ=;
 b=7DwGgWyk6cDY4KCMfBfUtiHo5pj1ilR3sl7uhTXH/zgSmYsz3dDWbFZ9mFVuENi44XUhwD
 V7cy2ZkVxlld1nDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA6C03EA62;
 Tue, 27 Jan 2026 12:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJjJL4K0eGmaYwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 27 Jan 2026 12:50:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 27 Jan 2026 13:50:11 +0100
MIME-Version: 1.0
Message-Id: <20260127-fork_refactoring-v1-3-e3e21ff1a4f7@suse.com>
References: <20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com>
In-Reply-To: <20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769518210; l=7776;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=IMIFYnf/g3KpVzFfgHL8re8ojOU5V5YLzOKP8CFCKv4=;
 b=KH7TPv7mkMoj/y1rqGnJSA1pyDvkoriKSnBKdbTagtxUsYhHhMzjZf4Jv4UoUhzM42v0RFlRf
 35fbAxa9XuFBx1Sy3E4icTxW7pwGLyu4nROK0QzgBpddKEDlK5ySJtW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EDCB5337D4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] syscalls: refactor vfork02 using new API
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
sigaction.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/vfork/vfork02.c | 230 +++---------------------------
 1 file changed, 23 insertions(+), 207 deletions(-)

diff --git a/testcases/kernel/syscalls/vfork/vfork02.c b/testcases/kernel/syscalls/vfork/vfork02.c
index efa70d0bef325a77e345448fc88d3fb721a8d39d..507666c5f2c59f2d74f2efcd4c0e088a9818ed05 100644
--- a/testcases/kernel/syscalls/vfork/vfork02.c
+++ b/testcases/kernel/syscalls/vfork/vfork02.c
@@ -1,229 +1,45 @@
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
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "vfork02";
-int TST_TOTAL = 1;
-
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-void sig_handler();		/* signal catching function */
-
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
 
-	cleanup();
-	tst_exit();
+#include "tst_test.h"
 
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *   This function installs signal handler for SIGUSR1, puts signal SIGUSR1
- *   on hold and then sends the signal SIGUSR1 to itself so that it is in
- *   pending state.
- */
-void setup(void)
+static void run(void)
 {
-	sigset_t PendSig;	/* variable to hold pending signal */
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (!vfork()) {
+		sigset_t signal;
 
-	TEST_PAUSE;
-
-	/* Install the signal handler */
-	if (signal(SIGUSR1, sig_handler) == SIG_ERR) {
-		tst_brkm(TBROK, cleanup, "Fails to catch the signal SIGUSR1");
-	}
-
-	/* Hold the signal SIGUSR1 */
-	if (sighold(SIGUSR1) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "sighold failed to hold the signal SIGUSR1");
-	}
+		if (sigpending(&signal) == -1)
+			tst_brk(TBROK | TERRNO, "sigpending() error");
 
-	/* Send the signal SIGUSR1 to itself so that SIGUSR1 is pending */
-	SAFE_KILL(cleanup, getpid(), SIGUSR1);
+		TST_EXP_EQ_LI(sigismember(&signal, SIGUSR1), 0);
 
-	/* If SIGUSR1 is not pending in the parent, fail */
-	if (sigpending(&PendSig) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "sigpending function failed in parent");
-	}
-
-	/* Check if SIGUSR1 is pending in parent */
-	if (sigismember(&PendSig, SIGUSR1) != 1) {
-		tst_brkm(TBROK, cleanup,
-			 "SIGUSR1 signal is not pending in parent");
+		exit(0);
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
+static void sig_handler(LTP_ATTRIBUTE_UNUSED int signo)
 {
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Release the signal 'SIGUSR1'  if still in pending state.
- */
-void cleanup(void)
+static void setup(void)
 {
+	struct sigaction action;
 
-	/* Release the signal 'SIGUSR1' if in pending state */
-	if (sigrelse(SIGUSR1) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to release 'SIGUSR1' in cleanup");
-	}
+	memset(&action, 0, sizeof(action));
+	action.sa_handler = sig_handler;
 
+	SAFE_SIGACTION(SIGUSR1, &action, NULL);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

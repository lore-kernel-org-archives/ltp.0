Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355B4EFCD96
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 10:46:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2EDD3DD6B8
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 11:46:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19B533DD984
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 11:45:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 837381A006AB
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 11:45:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 759975BE53;
 Mon,  9 Mar 2026 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773053112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9C7OEFV4m12EDSiZPWPdL2c3axvzNWkn+tF2dNW088=;
 b=pO2tAhXXwgQ6miczBKJChUp3WuskMXyhr2gyOwLtXpKxiUhZ68clow8bwgTQ+XyWtXlI7W
 e3dBD2hFFvzmfZPFUbjrHdw9V6NzTUCYr5svOyP6t2eQBSEZOPteYlVe0vVe+STRn7kBTg
 mbcj0n2EHBAMiztXlVGT9DU7R7YxYtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773053112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9C7OEFV4m12EDSiZPWPdL2c3axvzNWkn+tF2dNW088=;
 b=ohirSZ8BbNd5tpxCJ+H+5Aiyfzb4ZswsRL0xsFIyJCgIERGBNOnmyoQoM/A4Fi2zabEK3w
 uWUbNJsyIzFj/ODw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pO2tAhXX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ohirSZ8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773053112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9C7OEFV4m12EDSiZPWPdL2c3axvzNWkn+tF2dNW088=;
 b=pO2tAhXXwgQ6miczBKJChUp3WuskMXyhr2gyOwLtXpKxiUhZ68clow8bwgTQ+XyWtXlI7W
 e3dBD2hFFvzmfZPFUbjrHdw9V6NzTUCYr5svOyP6t2eQBSEZOPteYlVe0vVe+STRn7kBTg
 mbcj0n2EHBAMiztXlVGT9DU7R7YxYtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773053112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9C7OEFV4m12EDSiZPWPdL2c3axvzNWkn+tF2dNW088=;
 b=ohirSZ8BbNd5tpxCJ+H+5Aiyfzb4ZswsRL0xsFIyJCgIERGBNOnmyoQoM/A4Fi2zabEK3w
 uWUbNJsyIzFj/ODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D3FB3EE67;
 Mon,  9 Mar 2026 10:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOw9DbikrmlcTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 09 Mar 2026 10:45:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Mar 2026 11:45:12 +0100
MIME-Version: 1.0
Message-Id: <20260309-fork_refactoring-v3-3-8a645d7e00db@suse.com>
References: <20260309-fork_refactoring-v3-0-8a645d7e00db@suse.com>
In-Reply-To: <20260309-fork_refactoring-v3-0-8a645d7e00db@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773053111; l=8612;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=MILJmitePlocVlfDEvIrRTSABDO2YrEOwqMBKDdbm8o=;
 b=lJnilh6SDa4r5mUiUXfATTaFXMy913SxovZ54LtMqfw5jXzIKN+WVA5ShDX0qu2QEM0f9jnXp
 JM6gF8/hY+EB9pEAgjsK2k2+G/rQnPjRawghQnoE6GslwHoGyltAyGI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 759975BE53
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] syscalls: refactor vfork02 using new API
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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

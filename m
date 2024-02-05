Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2278FC48292
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 16:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E78C03CF620
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 17:50:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 213293CC6C8
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 17:49:59 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C526600288
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 17:49:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1765B1F911
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707151798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GhfxCAQeWPiVbq0+v55+BVq87YqiryEjNm1TLmC8l9I=;
 b=YM9CwQlcCoa4kkdKLtbWK6kFTWROCyscehRcB1xg366CzzBILxxgHqZha76bwEO4BJNKju
 vWP1dNV09qCIbGGomhuqaCoUraCMzaLjJMkqye4/fQOBPim4mRLbCFWS2SjBgKPKWJMteK
 4De38Go2IZAR6YEHGfhEUaYLGapOx/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707151798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GhfxCAQeWPiVbq0+v55+BVq87YqiryEjNm1TLmC8l9I=;
 b=DUkPIUxgyJj5HtRO/I5RvDSVNQhjC/V1w/B1/mlxz13O2bXaYW2Jk6ESZEtVMCAZiYVl82
 M7u971Mi0OOVi1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707151798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GhfxCAQeWPiVbq0+v55+BVq87YqiryEjNm1TLmC8l9I=;
 b=YM9CwQlcCoa4kkdKLtbWK6kFTWROCyscehRcB1xg366CzzBILxxgHqZha76bwEO4BJNKju
 vWP1dNV09qCIbGGomhuqaCoUraCMzaLjJMkqye4/fQOBPim4mRLbCFWS2SjBgKPKWJMteK
 4De38Go2IZAR6YEHGfhEUaYLGapOx/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707151798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GhfxCAQeWPiVbq0+v55+BVq87YqiryEjNm1TLmC8l9I=;
 b=DUkPIUxgyJj5HtRO/I5RvDSVNQhjC/V1w/B1/mlxz13O2bXaYW2Jk6ESZEtVMCAZiYVl82
 M7u971Mi0OOVi1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09DEB132DD
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 16:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yeMiArYRwWWvFgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 05 Feb 2024 16:49:58 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 Feb 2024 17:49:56 +0100
Message-ID: <20240205164957.24665-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] waitpid01: Add subtests from waitpid05
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

The waitpid05 test uses mostly the same test scenario as waitpid01
except the child uses kill(getpid(), sig) instead of raise(sig)
and the test also verifies that signals trigger coredump generation
according to POSIX. Add both subtests to waitpid01 and drop the now
obsolete waitpid05.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/syscalls                              |   1 -
 testcases/kernel/syscalls/waitpid/.gitignore  |   1 -
 testcases/kernel/syscalls/waitpid/waitpid01.c | 124 ++++++---
 testcases/kernel/syscalls/waitpid/waitpid05.c | 247 ------------------
 4 files changed, 90 insertions(+), 283 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/waitpid/waitpid05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 98f31c1ee..7794f1465 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1710,7 +1710,6 @@ wait403 wait403
 waitpid01 waitpid01
 waitpid03 waitpid03
 waitpid04 waitpid04
-waitpid05 waitpid05
 waitpid06 waitpid06
 waitpid07 waitpid07
 waitpid08 waitpid08
diff --git a/testcases/kernel/syscalls/waitpid/.gitignore b/testcases/kernel/syscalls/waitpid/.gitignore
index 2fac142c7..51a424653 100644
--- a/testcases/kernel/syscalls/waitpid/.gitignore
+++ b/testcases/kernel/syscalls/waitpid/.gitignore
@@ -1,7 +1,6 @@
 /waitpid01
 /waitpid03
 /waitpid04
-/waitpid05
 /waitpid06
 /waitpid07
 /waitpid08
diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c b/testcases/kernel/syscalls/waitpid/waitpid01.c
index db0ae224b..367f7875c 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid01.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
@@ -11,35 +11,59 @@
  * Check that when a child kills itself with one of the standard signals,
  * the waiting parent is correctly notified.
  *
- * Fork a child that raise()s given signal, the parent checks that the signal
- * was returned.
+ * Fork a child that sends given signal to itself using raise() or kill(),
+ * the parent checks that the signal was returned.
  */
 #include <stdlib.h>
 #include <sys/wait.h>
 #include "tst_test.h"
 
-static int testcase_list[] = {
-	SIGABRT,
-	SIGALRM,
-	SIGBUS,
-	SIGFPE,
-	SIGHUP,
-	SIGILL,
-	SIGINT,
-	SIGKILL,
-	SIGPIPE,
-	SIGPOLL,
-	SIGPROF,
-	SIGQUIT,
-	SIGSEGV,
-	SIGSYS,
-	SIGTERM,
-	SIGTRAP,
-	SIGUSR1,
-	SIGUSR2,
-	SIGVTALRM,
-	SIGXCPU,
-	SIGXFSZ
+static int test_coredump;
+static struct testcase {
+	int sig;
+	int coredump;
+} testcase_list[] = {
+	{SIGABRT, 1},
+	{SIGALRM, 0},
+	{SIGBUS, 1},
+	{SIGFPE, 1},
+	{SIGHUP, 0},
+	{SIGILL, 1},
+	{SIGINT, 0},
+	{SIGKILL, 0},
+	{SIGPIPE, 0},
+	{SIGPOLL, 0},
+	{SIGPROF, 0},
+	{SIGQUIT, 1},
+	{SIGSEGV, 1},
+	{SIGSYS, 1},
+	{SIGTERM, 0},
+	{SIGTRAP, 1},
+	{SIGUSR1, 0},
+	{SIGUSR2, 0},
+	{SIGVTALRM, 0},
+	{SIGXCPU, 1},
+	{SIGXFSZ, 1}
+};
+
+static void child_raise(int sig)
+{
+	raise(sig);
+	exit(0);
+}
+
+static void child_kill(int sig)
+{
+	kill(getpid(), sig);
+	exit(0);
+}
+
+static struct testvariant {
+	void (*func)(int sig);
+	const char *desc;
+} variant_list[] = {
+	{child_raise, "raise(sig)"},
+	{child_kill, "kill(getpid(), sig)"}
 };
 
 static void setup(void)
@@ -47,19 +71,32 @@ static void setup(void)
 	struct rlimit lim = { 0 };
 
 	/* Disable core dumps */
-	SAFE_SETRLIMIT(RLIMIT_CORE, &lim);
+	SAFE_GETRLIMIT(RLIMIT_CORE, &lim);
+
+	if (lim.rlim_max) {
+		lim.rlim_cur = getpagesize();
+
+		if (lim.rlim_max > 0 && lim.rlim_max < lim.rlim_cur)
+			lim.rlim_cur = lim.rlim_max;
+
+		SAFE_SETRLIMIT(RLIMIT_CORE, &lim);
+		test_coredump = 1;
+	} else {
+		tst_res(TCONF, "Skipping coredump tests due to low rlimit");
+	}
+
+	tst_res(TINFO, "Testing child: %s", variant_list[tst_variant].desc);
 }
 
 static void run(unsigned int n)
 {
 	pid_t pid;
-	int status, sig = testcase_list[n];
+	int status;
+	const struct testcase *tc = testcase_list + n;
 
 	pid = SAFE_FORK();
-	if (!pid) {
-		raise(sig);
-		exit(0);
-	}
+	if (!pid)
+		variant_list[tst_variant].func(tc->sig);
 
 	TST_EXP_PID_SILENT(waitpid(pid, &status, 0));
 	if (!TST_PASS)
@@ -80,18 +117,37 @@ static void run(unsigned int n)
 
 	tst_res(TPASS, "WIFSIGNALED() set in status");
 
-	if (WTERMSIG(status) != sig) {
-		tst_res(TFAIL, "WTERMSIG() != %s but %s", tst_strsig(sig),
+	if (WTERMSIG(status) != tc->sig) {
+		tst_res(TFAIL, "WTERMSIG() != %s but %s", tst_strsig(tc->sig),
 			tst_strsig(WTERMSIG(status)));
 		return;
 	}
 
-	tst_res(TPASS, "WTERMSIG() == %s", tst_strsig(sig));
+	tst_res(TPASS, "WTERMSIG() == %s", tst_strsig(tc->sig));
+
+	if (!test_coredump)
+		return;
+
+	if (!tc->coredump) {
+		if (WCOREDUMP(status))
+			tst_res(TFAIL, "Child unexpectedly dumped core");
+
+		return;
+	}
+
+	if (!WCOREDUMP(status)) {
+		tst_res(TFAIL, "Child did not dump core when expected");
+		return;
+	}
+
+	tst_res(TPASS, "Child dumped core as expected");
 }
 
 static struct tst_test test = {
 	.forks_child = 1,
 	.setup = setup,
 	.test = run,
-	.tcnt = ARRAY_SIZE(testcase_list)
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.test_variants = ARRAY_SIZE(variant_list),
+	.needs_tmpdir = 1	/* for coredumps */
 };
diff --git a/testcases/kernel/syscalls/waitpid/waitpid05.c b/testcases/kernel/syscalls/waitpid/waitpid05.c
deleted file mode 100644
index 5466fd911..000000000
--- a/testcases/kernel/syscalls/waitpid/waitpid05.c
+++ /dev/null
@@ -1,247 +0,0 @@
-/*
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
- */
-
-/*
- * NAME
- *	waitpid05.c
- *
- * DESCRIPTION
- *	Check that when a child kills itself with a kill statement after
- *	determining its process id by using getpid, the parent receives a
- *	correct report of the cause of its death. This also indirectly
- *	checks that getpid returns the correct process id.
- *
- * ALGORITHM
- *	For signals 1 - 15: fork a child that determines it's own process
- *	id, then sends the signal to itself.  The parent waits to see if the
- *	demise of the child results in the signal number being returned to
- *	the parent.
- *
- * USAGE:  <for command-line>
- *      waitpid05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *	04/2002 wjhuie sigset cleanups
- *
- * Restrictions
- *	None
- */
-
-#include <sys/file.h>
-#include <sys/signal.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <unistd.h>
-#include <errno.h>
-#include "test.h"
-
-static void do_child(int);
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "waitpid05";
-int TST_TOTAL = 1;
-
-#ifdef UCLINUX
-static void do_child_uclinux(void);
-static int sig_uclinux;
-#endif
-
-int main(int ac, char **av)
-{
-	int pid, npid, sig, nsig;
-	int exno, nexno, status;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child_uclinux, "d", &sig_uclinux);
-#endif
-
-	setup();
-
-	/* check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * Set SIGTERM to SIG_DFL as test driver sets up to ignore
-		 * SIGTERM
-		 */
-		if (signal(SIGTERM, SIG_DFL) == SIG_ERR) {
-			tst_resm(TFAIL, "Sigset SIGTERM failed, errno = %d",
-				 errno);
-
-		}
-
-		exno = 1;
-		for (sig = 1; sig <= 15; sig++) {
-			if (sig == SIGUSR1 || sig == SIGUSR2 || sig == SIGBUS)
-				continue;
-
-			/*Initialize signal to its default action */
-			signal(sig, SIG_DFL);
-			pid = FORK_OR_VFORK();
-
-			if (pid == 0) {
-#ifdef UCLINUX
-				self_exec(av[0], "d", sig);
-				/* No fork() error check is done so don't */
-				/* do an error check here */
-#else
-				do_child(sig);
-#endif
-			} else {
-				errno = 0;
-				while (((npid = waitpid(pid, &status, 0)) !=
-					-1) || (errno == EINTR)) {
-					if (errno == EINTR)
-						continue;
-
-					if (npid != pid) {
-						tst_resm(TFAIL, "waitpid "
-							 "error: unexpected "
-							 "pid returned");
-					} else {
-						tst_resm(TPASS, "received "
-							 "expected pid.");
-					}
-
-					nsig = status % 256;
-
-					/*
-					 * to check if the core dump bit has
-					 * been set, bit #7
-					 */
-					if (nsig >= 128) {
-						nsig -= 128;
-						if ((sig == 1) || (sig == 2) ||
-						    (sig == 9) || (sig == 13) ||
-						    (sig == 14) ||
-						    (sig == 15)) {
-							tst_resm(TFAIL,
-								 "signal "
-								 "error : "
-								 "core dump "
-								 "bit set for"
-								 " exception "
-								 "number %d",
-								 sig);
-						}
-					} else if ((sig == 3) || (sig == 4) ||
-						   (sig == 5) || (sig == 6) ||
-						   (sig == 8) || (sig == 11)) {
-						tst_resm(TFAIL,
-							 "signal error: "
-							 "core dump bit not "
-							 "set for exception "
-							 "number %d", sig);
-					}
-
-					/*
-					 * nsig is the signal number returned
-					 * by waitpid
-					 */
-					if (nsig != sig) {
-						tst_resm(TFAIL, "waitpid "
-							 "error: unexpected "
-							 "signal returned");
-						tst_resm(TINFO, "got signal "
-							 "%d, expected  "
-							 "%d", nsig, sig);
-					}
-
-					/*
-					 * nexno is the exit number returned
-					 * by waitpid
-					 */
-					nexno = status / 256;
-					if (nexno != 0) {
-						tst_resm(TFAIL, "signal "
-							 "error: unexpected "
-							 "exit number "
-							 "returned");
-					} else {
-						tst_resm(TPASS, "received "
-							 "expected exit number.");
-					}
-				}
-			}
-		}
-
-		if (access("core", F_OK) == 0)
-			unlink("core");
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void do_child(int sig)
-{
-	int exno = 1;
-	int pid = getpid();
-
-	if (kill(pid, sig) == -1) {
-		tst_resm(TFAIL, "kill error: kill unsuccessful");
-		exit(exno);
-	}
-}
-
-#ifdef UCLINUX
-/*
- * do_child_uclinux()
- *	run do_child with the appropriate sig variable
- */
-static void do_child_uclinux(void)
-{
-	do_child(sig_uclinux);
-}
-#endif
-
-static void setup(void)
-{
-	struct rlimit newlimit;
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	newlimit.rlim_max = newlimit.rlim_cur = RLIM_INFINITY;
-	if (setrlimit(RLIMIT_CORE, &newlimit) != 0)
-		tst_resm(TWARN,
-			 "setrlimit(RLIMIT_CORE,RLIM_INFINITY) failed; this may cause some false core-dump test failures");
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

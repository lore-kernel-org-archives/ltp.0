Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CCEC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 16:28:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E1703CF973
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 17:28:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E413F3CF965
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 17:28:19 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 358711A01137
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 17:28:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 279881F848
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706632098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5riv3yUqKVyi19ova/fyMfsLjQQwY4c0dzLgPnDwly0=;
 b=tRg4OvS0JZmdeveZp9MKxY/ZuKcNP0UA9douLGheTILmbe7bM9IeJoQn91TBQjbgtNzyWf
 3xLN+hlnkxkDiaNIFQ+TWdUPzu/1o6cfqoIsyCn0jdeYYvmOft9+zR9tVQianmyNymFrUr
 pyyPqqeo8FDnaoKz89qgpIKBU7bldjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706632098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5riv3yUqKVyi19ova/fyMfsLjQQwY4c0dzLgPnDwly0=;
 b=KdgO2xYc5eFDbpA2jDc9L0WRvkktnu4OWQNXfEQjL8S1oE0XXvtJACRbTqQZ4EsCuxrTzf
 Yvirge2/GLCxWoBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706632098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5riv3yUqKVyi19ova/fyMfsLjQQwY4c0dzLgPnDwly0=;
 b=tRg4OvS0JZmdeveZp9MKxY/ZuKcNP0UA9douLGheTILmbe7bM9IeJoQn91TBQjbgtNzyWf
 3xLN+hlnkxkDiaNIFQ+TWdUPzu/1o6cfqoIsyCn0jdeYYvmOft9+zR9tVQianmyNymFrUr
 pyyPqqeo8FDnaoKz89qgpIKBU7bldjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706632098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5riv3yUqKVyi19ova/fyMfsLjQQwY4c0dzLgPnDwly0=;
 b=KdgO2xYc5eFDbpA2jDc9L0WRvkktnu4OWQNXfEQjL8S1oE0XXvtJACRbTqQZ4EsCuxrTzf
 Yvirge2/GLCxWoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F03FF13A66
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 16:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eQMiOqEjuWWNCAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 16:28:17 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jan 2024 17:28:12 +0100
Message-ID: <20240130162813.20278-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [8.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(5.10)[99.99%];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] waitpid01: Test all standard deadly signals
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

Extend waitpid01 to test all standard signals that kill the target
process unless caught. Also remove waitpid02 since testing SIGFPE
in waitpid01 makes it redundant.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/syscalls                              |   1 -
 testcases/kernel/syscalls/waitpid/.gitignore  |   1 -
 testcases/kernel/syscalls/waitpid/waitpid01.c |  60 +++++--
 testcases/kernel/syscalls/waitpid/waitpid02.c | 167 ------------------
 4 files changed, 47 insertions(+), 182 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/waitpid/waitpid02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6e2407879..98f31c1ee 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1708,7 +1708,6 @@ wait402 wait402
 wait403 wait403
 
 waitpid01 waitpid01
-waitpid02 waitpid02
 waitpid03 waitpid03
 waitpid04 waitpid04
 waitpid05 waitpid05
diff --git a/testcases/kernel/syscalls/waitpid/.gitignore b/testcases/kernel/syscalls/waitpid/.gitignore
index cf9ddf6fa..2fac142c7 100644
--- a/testcases/kernel/syscalls/waitpid/.gitignore
+++ b/testcases/kernel/syscalls/waitpid/.gitignore
@@ -1,5 +1,4 @@
 /waitpid01
-/waitpid02
 /waitpid03
 /waitpid04
 /waitpid05
diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c b/testcases/kernel/syscalls/waitpid/waitpid01.c
index 5a39a1107..b6d8f6078 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid01.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
@@ -5,25 +5,57 @@
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
- * Check that when a child kills itself by SIGALRM the waiting parent is
- * correctly notified.
+/*\
+ * [Description]
+ *
+ * Check that when a child kills itself with one of the standard signals,
+ * the waiting parent is correctly notified.
  *
- * Fork a child that raises(SIGALRM), the parent checks that SIGALRM was
- * returned.
+ * Fork a child that raise()s given signal, the parent checks that the signal
+ * was returned.
  */
 #include <stdlib.h>
 #include <sys/wait.h>
 #include "tst_test.h"
 
-static void run(void)
+static int testcase_list[] = {
+	SIGABRT,
+	SIGALRM,
+	SIGBUS,
+	SIGFPE,
+	SIGHUP,
+	SIGILL,
+	SIGINT,
+	SIGKILL,
+	SIGPIPE,
+	SIGPOLL,
+	SIGPROF,
+	SIGQUIT,
+	SIGSEGV,
+	SIGSYS,
+	SIGTERM,
+	SIGTRAP,
+	SIGVTALRM,
+	SIGXCPU,
+	SIGXFSZ
+};
+
+static void setup(void)
+{
+	struct rlimit lim = { 0 };
+
+	/* Disable core dumps */
+	SAFE_SETRLIMIT(RLIMIT_CORE, &lim);
+}
+
+static void run(unsigned int n)
 {
 	pid_t pid;
-	int status;
+	int status, sig = testcase_list[n];
 
 	pid = SAFE_FORK();
 	if (!pid) {
-		raise(SIGALRM);
+		raise(sig);
 		exit(0);
 	}
 
@@ -46,16 +78,18 @@ static void run(void)
 
 	tst_res(TPASS, "WIFSIGNALED() set in status");
 
-	if (WTERMSIG(status) != SIGALRM) {
-		tst_res(TFAIL, "WTERMSIG() != SIGALRM but %s",
-		        tst_strsig(WTERMSIG(status)));
+	if (WTERMSIG(status) != sig) {
+		tst_res(TFAIL, "WTERMSIG() != %s but %s", tst_strsig(sig),
+			tst_strsig(WTERMSIG(status)));
 		return;
 	}
 
-	tst_res(TPASS, "WTERMSIG() == SIGALRM");
+	tst_res(TPASS, "WTERMSIG() == %s", tst_strsig(sig));
 }
 
 static struct tst_test test = {
 	.forks_child = 1,
-	.test_all = run,
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcase_list)
 };
diff --git a/testcases/kernel/syscalls/waitpid/waitpid02.c b/testcases/kernel/syscalls/waitpid/waitpid02.c
deleted file mode 100644
index 1164a7834..000000000
--- a/testcases/kernel/syscalls/waitpid/waitpid02.c
+++ /dev/null
@@ -1,167 +0,0 @@
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
- *	waitpid02.c
- *
- * DESCRIPTION
- *	Check that when a child gets killed by an integer zero
- *	divide exception, the waiting parent is correctly notified.
- *
- * ALGORITHM
- *	Fork a child and send a SIGFPE to it. The parent waits for the
- *	death of the child and checks that SIGFPE was returned.
- *
- * USAGE:  <for command-line>
- *      waitpid02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *	10/2002 Paul Larson
- *		Div by zero doesn't cause SIGFPE on some archs, fixed
- *		to send the signal with kill
- *
- * Restrictions
- *	None
- */
-
-#include <sys/file.h>
-#include <sys/resource.h>
-#include <sys/signal.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <errno.h>
-#include "test.h"
-
-static void do_child(void);
-static void setup(void);
-
-char *TCID = "waitpid02";
-int TST_TOTAL = 1;
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	int pid, npid, sig, nsig;
-	int nexno, status;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		sig = SIGFPE;
-
-		pid = FORK_OR_VFORK();
-
-		if (pid < 0)
-			tst_brkm(TBROK|TERRNO, NULL, "fork failed");
-
-		if (pid == 0) {
-#ifdef UCLINUX
-			self_exec(argv[0], "");
-			/* No fork() error check is done so don't check here */
-#else
-			do_child();
-#endif
-		} else {
-			kill(pid, sig);
-			errno = 0;
-			while (((npid = waitpid(pid, &status, 0)) != -1) ||
-			       (errno == EINTR)) {
-				if (errno == EINTR)
-					continue;
-
-				if (npid != pid) {
-					tst_resm(TFAIL, "waitpid error: "
-						 "unexpected pid returned");
-				} else {
-					tst_resm(TPASS,
-						 "received expected pid");
-				}
-
-				nsig = WTERMSIG(status);
-
-				/*
-				 * nsig is the signal number returned by
-				 * waitpid
-				 */
-				if (nsig != sig) {
-					tst_resm(TFAIL, "waitpid error: "
-						 "unexpected signal returned");
-				} else {
-					tst_resm(TPASS, "received expected "
-						 "signal");
-				}
-
-				/*
-				 * nexno is the exit number returned by
-				 * waitpid
-				 */
-				nexno = WEXITSTATUS(status);
-				if (nexno != 0) {
-					tst_resm(TFAIL, "signal error: "
-						 "unexpected exit number "
-						 "returned");
-				} else {
-					tst_resm(TPASS, "received expected "
-						 "exit value");
-				}
-			}
-		}
-	}
-
-	tst_exit();
-}
-
-static void do_child(void)
-{
-	int exno = 1;
-
-	while (1)
-		usleep(10);
-
-	exit(exno);
-}
-
-static void setup(void)
-{
-	/* SIGFPE is expected signal, so avoid creating any corefile.
-	 * '1' is a special value, that will also avoid dumping via pipe. */
-	struct rlimit r;
-	r.rlim_cur = 1;
-	r.rlim_max = 1;
-	setrlimit(RLIMIT_CORE, &r);
-
-	TEST_PAUSE;
-}
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

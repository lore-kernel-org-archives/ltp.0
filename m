Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5532C47DDB
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 15:48:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBC843CF9B2
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 16:48:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 800883CC94C
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 16:48:13 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 842D11A027A4
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 16:48:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14BA51F7F5
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706543291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sD2Bd5LGF1ZisgVrUP6EYY2p3Pny424gq+eZVbVuD6I=;
 b=OUkKnK3sKGS0qeg8pJf+tdMRWJ7OWVlJDS/Ouhiv56Ku6L3pqoRklj0QXceg+zNM5e/Yc6
 SJvN7C4XQQ+CzF6VdopnI6m5BhflOL+itxWSo4lD8Gz8xsM047HvDt4+UtFBDLxn7A9m9N
 EfXlfGpvgNwbpYrIJHnxFJNVkjnFXvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706543291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sD2Bd5LGF1ZisgVrUP6EYY2p3Pny424gq+eZVbVuD6I=;
 b=k92CI/W+mG8c+Yo8XjUzW5hEwchtITvnSXBlvk/uVroNHRQnhes+2Lo01x+n/QD0YFKVEb
 LigOlEy45VYFtyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706543291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sD2Bd5LGF1ZisgVrUP6EYY2p3Pny424gq+eZVbVuD6I=;
 b=OUkKnK3sKGS0qeg8pJf+tdMRWJ7OWVlJDS/Ouhiv56Ku6L3pqoRklj0QXceg+zNM5e/Yc6
 SJvN7C4XQQ+CzF6VdopnI6m5BhflOL+itxWSo4lD8Gz8xsM047HvDt4+UtFBDLxn7A9m9N
 EfXlfGpvgNwbpYrIJHnxFJNVkjnFXvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706543291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sD2Bd5LGF1ZisgVrUP6EYY2p3Pny424gq+eZVbVuD6I=;
 b=k92CI/W+mG8c+Yo8XjUzW5hEwchtITvnSXBlvk/uVroNHRQnhes+2Lo01x+n/QD0YFKVEb
 LigOlEy45VYFtyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D5313647
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 15:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8zGzAbvIt2XwSQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 15:48:11 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jan 2024 16:48:05 +0100
Message-ID: <20240129154806.24291-1-mdoucha@suse.cz>
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
Subject: [LTP] [PATCH] waitpid03: Convert to new API
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

Simplify the test by having the child processes immediately exit()
instead of killing them with a signal. Also check the return value
more thoroughly, including that waiting for invalid PID will cause
ECHILD error.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/waitpid/waitpid03.c | 224 +++++-------------
 1 file changed, 55 insertions(+), 169 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
index 7eae3ad5a..573b30559 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid03.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
@@ -1,194 +1,80 @@
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
+ * Copyright (c) 2024 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * NAME
- *	waitpid03.c
- *
- * DESCRIPTION
- *	Check that parent waits unitl specific child has returned.
- *
- * ALGORITHM
- *	Parent forks numerous (22 = MAXUPRC - 3) children, and starts waits :
- *	Should only wait for the specific child, a second wait on the same
- *	child should return with -1 and not one of the other zombied
- *	children.
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *      waitpid03 [-c n] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
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
+ * Check that waitpid() returns the exit status of a specific child process
+ * and repeated call on the same process will fail with ECHILD
  */
 
-#define DEBUG 0
-
+#include <stdlib.h>
 #include <sys/types.h>
 #include <signal.h>
 #include <errno.h>
 #include <sys/wait.h>
-#include "test.h"
 
-static void do_child(int);
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
 
-char *TCID = "waitpid03";
-int TST_TOTAL = 1;
+#define	MAX_CHILDREN 25
 
-#define	MAXUPRC	25
+static pid_t children[MAX_CHILDREN];
 
-static int ikids;
-static int pid[MAXUPRC];
-static int condition_number;
+void check_waitpid(pid_t pid, int reaped)
+{
+	TEST(waitpid(pid, NULL, 0));
 
-#ifdef UCLINUX
-static void do_child_uclinux(void);
-static int ikids_uclinux;
-#endif
+	if (!reaped && pid == (pid_t)TST_RET) {
+		tst_res(TPASS, "waitpid(%d) returned correct PID", pid);
+		return;
+	}
 
-int main(int argc, char **argv)
-{
-	int lc;
-
-	int status, ret;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "d", &ikids_uclinux);
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
-		if ((sig_t) signal(SIGTERM, SIG_DFL) == SIG_ERR) {
-			tst_resm(TFAIL, "Signal SIGTERM failed, errno = %d",
-				 errno);
-
-		}
-
-		while (++ikids < MAXUPRC) {
-			pid[ikids] = FORK_OR_VFORK();
-			if (pid[ikids] > 0) {
-				if (DEBUG)
-					tst_resm(TINFO, "child # %d", ikids);
-			} else if (pid[ikids] == -1) {
-				tst_brkm(TBROK|TERRNO, cleanup, "cannot open "
-					"fork #%d", ikids);
-
-			} else {
-#ifdef UCLINUX
-				if (self_exec(argv[0], "d", ikids) < 0) {
-					tst_resm(TFAIL, "cannot self_exec #%d",
-						 ikids);
-				}
-#else
-				do_child(ikids);
-#endif
-			}
-		}
-
-		for (ikids = 1; ikids < MAXUPRC; ikids++) {
-			if (DEBUG)
-				tst_resm(TINFO, "Killing #%d", ikids);
-			kill(pid[ikids], SIGTERM);
-		}
-
-		ikids = 0;
-		condition_number = 1;
-
-		/* Wait on one specific child */
-		if (DEBUG)
-			tst_resm(TINFO, "Waiting for child:#%d", MAXUPRC / 2);
-		ret = waitpid(pid[MAXUPRC / 2], &status, 0);
-		if (ret != pid[MAXUPRC / 2]) {
-			tst_resm(TFAIL, "condition %d test failed. "
-				 "waitpid(%d) returned %d.",
-				 condition_number, pid[MAXUPRC / 2], ret);
-		} else {
-			tst_resm(TPASS, "Got correct child PID");
-		}
-		condition_number++;
-
-		/*
-		 * Child has already been waited on, waitpid should return
-		 * -1
-		 */
-		ret = waitpid(pid[MAXUPRC / 2], &status, 0);
-		if (ret != -1) {
-			tst_resm(TFAIL, "condition %d test failed",
-				 condition_number);
-		} else {
-			tst_resm(TPASS, "Condition %d test passed",
-				 condition_number);
-		}
-		condition_number++;
+	if (reaped && TST_RET == -1 && TST_ERR == ECHILD) {
+		tst_res(TPASS | TTERRNO, "waitpid(%d) failed on reaped child",
+			pid);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "waitpid(%d) failed", pid);
+		return;
+	}
 
-static void do_child(int ikids)
-{
-	if (DEBUG)
-		tst_resm(TINFO, "child:%d", ikids);
-	pause();
-	exit(0);
-}
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TTERRNO,
+			"Unexpected waitpid(%d) return value %ld", pid,
+			TST_RET);
+		return;
+	}
 
-#ifdef UCLINUX
-/*
- * do_child_uclinux()
- *	run do_child with the appropriate ikids variable
- */
-static void do_child_uclinux(void)
-{
-	do_child(ikids_uclinux);
+	tst_res(TFAIL, "waitpid(%d) returned unexpected PID %ld", pid, TST_RET);
 }
-#endif
 
-static void setup(void)
+void run(void)
 {
-	TEST_PAUSE;
-}
+	int i;
 
-static void cleanup(void)
-{
-	while (ikids-- > 1)
-		kill(pid[ikids], SIGKILL);
+	for (i = 0; i < MAX_CHILDREN; i++) {
+		children[i] = SAFE_FORK();
+
+		/* Children have nothing to do... */
+		if (!children[i])
+			exit(0);
+	}
+
+	/* Wait for one specific child */
+	i = MAX_CHILDREN / 2;
+	check_waitpid(children[i], 0);
+
+	/* Try the same child again after it was reaped */
+	check_waitpid(children[i], 1);
+	tst_reap_children();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1
+};
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

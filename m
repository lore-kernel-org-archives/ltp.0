Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B9EB64D9
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 08:47:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0B4E3CC7BC
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 10:47:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4822E3C0424
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 10:47:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E7DA10007FD
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 10:47:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 627701FE1B
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 08:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689151642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gzT/L4Agr+KIRtlPybcAMHXbZHhC9bBDfv5qc53OtXY=;
 b=11Ud8rp3TNfLx65oobTGZrelk8BJ3AJ44+/hJTfyyhXQd3piJu8C1Hx5vMNo6GBjo8ZrfA
 XlrVhOWSW5k5JzeI/trOWt4yk/JdqKdmyuuiw69a4OpsKCtVW/jSVCn++nElSEfBcCRpD3
 WAXtt+ucICmm07Qj3ieuEgx5fmzLU7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689151642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gzT/L4Agr+KIRtlPybcAMHXbZHhC9bBDfv5qc53OtXY=;
 b=o/ZNDTmbAgIKhe2Wydh6WN8mxHHfIGmj5C2Hsz6dfT91iMAV+rVNU2uQWeQJ5sjeX7NF+G
 4pLzbkD9yDg66SDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D266133DD
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 08:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1gDENplormT3UQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 08:47:21 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 12 Jul 2023 14:17:17 +0530
Message-ID: <20230712084720.4261-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pipe10.c: Rewrite the test using new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/pipe/pipe10.c | 179 +++++-------------------
 1 file changed, 34 insertions(+), 145 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe10.c b/testcases/kernel/syscalls/pipe/pipe10.c
index 48f722e3e..662da523e 100644
--- a/testcases/kernel/syscalls/pipe/pipe10.c
+++ b/testcases/kernel/syscalls/pipe/pipe10.c
@@ -1,164 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
+ *		07/2001 Ported by Wayne Boyer
+ *   Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	pipe10.c
- *
- * DESCRIPTION
- *	Check that parent can open a pipe and have a child read from it
- *
- * ALGORITHM
- *	Parent opens pipe, child reads. Passes if child can read all the
- *	characters written by the parent.
- *
- * USAGE:  <for command-line>
- *  pipe10 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * Verify that, when a parent process opens a pipe, a child process can
+ * read from it.
  */
-#include <errno.h>
-#include <unistd.h>
-#include <sys/wait.h>
-#include <string.h>
-#include "test.h"
 
-char *TCID = "pipe10";
-int TST_TOTAL = 1;
+#include <stdio.h>
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
+static int fds[2];
 
-ssize_t do_read(int fd, void *buf, size_t count)
+static void run(void)
 {
-	ssize_t n;
-
-	do {
-		n = read(fd, buf, count);
-	} while (n < 0 && errno == EINTR);
-
-	return n;
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	int fd[2];		/* fds for pipe read/write */
-	char wrbuf[BUFSIZ], rebuf[BUFSIZ];
-	int red, written;	/* no of chars read and */
-	/* written to pipe */
-	int length, greater, forkstat;
-	int retval = 0, status, e_code;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	int pid;
+	int wr_cnt, rd_cnt;
+	char wrbuf[] = "abcdefghijklmnopqrstuvwxyz";
+	char rdbuf[BUFSIZ];
 
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	SAFE_PIPE(fds);
+	wr_cnt = SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, sizeof(wrbuf));
 
-		TEST(pipe(fd));
+	pid = SAFE_FORK();
 
-		if (TEST_RETURN == -1) {
-			retval = 1;
-			tst_resm(TFAIL, "pipe creation failed");
-			continue;
-		}
-
-		strcpy(wrbuf, "abcdefghijklmnopqrstuvwxyz");
-		length = strlen(wrbuf) + 1;
-
-		written = write(fd[1], wrbuf, length);
-
-		/* did write write at least some chars */
-		if ((written < 0) || (written > length)) {
-			tst_brkm(TBROK, cleanup, "write to pipe failed");
-		}
-
-		forkstat = FORK_OR_VFORK();
-
-		if (forkstat == -1) {
-			tst_brkm(TBROK, cleanup, "fork() failed");
-		}
-
-		if (forkstat == 0) {	/* child */
-			red = do_read(fd[0], rebuf, written);
-
-			/* did read , get at least some chars */
-			if ((red < 0) || (red > written)) {
-				tst_brkm(TBROK, cleanup, "read pipe failed");
-			}
-
-			greater = strcmp(rebuf, wrbuf);
-
-			/* are the strings written and read equal */
-			if (greater == 0) {
-				tst_resm(TPASS, "functionality is correct");
-			} else {
-				retval = 1;
-				tst_resm(TFAIL, "read & write strings do "
-					 "not match");
-			}
-			exit(retval);
-		} else {	/* parent */
-			/* wait for the child to finish */
-			wait(&status);
-			/* make sure the child returned a good exit status */
-			e_code = status >> 8;
-			if (e_code != 0) {
-				tst_resm(TFAIL, "Failures reported above");
-			}
-		}
+	if (pid == 0) {
+		rd_cnt = SAFE_READ(1, fds[0], rdbuf, wr_cnt);
+		TST_EXP_EQ_LU(wr_cnt, rd_cnt);
 	}
-	cleanup();
-
-	tst_exit();
+	tst_reap_children();
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void cleanup(void)
 {
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.cleanup = cleanup
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

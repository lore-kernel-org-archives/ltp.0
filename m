Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8AFC001DB
	for <ltp@archiver.kernel.org>; Fri,  4 Aug 2023 05:30:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35EB93CD4D3
	for <ltp@archiver.kernel.org>; Fri,  4 Aug 2023 07:30:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 351173CB8E5
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 07:30:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5EC41601189
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 07:30:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6580E1F8A4
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 05:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691127024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uixMdPreZBo42QRh3JOi7ZN++1eabgcfmtx0jXi2xns=;
 b=euyZvlnozIadSvdc11PQtyThBKr+fk7onvcPZ98MhXLovAbVPJtE5b8GZCULCcz0VWK67S
 P8SHL2d/56xI4iUxI+Eyo3Mvps7IDn6M624R19yHgi/YxFF7f+8/EirgamB+VMeBjFCHIK
 VaF6TTPRUIqRJMXOjzJ4khzcnafNyFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691127024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uixMdPreZBo42QRh3JOi7ZN++1eabgcfmtx0jXi2xns=;
 b=GgvJf2AWVoNnbyVNfCxaNLTLWL7daseg4UGI7SDBztA6zahifenpq3z6RC4K/0AYyR+Tgk
 7KXDJ9UOtjcJJBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ACA013904
 for <ltp@lists.linux.it>; Fri,  4 Aug 2023 05:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M8/bNe+MzGTYJQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 04 Aug 2023 05:30:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  4 Aug 2023 10:56:17 +0530
Message-ID: <20230804053022.22008-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pipe08: Rewrite test using new LTP API
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

Background [1]

Signed-off-by: Avinesh Kumar <akumar@suse.de>

[1] https://lore.kernel.org/ltp/ZMopSzK0MpPIj3p4@yuki/
---
 testcases/kernel/syscalls/pipe/pipe08.c | 152 ++++++------------------
 1 file changed, 37 insertions(+), 115 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe08.c b/testcases/kernel/syscalls/pipe/pipe08.c
index 173ec788a..1eac7e578 100644
--- a/testcases/kernel/syscalls/pipe/pipe08.c
+++ b/testcases/kernel/syscalls/pipe/pipe08.c
@@ -1,137 +1,59 @@
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
+ *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	pipe08.c
- *
- * DESCRIPTION
- *	Check that a SIGPIPE signal is generated when a write is
- *	attempted on an empty pipe.
- *
- * ALGORITHM
- *	1. Write to a pipe after closing the read side.
- *	2. Check for the signal SIGPIPE to be received.
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  pipe08 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * USAGE
- *	pipe08
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * Verify that, on any attempt to write to a pipe which is closed for
+ * reading will generate a SIGPIPE signal and write will fail with
+ * EPIPE errno.
  */
-#include <errno.h>
-#include <unistd.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
 
-char *TCID = "pipe08";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-void setup(void);
-void cleanup(void);
-void sighandler(int);
+static int pipefd[2];
+static int sigpipe_cnt;
 
-int main(int ac, char **av)
+static void sighandler(int sig)
 {
-	int lc;
-
-	int pipefd[2];		/* fds for pipe read/write */
-	char wrbuf[BUFSIZ];
-	int written, length;
-	int close_stat;		/*  exit status of close(read fd) */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		TEST(pipe(pipefd));
+	if (sig == SIGPIPE)
+		sigpipe_cnt++;
+}
 
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "call failed unexpectedly");
-			continue;
-		}
+static void run(void)
+{
+	char wrbuf[] = "abcdefghijklmnopqrstuvwxyz";
 
-		if ((close_stat = close(pipefd[0])) == -1) {
-			tst_brkm(TBROK, cleanup, "close of read side failed");
-		}
+	sigpipe_cnt = 0;
 
-		strcpy(wrbuf, "abcdefghijklmnopqrstuvwxyz\0");
-		length = strlen(wrbuf);
+	SAFE_PIPE(pipefd);
+	SAFE_CLOSE(pipefd[0]);
 
-		/*
-		 * the SIGPIPE signal will be caught here or else
-		 * the program will dump core when the signal is
-		 * sent
-		 */
-		written = write(pipefd[1], wrbuf, length);
-		if (written > 0)
-			tst_brkm(TBROK, cleanup, "write succeeded unexpectedly");
-	}
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL2_SILENT(write(pipefd[1], wrbuf, sizeof(wrbuf)), EPIPE);
+	TST_EXP_EQ_LI(sigpipe_cnt, 1);
 
+	SAFE_CLOSE(pipefd[1]);
 }
 
-/*
- * sighandler - catch signals and look for SIGPIPE
- */
-void sighandler(int sig)
+static void setup(void)
 {
-	if (sig != SIGPIPE)
-		tst_resm(TFAIL, "expected SIGPIPE, got %d", sig);
-	else
-		tst_resm(TPASS, "got expected SIGPIPE signal");
+	SAFE_SIGNAL(SIGPIPE, sighandler);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void cleanup(void)
 {
-
-	tst_sig(NOFORK, sighandler, cleanup);
-
-	TEST_PAUSE;
+	if (pipefd[0] > 0)
+		SAFE_CLOSE(pipefd[0]);
+	if (pipefd[1] > 0)
+		SAFE_CLOSE(pipefd[1]);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

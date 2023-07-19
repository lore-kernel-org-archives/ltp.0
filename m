Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E09BEB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:39:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 256A03C98EA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 13:39:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 404E23C02B2
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:39:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38F601A00FF3
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:39:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DE661FEBA
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689766748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=owdQj/+GgEnEXhavhcGtKfADFgNj0Ha2+gUcB08Lxqk=;
 b=lVJtM066+gtEoBuJKY6gjaR8NttIzG2ndSygcOcZ6qsV7dJT1lsp/7flwEKQN5islc96d6
 hVf5kaxIunoTvhNZslegIC6PYqwmoNGCK9aNxOcrTOI7bySwQrMq72NETkAx7APBo4boZZ
 pLY5piAk8aIXDDU7Z944HYVAXzSuW0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689766748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=owdQj/+GgEnEXhavhcGtKfADFgNj0Ha2+gUcB08Lxqk=;
 b=pJ0R5OpV6Dq6zJmfDUb7J2d5Mg3CIwCKClHgTDMwxYXASQ5tWC+yWRcIK+C/Ya07cvG1Fe
 TZ2G7y9x9vg/gWCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C68101361C
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NqNFKFvLt2SOZwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:39:07 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 17:07:09 +0530
Message-ID: <20230719113906.22317-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pipe08: Remove the test
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

This test scenario of verifying SIGPIPE signal is being covered in
syscalls/write05.c test.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/pipe/.gitignore |   1 -
 testcases/kernel/syscalls/pipe/pipe08.c   | 137 ----------------------
 3 files changed, 139 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/pipe/pipe08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b29151186..baae0dbe9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -983,7 +983,6 @@ pipe04 pipe04
 pipe05 pipe05
 pipe06 pipe06
 pipe07 pipe07
-pipe08 pipe08
 pipe09 pipe09
 pipe10 pipe10
 pipe11 pipe11
diff --git a/testcases/kernel/syscalls/pipe/.gitignore b/testcases/kernel/syscalls/pipe/.gitignore
index 774d73205..fc0ee705f 100644
--- a/testcases/kernel/syscalls/pipe/.gitignore
+++ b/testcases/kernel/syscalls/pipe/.gitignore
@@ -5,7 +5,6 @@
 /pipe05
 /pipe06
 /pipe07
-/pipe08
 /pipe09
 /pipe10
 /pipe11
diff --git a/testcases/kernel/syscalls/pipe/pipe08.c b/testcases/kernel/syscalls/pipe/pipe08.c
deleted file mode 100644
index 173ec788a..000000000
--- a/testcases/kernel/syscalls/pipe/pipe08.c
+++ /dev/null
@@ -1,137 +0,0 @@
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
- *	pipe08.c
- *
- * DESCRIPTION
- *	Check that a SIGPIPE signal is generated when a write is
- *	attempted on an empty pipe.
- *
- * ALGORITHM
- *	1. Write to a pipe after closing the read side.
- *	2. Check for the signal SIGPIPE to be received.
- *
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
- */
-#include <errno.h>
-#include <unistd.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
-
-char *TCID = "pipe08";
-int TST_TOTAL = 1;
-
-void setup(void);
-void cleanup(void);
-void sighandler(int);
-
-int main(int ac, char **av)
-{
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
-
-		if (TEST_RETURN != 0) {
-			tst_resm(TFAIL, "call failed unexpectedly");
-			continue;
-		}
-
-		if ((close_stat = close(pipefd[0])) == -1) {
-			tst_brkm(TBROK, cleanup, "close of read side failed");
-		}
-
-		strcpy(wrbuf, "abcdefghijklmnopqrstuvwxyz\0");
-		length = strlen(wrbuf);
-
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
-
-}
-
-/*
- * sighandler - catch signals and look for SIGPIPE
- */
-void sighandler(int sig)
-{
-	if (sig != SIGPIPE)
-		tst_resm(TFAIL, "expected SIGPIPE, got %d", sig);
-	else
-		tst_resm(TPASS, "got expected SIGPIPE signal");
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, sighandler, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-}
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

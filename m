Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08473EB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 15:33:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29B43CDDDB
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 17:33:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FDCD3C99A4
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 17:33:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 538426001E0
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 17:33:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C2701FDB2
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689608022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z/rTX43KPTG4JDC3Fnmlqj247wQ1Fsk7XlRDOhoZ9WE=;
 b=V+TRPCPBbMiDbT57mN/O+2wFLi0rwUWFYsqP12UFv8gFCLHeiGm4jHPAmZFRqWw4/8UrYj
 vf/+yulckTfc/GJdM9fE9zWvQdMXqsv5BAqsP2gzkGwTVF/VE8Ch5szVycMkfFdq2Zb0ls
 H+66Np898xK0Blws5hgUNXhgyCiEM3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689608022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Z/rTX43KPTG4JDC3Fnmlqj247wQ1Fsk7XlRDOhoZ9WE=;
 b=PyPfcf09QWdQ7XdXBTisKOUvJlgK5xdq/Oi2TFmp8FJp84GG5nSzVf90C3h33AVzWBgI1P
 oIzltiN5NxxfdRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F16D313276
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 15:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Pv5VMlVftWQTEgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 15:33:41 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 17 Jul 2023 21:03:38 +0530
Message-ID: <20230717153339.11904-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/pipe06: Rewrite the test using new LTP API
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
 testcases/kernel/syscalls/pipe/pipe06.c | 133 ++++++------------------
 1 file changed, 33 insertions(+), 100 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe06.c b/testcases/kernel/syscalls/pipe/pipe06.c
index d83765632..0faebc076 100644
--- a/testcases/kernel/syscalls/pipe/pipe06.c
+++ b/testcases/kernel/syscalls/pipe/pipe06.c
@@ -1,119 +1,52 @@
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
- *	pipe06.c
- *
- * DESCRIPTION
- *	Check what happens when the system runs out of pipes.
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	Issue enough pipe calls to run the system out of pipes.
- *	Check that we get EMFILE.
- *
- * USAGE:  <for command-line>
- *  pipe06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * Verify that, pipe(2) syscall fails with errno EMFILE when
+ * limit on the number of open file descriptors has been reached.
  */
-#include <fcntl.h>
-#include <errno.h>
-#include "test.h"
 
-char *TCID = "pipe06";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
-int pipe_ret, pipes[2];
-void setup(void);
-void cleanup(void);
+static int fds[2];
+static int *opened_fds, num_opened_fds;
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	int max_fds;
 
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	max_fds = getdtablesize();
+	tst_res(TINFO, "getdtablesize() = %d", max_fds);
+	opened_fds = SAFE_MALLOC(max_fds * sizeof(int));
 
-		TEST(pipe(pipes));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-		}
-
-		if (TEST_ERRNO != EMFILE) {
-			tst_resm(TFAIL | TTERRNO, "pipe failed unexpectedly");
-		} else {
-			tst_resm(TPASS, "failed with EMFILE");
-		}
-
-	}
-	cleanup();
-	tst_exit();
+	do {
+		SAFE_PIPE(fds);
+		opened_fds[num_opened_fds++] = fds[0];
+		opened_fds[num_opened_fds++] = fds[1];
+	} while (fds[1] < max_fds - 2);
 
+	tst_res(TINFO, "Number of fds opened by pipe calls: %d", num_opened_fds);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
-	int i, numb_fds;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	numb_fds = getdtablesize();
-
-	for (i = 0; i < numb_fds; i++) {
-		pipe_ret = pipe(pipes);
-		if (pipe_ret < 0) {
-			if (errno != EMFILE) {
-				tst_brkm(TBROK | TTERRNO, cleanup,
-					 "didn't get EMFILE");
-			}
-			break;
-		}
-	}
+	TST_EXP_FAIL(pipe(fds), EMFILE);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
+	for (int i = 0; i < num_opened_fds; i++)
+		SAFE_CLOSE(opened_fds[i]);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

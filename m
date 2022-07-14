Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F374FC43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 06:07:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C2A63CA929
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 08:07:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F1473CA8FB
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 08:07:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 936A51000B29
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 08:07:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EDCCA1FE29
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 06:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657778845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GTC+XLWvuTedNnNqOL7GMNkhIoBdtkyUwHuS1ngeqkw=;
 b=qhWzDtZnmC7gRzv5DppK6TeEtOKllBnjUTkYN4Lofa2jNJkgDT3hzT3M406+yWi5HqalJ5
 ZFExp0ke3KzuP6i/OCGpY8ef8vZ9uzRdrNn+vM9DMJZZKKr8RgPJ0q6U1dwzNfw/+KcmuF
 /BNbob4NPaIYoLEifDTQLJNlryTYbSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657778845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GTC+XLWvuTedNnNqOL7GMNkhIoBdtkyUwHuS1ngeqkw=;
 b=o6OLjDE6SStzIgMB/Jk1hRrPHaa/jxrZSXey3xtNZxYh8aPaH6akPuDgb7A21y+loR32qQ
 OUYBls8VSItNesAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6522A13748
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 06:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MNptCZ2yz2JWIQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 06:07:25 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Jul 2022 11:37:22 +0530
Message-Id: <20220714060722.18894-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open04.c: convert to new LTP API
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
 testcases/kernel/syscalls/open/open04.c | 144 ++++++------------------
 1 file changed, 34 insertions(+), 110 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 7b3b5eb6f..e7cb533fe 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -1,133 +1,57 @@
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
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * DESCRIPTION
- *	Testcase to check that open(2) sets EMFILE if a process opens files
- *	more than its descriptor size
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	First get the file descriptor table size which is set for a process.
- *	Use open(2) for creating files till the descriptor table becomes full.
- *	These open(2)s should succeed. Finally use open(2) to open another
- *	file. This attempt should fail with EMFILE.
+ * Verify that open(2) fails with EMFILE when
+ * per-process limit on the number of open file descriptors has been reached.
  */
 
 #include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "test.h"
-
-char *TCID = "open04";
-int TST_TOTAL = 1;
-
-static int fd, ifile, mypid, first;
-static int nfile;
-static int *buf;
-static char fname[40];
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
+static int fds_limit, first, i;
+static int *fds;
+static char fname[20];
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	int fd;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	fds_limit = getdtablesize();
+	first = SAFE_OPEN("open04", O_RDWR | O_CREAT, 0777);
 
-		TEST(open(fname, O_RDWR | O_CREAT, 0777));
+	fds = SAFE_MALLOC(sizeof(int) * (fds_limit - first));
+	fds[0] = first;
 
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			continue;
-		}
-
-		if (TEST_ERRNO != EMFILE)
-			tst_resm(TFAIL, "Expected EMFILE, got %d", TEST_ERRNO);
-		else
-			tst_resm(TPASS, "call returned expected EMFILE error");
+	for (i = first + 1; i < fds_limit; i++) {
+		sprintf(fname, "open04.%d", i);
+		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0777);
+		fds[i - first] = fd;
 	}
-
-	close(first);
-	close(fd);
-	cleanup();
-	tst_exit();
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
-
-	mypid = getpid();
-	nfile = getdtablesize();
-	sprintf(fname, "open04.%d", mypid);
-
-	first = fd = open(fname, O_RDWR | O_CREAT, 0777);
-	if (first == -1)
-		tst_brkm(TBROK, cleanup, "Cannot open first file");
-
-	close(fd);
-	close(first);
-	unlink(fname);
-
-	/* Allocate memory for stat and ustat structure variables */
-	buf = malloc(sizeof(int) * nfile - first);
-	if (buf == NULL)
-		tst_brkm(TBROK, NULL, "Failed to allocate Memory");
-
-	for (ifile = first; ifile <= nfile; ifile++) {
-		sprintf(fname, "open04.%d.%d", ifile, mypid);
-		fd = open(fname, O_RDWR | O_CREAT, 0777);
-		if (fd == -1) {
-			if (errno != EMFILE) {
-				tst_brkm(TBROK, cleanup, "Expected EMFILE got "
-					 "%d", errno);
-			}
-			break;
-		}
-		buf[ifile - first] = fd;
-	}
+	sprintf(fname, "open04.%d", fds_limit);
+	TST_EXP_FAIL2(open(fname, O_RDWR | O_CREAT, 0777),
+				EMFILE,
+				"open(%s, O_RDWR | O_CREAT, 0777)", fname);
 }
 
 static void cleanup(void)
 {
-	close(first);
-
-	for (ifile = first; ifile < nfile; ifile++) {
-		sprintf(fname, "open04.%d.%d", ifile, mypid);
-		close(buf[ifile - first]);
-		unlink(fname);
-	}
-
-	free(buf);
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
+	for (i = first; i < fds_limit; i++)
+		SAFE_CLOSE(fds[i - first]);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

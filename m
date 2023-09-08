Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5687EE57E0
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 07:34:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB6CC3CC801
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 09:34:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86E383CB513
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 09:34:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 589B31400457
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 09:34:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 338E3218E7;
 Fri,  8 Sep 2023 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694158454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U0w4JF2AUX9X6hi9/jYsqhmAH4fEKXxJMNCTJk+y+ds=;
 b=IGrp8L2TIykMQabt7xbALt/jDzFBoKia6MKlykJruSqjpoff1jfEMoom/lqKVfuLknatlO
 b7vLGKK+n+7sni67Z8H8uvIsYk77I0235YMmkv/98cdR2+f7VIUBa1+NVNX9XF/TxTkR4n
 3jIGWpaiAY86vUUG3Sp+4s0OFhgd54E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694158454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U0w4JF2AUX9X6hi9/jYsqhmAH4fEKXxJMNCTJk+y+ds=;
 b=aso0QLY/KPtjHUq579YLuienHKhHyMaCGeMz1hMRNtRMzIy/Rn3XEYsl6xlU8Q5sNtQVsp
 Cmn96z99dOEcb7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15081132F2;
 Fri,  8 Sep 2023 07:34:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7duCA3bO+mT6EQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 Sep 2023 07:34:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 09:34:07 +0200
Message-Id: <20230908073407.31444-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor fork10 test using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/fork/fork10.c | 215 +++++++++---------------
 1 file changed, 78 insertions(+), 137 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork10.c b/testcases/kernel/syscalls/fork/fork10.c
index 815eee1f6..96f61b5ed 100644
--- a/testcases/kernel/syscalls/fork/fork10.c
+++ b/testcases/kernel/syscalls/fork/fork10.c
@@ -1,159 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
- *
- *
- * NAME
- *	fork10.c
- *
- * DESCRIPTION
- *	Check inheritance of file descriptor by children, they
- *	should all be refering to the same file.
+ * Copyright (c) International Business Machines  Corp., 2001
+ *    07/2001 Ported by Wayne Boyer
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	Child reads several chars and exits.
- *	Parent forks another child, have the child and parent attempt to use
- *	that location
+ * This test verifies inheritance of file descriptors from parent to child
+ * process. We open a file from parent, then we check if file offset changes
+ * accordingly with file descriptor usage.
  *
- * USAGE
- *	fork10
+ * [Algorithm]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Test steps are the following:
+ * - create a file made in three parts -> | aa..a | bb..b | cc..c |
+ * - from parent, open the file
+ * - from child, move file offset after the first part
+ * - from parent, read second part and check if it's | bb..b |
+ * - from child, read third part and check if it's | cc..c |
  *
- * RESTRICTIONS
- *	None
+ * Test passes if we were able to read the correct file parts from parent and
+ * child.
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "fork10";
-int TST_TOTAL = 1;
+#include <stdlib.h>
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
+#define FILENAME "file.txt"
+#define DATASIZE 1024
 
-static char pidbuf[10];
-static char fnamebuf[40];
+static int fd;
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int status, pid, fildes;
-	char parchar[2];
-	char chilchar[2];
-
-	int lc;
-
-	fildes = -1;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fildes = SAFE_CREAT(cleanup, fnamebuf, 0600);
-		write(fildes, "ABCDEFGHIJKLMNOPQRSTUVWXYZ\n", 27);
-		close(fildes);
-
-		fildes = SAFE_OPEN(cleanup, fnamebuf, 0);
-
-		pid = fork();
-		if (pid == -1)
-			tst_brkm(TBROK, cleanup, "fork() #1 failed");
-
-		if (pid == 0) {	/* child */
-			tst_resm(TINFO, "fork child A");
-			if (lseek(fildes, 10L, 0) == -1L) {
-				tst_resm(TFAIL, "bad lseek by child");
-				exit(1);
-			}
-			exit(0);
-		} else {	/* parent */
-			wait(&status);
-
-			/* parent starts second child */
-			pid = fork();
-			if (pid == -1)
-				tst_brkm(TBROK, cleanup, "fork() #2 failed");
-
-			if (pid == 0) {	/* child */
-				if (read(fildes, chilchar, 1) <= 0) {
-					tst_resm(TFAIL, "Child can't read "
-						 "file");
-					exit(1);
-				} else {
-					if (chilchar[0] != 'K') {
-						chilchar[1] = '\n';
-						exit(1);
-					} else {
-						exit(0);
-					}
-				}
-			} else {	/* parent */
-				(void)wait(&status);
-				if (status >> 8 != 0) {
-					tst_resm(TFAIL, "Bad return from "
-						 "second child");
-					continue;
-				}
-				/* parent reads */
-				if (read(fildes, parchar, 1) <= 0) {
-					tst_resm(TFAIL, "Parent cannot read "
-						 "file");
-					continue;
-				} else {
-					write(fildes, parchar, 1);
-					if (parchar[0] != 'L') {
-						parchar[1] = '\n';
-						tst_resm(TFAIL, "Test failed");
-						continue;
-					}
-				}
-			}
-		}
-		tst_resm(TPASS, "test 1 PASSED");
+	int status;
+	char buff[DATASIZE];
+	char data[DATASIZE];
+
+	fd = SAFE_OPEN(FILENAME, 0);
+
+	if (!SAFE_FORK()) {
+		SAFE_LSEEK(fd, DATASIZE, SEEK_SET);
+		exit(0);
+	}
+
+	SAFE_WAIT(&status);
+
+	memset(buff, 'b', DATASIZE);
+	SAFE_READ(0, fd, data, DATASIZE);
+
+	TST_EXP_EXPR(strncmp(buff, data, DATASIZE) == 0,
+		"read first part of data from parent process");
+
+	if (!SAFE_FORK()) {
+		memset(buff, 'c', DATASIZE);
+		SAFE_READ(0, fd, data, DATASIZE);
+
+		TST_EXP_EXPR(strncmp(buff, data, DATASIZE) == 0,
+			"read second part of data from child process");
+
+		exit(0);
 	}
 
-	close(fildes);
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd);
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	umask(0);
-	TEST_PAUSE;
-	tst_tmpdir();
-
-	strcpy(fnamebuf, "fork10.");
-	sprintf(pidbuf, "%d", getpid());
-	strcat(fnamebuf, pidbuf);
+	char buff[DATASIZE];
+
+	fd = SAFE_CREAT(FILENAME, 0600);
+
+	memset(buff, 'a', DATASIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buff, DATASIZE);
+
+	memset(buff, 'b', DATASIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buff, DATASIZE);
+
+	memset(buff, 'c', DATASIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buff, DATASIZE);
+
+	SAFE_CLOSE(fd);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	if (fcntl(fd, F_GETFD) > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

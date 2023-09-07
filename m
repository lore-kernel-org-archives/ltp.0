Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C71EC8733
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 15:05:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D0623CE9CA
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 17:05:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3357C3C9274
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 17:05:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 29D541400F9C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 17:05:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 808B51F8B6;
 Thu,  7 Sep 2023 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694099139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Nn1DUKA7jgM3Ew86UOGPPb5Cb7W8eBHD+V+oXmjOY+Q=;
 b=lxevu7tZ2w/ABQHoi3LkVyEjPMcMqmLdI38XVCJGDf36sUL5aOOSaM6RmTqNZ6TPzLsPpT
 SoNZ0F07+WHpYnPIWbb409NUjZzCXcb9Bzcc8bPU6df497ld+V20GiCZOxNcLVA8b1Wtd/
 lSrcO6vrgjCg6QHfNojfWUyjjvQX3Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694099139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Nn1DUKA7jgM3Ew86UOGPPb5Cb7W8eBHD+V+oXmjOY+Q=;
 b=0Tn3/XVFJFHUH/OSCw1ndxa6N5MHG6hae07rLlJLC0zgsbagpeljhegC2Why2UiS8tPOVi
 upmqv9WoXtmDODAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 618CA138FA;
 Thu,  7 Sep 2023 15:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W90mFsPm+WSjcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 07 Sep 2023 15:05:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 17:05:38 +0200
Message-Id: <20230907150538.16772-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor fork09 using new LTP API
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
 testcases/kernel/syscalls/fork/fork09.c | 222 +++++++++---------------
 1 file changed, 78 insertions(+), 144 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index 32bad89b3..95b007e7e 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -1,172 +1,106 @@
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
- * NAME
- *	fork09.c
- *
- * DESCRIPTION
- *	Check that child has access to a full set of files.
- *
- * ALGORITHM
- *	Parent opens a maximum number of files
- *	Child closes one and attempts to open another, it should be
- *	available
- *
- * USAGE
- *	fork09
- *
- * HISTORY
+ * Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 Ported by Wayne Boyer
- *
  *	10/2008 Suzuki K P <suzuki@in.ibm.com>
  *		Fix maximum number of files open logic.
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * This test checks that child process has access to a full set of files which
+ * have been opened by the parent process.
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>		/* for _SC_OPEN_MAX */
-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+static FILE * *fd;
+static long maxfds;
+
+static void run_child(void)
+{
+	int ret;
+	FILE *file;
+	char filename[32];
 
-char *TCID = "fork09";
-int TST_TOTAL = 1;
+	sprintf(filename, "file0.%d", getpid());
 
-static void setup(void);
-static void cleanup(void);
+	ret = fclose(fd[0]);
+	TST_EXP_EXPR(ret != -1, "closed %s from child", filename);
+	if (ret == -1)
+		exit(1);
 
-static char filname[40], childfile[40];
-static int first;
-static FILE **fildeses;		/* file streams */
-static int mypid, nfiles;
+	fd[0] = NULL;
 
-#define OPEN_MAX (sysconf(_SC_OPEN_MAX))
+	file = fopen(filename, "a");
+	TST_EXP_EXPR(file != NULL, "opened %s from child", filename);
+	if (!file)
+		exit(1);
 
-int main(int ac, char **av)
+	fd[0] = file;
+}
+
+static void run(void)
 {
-	int pid, status, nf;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	fildeses = malloc((OPEN_MAX + 10) * sizeof(FILE *));
-	if (fildeses == NULL)
-		tst_brkm(TBROK, cleanup, "malloc failed");
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		mypid = getpid();
-
-		tst_resm(TINFO, "OPEN_MAX is %ld", OPEN_MAX);
-
-		/* establish first free file */
-		sprintf(filname, "fork09.%d", mypid);
-		first = SAFE_CREAT(cleanup, filname, 0660);
-		close(first);
-
-		tst_resm(TINFO, "first file descriptor is %d ", first);
-
-		SAFE_UNLINK(cleanup, filname);
-
-		/*
-		 * now open all the files for the test
-		 */
-		for (nfiles = first; nfiles < OPEN_MAX; nfiles++) {
-			sprintf(filname, "file%d.%d", nfiles, mypid);
-			fildeses[nfiles] = fopen(filname, "a");
-			if (fildeses[nfiles] == NULL) {
-				/* Did we already reach OPEN_MAX ? */
-				if (errno == EMFILE)
-					break;
-				tst_brkm(TBROK, cleanup, "Parent: cannot open "
-					 "file %d %s errno = %d", nfiles,
-					 filname, errno);
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "filname: %s", filname);
-#endif
-		}
+	char filename[32];
+	pid_t parent_pid;
+	FILE *file;
+	long nfiles;
 
-		tst_resm(TINFO, "Parent reporting %d files open", nfiles - 1);
-
-		pid = fork();
-		if (pid == -1)
-			tst_brkm(TBROK, cleanup, "Fork failed");
-
-		if (pid == 0) {	/* child */
-			nfiles--;
-			if (fclose(fildeses[nfiles]) == -1) {
-				tst_resm(TINFO, "Child could not close file "
-					 "#%d, errno = %d", nfiles, errno);
-				exit(1);
-			} else {
-				sprintf(childfile, "cfile.%d", getpid());
-				fildeses[nfiles] = fopen(childfile, "a");
-				if (fildeses[nfiles] == NULL) {
-					tst_resm(TINFO, "Child could not open "
-						 "file %s, errno = %d",
-						 childfile, errno);
-					exit(1);
-				} else {
-					tst_resm(TINFO, "Child opened new "
-						 "file #%d", nfiles);
-					unlink(childfile);
-					exit(0);
-				}
-			}
-		} else {	/* parent */
-			wait(&status);
-			if (status >> 8 != 0)
-				tst_resm(TFAIL, "test 1 FAILED");
-			else
-				tst_resm(TPASS, "test 1 PASSED");
-		}
+	parent_pid = getpid();
+
+	tst_res(TINFO, "Open all possible files from parent");
+
+	for (nfiles = 0; nfiles < maxfds; nfiles++) {
+		sprintf(filename, "file%lu.%d", nfiles, parent_pid);
+
+		file = fopen(filename, "a");
+		if (!file) {
+			if (errno == EMFILE)
+				break;
 
-		/* clean up things in case we are looping */
-		for (nf = first; nf < nfiles; nf++) {
-			fclose(fildeses[nf]);
-			sprintf(filname, "file%d.%d", nf, mypid);
-			unlink(filname);
+			tst_brk(TBROK | TERRNO, "Can't open %s file", filename);
 		}
+
+		fd[nfiles] = file;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TINFO, "Opened %lu files", nfiles);
+
+	if (!SAFE_FORK()) {
+		run_child();
+		exit(0);
+	}
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	umask(0);
+	maxfds = SAFE_SYSCONF(_SC_OPEN_MAX);
 
-	TEST_PAUSE;
-	tst_tmpdir();
+	fd = SAFE_MMAP(NULL, maxfds * sizeof(FILE *),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	for (long i = 0; i < maxfds; i++) {
+		if (fd[i])
+			SAFE_FCLOSE(fd[i]);
+	}
+
+	SAFE_MUNMAP(fd, maxfds * sizeof(FILE *));
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

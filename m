Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD33EB64DD
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 09:57:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD4EE3CE1C9
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 11:57:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 108FC3C8D9E
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 11:56:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 387B12009EE
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 11:56:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9639A1F8AB;
 Mon,  7 Aug 2023 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691402216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uokarnDFijPVZKd6uVPfX8JFpwa2GdaksKqFYNhTgAQ=;
 b=mnfty65547fnryveiMmCmLmq6HGHYXatqKb5njNb88nCUHjscBjsjeX4tSCg2GSAIlsTcj
 XFkoJsvYzQ/JSCno3VL6r5Z2kjPBzhfbxnN7Zh5lhpRZnzl55Gc3msoBwOUDSfM0aEulOS
 fQb1ua2PH1WjktLgUm3fV9AveNT2W0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691402216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uokarnDFijPVZKd6uVPfX8JFpwa2GdaksKqFYNhTgAQ=;
 b=q18+fyZ/QxJbCFIBfdAdM3NXmm+FVvMmt3S+RYc/T4v047FN1FscpLa2WfPlRYbfgipEMz
 BjiXWA54XL6r0IAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43DEA13487;
 Mon,  7 Aug 2023 09:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jStDB+i/0GQkMQAAMHmgww
 (envelope-from <akumar@suse.de>); Mon, 07 Aug 2023 09:56:56 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon,  7 Aug 2023 15:25:37 +0530
Message-ID: <20230807095654.20552-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/pipe07: Rewrite the test using new LTP API
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/pipe/pipe07.c | 201 ++++++++----------------
 1 file changed, 63 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
index 55bb9f419..196485684 100644
--- a/testcases/kernel/syscalls/pipe/pipe07.c
+++ b/testcases/kernel/syscalls/pipe/pipe07.c
@@ -1,176 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2002
- *               Ported by Paul Larson
+ *  Ported by Paul Larson
  * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test the ability of pipe to open the maximum even number of file
- * descriptors permitted (or (maxfds - 3)/2 pipes)
+/*\
+ * [Description]
  *
- * ALGORITHM
- *      1. record file descriptors open prior to test run
- * 	2. open pipes until EMFILE is returned
- * 	3. check to see that the number of pipes opened is (maxfds - 3) / 2
- * 	4. close all fds in range 0, maximal fd that were not open prior to
- * 	   the test execution
+ * Verify that, pipe(2) syscall can open the maximum number of
+ * file descriptors permitted.
  */
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <dirent.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "pipe07";
-int TST_TOTAL = 1;
-
-/* used to record file descriptors open at the test start */
-static int rec_fds[128];
-static int rec_fds_max;
-static void record_open_fds(void);
-static void close_test_fds(int max_fd);
+#include "tst_test.h"
+#include <stdlib.h>
 
-static void setup(void);
-static void cleanup(void);
+static int *opened_fds, *pipe_fds;
+static int num_pipe_fds, exp_num_pipes;
 
-int main(int ac, char **av)
+static int record_open_fds(void)
 {
-	int lc;
-	int min, ret;
-	int npipes;
-	int pipes[2], max_fd = 0;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	DIR *dir;
+	struct dirent *ent;
+	int fd;
+	int num_opened_fds = 0;
+	int arr_size = 0;
 
-	setup();
+	dir = SAFE_OPENDIR("/proc/self/fd");
 
-	min = getdtablesize() - rec_fds_max;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	while ((ent = SAFE_READDIR(dir))) {
+		if (!strcmp(ent->d_name, ".") ||
+			!strcmp(ent->d_name, ".."))
+			continue;
+		fd = atoi(ent->d_name);
 
-		for (npipes = 0;; npipes++) {
-			ret = pipe(pipes);
-			if (ret < 0) {
-				if (errno != EMFILE) {
-					tst_brkm(TFAIL, cleanup,
-						 "got unexpected error - %d",
-						 errno);
-				}
-				break;
-			}
+		if (fd == dirfd(dir))
+			continue;
 
-			max_fd = MAX(pipes[0], max_fd);
-			max_fd = MAX(pipes[1], max_fd);
+		if (num_opened_fds >= arr_size) {
+			arr_size = MAX(1, arr_size * 2);
+			opened_fds = SAFE_REALLOC(opened_fds, arr_size * sizeof(int));
 		}
-
-		if (npipes == (min / 2))
-			tst_resm(TPASS, "Opened %d pipes", npipes);
-		else
-			tst_resm(TFAIL, "Unable to open maxfds/2 pipes");
-
-		close_test_fds(max_fd);
-		max_fd = 0;
+		opened_fds[num_opened_fds++] = fd;
 	}
 
-	cleanup();
-	tst_exit();
+	return num_opened_fds;
 }
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	int max_fds;
 
-	record_open_fds();
+	max_fds = getdtablesize();
+	tst_res(TINFO, "getdtablesize() = %d", max_fds);
+	pipe_fds = SAFE_MALLOC(max_fds * sizeof(int));
+
+	exp_num_pipes = (max_fds - record_open_fds()) / 2;
+	tst_res(TINFO, "expected max fds to be opened by pipe(): %d", exp_num_pipes * 2);
 }
 
-static void record_open_fds(void)
+static void run(void)
 {
-	DIR *dir = opendir("/proc/self/fd");
-	int dir_fd, fd;
-	struct dirent *file;
-
-	if (dir == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "opendir()");
-
-	dir_fd = dirfd(dir);
-
-	if (dir_fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "dirfd()");
+	int fds[2];
 
-	errno = 0;
-
-	while ((file = readdir(dir))) {
-		if (!strcmp(file->d_name, ".") || !strcmp(file->d_name, ".."))
-			continue;
-
-		fd = atoi(file->d_name);
-
-		if (fd == dir_fd)
-			continue;
-
-		if (rec_fds_max >= (int)ARRAY_SIZE(rec_fds)) {
-			tst_brkm(TBROK, cleanup,
-			         "Too much file descriptors open");
+	do {
+		TEST(pipe(fds));
+		if (!TST_RET) {
+			pipe_fds[num_pipe_fds++] = fds[0];
+			pipe_fds[num_pipe_fds++] = fds[1];
 		}
+	} while (!TST_RET);
 
-		rec_fds[rec_fds_max++] = fd;
-	}
-
-	if (errno)
-		tst_brkm(TBROK | TERRNO, cleanup, "readdir()");
+	TST_EXP_EQ_LI(errno, EMFILE);
+	TST_EXP_EQ_LI(exp_num_pipes * 2, num_pipe_fds);
 
-	closedir(dir);
+	for (int i = 0; i < num_pipe_fds; i++)
+		SAFE_CLOSE(pipe_fds[i]);
 
-	tst_resm(TINFO, "Found %u files open", rec_fds_max);
+	num_pipe_fds = 0;
 }
 
-static int not_recorded(int fd)
+static void cleanup(void)
 {
-	int i;
+	for (int i = 0; i < num_pipe_fds; i++)
+		if (pipe_fds[i] > 0)
+			SAFE_CLOSE(pipe_fds[i]);
 
-	for (i = 0; i < rec_fds_max; i++)
-		if (fd == rec_fds[i])
-			return 0;
+	if (pipe_fds)
+		free(pipe_fds);
 
-	return 1;
+	if (opened_fds)
+		free(opened_fds);
 }
 
-static void close_test_fds(int max_fd)
-{
-	int i;
-
-	for (i = 0; i <= max_fd; i++) {
-		if (not_recorded(i)) {
-			if (close(i)) {
-				if (errno == EBADF)
-					continue;
-				tst_resm(TWARN | TERRNO, "close(%i)", i);
-			}
-		}
-	}
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run
+};
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

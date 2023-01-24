Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9568CC25B4E
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 08:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB36B3CC78B
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 09:49:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8EE33CB39D
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 09:49:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2CA781A001CD
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 09:49:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39F8A1FE4C
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1674550156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ut4Vo48YDH8f+E9uhGGCVewJyW1mrGYjj02KIG+IPfw=;
 b=EotdDQhJJZpf58ktV7UxaW7WrTZ6OpH8MTiXo/8WupWMkzlnXgRUEDrICg1AR+oYHHOsUj
 vOWhtRLJ8AEqfBkA3YTJoflq0g60sJaNMoI3kwRPBShysMXMCKLIVpYpzW0ncX96T1T7gJ
 /8tSWEz14x9RyTfe+PmRPGrvZe+h02c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1674550156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ut4Vo48YDH8f+E9uhGGCVewJyW1mrGYjj02KIG+IPfw=;
 b=MAqV/DHUCcV8SFiBKHT6EAvDcGm0f0vZi56JFQVaCNPllzpftsYN4DzJEse56FTv0Y0A5B
 kiclOHozYgRkvXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EC5913487
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 08:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hMklFIubz2OdPAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 08:49:15 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 24 Jan 2023 14:19:11 +0530
Message-Id: <20230124084911.7208-1-akumar@suse.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setreuid07.c: Rewrite the test using new LTP API
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
 .../kernel/syscalls/setreuid/setreuid07.c     | 197 ++++--------------
 1 file changed, 36 insertions(+), 161 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index ff222cd00..83559583e 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -1,192 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-later
 /*
  * Copyright (c) Kerlabs 2008.
  * Copyright (c) International Business Machines  Corp., 2008
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
- *
  * Created by Renaud Lottiaux
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Check if setreuid behaves correctly with file permissions.
  * The test creates a file as ROOT with permissions 0644, does a setreuid
  * and then tries to open the file with RDWR permissions.
  * The same test is done in a fork to check if new UIDs are correctly
- * passed to the son.
+ * passed to the child process.
  */
 
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <pwd.h>
+#include <stdlib.h>
 
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(setreuid07);
-int TST_TOTAL = 1;
+#define TEMPFILE "testfile"
 
-static char testfile[256] = "";
 static struct passwd *ltpuser;
 
-static int fd = -1;
-
-static void setup(void);
-static void cleanup(void);
-static void do_master_child(void);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	pid_t pid;
+	int fd;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	ltpuser = SAFE_GETPWNAM("nobody");
 
-	setup();
-
-	pid = FORK_OR_VFORK();
-	if (pid < 0)
-		tst_brkm(TBROK, cleanup, "Fork failed");
-
-	if (pid == 0)
-		do_master_child();
-
-	tst_record_childstatus(cleanup, pid);
-
-	cleanup();
-	tst_exit();
+	UID16_CHECK(ltpuser->pw_uid, setreuid);
+	fd = SAFE_OPEN(TEMPFILE, O_CREAT | O_RDWR, 0644);
+	SAFE_CLOSE(fd);
 }
 
-static void do_master_child(void)
+static void run(void)
 {
-	int lc;
-	int pid;
+	pid_t pid;
 	int status;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int tst_fd;
-
-		tst_count = 0;
-
-		if (SETREUID(NULL, 0, ltpuser->pw_uid) == -1) {
-			perror("setreuid failed");
-			exit(TFAIL);
-		}
-
-		/* Test 1: Check the process with new uid cannot open the file
-		 *         with RDWR permissions.
-		 */
-		TEST(tst_fd = open(testfile, O_RDWR));
-
-		if (TEST_RETURN != -1) {
-			printf("open succeeded unexpectedly\n");
-			close(tst_fd);
-			exit(TFAIL);
-		}
-
-		if (TEST_ERRNO == EACCES) {
-			printf("open failed with EACCES as expected\n");
-		} else {
-			perror("open failed unexpectedly");
-			exit(TFAIL);
-		}
+	TST_EXP_PASS_SILENT(SETREUID(-1, ltpuser->pw_uid));
+	TST_EXP_FAIL2(open(TEMPFILE, O_RDWR), EACCES);
 
-		/* Test 2: Check a son process cannot open the file
-		 *         with RDWR permissions.
-		 */
-		pid = FORK_OR_VFORK();
-		if (pid < 0)
-			tst_brkm(TBROK, cleanup, "Fork failed");
-
-		if (pid == 0) {
-			int tst_fd2;
-
-			/* Test to open the file in son process */
-			TEST(tst_fd2 = open(testfile, O_RDWR));
-
-			if (TEST_RETURN != -1) {
-				printf("call succeeded unexpectedly\n");
-				close(tst_fd2);
-				exit(TFAIL);
-			}
-
-			if (TEST_ERRNO == EACCES) {
-				printf("open failed with EACCES as expected\n");
-				exit(TPASS);
-			} else {
-				printf("open failed unexpectedly\n");
-				exit(TFAIL);
-			}
-		} else {
-			/* Wait for son completion */
-			if (waitpid(pid, &status, 0) == -1) {
-				perror("waitpid failed");
-				exit(TFAIL);
-			}
-			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-				exit(WEXITSTATUS(status));
-		}
-
-		/* Test 3: Fallback to initial uid and check we can again open
-		 *         the file with RDWR permissions.
-		 */
-		tst_count++;
-		if (SETREUID(NULL, 0, 0) == -1) {
-			perror("setreuid failed");
-			exit(TFAIL);
-		}
-
-		TEST(tst_fd = open(testfile, O_RDWR));
-
-		if (TEST_RETURN == -1) {
-			perror("open failed unexpectedly");
-			exit(TFAIL);
-		} else {
-			printf("open call succeeded\n");
-			close(tst_fd);
-		}
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		TST_EXP_FAIL2(open(TEMPFILE, O_RDWR), EACCES);
+		exit(0);
 	}
-	exit(TPASS);
-}
+	SAFE_WAITPID(pid, &status, 0);
+	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
+		exit(WEXITSTATUS(status));
 
-static void setup(void)
-{
-	tst_require_root();
-
-	ltpuser = getpwnam("nobody");
-	if (ltpuser == NULL)
-		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-
-	tst_tmpdir();
-
-	sprintf(testfile, "setreuid07file%d.tst", getpid());
-
-	/* Create test file */
-	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0644);
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	TST_EXP_PASS_SILENT(SETREUID(-1, 0));
+	TST_EXP_FD(open(TEMPFILE, O_RDWR));
+	SAFE_CLOSE(TST_RET);
 }
 
-static void cleanup(void)
-{
-	close(fd);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1
+};
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

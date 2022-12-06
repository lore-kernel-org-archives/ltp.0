Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B765C352A1
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 07:58:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4F933CC155
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 08:58:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBFBE3CA0DA
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 08:57:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0B304ACCB0D
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 08:57:52 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D61E1FE6F
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670313471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BpWZ86Eg94RNae1MSnRRtBQID+o6vVmmN75ihUcnxOg=;
 b=gc453MqKQPnztKwqbAXtYnOnleGxDqCXV9hHkhbVGD0c8kImAlQhArp47lO5ES8sQVsTlO
 gxRXMfCcPSorsNeYTOo/84FutdrwjTSAUFmWbgXoLhTypVoDZno7SflF3uRiTHnS7lXgmH
 fWmt5OIBoY+OahY3SIMvOLOAVsvHW88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670313471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BpWZ86Eg94RNae1MSnRRtBQID+o6vVmmN75ihUcnxOg=;
 b=uoFvdX363p1j724kLAqd1M969lP2QlEruS11y60aU+n/u/PCLtCoQ/GQKmC5H+l+MeDLLM
 E3g81pyzurTQlJDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B033813326
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 07:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 5j/RG/71jmPEXwAAGKfGzw
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 06 Dec 2022 07:57:50 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  6 Dec 2022 13:27:47 +0530
Message-Id: <20221206075747.17352-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setresuid04.c: Rewrite the test using new LTP API
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
 .../kernel/syscalls/setresuid/setresuid04.c   | 255 ++++--------------
 1 file changed, 52 insertions(+), 203 deletions(-)

diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
index e197476ff..20840e2a2 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -1,223 +1,72 @@
-/******************************************************************************/
-/* Copyright (c) Kerlabs 2008.                                                */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/*
- * NAME
- * 	setresuid04.c
- *
- * DESCRIPTION
- * 	Check if setresuid behaves correctly with file permissions.
- *      The test creates a file as ROOT with permissions 0644, does a setresuid
- *      and then tries to open the file with RDWR permissions.
- *      The same test is done in a fork to check if new UIDs are correctly
- *      passed to the son.
- *
- * USAGE:  <for command-line>
- *  setresuid04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Created by Renaud Lottiaux
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Kerlabs 2008.
+ * Copyright (c) International Business Machines  Corp., 2008
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- * 	Must be run as root.
+ * Verify that setresuid() behaves correctly with file permissions.
+ * The test creates a file as ROOT with permissions 0644, does a setresuid
+ * to change euid to a non-root user and tries to open the file with RDWR
+ * permissions, which should fail with EACCES errno.
+ * The same test is done in a fork also to check that child process also
+ * inherits new euid and open fails with EACCES.
+ * Test verifies the successful open action after reverting the euid back
+ * ROOT user.
  */
-#define _GNU_SOURCE 1
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+
 #include <sys/wait.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
 #include <pwd.h>
-#include "compat_16.h"
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-TCID_DEFINE(setresuid04);
-int TST_TOTAL = 1;
-char nobody_uid[] = "nobody";
-char testfile[256] = "";
-struct passwd *ltpuser;
+#define TEMP_FILE	"testfile"
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+static int fd = -1;
 
-int fd = -1;
-
-void setup(void);
-void cleanup(void);
-void do_master_child();
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	pid_t pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-	setup();
-
-	pid = FORK_OR_VFORK();
-	if (pid < 0)
-		tst_brkm(TBROK, cleanup, "Fork failed");
+	ltpuser = SAFE_GETPWNAM(nobody_uid);
+	UID16_CHECK(ltpuser->pw_uid, "setresuid");
 
-	if (pid == 0)
-		do_master_child();
-
-	tst_record_childstatus(cleanup, pid);
-
-	cleanup();
-	tst_exit();
+	fd = SAFE_OPEN(TEMP_FILE, O_CREAT | O_RDWR, 0644);
 }
 
-/*
- * do_master_child()
- */
-void do_master_child(void)
+static void run(void)
 {
-	int lc;
-	int pid;
+	pid_t pid;
 	int status;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int tst_fd;
-
-		/* Reset tst_count in case we are looping */
-		tst_count = 0;
-
-		if (SETRESUID(NULL, 0, ltpuser->pw_uid, 0) == -1) {
-			perror("setresuid failed");
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
-
-		/* Test 2: Check a son process cannot open the file
-		 *         with RDWR permissions.
-		 */
-		pid = FORK_OR_VFORK();
-		if (pid < 0)
-			tst_brkm(TBROK, NULL, "Fork failed");
-
-		if (pid == 0) {
-			int tst_fd2;
+	SAFE_SETRESUID(0, ltpuser->pw_uid, 0);
+	TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);
 
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
-
-			if (!WIFEXITED(status))
-				exit(TFAIL);
-
-			if (WEXITSTATUS(status) != TPASS)
-				exit(WEXITSTATUS(status));
-		}
-
-		/* Test 3: Fallback to initial uid and check we can again open
-		 *         the file with RDWR permissions.
-		 */
-		tst_count++;
-		if (SETRESUID(NULL, 0, 0, 0) == -1) {
-			perror("setresuid failed");
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
+	if (!pid) {
+		TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);
+		return;
 	}
-	exit(TPASS);
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-	tst_require_root();
+	SAFE_WAITPID(pid, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_res(TFAIL, "child process exited with status: %d", status);
 
-	ltpuser = getpwnam(nobody_uid);
-
-	UID16_CHECK(ltpuser->pw_uid, "setresuid", cleanup)
-
-	tst_tmpdir();
-
-	sprintf(testfile, "setresuid04file%d.tst", getpid());
-
-	/* Create test file */
-	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0644);
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_SETRESUID(0, 0, 0);
+	TST_EXP_FD(open(TEMP_FILE, O_RDWR));
+	SAFE_CLOSE(TST_RET);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	close(fd);
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1
+};
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

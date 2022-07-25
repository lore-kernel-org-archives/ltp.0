Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346F6C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 17:37:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B8E23C9F6D
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 19:37:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0365D3C04EF
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 19:37:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5D571400066
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 19:37:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8DC31FF58
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658770625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5LgUnqUJ40gGaGvDoSMHN8sIrW69FtW/B1wfzMrUWBk=;
 b=2DVM0XDLdHy2KscHE2hcTUTfIOPuytvkmsv0A9l88iH7Ep0/mrQRIJvQBMt54sDAliLqxG
 ZPa+F4CWvFpjiMpRJ51g6YwdfT8WWFIP7XWiomtWlmd3ChDPYqS3bIuR6/t+Zkcyw/zz8e
 bwpNLXpcZWyomIzWmebSDxXNVOk7M6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658770625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5LgUnqUJ40gGaGvDoSMHN8sIrW69FtW/B1wfzMrUWBk=;
 b=/UBjIlEbtfeeHVAA+WDh1nAjTABAM7OixqqRQOw4bO1ulmTqY8RwM6jFv7xzaBjCLygCBj
 72f3xaZrvZj89wBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FFCA13ABB
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BdTyM8DU3mKtZgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:37:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 25 Jul 2022 23:07:02 +0530
Message-Id: <20220725173702.9359-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rename12.c: Convert to new LTP API
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

Rewrite test using new LTP API and enable on all supporting filesystems

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/rename/rename12.c | 253 ++++----------------
 1 file changed, 50 insertions(+), 203 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
index 36691783f..d6e1ccbe9 100644
--- a/testcases/kernel/syscalls/rename/rename12.c
+++ b/testcases/kernel/syscalls/rename/rename12.c
@@ -1,222 +1,69 @@
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
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	rename12
- *
- * DESCRIPTION
- *      check rename() fails with EPERM or EACCES
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *		Loop if the proper options are given.
- *              create a directory fdir and set the sticky bit
- *              create file fname under fdir
- *              fork a child
- *                      set to nobody
- *                      try to rename fname to mname
- *                      check the return value, if succeeded (return=0)
- *			       Log the errno and Issue a FAIL message.
- *		        Otherwise,
- *			       Verify the errno
- *			       if equals to EPERMS or EACCES,
- *				       Issue Pass message.
- *			       Otherwise,
- *				       Issue Fail message.
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- * USAGE
- *	rename12 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	Must run test as root.
+/*\
+ * [Description]
  *
+ * Verify that rename() fails with EPERM or EACCES when the directory
+ * containing oldpath has the sticky bit (S_ISVTX) set and the caller
+ * is not privileged.
  */
-#include <errno.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-#include <pwd.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-#define PERMS		0777
-
-char *TCID = "rename12";
-int TST_TOTAL = 1;
-
-int fd;
-char fdir[255];
-char fname[255], mname[255];
-uid_t nobody_uid;
-struct stat buf1;
-
-int main(int ac, char **av)
-{
-	int lc;
-	pid_t pid;
-	int status;
-
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * perform global setup for test
-	 */
-	setup();
-
-	/*
-	 * check looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * rename a file whose parent directory has
-		 * the sticky bit set without root permission
-		 * or effective uid
-		 */
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork() failed");
-		}
 
-		if (pid == 0) {	/* child */
-			/* set to nobody */
-			if (seteuid(nobody_uid) == -1) {
-				tst_resm(TWARN, "setreuid failed");
-				perror("setreuid");
-				exit(1);
-			}
-
-			/* rename "old" to "new" */
-			TEST(rename(fname, mname));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				exit(1);
-			}
-
-			if ((TEST_ERRNO != EPERM) && (TEST_ERRNO != EACCES)) {
-				tst_resm(TFAIL,
-					 "Expected EPERM or EACCES, got %d",
-					 TEST_ERRNO);
-				exit(1);
-			} else {
-				tst_resm(TPASS,
-					 "rename returned EPERM or EACCES");
-			}
-
-			/* set the id back to root */
-			if (seteuid(0) == -1) {
-				tst_resm(TWARN, "seteuid(0) failed");
-			}
-		} else {	/* parent */
-			wait(&status);
-			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
-				exit(WEXITSTATUS(status));
-			} else {
-				exit(0);
-			}
-
-		}
-	}
+#include <stdio.h>
+#include <pwd.h>
+#include "tst_test.h"
 
-	cleanup();
-	tst_exit();
+#define MNT_POINT "mntpoint"
+#define TEMP_DIR "tempdir"
+#define TEMP_FILE1 TEMP_DIR"/tmpfile1"
+#define TEMP_FILE2 TEMP_DIR"/tmpfile2"
 
-}
+static uid_t nobody_uid;
+static struct stat buf1;
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
 	struct passwd *pw;
 
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	pw = SAFE_GETPWNAM(NULL, "nobody");
+	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
 
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
-
-	umask(0);
-
-	sprintf(fdir, "./tdir_%d", getpid());
-	sprintf(fname, "%s/tfile_%d", fdir, getpid());
-	sprintf(mname, "%s/rnfile_%d", fdir, getpid());
-
-	/* create a directory */
-	SAFE_MKDIR(cleanup, fdir, PERMS);
-
-	SAFE_STAT(cleanup, fdir, &buf1);
-
-	/* set the sticky bit */
-	if (chmod(fdir, buf1.st_mode | S_ISVTX) != 0) {
-		tst_brkm(TBROK, cleanup, "failed to set the S_ISVTX bit");
-
-	}
-
-	/* create a file under fdir */
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
+	SAFE_CHDIR(MNT_POINT);
+	SAFE_MKDIR(TEMP_DIR, 0777);
+	SAFE_STAT(TEMP_DIR, &buf1);
+	SAFE_CHMOD(TEMP_DIR, buf1.st_mode | S_ISVTX);
+	SAFE_TOUCH(TEMP_FILE1, 0700, NULL);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void run(void)
 {
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
+	SAFE_SETEUID(nobody_uid);
+
+	TEST(rename(TEMP_FILE1, TEMP_FILE2));
+	if (TST_RET == -1 && (TST_ERR == EPERM || TST_ERR == EACCES))
+		tst_res(TPASS | TTERRNO, "rename() failed as expected");
+	else if (TST_RET == 0)
+		tst_res(TFAIL, "rename() succeeded unexpectedly");
+	else
+		tst_res(TFAIL | TTERRNO, "rename() failed, but not with expected errno");
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.mntpoint = MNT_POINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]){
+		"exfat",
+		"vfat",
+		"fuse",
+		"ntfs",
+		NULL
+	},
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

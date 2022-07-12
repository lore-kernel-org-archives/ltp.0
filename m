Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CD8C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 15:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 896D13CA728
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 17:35:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2196E3CA592
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C38B1A004A4
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2FF8229E2
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657640074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JduWW+6FEnqnLR6EExPmWwwmYJZVd+B3+YcvrAoa28=;
 b=n45x7wgbJ3uLkxKWxWLXHSFpQZDd3YDPDzf8w7Vjy07GUbm/dv4Csmy3wtOnJ68L54LciU
 siSYybIv83Pn9YowT3PY2BAzHv808Cjp6hKB53zJIKBQlRVw0o6aIswv6g9zsbAjx8Bbbw
 akXPJNbrPfmp0oxNGToObbL4yVvbICw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657640074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JduWW+6FEnqnLR6EExPmWwwmYJZVd+B3+YcvrAoa28=;
 b=6w4OZtBWlYr7zU992PV5IWbCIzSkFN0edorYSPerak//fBvsQu+dgohG0Mk8oz4cSkApQE
 BNneW3aejYRW4vCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F3F913A94
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yZNmN4mUzWI3fAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:33 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 21:04:12 +0530
Message-Id: <20220712153417.14551-5-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712153417.14551-1-akumar@suse.de>
References: <20220712153417.14551-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/9] Rewrite rename04.c using new LTP API
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

Rewrite using new LTP API and enable all filesystems

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/rename/rename04.c | 204 ++++----------------
 1 file changed, 36 insertions(+), 168 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename04.c b/testcases/kernel/syscalls/rename/rename04.c
index 32594a776..d1d7161b8 100644
--- a/testcases/kernel/syscalls/rename/rename04.c
+++ b/testcases/kernel/syscalls/rename/rename04.c
@@ -1,182 +1,50 @@
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
+ * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- *	rename04
- *
- * DESCRIPTION
- *	This test will verify that rename(2) failed when newpath is
- *      a non-empty directory and return EEXIST or ENOTEMPTY
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *              create the "old" directory and the "new" directory
- *              create a file uner the "new" directory
- *
- *	Test:
- *		Loop if the proper options are given.
- *                  rename the "old" to the "new" directory
- *                  verify rename() failed and returned ENOTEMPTY
- *
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- *
- * USAGE
- *	rename04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None.
+ * Verify that rename() fails with EEXIST or ENOTEMPTY when
+ * newpath is a non-empty directory.
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include <stdio.h>
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+#define MNT_POINT "mntpoint"
+#define DIR1 "dir1"
+#define DIR2 "dir2"
+#define TEMP_FILE DIR2"/tmpfile"
 
-char *TCID = "rename04";
-int TST_TOTAL = 1;
-
-int fd;
-char tstfile[40];
-char fdir[255], mdir[255];
-struct stat buf1, buf2;
-dev_t olddev, olddev1;
-ino_t oldino, oldino1;
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
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
-		/* rename a directory to a non-empty directory */
-
-		/* Call rename(2) */
-		TEST(rename(fdir, mdir));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "rename(%s, %s) succeeded unexpectedly",
-				 fdir, mdir);
-			continue;
-		}
-
-		if (TEST_ERRNO == ENOTEMPTY) {
-			tst_resm(TPASS, "rename() returned ENOTEMPTY");
-		} else if (TEST_ERRNO == EEXIST) {
-			tst_resm(TPASS, "rename() returned EEXIST");
-		} else {
-			tst_resm(TFAIL, "Expected ENOTEMPTY or EEXIST got %d",
-				 TEST_ERRNO);
-		}
-
-	}
-
-	/*
-	 * cleanup and exit
-	 */
-	cleanup();
-	tst_exit();
-
+	SAFE_CHDIR(MNT_POINT);
+	SAFE_MKDIR(DIR1, 00770);
+	SAFE_MKDIR(DIR2, 00770);
+	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
-
-	sprintf(fdir, "./tdir_%d", getpid());
-	sprintf(mdir, "./rndir_%d", getpid());
-	sprintf(tstfile, "%s/tstfile_%d", mdir, getpid());
-
-	/* create "old" directory */
-	SAFE_MKDIR(cleanup, fdir, 00770);
-
-	SAFE_STAT(cleanup, fdir, &buf1);
-
-	/* save "old"'s dev and ino */
-	olddev = buf1.st_dev;
-	oldino = buf1.st_ino;
-
-	/* create another directory */
-	SAFE_MKDIR(cleanup, mdir, 00770);
-
-	SAFE_TOUCH(cleanup, tstfile, 0700, NULL);
-
-	SAFE_STAT(cleanup, mdir, &buf2);
-
-	/* save "new"'s dev and ino */
-	olddev1 = buf2.st_dev;
-	oldino1 = buf2.st_ino;
+	TEST(rename(DIR1, DIR2));
+
+	if (TST_RET == -1 && (TST_ERR == ENOTEMPTY || TST_ERR == EEXIST))
+		tst_res(TPASS | TERRNO, "rename() failed as expected");
+	else if (TST_RET == 0)
+		tst_res(TFAIL, "rename() succeeded unexpectedly");
+	else
+		tst_res(TFAIL | TERRNO, "rename() failed, but not with expected errno");
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *              completion or premature exit.
- */
-void cleanup(void)
-{
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.mntpoint = MNT_POINT,
+	.mount_device = 1,
+	.all_filesystems = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

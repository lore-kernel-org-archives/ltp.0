Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E37C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10ADB610CE
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10ADB610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 292833C8D80
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 17:52:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 311123C8D8A
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3E13600095
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 951D221CDC
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631202687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CRN/bWTFe48KkbxGojjR+2VbuqjxPPytkL85fezLFWw=;
 b=OnsaI7kQcLwYXsa/gt3jtsqmDFr/1P4HKuM2pOGI+FXAWXVGRLWX7JzN+OhOGgldhWBMQ7
 dFvAhqX5Is0/S6JbLZEl2sb2hvVXtK2YUnaChyF7qBnasnWyk39eTFCie0bH+EKAAuqKOD
 kDyi1E9BMVSM5YnPfdH6cmvxNwBQ8WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631202687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CRN/bWTFe48KkbxGojjR+2VbuqjxPPytkL85fezLFWw=;
 b=iJ/ckHOrwMbueEoeQereWIRjb1EyH87wa9NvmcCnrThUmEdk+yqQTMSmvgT2aGT7ZpYoUg
 WJd8Mvr6YdxcCqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 729B213CC8
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lPdqGn8tOmFZXwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Sep 2021 15:51:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Sep 2021 17:51:19 +0200
Message-ID: <20210909155126.2720-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/8] syscalls/rename09: Simplify and convert to new API
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
Message-ID: <20210909155119.EXFA1C42tAlhV6-FVz7ecIL3pH5qXQ9GJvTpn6pc5Ig@z>

The original test does unnecessaty fork()s and looks up specific usernames
which may not exist on some systems. Simplify test and use any two UIDs.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

This is the second batch of fixes for tests failing due to missing system
users, this time with API conversions. I'll send one more batch next week.

 testcases/kernel/syscalls/rename/rename09.c | 293 ++++----------------
 1 file changed, 49 insertions(+), 244 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename09.c b/testcases/kernel/syscalls/rename/rename09.c
index 9b2022592..368a436c2 100644
--- a/testcases/kernel/syscalls/rename/rename09.c
+++ b/testcases/kernel/syscalls/rename/rename09.c
@@ -1,266 +1,71 @@
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
+ *	07/2001 Ported by Wayne Boyer
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * NAME
- *	rename09
- *
- * DESCRIPTION
- *      check rename() fails with EACCES
- *
- * ALGORITHM
- *	Setup:
- *		Setup signal handling.
- *		Create temporary directory.
- *		Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *		Loop if the proper options are given.
- *              fork the first child
- *                      set to be nobody
- *                      create old dir with mode 0700
- *                      creat a file under it
- *              fork the second child
- *                      set to bin
- *                      create new dir with mode 0700
- *                      create a "new" file under it
- *                      try to rename file under old dir to file under new dir
- *                      check the return value, if succeeded (return=0)
- *			       Issue a FAIL message.
- *		        Otherwise,
- *			       Log the errno
- *			       Verify the errno
- *			       if equals to EACCESS,
- *				       Issue Pass message.
- *			       Otherwise,
- *				       Issue Fail message.
- *	Cleanup:
- *		Print errno log and/or timing stats if options given
- *		Delete the temporary directory created.
- *
- * USAGE
- *	rename09 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
+ * Check that renaming/moving a file from directory where the current user does
+ * not have write permissions fails with EACCES.
  */
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <pwd.h>
-#include <sys/wait.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "safe_macros.h"
 
-void setup();
-void cleanup();
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
 
-#define PERMS		0700
+#include "tst_test.h"
+#include "tst_safe_file_ops.h"
+#include "tst_uid.h"
 
-char *TCID = "rename09";
-int TST_TOTAL = 1;
+#define SRCDIR   "srcdir"
+#define DESTDIR  "destdir"
+#define SRCFILE  SRCDIR "/file"
+#define DESTFILE DESTDIR "/file"
+#define PERMS    0700
 
-char fdir[255], mdir[255];
-char fname[255], mname[255];
-uid_t nobody_uid, bin_uid;
+static uid_t orig_uid, test_users[2];
+static char *tmpdir;
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-	int rval;
-	pid_t pid, pid1;
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
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork() #1 failed");
-		}
-
-		if (pid == 0) {	/* first child */
-			/* set to nobody */
-			rval = setreuid(nobody_uid, nobody_uid);
-			if (rval < 0) {
-				tst_resm(TWARN, "setreuid failed to "
-					 "to set the real uid to %d and "
-					 "effective uid to %d",
-					 nobody_uid, nobody_uid);
-				perror("setreuid");
-				exit(1);
-			}
-
-			/* create the a directory with 0700 permits */
-			if (mkdir(fdir, PERMS) == -1) {
-				tst_resm(TWARN, "mkdir(%s, %#o) Failed",
-					 fdir, PERMS);
-				exit(1);
-			}
-
-			/* create "old" file under it */
-			SAFE_TOUCH(cleanup, fname, 0700, NULL);
-
-			exit(0);
-		}
-
-		/* wait for child to exit */
-		wait(&status);
-		if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
-			tst_brkm(TBROK, cleanup, "First child failed to set "
-				 "up conditions for the test");
-		}
-
-		if ((pid1 = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork() #2 failed");
-		}
-
-		if (pid1 == 0) {	/* second child */
-			/* set to bin */
-			if ((rval = seteuid(bin_uid)) == -1) {
-				tst_resm(TWARN, "seteuid() failed");
-				perror("setreuid");
-				exit(1);
-			}
-
-			/* create "new" directory */
-			if (mkdir(mdir, PERMS) == -1) {
-				tst_resm(TWARN, "mkdir(%s, %#o) failed",
-					 mdir, PERMS);
-				exit(1);
-			}
-
-			SAFE_TOUCH(cleanup, mname, 0700, NULL);
-
-			/* rename "old" to "new" */
-			TEST(rename(fname, mname));
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO != EACCES) {
-				tst_resm(TFAIL, "Expected EACCES got %d",
-					 TEST_ERRNO);
-			} else {
-				tst_resm(TPASS, "rename() returned EACCES");
-			}
-
-			/* set the process id back to root */
-			if (seteuid(0) == -1) {
-				tst_resm(TWARN, "seteuid(0) failed");
-				exit(1);
-			}
-
-			/* clean up things in case we are looping */
-			SAFE_UNLINK(cleanup, fname);
-			SAFE_UNLINK(cleanup, mname);
-			SAFE_RMDIR(cleanup, fdir);
-			SAFE_RMDIR(cleanup, mdir);
-		} else {
-			/* parent - let the second child carry on */
-			waitpid(pid1, &status, 0);
-			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
-				exit(WEXITSTATUS(status));
-			} else {
-				exit(0);
-			}
-		}
-	}
-
-	/*
-	 * cleanup and exit
-	 */
-	cleanup();
-	tst_exit();
-
+	umask(0);
+	orig_uid = getuid();
+	tst_get_uids(test_users, 0, 2);
+	tmpdir = tst_get_tmpdir();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
-	struct passwd *pw;
-
-	tst_require_root();
+	gid_t curgid = getgid();
 
-	pw = SAFE_GETPWNAM(NULL, "nobody");
-	nobody_uid = pw->pw_uid;
-	pw = SAFE_GETPWNAM(NULL, "bin");
-	bin_uid = pw->pw_uid;
+	SAFE_MKDIR(SRCDIR, PERMS);
+	SAFE_TOUCH(SRCFILE, PERMS, NULL);
+	SAFE_CHOWN(SRCDIR, test_users[0], curgid);
+	SAFE_CHOWN(SRCFILE, test_users[0], curgid);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_SETEUID(test_users[1]);
+	SAFE_MKDIR(DESTDIR, PERMS);
+	SAFE_TOUCH(DESTFILE, PERMS, NULL);
 
-	TEST_PAUSE;
-
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
-
-	umask(0);
+	TST_EXP_FAIL(rename(SRCFILE, DESTFILE), EACCES, "rename()");
 
-	sprintf(fdir, "tdir_%d", getpid());
-	sprintf(mdir, "rndir_%d", getpid());
-	sprintf(fname, "%s/tfile_%d", fdir, getpid());
-	sprintf(mname, "%s/rnfile_%d", mdir, getpid());
+	/* Cleanup between loops */
+	SAFE_SETEUID(orig_uid);
+	tst_purge_dir(tmpdir);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-
-	/*
-	 * Exit with return code appropriate for results.
-	 */
-
+	free(tmpdir);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

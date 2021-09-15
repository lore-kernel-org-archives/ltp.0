Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1626C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 13:45:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6546105A
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 13:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F6546105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D163C919E
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:45:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6216D3C217B
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:45:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 68D1C1A00CCD
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 15:45:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAEE122129
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631713506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKGJTB+A0qvW040F/w1kq37rWuGREXY6TA1oItUisR4=;
 b=mjWueABkub/WExV7qNhI/Icfu3A8fWUwlo8LRnlgOpCncsUQf9+hYdgStRc4v24AnvNK2o
 anO8lCSDvW94e2x3I1GVjJEsu7eb1hl7u0e2GgqbcF6cyzDgi6j17q7ApiEJnDjz2UbY9C
 wqaGYQ3BP02jI62mkBp2wV7CEGH1VVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631713506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKGJTB+A0qvW040F/w1kq37rWuGREXY6TA1oItUisR4=;
 b=VnX2B34ml6rx0Q6QZIY3De2RlxqItmoWSFdzcTzFvkFPed9EBp8WIYgYp0kN/drpFbKV5r
 O1DreT/kvqvhiSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B145213F3D
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MP55KuL4QWHZaQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 13:45:06 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Sep 2021 15:45:05 +0200
Message-ID: <20210915134505.22771-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915134505.22771-1-mdoucha@suse.cz>
References: <20210915134505.22771-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] syscalls/utime03: Convert to new API
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
Message-ID: <20210915134505.L9l38VYcKWFeeOoOpGJetwpI4flI5d6MEHoPnTc1gig@z>

The original test looks up specific usernames which may not exist on some
systems. Use any non-root UID instead.

Also drop obsolete kernel version check for NFS and eliminate unnecessary
sleep() calls.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/utime/utime03.c | 344 +++++-----------------
 1 file changed, 70 insertions(+), 274 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index c5956712f..2b50dc1f6 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -1,299 +1,95 @@
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
+ *    07/2001 ported by John George
+ * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * Test Name: utime03
- *
- * Test Description:
- *  Verify that the system call utime() successfully sets the modification
- *  and access times of a file to the current time, under the following
- *  constraints,
- *	- The times argument is null.
- *	- The user ID of the process is not "root".
- *	- The file is not owned by the user ID of the process.
- *	- The user ID of the process has write access to the file.
- *
- * Expected Result:
- *  utime succeeds returning zero and sets the access and modificatio
- *  times of the file to the current time.
+/*\
+ * [Description]
  *
- * Algorithm:
- *  Setup:
- *   Setup signal handling.
- *   Create temporary directory.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *	Verify the Functionality of system call
- *      if successful,
- *		Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  utime03 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
- *  This test should be run by root only.
- *  nobody and bin must be valid users.
+ * Verify that the system call utime() successfully sets the modification
+ * and access times of a file to the current time, under the following
+ * constraints:
  *
+ * - The times argument is NULL.
+ * - The user ID of the process is not "root".
+ * - The file is not owned by the user ID of the process.
+ * - The user ID of the process has write access to the file.
  */
 
-#include <errno.h>
-#include <fcntl.h>
+#include <sys/types.h>
 #include <pwd.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
 #include <utime.h>
-#include <sys/wait.h>
 #include <sys/stat.h>
-#include <sys/types.h>
 #include <time.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "tst_uid.h"
 
 #define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRWXU | S_IRGRP | S_IWGRP| S_IROTH | S_IWOTH
-#define LTPUSER1	"nobody"
-#define LTPUSER2	"bin"
-
-char *TCID = "utime03";
-int TST_TOTAL = 1;
-time_t curr_time;		/* current time in seconds */
+#define FILE_MODE	0766
 
-struct passwd *ltpuser;		/* password struct for ltpusers */
-uid_t user_uid;			/* user id of ltpuser */
-gid_t group_gid;		/* group id of ltpuser */
-int status;
+static uid_t root_uid, user_uid;
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	struct stat stat_buf;	/* struct buffer to hold file info. */
-	int lc;
-	long type;
-	time_t modf_time, access_time;
-	time_t pres_time;	/* file modification/access/present time */
-	pid_t pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	switch ((type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-		if (tst_kvercmp(2, 6, 18) < 0)
-			tst_brkm(TCONF, cleanup, "Cannot do utime on a file"
-				" on %s filesystem before 2.6.18",
-				 tst_fs_type_name(type));
-		break;
-	case TST_V9FS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do utime on a file on %s filesystem",
-			 tst_fs_type_name(type));
-		break;
-	}
-
-	pid = FORK_OR_VFORK();
-
-	if (pid == -1) {
-		tst_brkm(TBROK, cleanup, "fork() failed");
-	} else if (pid == 0) {
-		if ((ltpuser = getpwnam(LTPUSER1)) == NULL) {
-			tst_brkm(TBROK, cleanup, "%s not found in /etc/passwd",
-				 LTPUSER1);
-		}
-
-		/* get uid/gid of user accordingly */
-		user_uid = ltpuser->pw_uid;
-
-		seteuid(user_uid);
-
-		for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-			tst_count = 0;
-
-			/*
-			 * Invoke utime(2) to set TEMP_FILE access and
-			 * modification times to the current time.
-			 */
-			TEST(utime(TEMP_FILE, NULL));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL|TTERRNO,
-					 "utime(%s) failed", TEMP_FILE);
-			} else {
-				/*
-				 * Sleep for a second so that mod time
-				 * and access times will be different
-				 * from the current time.
-				 */
-				sleep(2);
-
-				/*
-				 * Get the current time now, after
-				 * calling utime(2)
-				 */
-				pres_time = time(NULL);
-
-				/*
-				 * Get the modification and access
-				 * times of temporary file using
-				 * stat(2).
-				 */
-				SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
-				modf_time = stat_buf.st_mtime;
-				access_time = stat_buf.st_atime;
-
-				/* Now do the actual verification */
-				if (modf_time <= curr_time ||
-				    modf_time >= pres_time ||
-				    access_time <= curr_time ||
-				    access_time >= pres_time) {
-					tst_resm(TFAIL, "%s access and "
-						 "modification times "
-						 "not set", TEMP_FILE);
-				} else {
-					tst_resm(TPASS, "Functionality "
-						 "of utime(%s, NULL) "
-						 "successful",
-						 TEMP_FILE);
-				}
-			}
-			tst_count++;	/* incr. TEST_LOOP counter */
-		}
-	} else {
-		waitpid(pid, &status, 0);
-		_exit(0);	/*
-				 * Exit here and let the child clean up.
-				 * This allows the errno information set
-				 * by the TEST_ERROR_LOG macro and the
-				 * PASS/FAIL status to be preserved for
-				 * use during cleanup.
-				 */
-	}
-
-	cleanup();
-	tst_exit();
-
+	struct passwd *pw;
+	uid_t test_users[2];
+	int fd;
+
+	root_uid = getuid();
+	pw = SAFE_GETPWNAM("nobody");
+	test_users[0] = pw->pw_uid;
+	tst_get_uids(test_users, 1, 2);
+	user_uid = test_users[1];
+
+	fd = SAFE_CREAT(TEMP_FILE, FILE_MODE);
+	SAFE_CLOSE(fd);
+
+	/* Override umask */
+	SAFE_CHMOD(TEMP_FILE, FILE_MODE);
+	SAFE_CHOWN(TEMP_FILE, pw->pw_uid, pw->pw_gid);
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and close it
- *  Change the ownership of testfile to that of "bin" user.
- *  Record the current time.
- */
-void setup(void)
+static void run(void)
 {
-	int fildes;		/* file handle for temp file */
-	char *tmpd = NULL;
-
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* get the name of the temporary directory */
-	tmpd = SAFE_GETCWD(NULL, tmpd, 0);
-
-	/* Creat a temporary file under above directory */
-	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
-
-	/* Close the temporary file created */
-	SAFE_CLOSE(cleanup, fildes);
-
-	/*
-	 * Make sure that specified Mode permissions set as
-	 * umask value may be different.
-	 */
-	SAFE_CHMOD(cleanup, TEMP_FILE, FILE_MODE);
-	SAFE_CHMOD(cleanup, tmpd, 0711);
-
-	ltpuser = SAFE_GETPWNAM(cleanup, LTPUSER2);
-
-	/* get uid/gid of user accordingly */
-	user_uid = ltpuser->pw_uid;
-	group_gid = ltpuser->pw_gid;
-
-	/*
-	 * Change the ownership of test directory/file specified by
-	 * pathname to that of user_uid and group_gid.
-	 */
-	SAFE_CHOWN(cleanup, TEMP_FILE, user_uid, group_gid);
+	struct utimbuf utbuf;
+	struct stat statbuf;
+	time_t mintime, maxtime;
+
+	utbuf.modtime = time(0) - 5;
+	utbuf.actime = utbuf.modtime + 1;
+	TST_EXP_PASS_SILENT(utime(TEMP_FILE, &utbuf));
+	SAFE_STAT(TEMP_FILE, &statbuf);
+
+	if (statbuf.st_atime != utbuf.actime ||
+		statbuf.st_mtime != utbuf.modtime) {
+		tst_res(TFAIL, "Could not set initial file times");
+		return;
+	}
 
-	/* Get the current time */
-	curr_time = time(NULL);
+	SAFE_SETEUID(user_uid);
+	mintime = time(0);
+	TST_EXP_PASS(utime(TEMP_FILE, NULL));
+	maxtime = time(0);
+	SAFE_SETEUID(root_uid);
+	SAFE_STAT(TEMP_FILE, &statbuf);
 
-	/*
-	 * Sleep for a second so that mod time and access times will be
-	 * different from the current time
-	 */
-	sleep(2);		/* sleep(1) on IA64 sometimes sleeps < 1 sec!! */
+	if (statbuf.st_atime < mintime || statbuf.st_atime > maxtime)
+		tst_res(TFAIL, "utime() did not set expected atime");
 
+	if (statbuf.st_mtime < mintime || statbuf.st_mtime > maxtime)
+		tst_res(TFAIL, "utime() did not set expected mtime");
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-	seteuid(0);
-
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.skip_filesystems = (const char *const[]) {
+		"v9",
+		NULL
+	}
+};
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

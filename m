Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B4AC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 17:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D5793C8CCF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 19:21:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A20C33C8CC0
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02FAB6007A3
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DD5A21D1F;
 Fri, 17 Jun 2022 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655486437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iD2+0g5K6U0KWw19EZPZ2DIhpbFI0HYXDq27EGCqpQc=;
 b=1EU9u/RrY96B53qFJY3dncxeBLYL3dnlL5ZqdC9hOwBe0IR9gvnsWywkmyfyUNUwAfaGRS
 1gJLWvT3t00BpyeLhQK7B+tAResLOh/KG/7p68ISP/JjTz5xtY/8JfrSRiu3GXB9SVOh40
 xxYSPH6yKApzbHW1LtbmYSk3bKtEz2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655486437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iD2+0g5K6U0KWw19EZPZ2DIhpbFI0HYXDq27EGCqpQc=;
 b=is7RZNT7XH5Ze3T+8JPJ0fLmSbo6xJXybDmJcYeVGr9MaXA0tJ9HmsWjoDNtnmjXx5lrpn
 JPDUY+2Cg9zwEnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96EEB1348E;
 Fri, 17 Jun 2022 17:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kYFuGuS3rGKOcwAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 17 Jun 2022 17:20:36 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 17 Jun 2022 22:50:21 +0530
Message-Id: <20220617172025.23975-3-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617172025.23975-1-akumar@suse.de>
References: <20220617172025.23975-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] Rewrite utime02.c using new LTP API
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
 testcases/kernel/syscalls/utime/utime02.c | 265 +++++-----------------
 1 file changed, 53 insertions(+), 212 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index 14d5e18c9..59df9953b 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -1,238 +1,79 @@
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
+ *		07/2001 ported by John George
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * Test Name: utime02
- *
- * Test Description:
- *  Verify that the system call utime() successfully sets the modification
- *  and access times of a file to the current time, under the following
- *  constraints,
- *	- The times argument is null.
+/*\
+ * [Description]
+ *  Verify that the system call utime() successfully changes the last
+ *  access and modification times of a file to the current time,
+ *  under the following constraints:
+ *	- The times argument is NULL.
  *	- The user ID of the process is not "root".
  *	- The file is owned by the user ID of the process.
- *
- * Expected Result:
- *  utime succeeds returning zero and sets the access and modification
- *  times of the file to the current time.
- *
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
- *	utime02 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
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
- *
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <utime.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <signal.h>
 #include <pwd.h>
-#include <time.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
 
-char *TCID = "utime02";
-int TST_TOTAL = 1;
-time_t curr_time;		/* current time in seconds */
+#include "tst_test.h"
+#include "tst_clocks.h"
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+#define MNT_POINT	"mntpoint"
+#define TEMP_FILE	MNT_POINT"/tmp_file"
+#define FILE_MODE	0444
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
+#define TEST_USERNAME "nobody"
 
-int main(int ac, char **av)
-{
-	struct stat stat_buf;	/* struct buffer to hold file info. */
-	int lc;
-	long type;
-	time_t modf_time, access_time;
-	time_t pres_time;	/* file modification/access/present time */
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
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Invoke utime(2) to set TEMP_FILE access and
-		 * modification times to the current time.
-		 */
-		TEST(utime(TEMP_FILE, NULL));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
-		} else {
-			/*
-			 * Sleep for a second so that mod time and
-			 * access times will be different from the
-			 * current time
-			 */
-			sleep(2);
-
-			/*
-			 * Get the current time now, after calling
-			 * utime(2)
-			 */
-			pres_time = time(NULL);
-
-			/*
-			 * Get the modification and access times of
-			 * temporary file using stat(2).
-			 */
-			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
-			modf_time = stat_buf.st_mtime;
-			access_time = stat_buf.st_atime;
-
-			/* Now do the actual verification */
-			if (modf_time <= curr_time ||
-			    modf_time >= pres_time ||
-			    access_time <= curr_time ||
-			    access_time >= pres_time) {
-				tst_resm(TFAIL, "%s access and "
-					 "modification times not set",
-					 TEMP_FILE);
-			} else {
-				tst_resm(TPASS, "Functionality of "
-					 "utime(%s, NULL) successful",
-					 TEMP_FILE);
-			}
-		}
-		tst_count++;
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and close it
- */
-void setup(void)
+static void setup(void)
 {
-	int fildes;		/* file handle for temp file */
+	struct passwd *pw;
 
-	tst_require_root();
+	pw = SAFE_GETPWNAM(TEST_USERNAME);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_TOUCH(TEMP_FILE, FILE_MODE, NULL);
+	SAFE_CHOWN(TEMP_FILE, pw->pw_uid, pw->pw_gid);
 
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
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
-	/* Creat a temporary file under above directory */
-	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
-
-	/* Close the temporary file created */
-	SAFE_CLOSE(cleanup, fildes);
-
-	/* Get the current time */
-	curr_time = time(NULL);
-
-	/*
-	 * Sleep for a second so that mod time and access times will be
-	 * different from the current time
-	 */
-	sleep(2);		/* sleep(1) on IA64 sometimes sleeps < 1 sec!! */
+	tst_res(TINFO, "Switching effective user ID to user: %s", pw->pw_name);
 
+	SAFE_SETEUID(pw->pw_uid);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
+static void run(void)
 {
+	struct stat stat_buf;
+	time_t pre_time, post_time;
+
+	pre_time = tst_get_fs_timestamp();
+	TST_EXP_PASS(utime(TEMP_FILE, NULL), "utime(%s, NULL)", TEMP_FILE);
+	if (!TST_PASS) {
+		tst_res(TFAIL | TTERRNO, "utime(%s) failed", TEMP_FILE);
+		return;
+	}
+	post_time = tst_get_fs_timestamp();
+	SAFE_STAT(TEMP_FILE, &stat_buf);
 
-	tst_rmdir();
+	if (stat_buf.st_mtime < pre_time || stat_buf.st_mtime > post_time)
+		tst_res(TFAIL, "utime() did not set expected mtime");
 
+	if (stat_buf.st_atime < pre_time || stat_buf.st_atime > post_time)
+		tst_res(TFAIL, "utime() did not set expected atime");
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MNT_POINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]) {
+		"vfat",
+		"exfat",
+		NULL
+	}
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

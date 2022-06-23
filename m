Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D622DC43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:03:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFA243C94B4
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:03:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03E7B3C9564
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:02:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EFE911A00A5E
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:02:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 306CC21C09;
 Thu, 23 Jun 2022 08:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655971359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7vc98AWe++Klm3+ivHonmgQhyEB30zqrBVteXb4Ypc=;
 b=qrsFUQpoetLnMDXTIcXyTTAp4jvdyUIJte4PjJVIDFFfz0Ga2OxVQlM1xT4g8XZRiTZGQt
 JMFPOUNYN9iuv5XAvqOy29UNCA1DZ8eqQ7n8LdGvIm+f6IjcHjYeqM7bOLa04g9LnV0foa
 E97ra12ltr9qZU5sHqlfQTY2ggZ+IKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655971359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7vc98AWe++Klm3+ivHonmgQhyEB30zqrBVteXb4Ypc=;
 b=yDe/g1ESaPqAeXu52jg4odKJgzdk+ElCDUYZqXfu/TdtHe+q+129KM7fxd6f4/rlq9Rayk
 gOsnKTlr6F0ZmaDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5C39133A6;
 Thu, 23 Jun 2022 08:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3d23JR4etGKXdgAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 23 Jun 2022 08:02:38 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 23 Jun 2022 13:32:14 +0530
Message-Id: <20220623080215.24186-6-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623080215.24186-1-akumar@suse.de>
References: <20220623080215.24186-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/6] Rewrite utime05.c using new LTP API
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
 testcases/kernel/syscalls/utime/utime05.c | 213 ++++------------------
 1 file changed, 40 insertions(+), 173 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index b2d2450bf..ad035330c 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -1,200 +1,67 @@
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
- * Test Name: utime05
- *
- * Test Description:
- *  Verify that the system call utime() successfully sets the modification
- *  and access times of a file to the value specified by the times argument
- *  under the following constraints,
- *		- The times argument is not null,
- *		- The user ID of the process is not "root".
- *		- The file is owned by the user ID of the process.
- *
- * Expected Result:
- *  utime succeeds returning zero and sets the access and modification
- *  times of the file to that specified by the times argument.
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
- *  utime05 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
- *		where,	-c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functionality Testing.
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions:
+/*\
+ * [Description]
  *
+ * Verify that the system call utime() successfully changes the last
+ * access and modification times of a file to the values specified by
+ * times argument, under the following constraints:
+ * - The times argument is not NULL.
+ * - The user ID of the process is not "root".
+ * - The file is owned by the user ID of the process.
  */
 
-#include <stdio.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
 #include <utime.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <signal.h>
 #include <pwd.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
-#define NEW_TIME	10000
-
-char *TCID = "utime05";
-int TST_TOTAL = 1;
+#define FILE_MODE	0444
+#define NEW_MODF_TIME	10000
+#define NEW_ACCESS_TIME	20000
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+#define TEST_USERNAME "nobody"
 
-struct utimbuf times;		/* struct. buffer for utime() */
+static struct utimbuf times = {
+	.modtime = NEW_MODF_TIME,
+	.actime = NEW_ACCESS_TIME
+};
 
-void setup();			/* Main setup function of test */
-void cleanup();			/* cleanup function for the test */
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	struct stat stat_buf;	/* struct buffer to hold file info. */
-	int lc;
-	time_t modf_time, access_time;
-	/* file modification/access time */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	struct passwd *pw;
 
-		tst_count = 0;
+	pw = SAFE_GETPWNAM(TEST_USERNAME);
 
-		/*
-		 * Invoke utime(2) to set TEMP_FILE access and
-		 * modification times to that specified by
-		 * times argument.
-		 */
-		TEST(utime(TEMP_FILE, &times));
+	tst_res(TINFO, "Switching effective user ID to user: %s", pw->pw_name);
+	SAFE_SETEUID(pw->pw_uid);
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
-		} else {
-			/*
-			 * Get the modification and access times of
-			 * temporary file using stat(2).
-			 */
-			SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
-			modf_time = stat_buf.st_mtime;
-			access_time = stat_buf.st_atime;
-
-			/* Now do the actual verification */
-			if ((modf_time != NEW_TIME) ||
-			    (access_time != NEW_TIME)) {
-				tst_resm(TFAIL, "%s access and "
-					 "modification times not set",
-					 TEMP_FILE);
-			} else {
-				tst_resm(TPASS, "Functionality of "
-					 "utime(%s, &times) successful",
-					 TEMP_FILE);
-			}
-		}
-		tst_count++;	/* incr TEST_LOOP counter */
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_TOUCH(TEMP_FILE, FILE_MODE, NULL);
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and change directory to it.
- *  Create a test file under temporary directory and close it
- */
-void setup(void)
+static void run(void)
 {
-	int fildes;		/* file handle for temp file */
-
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
+	struct stat stat_buf;
 
-	tst_tmpdir();
+	TST_EXP_PASS(utime(TEMP_FILE, &times), "utime(%s, &times)", TEMP_FILE);
+	if (!TST_PASS)
+		return;
 
-	/* Creat a temporary file under above directory */
-	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
-
-	/* Close the temporary file created */
-	SAFE_CLOSE(cleanup, fildes);
-
-	/* Initialize the modification and access time in the times arg */
-	times.actime = NEW_TIME;
-	times.modtime = NEW_TIME;
+	SAFE_STAT(TEMP_FILE, &stat_buf);
 
+	TST_EXP_EQ_LI(stat_buf.st_mtime, NEW_MODF_TIME);
+	TST_EXP_EQ_LI(stat_buf.st_atime, NEW_ACCESS_TIME);
 }
 
-/*
- * void
- * cleanup() -	performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- *		Remove the test directory and testfile created in the setup.
- */
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1
+};
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

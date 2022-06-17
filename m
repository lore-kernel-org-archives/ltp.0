Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4B2C43334
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 17:21:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C1B83C8CAB
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 19:21:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 594273C8965
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 543751000D19
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 901631F8B4;
 Fri, 17 Jun 2022 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655486444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=et4yFEDyg7PObmNw9fzOuXf2yj6f7c+e8yeELzMT++w=;
 b=vxood6fJHu1T5i30cmM+c3ZZ+bu+ncHVpdwcNW/kCj79MeVdenrCcxy89ZKGtxECAgBt2f
 5fC4LW7GQ1d4ApcOLy8hXx3WRKcSRrLkTHCVCTS729+Z7OUp0PMBKI3emXjRTIDIwJP1wO
 hXfanrUpl02UcCGzNyNIzOTM9F4If7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655486444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=et4yFEDyg7PObmNw9fzOuXf2yj6f7c+e8yeELzMT++w=;
 b=VrgRTIhilsa+gyy1jCdpOq1TzRNOSFURoSGJvRRST65n8edIqTDLbBP3q1QdaiVBbxsC6N
 bbSCsRWqV2b/eeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0C5E1348E;
 Fri, 17 Jun 2022 17:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vXP+Heu3rGKccwAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 17 Jun 2022 17:20:43 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 17 Jun 2022 22:50:23 +0530
Message-Id: <20220617172025.23975-5-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617172025.23975-1-akumar@suse.de>
References: <20220617172025.23975-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] Rewrite utime04.c using new LTP API
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
 testcases/kernel/syscalls/utime/utime04.c | 204 ++++------------------
 1 file changed, 37 insertions(+), 167 deletions(-)

diff --git a/testcases/kernel/syscalls/utime/utime04.c b/testcases/kernel/syscalls/utime/utime04.c
index 5253f768a..4b516f403 100644
--- a/testcases/kernel/syscalls/utime/utime04.c
+++ b/testcases/kernel/syscalls/utime/utime04.c
@@ -1,190 +1,60 @@
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
- * Test Name: utime04
- *
- * Test Description:
- *  Verify that the system call utime() successfully sets the modification
- *  and access times of a file to the time specified by times argument, if
- *  the times argument is not null, and the user ID of the process is "root".
- *
- * Expected Result:
- *   utime succeeds returning zero and sets the access and modification
- *   times of the file to that specified by the times argument.
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
- *  utime04 [-c n] [-e] [-f] [-i n] [-I x] [-p x] [-t]
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
- *  This test should be run by 'super-user' (root) only.
- *
+/*\
+ * [Description]
+ *  Verify that the system call utime() successfully changes the last
+ *  access and modification times of a file to the values specified by
+ *  times argument, under the following constraints:
+ *  - The times argument is not NULL.
+ *  - The user ID of the process is "root".
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
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define TEMP_FILE	"tmp_file"
-#define FILE_MODE	S_IRUSR | S_IRGRP | S_IROTH
-#define NEW_TIME	10000
-
-char *TCID = "utime04";
-int TST_TOTAL = 1;
+#define FILE_MODE	0444
+#define NEW_MODF_TIME	10000
+#define NEW_ACCESS_TIME	20000
 
-struct utimbuf times;		/* struct. buffer for utime() */
+static struct utimbuf times;
 
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
-
-		tst_count = 0;
-
-		/*
-		 * Invoke utime(2) to set TEMP_FILE access and
-		 * modification times to that specified by
-		 * times argument.
-		 */
-		TEST(utime(TEMP_FILE, &times));
-
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
+	SAFE_TOUCH(TEMP_FILE, FILE_MODE, NULL);
 
-	cleanup();
-	tst_exit();
+	times.modtime = NEW_MODF_TIME;
+	times.actime = NEW_ACCESS_TIME;
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
+	struct stat stat_buf;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	TST_EXP_PASS(utime(TEMP_FILE, &times), "utime(%s, &times)", TEMP_FILE);
 
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Creat a temporary file under above directory */
-	fildes = SAFE_CREAT(cleanup, TEMP_FILE, FILE_MODE);
+	if (!TST_PASS) {
+		tst_res(TFAIL | TTERRNO, "utime(%s, &times) failed", TEMP_FILE);
+		return;
+	}
 
-	/* Close the temporary file created */
-	SAFE_CLOSE(cleanup, fildes);
+	SAFE_STAT(TEMP_FILE, &stat_buf);
 
-	/* Initialize the modification and access time in the times arg */
-	times.actime = NEW_TIME;
-	times.modtime = NEW_TIME;
+	if (stat_buf.st_mtime != NEW_MODF_TIME)
+		tst_res(TFAIL, "utime() did not set expected mtime");
 
+	if (stat_buf.st_atime != NEW_ACCESS_TIME)
+		tst_res(TFAIL, "utime() did not set expected atime");
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- *  Remove the test directory and testfile created in the setup.
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

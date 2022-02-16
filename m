Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5DAC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 07:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F03383CA072
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 08:39:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87A0E3CA071
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 08:38:54 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 79D8D1A014D8
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 08:38:51 +0100 (CET)
X-QQ-mid: bizesmtp73t1644997122t7r85rxc
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 16 Feb 2022 15:38:40 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000C00A0000000
X-QQ-FEAT: 3u0oYPVhaeP04bygOGDUKEiTie9q/WQLBqseco3Av2vX9Y0CoGwJ+CL5lBOgK
 8yP7V9YWiM/wfmpTH/s3mFr/OTkTWTxT8pV79ChQxbgC+wXjT0l95S8fK8KR1jn9TNhLD8+
 2wKSrCJ4qTzglS98jEi6xN57lgrbRQ7rBJuB6iGqOHg1CWotfuq/Z9xY5W1DIenhebzIUtJ
 EX9hSFxCcqS9fiWulMwdJ350yYckiGXjJuRDiLJjeZxHFXQr7gDdOQt52/I5ZPYl7INpinm
 7xM0Roxcc9bw0bwRQQHAMp6wHZcRD6jc0EzUm2H1FgwPklaxVLPJy5aMLPDVgxYAAfcUED0
 QMtoTt4o50ZqNIVL6ZdcThH6SL2chvZxUUAss+q
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 16 Feb 2022 15:38:31 +0800
Message-Id: <20220216073831.20148-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220216073831.20148-1-tangmeng@uniontech.com>
References: <20220216073831.20148-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/fchmod_04: Convert to new API
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
Cc: tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 testcases/kernel/syscalls/fchmod/fchmod04.c | 210 ++++----------------
 1 file changed, 42 insertions(+), 168 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index befaadb35..d60cb39b2 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -1,190 +1,64 @@
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
  */
 
-/*
- * Test Name: fchmod04
+/*\
+ * [Description]
  *
- * Test Description:
- *  Verify that, fchmod(2) will succeed to change the mode of a directory
- *  and set the sticky bit on it if invoked by non-root (uid != 0) process
- *  with the following constraints,
+ * Verify that, fchmod(2) will succeed to change the mode of a directory
+ * and set the sticky bit on it if invoked by non-root (uid != 0) process
+ * with the following constraints,
  *	- the process is the owner of the directory.
  *	- the effective group ID or one of the supplementary group ID's of the
  *	  process is equal to the group ID of the directory.
- *
- * Expected Result:
- *  fchmod() should return value 0 on success and succeeds to set sticky bit
- *  on the specified directory.
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
- *   	Log the errno and Issue a FAIL message.
- *   Otherwise,
- *   	Verify the Functionality of system call
- *      if successful,
- *      	Issue Functionality-Pass message.
- *      Otherwise,
- *		Issue Functionality-Fail message.
- *  Cleanup:
- *   Print errno log and/or timing stats if options given
- *   Delete the temporary directory created.
- *
- * Usage:  <for command-line>
- *  fchmod04 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  This test should be run by 'non-super-user' only.
- *
  */
 
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include <stdio.h>
 #include "fchmod.h"
+#include "tst_test.h"
 
-int fd;				/* file descriptor for test directory */
-char *TCID = "fchmod04";
-int TST_TOTAL = 1;
+static int fd;
+static const char nobody_uid[] = "nobody";
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-void setup();
-void cleanup();
-
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
-	struct stat stat_buf;	/* stat struct. */
-	int lc;
-	mode_t dir_mode;	/* mode permissions set on testdirectory */
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
-		 * Call fchmod(2) with mode argument to
-		 * set sticky bit on TESTDIR
-		 */
-		TEST(fchmod(fd, PERMS));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "fchmod failed");
-			continue;
-		}
-		if (fstat(fd, &stat_buf) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "fstat failed");
-		dir_mode = stat_buf.st_mode;
-
-		if ((dir_mode & PERMS) == PERMS)
-			tst_resm(TPASS, "Functionality of fchmod(%d, "
-				 "%#o) successful", fd, PERMS);
-		else
-			tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
-				 "Expected 0%03o",
-				 TESTDIR, dir_mode, PERMS);
-	}
-
-	cleanup();
-	tst_exit();
+	struct stat stat_buf;
+	mode_t dir_mode;
+
+	TST_EXP_PASS_SILENT(fchmod(fd, PERMS));
+
+	if (fstat(fd, &stat_buf) == -1)
+		tst_brk(TFAIL | TERRNO, "fstat failed");
+	dir_mode = stat_buf.st_mode;
+
+	if ((dir_mode & PERMS) == PERMS)
+		tst_res(TPASS, "Functionality of fchmod(%d, "
+			"%#o) successful", fd, PERMS);
+	else
+		tst_res(TFAIL, "%s: Incorrect modes 0%03o, "
+			"Expected 0%03o",
+			TESTDIR, dir_mode, PERMS);
 }
 
-/*
- * void
- * setup() - performs all ONE TIME setup for this test.
- *  Create a temporary directory and cd to it.
- *  Create another test directory under temporary directory.
- *  Open the test directory for reading.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "seteuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("seteuid");
-	}
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/*
-	 * Create a test directory under temporary directory with specified
-	 * mode permissios and open it for reading/writing.
-	 */
-	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
-	if ((fd = open(TESTDIR, O_RDONLY)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDONLY) failed, errno=%d : %s",
-			 TESTDIR, errno, strerror(errno));
-	}
+	SAFE_GETPWNAM(nobody_uid);
+	SAFE_MKDIR(TESTDIR, DIR_MODE);
+	fd = SAFE_OPEN(TESTDIR, O_RDONLY);
 }
 
-/*
- * void
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- *  Close the test directory opened during setup().
- *  Remove the test directory and temporary directory created in setup().
- */
-void cleanup(void)
+static void cleanup(void)
 {
-
-	/* Close the test directory opened during setup() */
-	SAFE_CLOSE(NULL, fd);
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = verify_fchmod,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9499C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 07:39:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9003CA06F
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 08:39:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5935F3C101E
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 08:38:48 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 86E2C600F98
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 08:38:45 +0100 (CET)
X-QQ-mid: bizesmtp73t1644997118tksrhm5c
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 16 Feb 2022 15:38:33 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000C00A0000000
X-QQ-FEAT: Mzskoac49OjgbrexYFIohglRbScaxMhfmzg/k0Wwz+hZwNu7XyppndUKZdXen
 EPHvJ0vW+jjNJ9MIhW/C06vYkjsMqAGZmxVbt1EgVs5Z23fiZmcbAnDkkX0WUSV7/o9c6E8
 i/ckzGQvpZFe1mrd52MQyqQQFNF/vfRGHQl5MYVrXe3g6mhBga5nIlwwdjaVyhqhMInbL49
 69IlxtC3OKOh0iokjksmIhz4ljHRb9GUJe5T6lpqqZKAsPzwWVKJm0OQOMojLpNV+XIcKXp
 jdhQESgJdIDdJ7jwe/pRN/9dmHZKCETlvDGx202WnLnh4CUhqIfVXyCamAJ6I9/UkptW/60
 niUb/n63cCrJN/dsB/WPp89w4evbaRojzpTxMKd
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 16 Feb 2022 15:38:30 +0800
Message-Id: <20220216073831.20148-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/fchmod_03: Convert to new API
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
 testcases/kernel/syscalls/fchmod/fchmod03.c | 181 ++++----------------
 1 file changed, 38 insertions(+), 143 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c b/testcases/kernel/syscalls/fchmod/fchmod03.c
index a5824f36b..12a6f5a93 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -1,170 +1,65 @@
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
- * Test Name: fchmod03
+/*\
+ * [Description]
  *
- * Test Description:
- *  Verify that, fchmod(2) will succeed to change the mode of a file
- *  and set the sticky bit on it if invoked by non-root (uid != 0)
- *  process with the following constraints,
+ * Verify that, fchmod(2) will succeed to change the mode of a file
+ * and set the sticky bit on it if invoked by non-root (uid != 0)
+ * process with the following constraints,
  *	- the process is the owner of the file.
  *	- the effective group ID or one of the supplementary group ID's of the
  *	  process is equal to the group ID of the file.
- *
- * Expected Result:
- *  fchmod() should return value 0 on success and succeeds to change
- *  the mode of specified file, sets sticky bit on it.
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
- *  fchmod03 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
 #include "fchmod.h"
+#include "tst_test.h"
 
-int fd;				/* file descriptor for test file */
-char *TCID = "fchmod03";
-int TST_TOTAL = 1;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+static int fd;
+static const char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
 
-void setup();			/* Main setup function for the test */
-void cleanup();			/* Main cleanup function for the test */
-
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
-	struct stat stat_buf;	/* stat struct. */
-	int lc;
-	mode_t file_mode;	/* mode permissions set on testfile */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	struct stat stat_buf;
+	mode_t file_mode;
 
-		tst_count = 0;
+	TST_EXP_PASS_SILENT(fchmod(fd, PERMS));
 
-		TEST(fchmod(fd, PERMS));
+	if (fstat(fd, &stat_buf) == -1)
+		tst_brk(TFAIL | TERRNO, "fstat failed");
+	file_mode = stat_buf.st_mode;
 
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "fchmod failed");
-			continue;
-		}
-		/*
-		 * Get the file information using
-		 * fstat(2).
-		 */
-		if (fstat(fd, &stat_buf) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "fstat failed");
-		file_mode = stat_buf.st_mode;
-
-		/* Verify STICKY BIT set on testfile */
-		if ((file_mode & PERMS) != PERMS)
-			tst_resm(TFAIL, "%s: Incorrect modes 0%3o, "
-				 "Expected 0777", TESTFILE, file_mode);
-		else
-			tst_resm(TPASS, "Functionality of fchmod(%d, "
-				 "%#o) successful", fd, PERMS);
-	}
-
-	cleanup();
-	tst_exit();
+	if ((file_mode & PERMS) != PERMS)
+		tst_res(TFAIL, "%s: Incorrect modes 0%3o, "
+			"Expected 0777", TESTFILE, file_mode);
+	else
+		tst_res(TPASS, "Functionality of fchmod(%d, "
+			"%#o) successful", fd, PERMS);
 }
 
-void setup(void)
+static void setup(void)
 {
+	ltpuser = SAFE_GETPWNAM(nobody_uid);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
+	SAFE_SETEUID(ltpuser->pw_uid);
 
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	SAFE_SETEUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/*
-	 * Create a test file under temporary directory with specified
-	 * mode permissios and set the ownership of the test file to the
-	 * uid/gid of guest user.
-	 */
-	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
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

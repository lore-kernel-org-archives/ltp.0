Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEB5C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:17:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C5A61AFD
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98C5A61AFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F8463C89B4
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:17:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 999323C7A4A
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:16:56 +0100 (CET)
Received: from smtpbg511.qq.com (smtpbg511.qq.com [203.205.250.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 48D8D6008A6
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:16:53 +0100 (CET)
X-QQ-mid: bizesmtp50t1637306208tsrghb9n
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 19 Nov 2021 15:16:46 +0800 (CST)
X-QQ-SSF: 0140000000200050D000000D0000000
X-QQ-FEAT: vplKx+OOQC1BrbCHVuxCg3DC6Iwlvf9SRPV/uxDQc7Uhn1RxcRgRbIDnLPxSJ
 rYZLx3k2gr0zCz5LyilC0gCjxbvoOZQKI4j4MjXKcNOdhqhFxD5Le8PHBtiLmgfIJY2Sas1
 3S3IZtV3n5/TNS+cBTgciGZcpZcIxutvhfHNpSHqz3vfe6RTs62YSJ2OybqStpgQLg7wOOU
 Kifns4sDoKnFyB8xC8XnzMf2uokia7zaew+DxXi1OGa/XcWfaqs4kCpbO/nWkWYJ4+oKkiq
 h0+F9IiatNyYcFP72VhACuTzSu21kCu3W6h7G1YiFPElDX1/R7cHAbDiZpcUkTDNhz5DCJC
 3ftXKgPJXz67bt9A5T+x8Bfj9E+9A==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 15:16:37 +0800
Message-Id: <20211119071637.19635-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211119071637.19635-1-tangmeng@uniontech.com>
References: <20211119071637.19635-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/fchmod_04: Convert to new API
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
 testcases/kernel/syscalls/fchmod/fchmod04.c | 185 +++++---------------
 1 file changed, 39 insertions(+), 146 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index befaadb35..1d84b4424 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -1,190 +1,83 @@
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

 int fd;				/* file descriptor for test directory */
-char *TCID = "fchmod04";
-int TST_TOTAL = 1;
-
 char nobody_uid[] = "nobody";
 struct passwd *ltpuser;

-void setup();
-void cleanup();
-
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
 	struct stat stat_buf;	/* stat struct. */
-	int lc;
 	mode_t dir_mode;	/* mode permissions set on testdirectory */

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
+	/*
+	 * Call fchmod(2) with mode argument to
+	 * set sticky bit on TESTDIR
+	 */
+	TST_EXP_PASS_SILENT(fchmod(fd, PERMS));
+
+	if (fstat(fd, &stat_buf) == -1)
+		tst_brk(TFAIL | TERRNO, "fstat failed");
+	dir_mode = stat_buf.st_mode;
+
+	if ((dir_mode & PERMS) == PERMS)
+		tst_res(TPASS, "Functionality of fchmod(%d, "
+			 "%#o) successful", fd, PERMS);
+	else
+		tst_res(TFAIL, "%s: Incorrect modes 0%03o, "
+			 "Expected 0%03o",
+			 TESTDIR, dir_mode, PERMS);
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
 	/* Switch to nobody user for correct error code collection */
 	ltpuser = getpwnam(nobody_uid);
 	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "seteuid failed to "
+		tst_res(TINFO, "seteuid failed to "
 			 "to set the effective uid to %d", ltpuser->pw_uid);
 		perror("seteuid");
 	}

-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	/*
 	 * Create a test directory under temporary directory with specified
 	 * mode permissios and open it for reading/writing.
 	 */
-	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
+	SAFE_MKDIR(TESTDIR, DIR_MODE);
 	if ((fd = open(TESTDIR, O_RDONLY)) == -1) {
-		tst_brkm(TBROK, cleanup,
+		tst_brk(TBROK,
 			 "open(%s, O_RDONLY) failed, errno=%d : %s",
 			 TESTDIR, errno, strerror(errno));
 	}
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
 	/* Close the test directory opened during setup() */
-	SAFE_CLOSE(NULL, fd);
-
-	tst_rmdir();
-
+	SAFE_CLOSE(fd);
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

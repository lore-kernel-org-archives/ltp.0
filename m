Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A28C433FE
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:17:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A1061B04
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2A1061B04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80AE63C8989
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:17:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A96743C7A4A
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:16:55 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1BD692011E0
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:16:51 +0100 (CET)
X-QQ-mid: bizesmtp50t1637306205tod69nxq
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 19 Nov 2021 15:16:39 +0800 (CST)
X-QQ-SSF: 0140000000200050D000000D0000000
X-QQ-FEAT: Mzskoac49OgoSdswGab5sSZilUiAV/+Z7PgUfELOaywPtYmSebsCROLK4ZwVx
 DPE3ArnuCL4AklmOdE2/W7AaBNd1hHfTm+6LbqnLlFi4F0sfKGkixqW8LaYLycpgZDqQe0U
 6V2BVwlWfeOB2vGvMzDdiLUjRPrphOS1qFiL11+r+X1sQi/NLbczqgDW54vvxMUgjqCrDTY
 8MFbA2Rx+Jy4PmjXa9eqF5Ar5b1OZJCmLgh5QFoST7jI4HMXkfkyTzVK+/Q9eXhLIUtLTi7
 TotE+UON0zXGI1OTP6Fe9aw6psmYT1OyTauLAD0Vyw4ZPq2KAjgkH5AjgpZKdUtO8KhFa5k
 p35ac55/LgRsCzWsmNXy5lU/qvj0ApcyvL18MxX
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 15:16:36 +0800
Message-Id: <20211119071637.19635-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/fchmod_03: Convert to new API
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
 testcases/kernel/syscalls/fchmod/fchmod03.c | 165 +++++---------------
 1 file changed, 36 insertions(+), 129 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c b/testcases/kernel/syscalls/fchmod/fchmod03.c
index a5824f36b..8ebfc2536 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -1,155 +1,58 @@
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

 int fd;				/* file descriptor for test file */
-char *TCID = "fchmod03";
-int TST_TOTAL = 1;
-
 char nobody_uid[] = "nobody";
 struct passwd *ltpuser;

-void setup();			/* Main setup function for the test */
-void cleanup();			/* Main cleanup function for the test */
-
-int main(int ac, char **av)
+static void verify_fchmod(void)
 {
 	struct stat stat_buf;	/* stat struct. */
-	int lc;
 	mode_t file_mode;	/* mode permissions set on testfile */

-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	TST_EXP_PASS_SILENT(fchmod(fd, PERMS));

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(fchmod(fd, PERMS));
-
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
+	/*
+	 * Get the file information using
+	 * fstat(2).
+	 */
+	if (fstat(fd, &stat_buf) == -1)
+		tst_brk(TFAIL | TERRNO, "fstat failed");
+	file_mode = stat_buf.st_mode;
+
+	/* Verify STICKY BIT set on testfile */
+	if ((file_mode & PERMS) != PERMS)
+		tst_res(TFAIL, "%s: Incorrect modes 0%3o, "
+			 "Expected 0777", TESTFILE, file_mode);
+	else
+		tst_res(TPASS, "Functionality of fchmod(%d, "
+			 "%#o) successful", fd, PERMS);
 }

 void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
 	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	SAFE_SETEUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;

-	tst_tmpdir();
+	if (ltpuser == NULL)
+		tst_brk(TBROK | TERRNO, "getpwnam failed");
+	SAFE_SETEUID(ltpuser->pw_uid);

 	/*
 	 * Create a test file under temporary directory with specified
@@ -157,14 +60,18 @@ void setup(void)
 	 * uid/gid of guest user.
 	 */
 	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+		tst_brk(TBROK | TERRNO, "open failed");
 }

 void cleanup(void)
 {
 	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
-
+		tst_res(TWARN | TERRNO, "close failed");
 }
+
+static struct tst_test test = {
+	.test_all = verify_fchmod,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

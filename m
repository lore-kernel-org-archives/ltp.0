Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C8CC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 06:34:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34623CA06C
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 07:34:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247FD3C95E3
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 07:34:47 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ACFAB20100B
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 07:34:45 +0100 (CET)
X-QQ-mid: bizesmtp71t1644993279tafqy27x
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 16 Feb 2022 14:34:33 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000C00A0000000
X-QQ-FEAT: k0yT7W7BRd0vxkgFu0VMFCh3M6sq9VDWQ5qp8uBJlfch0T0NTGa0kc9D8lTP+
 TyBKm064S1RwCcmI82dT06CtgOH0uHiREsZvnmMlxxjpa3l0xi9ulxH9hb7Y/cyhkQWzBJW
 pqY7B0HBME/7K7fa0lPaIkhndYYE1EL2+7geuirmWFnaId2jfVlusGPEH50aaSISQ6SCS1F
 EtbbHulswWBGnhuZ4GxZO7K1YSA1GNz+2vdyE9nN2T/F3WZiILjXV0uXHaN+/WB6BCbIoLq
 FkNXFUj4rN8aF1RSr7tDAAn+/aHB0plBt37j6JAr+KkGYGimbIb+1gu2rryG1Ce0HkSogiB
 8mu4VnxmJ0MOUOUCFw9b3VmOqAXAz/ZyXZIYsyV
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 16 Feb 2022 14:34:30 +0800
Message-Id: <20220216063430.31447-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/fchmodat_01: Convert to new API
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
 .../kernel/syscalls/fchmodat/fchmodat01.c     | 166 +++++++-----------
 1 file changed, 60 insertions(+), 106 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 9676ae0fd..70e35b363 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -1,116 +1,65 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
  *
- *   Copyright (c) International Business Machines  Corp., 2006
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
- *
- * NAME
- *      fchmodat01.c
- *
- * DESCRIPTION
- *	This test case will verify basic function of fchmodat
- *	added by kernel 2.6.16 or up.
- *
- * Author
- *	Yi Yang <yyangcdl@cn.ibm.com>
- *
- * History
- *      08/28/2006      Created first by Yi Yang <yyangcdl@cn.ibm.com>
+ * 08/28/2006 AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
+ */
+
+/*\
+ * [Description]
  *
- *****************************************************************************/
+ * This test case will verify basic function of fchmodat.
+ */
 
 #define _GNU_SOURCE
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
 #include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
 #include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 
-#define TEST_CASES 6
 #ifndef AT_FDCWD
 #define AT_FDCWD -100
 #endif
-void setup();
-void cleanup();
-
-char *TCID = "fchmodat01";
-int TST_TOTAL = TEST_CASES;
-char pathname[256];
-char testfile[256];
-char testfile2[256];
-char testfile3[256];
-int fds[TEST_CASES];
-char *filenames[TEST_CASES];
-int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
-
-int myfchmodat(int dirfd, const char *filename, mode_t mode)
-{
-	return tst_syscall(__NR_fchmodat, dirfd, filename, mode);
-}
 
-int main(int ac, char **av)
+static char pathname[256];
+static char testfile[256];
+static char testfile2[256];
+static char testfile3[256];
+
+static struct tcase {
+	int exp_errno;          /* Expected error no            */
+	char *exp_errval;       /* Expected error value string  */
+} tcases[] = {
+	{ 0, NULL},
+	{ 0, NULL},
+	{ ENOTDIR, "ENOTDIR"},
+	{ EBADF, "EBADF"},
+	{ 0, NULL},
+	{ 0, NULL},
+};
+static int fds[ARRAY_SIZE(tcases)];
+static char *filenames[ARRAY_SIZE(tcases)];
+
+static void verify_fchmodat(unsigned int i)
 {
-	int lc;
-	int i;
-
-	/* Disable test if the version of the kernel is less than 2.6.16 */
-	if ((tst_kvercmp(2, 6, 16)) < 0) {
-		tst_resm(TWARN, "This test can only run on kernels that are ");
-		tst_resm(TWARN, "2.6.16 and higher");
-		exit(0);
-	}
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(myfchmodat(fds[i], filenames[i], 0600));
-
-			if (TEST_ERRNO == expected_errno[i]) {
-				tst_resm(TPASS,
-					 "fchmodat() returned the expected  errno %d: %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL,
-					 "fchmodat() Failed, errno=%d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	struct tcase *tc = &tcases[i];
+
+	if (tc->exp_errno == 0)
+		TST_EXP_PASS(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
+			     "fchmodat() returned the expected errno %d: %s",
+			     TST_ERR, strerror(TST_ERR));
+	else
+		TST_EXP_FAIL(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
+			     tc->exp_errno,
+			     "fchmodat() returned the expected errno %d: %s",
+			     TST_ERR, strerror(TST_ERR));
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
 	/* Initialize test dir and file names */
 	char *abs_path = tst_get_tmpdir();
 	int p = getpid();
@@ -122,31 +71,36 @@ void setup(void)
 
 	free(abs_path);
 
-	SAFE_MKDIR(cleanup, pathname, 0700);
+	SAFE_MKDIR(pathname, 0700);
 
-	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
+	fds[0] = SAFE_OPEN(pathname, O_DIRECTORY);
 	fds[1] = fds[4] = fds[0];
 
-	SAFE_FILE_PRINTF(cleanup, testfile, "%s", testfile);
-	SAFE_FILE_PRINTF(cleanup, testfile2, "%s", testfile2);
+	SAFE_FILE_PRINTF(testfile, "%s", testfile);
+	SAFE_FILE_PRINTF(testfile2, "%s", testfile2);
 
-	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
+	fds[2] = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
 	fds[3] = 100;
 	fds[5] = AT_FDCWD;
 
 	filenames[0] = filenames[2] = filenames[3] = filenames[4] = testfile;
 	filenames[1] = testfile2;
 	filenames[5] = testfile3;
-
-	TEST_PAUSE;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	if (fds[0] > 0)
 		close(fds[0]);
 	if (fds[2] > 0)
 		close(fds[2]);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.min_kver = "2.6.16",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_fchmodat,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

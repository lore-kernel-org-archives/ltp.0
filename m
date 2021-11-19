Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7228FC433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:17:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F6F61AFB
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0F6F61AFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 538193C891E
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:17:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DD5F3C7A4A
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:17:42 +0100 (CET)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0F6B4600F67
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:17:38 +0100 (CET)
X-QQ-mid: bizesmtp48t1637306253tde78x4d
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 19 Nov 2021 15:17:24 +0800 (CST)
X-QQ-SSF: 0140000000200050D000000D0000000
X-QQ-FEAT: a4niRxydalGRtqbuxcfvzW3/PDzOsamnTg1Dyl/DmXZF3vkDR2SNKBbPyCh5K
 lL/gw02XgGksPzqbf7hq51lBaZOE/FsjM7xkXlqHUvPXrhR3C2ynizrxnYeWxm1mJMqKlaf
 3YqR+XLwzom1nR/2Uf2Xf5qIP8J+bhhgJKYYjCNe4E8dJwe8P4slgbi8ZxKF+Atkzfj3Loe
 QHVVDzf2gLck5bTdnF9ZxLXspxYOTJGTl+EDgFQW4+L1N1ONACVYWMDEP/HkTy/EsOC86YU
 5/9IslhgCjGVkZCvDAHOWewhcr3NKr6hsHxOZZYC1n1mOJMl/blbckY+eCGSP7PTJfpzU5+
 vTZI1qdufBvfqg1EJJ1nKVd/oYmXtHyrqCWlxXQ
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 15:17:23 +0800
Message-Id: <20211119071723.19836-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fchmodat_01: Convert to new API
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
 .../kernel/syscalls/fchmodat/fchmodat01.c     | 140 ++++++------------
 1 file changed, 44 insertions(+), 96 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 369f80eb2..555535174 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -1,116 +1,59 @@
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

-char *TCID = "fchmodat01";
-int TST_TOTAL = TEST_CASES;
 char pathname[256];
 char testfile[256];
 char testfile2[256];
 char testfile3[256];
-int fds[TEST_CASES];
-char *filenames[TEST_CASES];
-int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
+int expected_errno[6] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
+int fds[ARRAY_SIZE(expected_errno)];
+char *filenames[ARRAY_SIZE(expected_errno)];

 int myfchmodat(int dirfd, const char *filename, mode_t mode)
 {
-	return ltp_syscall(__NR_fchmodat, dirfd, filename, mode);
+	return tst_syscall(__NR_fchmodat, dirfd, filename, mode);
 }

-int main(int ac, char **av)
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
+	TEST(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600));
+
+	if (TST_ERR == expected_errno[i]) {
+		tst_res(TPASS,
+			 "fchmodat() returned the expected  errno %d: %s",
+			 TST_ERR, strerror(TST_ERR));
+	} else {
+		tst_res(TFAIL,
+			 "fchmodat() Failed, errno=%d : %s",
+			 TST_ERR, strerror(TST_ERR));
 	}
-
-	cleanup();
-	tst_exit();
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
@@ -122,31 +65,36 @@ void setup(void)

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
+	.tcnt = ARRAY_SIZE(expected_errno),
+	.test = verify_fchmodat,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4F9C001DB
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 04:08:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49D3F3CE375
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 06:08:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5A9D3CE37F
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:25 +0200 (CEST)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4E36200973
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:24 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="128401964"
X-IronPort-AV: E=Sophos;i="6.01,256,1684767600"; d="scan'208";a="128401964"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2023 13:08:21 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 33B48D29E5
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:19 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5B76FD9467
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 67610878F1;
 Sat,  5 Aug 2023 13:08:17 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat,  5 Aug 2023 12:07:57 +0800
Message-Id: <1691208482-5464-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27794.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27794.003
X-TMASE-Result: 10--10.038500-10.000000
X-TMASE-MatchedRID: vMX41ujcXajyq/cli2hvDU7nLUqYrlslFIuBIWrdOePEosIs7IJbkFI3
 NifDbduL+FyTwBk2ojyri0Mekz/9sqZY4PxfRMWExDiakrJ+SpmqxXpq+unGVQO9eL/lCA+UBuh
 MNLfO6UCkV52mAIXFpRfO14W+QP3kz5odC7feL1b7IK6Q1+r9ntmhsJODizUsvnhgJqkfm0B9Jp
 pVNkb1KyolWOAMg2fcldsH2WVXUxV0c2Jq7zcO7b0dPFETpBAHMi5cVoUvU/Zf/JRqlbLSVz+/s
 uSwJuNyuzW0mXOtDblXNicS/yg1bT+7nvNv6fe6dXu122+iJtrDvsJEJ3LgvPRHUPIiGLuAa0IE
 kYOsokX5fXwbFMncd0GaeX/AzQEVS62nMBX/dwPfSQNpZkETVB4crFjzdzs4myiLZetSf8mfop0
 ytGwvXiq2rl3dzGQ10lbMTFdJUXyLclfvM09yEiCRHWHAeJfRI4tqBE8QtlqZEZkpOCfW2g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] syscalls/faccessat01: Convert to new API
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/faccessat/faccessat01.c   | 208 +++++++-----------
 1 file changed, 76 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index d11e8cf12..52f6454fd 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -1,151 +1,95 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Yi Yang <yyangcdl@cn.ibm.com>
+ */
+
+/*\
+ * [Description]
  *
- *   Copyright (c) International Business Machines  Corp., 2006
+ * Check the basic functionality of the faccessat() system call.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * - faccessat() passes if dir_fd is file descriptor to the directory
+ *   where the file is located and pathname is relative path of the file.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * - faccessat() passes if dir_fd is a bad file descriptor and pathname is
+ *   absolute path of the file.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * NAME
- *      faccessat01.c
- *
- * DESCRIPTION
- *	This test case will verify basic function of faccessat
- *	added by kernel 2.6.16 or up.
- *
- * Author
- *	Yi Yang <yyangcdl@cn.ibm.com>
- *
- * History
- *      08/28/2006      Created first by Yi Yang <yyangcdl@cn.ibm.com>
- *
- *****************************************************************************/
-
-#define _GNU_SOURCE
+ * - faccessat() passes if dir_fd is AT_FDCWD and pathname is interpreted
+ *   relative to the current working directory of the calling process.
+ */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/syscalls.h"
-
-#define TEST_CASES 6
-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
-void setup();
-void cleanup();
-
-char *TCID = "faccessat01";
-int TST_TOTAL = TEST_CASES;
-static char pathname[256];
-static char testfile[256];
-static char testfile2[256];
-static char testfile3[256];
-static int fds[TEST_CASES];
-static char *filenames[TEST_CASES];
-static int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
-
-int myfaccessat(int dirfd, const char *filename, int mode)
-{
-	return tst_syscall(__NR_faccessat, dirfd, filename, mode);
-}
-
-int main(int ac, char **av)
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/faccessat.h"
+
+#define TESTDIR         "faccessatdir"
+#define TESTFILE        "faccessatfile"
+#define FILEPATH        "faccessatdir/faccessatfile"
+
+static int dir_fd, file_fd;
+static int atcwd_fd = AT_FDCWD;
+static char *filenames[4];
+static char abs_path[128];
+
+static struct tcase {
+	int *fd;
+	char **filename;
+	int exp_errno;
+} tcases[] = {
+	{&dir_fd, &filenames[0], 0},
+	{&dir_fd, &filenames[1], 0},
+	{&dir_fd, &filenames[0], 0},
+	{&atcwd_fd, &filenames[2], 0},
+};
+
+static void verify_faccessat(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	struct tcase *tc = &tcases[i];
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/*
-		 * Call faccessat
-		 */
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(myfaccessat(fds[i], filenames[i], R_OK));
-
-			/* check return code */
-			if (TEST_ERRNO == expected_errno[i]) {
-				tst_resm(TPASS,
-					 "faccessat() returned the expected  errno %d: %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL,
-					 "faccessdat() Failed, errno=%d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(faccessat(*tc->fd, *tc->filename, R_OK, 0),
+		     "faccessat(%d, %s, R_OK, 0)",
+		     *tc->fd, *tc->filename);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	char *abs_path = tst_get_tmpdir();
-	int p = getpid();
-
-	/* Initialize test dir and file names */
-	sprintf(pathname, "faccessattestdir%d", p);
-	sprintf(testfile, "faccessattestfile%d.txt", p);
-	sprintf(testfile2, "%s/faccessattestfile%d.txt", abs_path, p);
-	sprintf(testfile3, "faccessattestdir%d/faccessattestfile%d.txt", p, p);
+	char *tmpdir_path = tst_get_tmpdir();
 
-	free(abs_path);
+	sprintf(abs_path, "%s/%s", tmpdir_path, FILEPATH);
+	free(tmpdir_path);
 
-	SAFE_MKDIR(cleanup, pathname, 0700);
+	SAFE_MKDIR(TESTDIR, 0700);
+	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
+	file_fd = SAFE_OPEN(FILEPATH, O_CREAT | O_RDWR, 0600);
 
-	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
-	fds[1] = fds[4] = fds[0];
-
-	SAFE_FILE_PRINTF(cleanup, testfile, "%s", testfile);
-	SAFE_FILE_PRINTF(cleanup, testfile2, "%s", testfile2);
-
-	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
-
-	fds[3] = 100;
-	fds[5] = AT_FDCWD;
-
-	filenames[0] = filenames[2] = filenames[3] = filenames[4] = testfile;
-	filenames[1] = testfile2;
-	filenames[5] = testfile3;
-
-	TEST_PAUSE;
+	filenames[0] = TESTFILE;
+	filenames[1] = abs_path;
+	filenames[2] = FILEPATH;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (fds[0] > 0)
-		close(fds[0]);
-	if (fds[2] > 0)
-		close(fds[2]);
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
 
-	tst_rmdir();
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
 }
+
+static struct tst_test test = {
+	.test = verify_faccessat,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&filenames[0], .size = sizeof(*filenames[0])},
+		{&filenames[1], .size = sizeof(*filenames[1])},
+		{&filenames[2], .size = sizeof(*filenames[2])},
+		{},
+	},
+	.needs_tmpdir = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

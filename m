Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EA5CD494F
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 05:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0723D3CDE84
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 07:22:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEA943CA31F
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 07:22:40 +0200 (CEST)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE6E41000D45
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 07:22:39 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="132804751"
X-IronPort-AV: E=Sophos;i="6.03,164,1694703600"; d="scan'208";a="132804751"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 14:22:36 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 01DE9DA68D
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 14:22:34 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C331BF3CD
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 14:22:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 496748817B;
 Thu, 21 Sep 2023 14:22:32 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 21 Sep 2023 13:22:27 +0800
Message-Id: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27888.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27888.005
X-TMASE-Result: 10--11.221300-10.000000
X-TMASE-MatchedRID: oBjmd5ti2Ofyq/cli2hvDU7nLUqYrlslFIuBIWrdOePEosIs7IJbkFI3
 NifDbduL+FyTwBk2ojyri0Mekz/9si+3xqQ44pFWbTdhrAcm88IEa8g1x8eqFzb+WPFOeKNMysx
 /ZixtIIqTOkeik9B9Gh1NT+IwZHu0hVgj6N6wwHCVF2HD8EHNpwXR2ID7xaV6rrmlNXieXJTQsq
 gKndcUfvDkXmQzkSgGFR2nHgrUQCM3KXWd30Ii3RRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7sXiF
 LBDiKfHQk8YksAbp1hHndL5ppj0Q2OqUloHFKahNkUSDDq742k=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/fchmodat01: Convert to new API
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
 .../kernel/syscalls/fchmodat/fchmodat01.c     | 103 +++++++-----------
 1 file changed, 42 insertions(+), 61 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 3deff0ebe..d9db4ec10 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -1,99 +1,75 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2006
- *
+ * Copyright (c) Linux Test Project, 2003-2023
  * 08/28/2006 AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
  */
 
 /*\
  * [Description]
  *
- * This test case will verify basic function of fchmodat.
+ * Check the basic functionality of the faccessat() system call.
+ *
+ * - fchmodat() passes if dir_fd is file descriptor to the directory
+ *   where the file is located and pathname is relative path of the file.
+ *
+ * - fchmodat() passes if dir_fd is a bad file descriptor and pathname is
+ *   absolute path of the file.
+ *
+ * - fchmodat() passes if dir_fd is AT_FDCWD and pathname is interpreted
+ *   relative to the current working directory of the calling process.
  */
 
-#define _GNU_SOURCE
-
-#include <unistd.h>
-#include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 
-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
+#define TESTDIR         "fchmodatdir"
+#define TESTFILE        "fchmodatfile"
+#define FILEPATH        "fchmodatdir/fchmodatfile"
 
-static char pathname[256];
-static char testfile[256];
-static char testfile2[256];
-static char testfile3[256];
+static int dir_fd, file_fd;
+static int atcwd_fd = AT_FDCWD;
+static char *abs_path;
+static char *test_file;
+static char *file_path;
 
 static struct tcase {
-	int exp_errno;
-	char *exp_errval;
+	int *fd;
+	char **filenames;
 } tcases[] = {
-	{ 0, NULL},
-	{ 0, NULL},
-	{ ENOTDIR, "ENOTDIR"},
-	{ EBADF, "EBADF"},
-	{ 0, NULL},
-	{ 0, NULL},
+	{&dir_fd, &test_file},
+	{&dir_fd, &abs_path},
+	{&atcwd_fd, &file_path},
 };
-static int fds[ARRAY_SIZE(tcases)];
-static char *filenames[ARRAY_SIZE(tcases)];
 
 static void verify_fchmodat(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	if (tc->exp_errno == 0)
-		TST_EXP_PASS(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
-			     "fchmodat() returned the expected errno %d: %s",
-			     TST_ERR, strerror(TST_ERR));
-	else
-		TST_EXP_FAIL(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
-			     tc->exp_errno,
-			     "fchmodat() returned the expected errno %d: %s",
-			     TST_ERR, strerror(TST_ERR));
+	TST_EXP_PASS(fchmodat(*tc->fd, *tc->filenames, 0600, 0),
+		     "fchmodat(%d, %s, 0600, 0)",
+		     *tc->fd, *tc->filenames);
 }
 
 static void setup(void)
 {
-	/* Initialize test dir and file names */
-	char *abs_path = tst_get_tmpdir();
-	int p = getpid();
-
-	sprintf(pathname, "fchmodattestdir%d", p);
-	sprintf(testfile, "fchmodattest%d.txt", p);
-	sprintf(testfile2, "%s/fchmodattest%d.txt", abs_path, p);
-	sprintf(testfile3, "fchmodattestdir%d/fchmodattest%d.txt", p, p);
-
-	free(abs_path);
-
-	SAFE_MKDIR(pathname, 0700);
-
-	fds[0] = SAFE_OPEN(pathname, O_DIRECTORY);
-	fds[1] = fds[4] = fds[0];
-
-	SAFE_FILE_PRINTF(testfile, "%s", testfile);
-	SAFE_FILE_PRINTF(testfile2, "%s", testfile2);
+	char *tmpdir_path = tst_get_tmpdir();
 
-	fds[2] = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
-	fds[3] = 100;
-	fds[5] = AT_FDCWD;
+	abs_path = tst_aprintf("%s/%s", tmpdir_path, FILEPATH);
+	free(tmpdir_path);
 
-	filenames[0] = filenames[2] = filenames[3] = filenames[4] = testfile;
-	filenames[1] = testfile2;
-	filenames[5] = testfile3;
+	SAFE_MKDIR(TESTDIR, 0700);
+	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
+	file_fd = SAFE_OPEN(FILEPATH, O_CREAT | O_RDWR, 0600);
 }
 
 static void cleanup(void)
 {
-	if (fds[0] > 0)
-		close(fds[0]);
-	if (fds[2] > 0)
-		close(fds[2]);
+	if (dir_fd > -1)
+		close(dir_fd);
+	if (file_fd > -1)
+		close(file_fd);
 }
 
 static struct tst_test test = {
@@ -101,5 +77,10 @@ static struct tst_test test = {
 	.test = verify_fchmodat,
 	.setup = setup,
 	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&test_file, .str = TESTFILE},
+		{&file_path, .str = FILEPATH},
+		{},
+	},
 	.needs_tmpdir = 1,
 };
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048E2CDB482
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 02:56:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7164B3CEF3C
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 04:56:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1673F3CEF1B
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:56:13 +0200 (CEST)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 16E6D140118C
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:56:12 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="115537031"
X-IronPort-AV: E=Sophos;i="6.03,236,1694703600"; d="scan'208";a="115537031"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 11:56:09 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B0AE9D29EA
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:56:07 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D832BD88C8
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:56:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 70B0C6BA79
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:56:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 289371A0071;
 Thu, 19 Oct 2023 10:56:06 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 19 Oct 2023 10:55:51 +0800
Message-Id: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27944.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27944.004
X-TMASE-Result: 10--13.721300-10.000000
X-TMASE-MatchedRID: msu67+ufaNDyq/cli2hvDU7nLUqYrlslFIuBIWrdOePEosIs7IJbkFI3
 NifDbduL+FyTwBk2ojyri0Mekz/9si+3xqQ44pFWbTdhrAcm88IEa8g1x8eqFzb+WPFOeKNMysx
 /ZixtIIqTOkeik9B9Gh1NT+IwZHu0hVgj6N6wwHCVF2HD8EHNp5ki3iIBA3o/WOMZWlSRoSHmwv
 piATxAX3MoTQp2046LUJMaQQ/7IyRsGCemus4bpp4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
 q42LRYkvs7KvPwE35LkHBE+uLdIL9nPgjMhCqCJ5bOGIm5wnk5+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/fchmodat01: Convert to new API
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
 .../kernel/syscalls/fchmodat/fchmodat01.c     | 108 ++++++++----------
 1 file changed, 48 insertions(+), 60 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 3deff0ebe..004fea59a 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -1,99 +1,82 @@
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
+ * Check the basic functionality of the fchmodat() system call.
+ *
+ * - fchmodat() passes if dir_fd is file descriptor to the directory
+ *   where the file is located and pathname is relative path of the file.
+ * - fchmodat() passes if pathname is absolute, then dirfd is ignored.
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
+	char **full_path;
 } tcases[] = {
-	{ 0, NULL},
-	{ 0, NULL},
-	{ ENOTDIR, "ENOTDIR"},
-	{ EBADF, "EBADF"},
-	{ 0, NULL},
-	{ 0, NULL},
+	{&dir_fd, &test_file, &file_path},
+	{&file_fd, &abs_path, &abs_path},
+	{&atcwd_fd, &file_path, &file_path},
 };
-static int fds[ARRAY_SIZE(tcases)];
-static char *filenames[ARRAY_SIZE(tcases)];
 
 static void verify_fchmodat(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
+	struct stat st;
 
-	if (tc->exp_errno == 0)
-		TST_EXP_PASS(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
-			     "fchmodat() returned the expected errno %d: %s",
-			     TST_ERR, strerror(TST_ERR));
+	TST_EXP_PASS(fchmodat(*tc->fd, *tc->filenames, 0600, 0),
+		     "fchmodat(%d, %s, 0600, 0)",
+		     *tc->fd, *tc->filenames);
+
+	SAFE_LSTAT(*tc->full_path, &st);
+
+	if ((st.st_mode & ~S_IFREG) == 0600)
+		tst_res(TPASS, "File permission changed correctly");
 	else
-		TST_EXP_FAIL(tst_syscall(__NR_fchmodat, fds[i], filenames[i], 0600),
-			     tc->exp_errno,
-			     "fchmodat() returned the expected errno %d: %s",
-			     TST_ERR, strerror(TST_ERR));
+		tst_res(TFAIL, "File permission not changed correctly");
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
+	char *tmpdir_path = tst_get_tmpdir();
 
-	free(abs_path);
+	abs_path = tst_aprintf("%s/%s", tmpdir_path, FILEPATH);
+	free(tmpdir_path);
 
-	SAFE_MKDIR(pathname, 0700);
-
-	fds[0] = SAFE_OPEN(pathname, O_DIRECTORY);
-	fds[1] = fds[4] = fds[0];
-
-	SAFE_FILE_PRINTF(testfile, "%s", testfile);
-	SAFE_FILE_PRINTF(testfile2, "%s", testfile2);
-
-	fds[2] = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
-	fds[3] = 100;
-	fds[5] = AT_FDCWD;
-
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
+		SAFE_CLOSE(dir_fd);
+
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
 }
 
 static struct tst_test test = {
@@ -101,5 +84,10 @@ static struct tst_test test = {
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

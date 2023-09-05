Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7D1C83F3E
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 07:30:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B52B33CEB4E
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 09:30:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6785E3CB794
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 09:30:32 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D2A9600ACF
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 09:30:30 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="110251048"
X-IronPort-AV: E=Sophos;i="6.02,228,1688396400"; d="scan'208";a="110251048"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2023 16:30:28 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0821ECA1E6
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 16:30:27 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 276C9D4BCF
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 16:30:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C9388830C;
 Tue,  5 Sep 2023 16:30:25 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 15:30:03 +0800
Message-Id: <1693899003-2248-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27856.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27856.005
X-TMASE-Result: 10--11.003100-10.000000
X-TMASE-MatchedRID: mLEC5fZiOdDyq/cli2hvDU7nLUqYrlslFIuBIWrdOePEosIs7IJbkFI3
 NifDbduL+FyTwBk2ojyri0Mekz/9smOSupRYVKrIypiC33/79mcL//VMxXlyE97p0Ru8jKvF/9T
 DS4zEk/zv3R81Uj/6vMjhLggtE8XmxB13Y/+OC6ap3Btb1bH20PlSepWcgdLPZ7MN8KplzpzZ6K
 rkcB2NwYtUMxfMQaZF69uDFvmoY4f+0jQufZU6FKUl1aQUvopWjlRp8uau9oYW6DSK3JHrYpbjt
 ojIJiNqXoyZmORsN2VXNicS/yg1bRHdGMlurS25hdD+G7U5X/QaJDwYgQY/fxG3US/I5cDR8mBH
 5i5c0qz5DhMAITBjS1CTGkEP+yMkbBgnprrOG6aeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+ICq
 uNi0WJPYBGisriQ2KFxX+C0Wvse/BOu0S30k/BNPvCbE3TVQ9ftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/readlinkat01: Convert to new API
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
 .../kernel/syscalls/readlinkat/readlinkat01.c | 181 +++++++-----------
 1 file changed, 70 insertions(+), 111 deletions(-)

diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index 985890ebe..c82dff7f3 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -1,143 +1,102 @@
-/******************************************************************************
- *
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
  * Copyright (c) International Business Machines  Corp., 2006
- *  Author: Yi Yang <yyangcdl@cn.ibm.com>
  * Copyright (c) Cyril Hrubis 2014 <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Yi Yang <yyangcdl@cn.ibm.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * This test case will verify basic function of readlinkat
- * added by kernel 2.6.16 or up.
+ * Check the basic functionality of the readlinkat() system call.
  *
- *****************************************************************************/
+ * - readlinkat() passes if dirfd is directory file descriptor
+ *   and the pathname is relative.
+ * - readlinkat() passes if the pathname is abspath, then dirfd
+ *   is ignored.
+ * - readlinkat() passes if dirfd is the special value AT_FDCWD
+ *   and the pathname is relative.
+ * - readlinkat() passes if pathname is an empty string, in which
+ *   case the call operates on the symbolic link referred to by dirfd.
+ */
 
-#define _GNU_SOURCE
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <fcntl.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/readlinkat.h"
-
-static void setup(void);
-static void cleanup(void);
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
 
-char *TCID = "readlinkat01";
+#define TEST_FILE       "readlink_file"
+#define TEST_SYMLINK    "readlink_symlink"
 
-static int dir_fd, fd;
-static int fd_invalid = 100;
+static int file_fd, dir_fd, dir_fd2;
 static int fd_atcwd = AT_FDCWD;
-
-#define TEST_SYMLINK "readlink_symlink"
-#define TEST_FILE "readlink_file"
-
-static char abspath[1024];
-
-static struct test_case {
-	int *dir_fd;
-	const char *path;
-	const char *exp_buf;
-	int exp_ret;
-	int exp_errno;
-} test_cases[] = {
-	{&dir_fd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
-	{&dir_fd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
-	{&fd, TEST_SYMLINK, NULL, -1, ENOTDIR},
-	{&fd_invalid, TEST_SYMLINK, NULL, -1, EBADF},
-	{&fd_atcwd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
+static const char *abspath;
+static const char *testsymlink;
+static const char *emptypath = "";
+
+static struct tcase {
+	int *fd;
+	const char **path;
+} tcases[] = {
+	{&dir_fd, &testsymlink},
+	{&dir_fd, &abspath},
+	{&file_fd, &abspath},
+	{&fd_atcwd, &abspath},
+	{&fd_atcwd, &testsymlink},
+	{&dir_fd2, &emptypath},
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void verify_readlinkat(struct test_case *test)
+static void verify_readlinkat(unsigned int i)
 {
 	char buf[1024];
+	struct tcase *tc = &tcases[i];
 
 	memset(buf, 0, sizeof(buf));
 
-	TEST(readlinkat(*test->dir_fd, test->path, buf, sizeof(buf)));
-
-	if (TEST_RETURN != test->exp_ret) {
-		tst_resm(TFAIL | TTERRNO,
-		         "readlinkat() returned %ld, expected %d",
-		         TEST_RETURN, test->exp_ret);
-		return;
-	}
-
-	if (TEST_ERRNO != test->exp_errno) {
-		tst_resm(TFAIL | TTERRNO,
-		         "readlinkat() returned %ld, expected %d",
-		         TEST_RETURN, test->exp_ret);
-		return;
-	}
-
-	if (test->exp_ret > 0 && strcmp(test->exp_buf, buf)) {
-		tst_resm(TFAIL, "Unexpected buffer have '%s', expected '%s'",
-		         buf, test->exp_buf);
-		return;
-	}
-
-	tst_resm(TPASS | TTERRNO, "readlinkat() returned %ld", TEST_RETURN);
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	TST_EXP_POSITIVE(readlinkat(*tc->fd, *tc->path, buf, sizeof(buf)),
+		     "readlinkat(%d, %s, %s, %ld)",
+		     *tc->fd, *tc->path, buf, sizeof(buf));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_readlinkat(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
+	if (strcmp(buf, TEST_FILE) == 0)
+		tst_res(TPASS, "The filename in buffer is correct");
+	else
+		tst_res(TFAIL, "Wrong filename in buffer '%s'", buf);
 }
 
 static void setup(void)
 {
-	tst_tmpdir();
 	char *tmpdir = tst_get_tmpdir();
 
-	snprintf(abspath, sizeof(abspath), "%s/" TEST_SYMLINK, tmpdir);
+	abspath = tst_aprintf("%s/" TEST_SYMLINK, tmpdir);
 	free(tmpdir);
 
-	fd = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT, 0600);
-	SAFE_SYMLINK(cleanup, TEST_FILE, TEST_SYMLINK);
-	dir_fd = SAFE_OPEN(cleanup, ".", O_DIRECTORY);
-
-	TEST_PAUSE;
+	file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
+	SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
+	dir_fd = SAFE_OPEN(".", O_DIRECTORY);
+	dir_fd2 = SAFE_OPEN(TEST_SYMLINK, O_PATH | O_NOFOLLOW);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "Failed to close fd");
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
 
-	if (dir_fd > 0 && close(dir_fd))
-		tst_resm(TWARN | TERRNO, "Failed to close dir_fd");
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
 
-	tst_rmdir();
+	if (dir_fd2 > -1)
+		SAFE_CLOSE(dir_fd2);
 }
+
+static struct tst_test test = {
+	.test = verify_readlinkat,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&testsymlink, .str = TEST_SYMLINK},
+		{},
+	},
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

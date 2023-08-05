Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B7FC001DB
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 04:09:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C5183CE377
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 06:09:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 851B43CE37B
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:29 +0200 (CEST)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ACA8820097D
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:28 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="126616720"
X-IronPort-AV: E=Sophos;i="6.01,256,1684767600"; d="scan'208";a="126616720"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2023 13:08:26 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 684C8D29E1
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:24 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 91B61D9467
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id B5E28878F1;
 Sat,  5 Aug 2023 13:08:22 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat,  5 Aug 2023 12:08:01 +0800
Message-Id: <1691208482-5464-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27794.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27794.003
X-TMASE-Result: 10--8.593100-10.000000
X-TMASE-MatchedRID: l/ZqERfMFvfyq/cli2hvDU7nLUqYrlslFIuBIWrdOePEosIs7IJbkFI3
 NifDbduL+FyTwBk2ojyri0Mekz/9smOSupRYVKrIypiC33/79mcL//VMxXlyE97p0Ru8jKvFtge
 qIbcGUmjbn8uPtIBRS8S0L3nbRahdCaYeD4qDm9XkKCFOKwAEzNmhsJODizUsvnhgJqkfm0B9Jp
 pVNkb1KyolWOAMg2fcxSdrm2HKzRjOLLwxlMO5PUrOO5m0+0gEMi5cVoUvU/ae38zXnNg9Q2RxN
 dQB9xCvbh0Sdbm7p1Pij2crwUJUxf69iusHSJvfdXu122+iJtr+8VJw3WmYLJwsUqEjZnPrhB23
 GqvpPlH93kA1ImA+YB0XwFnoQFewHxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwfNYXO9GkFlIgjnY
 Sy8ny0NXKi5lgAQ1YUtSDlmgmyu45dsuF2FPBIg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/readlinkat01: Convert to new API
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
 .../kernel/syscalls/readlinkat/readlinkat01.c | 152 ++++++------------
 1 file changed, 53 insertions(+), 99 deletions(-)

diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index 985890ebe..965afbd5d 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -1,143 +1,97 @@
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
+ * Check the basic functionality of the readlinkat() system call.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * - faccessat() passes if dir_fd is file descriptor to the directory and
+ *   pathname is interpreted to the symbolic link file.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * - faccessat() passes if dir_fd is file descriptor to the directory and
+ *   pathname is absolute path of the file.
  *
- * This test case will verify basic function of readlinkat
- * added by kernel 2.6.16 or up.
+ * - faccessat() passes if dir_fd is file descriptor to the file and
+ *   pathname is absolute path of the file.
  *
- *****************************************************************************/
-
-#define _GNU_SOURCE
+ * - faccessat() passes if dir_fd is AT_FDCWD and pathname is interpreted
+ *   relative to the symbolic link file.
+ *
+ * - faccessat() passes if dir_fd is AT_FDCWD and pathname is absolute
+ *   path of the file.
+ */
 
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
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
 #include "lapi/readlinkat.h"
+#include "lapi/syscalls.h"
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "readlinkat01";
+#define TEST_FILE	"readlink_file"
+#define TEST_SYMLINK	"readlink_symlink"
 
-static int dir_fd, fd;
-static int fd_invalid = 100;
+static int file_fd, dir_fd;
 static int fd_atcwd = AT_FDCWD;
-
-#define TEST_SYMLINK "readlink_symlink"
-#define TEST_FILE "readlink_file"
-
 static char abspath[1024];
 
-static struct test_case {
-	int *dir_fd;
+static struct tcase {
+	int *fd;
 	const char *path;
 	const char *exp_buf;
 	int exp_ret;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{&dir_fd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
 	{&dir_fd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
-	{&fd, TEST_SYMLINK, NULL, -1, ENOTDIR},
-	{&fd_invalid, TEST_SYMLINK, NULL, -1, EBADF},
+	{&file_fd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
 	{&fd_atcwd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
+	{&fd_atcwd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
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
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_readlinkat(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_POSITIVE(readlinkat(*tc->fd, tc->path, buf, sizeof(buf)),
+		     "readlinkat(%d, %s, %s, %ld)",
+		     *tc->fd, tc->path, buf, sizeof(buf));
 }
 
 static void setup(void)
 {
-	tst_tmpdir();
 	char *tmpdir = tst_get_tmpdir();
 
 	snprintf(abspath, sizeof(abspath), "%s/" TEST_SYMLINK, tmpdir);
 	free(tmpdir);
 
-	fd = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT, 0600);
-	SAFE_SYMLINK(cleanup, TEST_FILE, TEST_SYMLINK);
-	dir_fd = SAFE_OPEN(cleanup, ".", O_DIRECTORY);
-
-	TEST_PAUSE;
+	file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
+	SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
+	dir_fd = SAFE_OPEN(".", O_DIRECTORY);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "Failed to close fd");
-
-	if (dir_fd > 0 && close(dir_fd))
-		tst_resm(TWARN | TERRNO, "Failed to close dir_fd");
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
 
-	tst_rmdir();
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
 }
+
+static struct tst_test test = {
+	.test = verify_readlinkat,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

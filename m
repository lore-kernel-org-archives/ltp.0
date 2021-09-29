Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0EC433F5
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:33:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECA3613CD
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0ECA3613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77CC23C6F36
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 10:33:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C70323C6E52
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:33:44 +0200 (CEST)
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0408514012B6
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:33:42 +0200 (CEST)
X-QQ-mid: bizesmtp43t1632904394t48apgaj
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 29 Sep 2021 16:33:06 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00A0000000
X-QQ-FEAT: ssdqv2V8ieJEUABq7p1CvBdHJR3DdjRzqhNbP98D2tT6THR0ZOYxM8AIjOGZj
 +ah1jg/Qyki5qbpdQcMTDGhDSgoRx3z7pyuLBeHuKSPTDpKho3S6xg6sp6nhJ+/ql7iJGm7
 OMT9nFOXAg56kpdo6AIomcba/JdRpP/zxdAsQFkwaNqxSTIwJUipZYbCB3QQ/HteZBk/7E+
 fK+r9ZGLewjXHaoK4x7IScy7YIsAjQbbcGodjJdOaJbRSxFtdWE/httNkUnZ4QkAzrEv2rU
 oEyrjjwF8wUFrkg6wYG/PeSQvkPe8+ljP9a4EHv/XiNrLafETDUjj3/ys16CGhjCaZZGk+m
 R+LkwoGNEhQfS6r4Y8M/LCLTbJfKY+3D/Q4Eifs
X-QQ-GoodBg: 2
From: zhanglianjie <zhanglianjie@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 29 Sep 2021 16:32:49 +0800
Message-Id: <20210929083249.22320-2-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929083249.22320-1-zhanglianjie@uniontech.com>
References: <20210929083249.22320-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/readdir21: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/readdir/readdir21.c b/testcases/kernel/syscalls/readdir/readdir21.c
index 205e0715b..1bc3cc199 100644
--- a/testcases/kernel/syscalls/readdir/readdir21.c
+++ b/testcases/kernel/syscalls/readdir/readdir21.c
@@ -1,20 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
-/*
+
+/*\
+ * [Description]
+ *
  * Test Description:
  *  Verify that,
  *   1. Creat a directory and open it, then delete the directory, ENOENT would
@@ -23,28 +15,16 @@
  *   3. Invalid file descriptor fd, EBADF would return.
  *   4. Argument points outside the calling process's address space, EFAULT
  *	would return.
- *
- *  PS:
- *   This file is for readdir(2) and the other files(readdir01.c and
- *   readdir02.c) are for readdir(3).
  */

-#define _GNU_SOURCE
+//#define _GNU_SOURCE

 #include <stdio.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "lapi/readdir.h"

-char *TCID = "readdir21";
-
 #define TEST_DIR	"test_dir"
 #define TEST_DIR4	"test_dir4"
 #define TEST_FILE	"test_file"
@@ -55,96 +35,46 @@ static unsigned int del_dir_fd, file_fd;
 static unsigned int invalid_fd = 999;
 static unsigned int dir_fd;
 static struct old_linux_dirent dirp;
-static void setup(void);
-static void cleanup(void);

-static struct test_case_t {
+static struct tcase {
 	unsigned int *fd;
 	struct old_linux_dirent *dirp;
 	unsigned int count;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT},
 	{&file_fd, &dirp, sizeof(struct old_linux_dirent), ENOTDIR},
 	{&invalid_fd, &dirp, sizeof(struct old_linux_dirent), EBADF},
-#if !defined(UCLINUX)
 	{&dir_fd, (struct old_linux_dirent *)-1,
 	 sizeof(struct old_linux_dirent), EFAULT},
-#endif
 };

-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void readdir_verify(const struct test_case_t *);
-
-int main(int argc, char **argv)
-{
-	int i, lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			readdir_verify(&test_cases[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	SAFE_MKDIR(TEST_DIR, DIR_MODE);
+	del_dir_fd = SAFE_OPEN(TEST_DIR, O_RDONLY | O_DIRECTORY);
+	SAFE_RMDIR(TEST_DIR);

-	tst_tmpdir();
+	file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);

-	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
-	del_dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_RDONLY | O_DIRECTORY);
-	SAFE_RMDIR(cleanup, TEST_DIR);
+	SAFE_MKDIR(TEST_DIR4, DIR_MODE);
+	dir_fd = SAFE_OPEN(TEST_DIR4, O_RDONLY | O_DIRECTORY);

-	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0777);
-
-	SAFE_MKDIR(cleanup, TEST_DIR4, DIR_MODE);
-	dir_fd = SAFE_OPEN(cleanup, TEST_DIR4, O_RDONLY | O_DIRECTORY);
-
-#if !defined(UCLINUX)
-	test_cases[3].dirp = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
-				       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-#endif
+	tcases[3].dirp = tst_get_bad_addr(NULL);
 }

-static void readdir_verify(const struct test_case_t *test)
+static void verify_readdir(unsigned int nr)
 {
-	TEST(ltp_syscall(__NR_readdir, *test->fd, test->dirp, test->count));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "readdir() succeeded unexpectedly");
-		return;
-	}
+	struct tcase *tc = &tcases[nr];

-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "readdir() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "readdir() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	TST_EXP_FAIL(tst_syscall(__NR_readdir, *tc->fd, tc->dirp, tc->count),
+			tc->exp_errno, "readdir() failed unexpectedly, expected: %d - %s",
+			tc->exp_errno, strerror(tc->exp_errno));
 }

-static void cleanup(void)
-{
-	if (dir_fd > 0)
-		close(dir_fd);
-
-	if (del_dir_fd > 0)
-		close(del_dir_fd);
-
-	if (file_fd > 0)
-		close(file_fd);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = verify_readdir,
+	.needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

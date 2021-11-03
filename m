Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B5C433EF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 23:26:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B009608FB
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 23:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B009608FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FE653C72BC
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 00:26:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 049313C552C
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 00:26:23 +0100 (CET)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 582CB1000231
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 00:26:15 +0100 (CET)
X-QQ-mid: bizesmtp44t1635981971ts9bq924
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 04 Nov 2021 07:26:05 +0800 (CST)
X-QQ-SSF: 0140000000000040C000B00A0000000
X-QQ-FEAT: PdU/eI8FBMC+SAa578HIc1QmgmGN/lebtt1QzaYbyowOFRiqp2L0XOgn/OSGI
 zb20z/y024UNJyJjKUy1BP4XW8dvDNaon+uGLZVPRNS/2Bp0dphxwnfDPQzhef+sw0y4KWX
 eGhC1RtIVIsSwO+Brpvkb3b2DzWFWhA469VqCIKIn9RtVwIdH4v5uCDPfP9V45Z1X8BsOa2
 bg+aDZ3jXg1eRSIxNpUsDSqx139FNFnaCqNjHosLjhsMSREHFx4KJ9YY8VMFcGf9ng8wyV3
 xTPelhQcCooOimrYFOuqFYPrIlh7STNBa/mFdBom+8yvjo8a91LJnX+omamSsxZ5sc6G76c
 eGkeYZZpP6CfnASxxnGO274/n7z9w==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Thu,  4 Nov 2021 07:26:03 +0800
Message-Id: <20211103232604.7930-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] syscalls/link: Convert to new API and merge
 link06 and link07 into link04
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
 runtest/syscalls                        |   2 -
 testcases/kernel/syscalls/link/link04.c | 208 +++++++++++-------------
 testcases/kernel/syscalls/link/link06.c | 113 -------------
 testcases/kernel/syscalls/link/link07.c | 118 --------------
 4 files changed, 93 insertions(+), 348 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/link/link06.c
 delete mode 100644 testcases/kernel/syscalls/link/link07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b19316805..1e6d46744 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -673,8 +673,6 @@ link02 link02
 link03 link03
 link04 link04
 link05 link05
-link06 link06
-link07 link07
 link08 link08

 #linkat test cases
diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/syscalls/link/link04.c
index d9408845e..9a1c32859 100644
--- a/testcases/kernel/syscalls/link/link04.c
+++ b/testcases/kernel/syscalls/link/link04.c
@@ -1,65 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *  AUTHOR		: Richard Logan
  *  CO-PILOT		: William Roske
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */

-/*
+/*\
+ * [Description]
+ *
  * Negative test cases for link(2).
  *
  * This test program should contain test cases where link will fail regardless
  * of who executed it (i.e. joe-user or root)
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
+#include <pwd.h>
 #include <sys/param.h>
 #include <sys/mman.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+
+#define NOBODY_USER     99
+#define MODE_TO1 S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IXOTH|S_IROTH
+#define MODE_TO2 S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IXOTH|S_IROTH|S_IWOTH
+#define MODE_TE S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH
+#define MODE_RWX        S_IRWXU | S_IRWXG | S_IRWXO
+#define DIR_TEMP        "dir2/testdir_1"

 static char longpath[PATH_MAX + 2];

-struct test_case_t {
+static struct tcase {
 	char *file1;
 	char *desc1;
 	char *file2;
 	char *desc2;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	/* first path is invalid */
 	{"nonexistfile", "non-existent file", "nefile", "nefile", ENOENT},
 	{"", "path is empty string", "nefile", "nefile", ENOENT},
@@ -79,92 +54,95 @@ struct test_case_t {
 	{"regfile", "regfile", NULL, "invalid address", EFAULT},
 	/* two existing files */
 	{"regfile", "regfile", "regfile2", "regfile2", EEXIST},
+	{"dir1/oldpath", "Write access diretory", "dir1/newpath", "newpath", EACCES},
+	{"dir2/testdir_1/tfile_2", "Search access diretory", "dir2/testdir_1/new_tfile_2",
+	"dir2/testdir_1/new_tfile_2", EACCES},
 };

-char *TCID = "link04";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_link(unsigned int i)
 {
-	int lc;
-	char *fname1, *fname2;
-	char *desc1, *desc2;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			fname1 = test_cases[i].file1;
-			desc1 = test_cases[i].desc1;
-			fname2 = test_cases[i].file2;
-			desc2 = test_cases[i].desc2;
-
-			TEST(link(fname1, fname2));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == test_cases[i].exp_errno) {
-					tst_resm(TPASS | TTERRNO,
-						 "link(<%s>, <%s>)",
-						 desc1, desc2);
-				} else {
-					tst_resm(TFAIL | TTERRNO,
-						 "link(<%s>, <%s>) Failed "
-					         "expected errno: %d",
-						 desc1, desc2,
-						 test_cases[i].exp_errno);
-				}
-			} else {
-				tst_resm(TFAIL,
-					 "link(<%s>, <%s>) returned %ld, "
-				         "expected -1, errno:%d",
-					 desc1, desc2, TEST_RETURN,
-					 test_cases[i].exp_errno);
-			}
+	struct tcase *tc = &tcases[i];
+
+	TEST(link(tc->file1, tc->file2));
+
+	if (TST_RET == -1) {
+		if (TST_ERR == tc->exp_errno) {
+			tst_res(TPASS | TTERRNO,
+			"link(<%s>, <%s>)",
+			tc->desc1, tc->desc2);
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			"link(<%s>, <%s>) Failed "
+			"expected errno: %d",
+			tc->desc1, tc->desc2,
+			tc->exp_errno);
 		}
-
+	} else {
+		tst_res(TFAIL,
+			 "link(<%s>, <%s>) returned %ld, "
+			"expected -1, errno:%d",
+			tc->desc1, tc->desc2, TST_RET,
+			tc->exp_errno);
 	}
-
-	cleanup();
-	tst_exit();
 }

 static void setup(void)
 {
-	int n;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	memset(longpath, 'a', PATH_MAX+1);
-	SAFE_TOUCH(cleanup, "regfile", 0777, NULL);
-	SAFE_TOUCH(cleanup, "regfile2", 0777, NULL);
-	SAFE_MKDIR(cleanup, "dir", 0777);
-
-	void *bad_addr = tst_get_bad_addr(cleanup);

-	for (n = 0; n < TST_TOTAL; n++) {
-		if (!test_cases[n].file1)
-			test_cases[n].file1 = bad_addr;
-
-		if (!test_cases[n].file2)
-			test_cases[n].file2 = bad_addr;
+	SAFE_TOUCH("regfile", 0777, NULL);
+	SAFE_TOUCH("regfile2", 0777, NULL);
+	SAFE_MKDIR("dir", 0777);
+
+	unsigned int i;
+	struct passwd *nobody_pwd;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		struct tcase *tc = &tcases[i];
+
+		switch (tc->exp_errno) {
+		case EACCES:
+			if (tc->desc1 == "Write access diretory") {
+				SAFE_SETEUID(0);
+				SAFE_MKDIR("dir1", MODE_RWX);
+				/* Modify mode permissions on test directory */
+				SAFE_CHMOD("dir1", MODE_TO1);
+				SAFE_TOUCH(tc->file1, 0777, NULL);
+				nobody_pwd = SAFE_GETPWNAM("nobody");
+				SAFE_SETEUID(nobody_pwd->pw_uid);
+			} else if (tc->desc1 == "Search access diretory") {
+				SAFE_SETEUID(0);
+				SAFE_MKDIR("dir2", MODE_RWX);
+				/* Modify mode permissions on test directory */
+				SAFE_CHMOD("dir2", MODE_TO2);
+				SAFE_MKDIR(DIR_TEMP, MODE_RWX);
+				SAFE_TOUCH(tc->file1, 0666, NULL);
+
+				/* Modify mode permissions on test directory - test conditions */
+				SAFE_CHMOD(DIR_TEMP, MODE_TE);
+				nobody_pwd = SAFE_GETPWNAM("nobody");
+				SAFE_SETEUID(nobody_pwd->pw_uid);
+			}
+			break;
+		case ENOENT:
+		case ENOTDIR:
+		case ENAMETOOLONG:
+		case EFAULT:
+		case EEXIST:
+			if (!tc->file1)
+				tc->file1 = tst_get_bad_addr(NULL);
+
+			if (!tc->file2)
+				tc->file2 = tst_get_bad_addr(NULL);
+			break;
+		}
 	}
 }

-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_link,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/link/link06.c b/testcases/kernel/syscalls/link/link06.c
deleted file mode 100644
index 17b38ad43..000000000
--- a/testcases/kernel/syscalls/link/link06.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Copyright (C) Bull S.A. 2001
- * Copyright (c) International Business Machines  Corp., 2001
- * 06/2002 Ported by Jacky Malcles
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
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
- */
-
-/*
- * Verify that, link() fails with -1 and sets errno to EACCES when Write access
- * to the directory containing newpath is not allowed for the process's
- * effective uid.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define NOBODY_USER	99
-#define MODE_TO S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IXOTH|S_IROTH
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "link06";
-int TST_TOTAL = 1;
-
-#define OLDPATH "oldpath"
-#define NEWPATH "newpath"
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(link(OLDPATH, NEWPATH));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "link() returned %ld, "
-				 "expected -1, errno=%d", TEST_RETURN,
-				 EACCES);
-		} else {
-			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS, "link() fails with expected "
-					 "error EACCES errno:%d", TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "link() fails with "
-					 "errno=%d, expected errno=%d",
-					 TEST_ERRNO, EACCES);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	struct passwd *nobody_pwd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Modify mode permissions on test directory */
-	SAFE_CHMOD(cleanup, ".", MODE_TO);
-
-	SAFE_TOUCH(cleanup, OLDPATH, 0777, NULL);
-	nobody_pwd = SAFE_GETPWNAM(cleanup, "nobody");
-	SAFE_SETEUID(cleanup, nobody_pwd->pw_uid);
-}
-
-static void cleanup(void)
-{
-	if (seteuid(0))
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
-
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/link/link07.c b/testcases/kernel/syscalls/link/link07.c
deleted file mode 100644
index 09743b59c..000000000
--- a/testcases/kernel/syscalls/link/link07.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Copyright (C) Bull S.A. 2001
- * Copyright (c) International Business Machines  Corp., 2001
- *  06/2002 Ported by Jacky Malcles
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
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
- */
-
-/*
- * Verify that, link() fails with -1 and sets errno to EACCES when one of the
- * directories in oldpath or newpath did not allow search (execute) permission.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-#define MODE_TO S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IXOTH|S_IROTH|S_IWOTH
-#define MODE_TE S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH
-#define MODE_RWX        S_IRWXU | S_IRWXG | S_IRWXO
-#define DIR_TEMP        "testdir_1"
-#define TEST_FILE2      "testdir_1/tfile_2"
-#define NEW_TEST_FILE2  "testdir_1/new_tfile_2"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "link07";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(link(TEST_FILE2, NEW_TEST_FILE2));
-
-		/* Check return code from link(2) */
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL | TTERRNO, "link() returned %ld, "
-				 "expected -1, errno=%d", TEST_RETURN, EACCES);
-		} else {
-			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS | TTERRNO,
-				         "link() fails with expected error");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "link() failed"
-				         ", expected errno=%d (EACCES)",
-				         EACCES);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	struct passwd *nobody_pwd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Modify mode permissions on test directory */
-	SAFE_CHMOD(cleanup, ".", MODE_TO);
-
-	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
-
-	/* Modify mode permissions on test directory - test conditions */
-	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_TE);
-
-	nobody_pwd = SAFE_GETPWNAM(cleanup, "nobody");
-	SAFE_SETEUID(cleanup, nobody_pwd->pw_uid);
-}
-
-static void cleanup(void)
-{
-	if (seteuid(0))
-		tst_resm(TWARN | TERRNO, "seteuid(o) failed");
-
-	tst_rmdir();
-}
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

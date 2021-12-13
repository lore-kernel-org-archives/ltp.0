Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDDFC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 03:42:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A30F83C89A4
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 04:42:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C75023C1448
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 04:42:44 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED3AA10005BB
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 04:42:41 +0100 (CET)
X-QQ-mid: bizesmtp35t1639366954txaq4vjl
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Mon, 13 Dec 2021 11:42:28 +0800 (CST)
X-QQ-SSF: 0140000000200070E000000B0000000
X-QQ-FEAT: 4LFlwc+MlXmqnpGi9L9tyFsagf6I45RFYFWiUTVMjCPLlQKxoi2jvT0pyIBXq
 z3z0wl6L5/OsJcYXw8o2oOhcFvZTBsamVKmjdKrbIUqTE967BhshIUp5cK/2ylFLe7XXRx3
 yD7GVxYNlsmTUXJBQLT2Lvf5LjA0b56aO7NFTfb/LOwV8bLF2974un5GgQ4Pv13v+IfROps
 hqOZUtuZwnxYA5Ri8WI2hCZfORHc3MobMuL7tFS+JcdhdmN79EhOzahg+jH9qMDhHMoHrGm
 AUT/cxijkSF4dkm6qsMgUOFCniWhrjfPy736sT2TqvYRRwPqtv3lQNKv2geZhHB0PDJljPl
 A+ixH58+0a58LGPC1zPfQeePVGIjw==
X-QQ-GoodBg: 2
From: sujiaxun <sujiaxun@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 11:42:13 +0800
Message-Id: <20211213034213.10306-1-sujiaxun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [v1] syscalls/symlinkat01: Convert to new API
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
Cc: sujiauxn <sujiaxun@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: sujiauxn <sujiaxun@uniontech.com>

Signed-off-by: sujiauxn <sujiaxun@uniontech.com>
---
 .../kernel/syscalls/symlinkat/symlinkat01.c   | 198 ++++++------------
 1 file changed, 63 insertions(+), 135 deletions(-)

diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index 8c9e148e9..beda359c1 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -1,35 +1,16 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * 08/25/2006      Created first by Yi Yang <yyangcdl@cn.ibm.com>
+ */
+
+/*\
+ * [Description]
  *
- *   Copyright (c) International Business Machines  Corp., 2006
+ * This test case will verify basic function of symlinkat
+ * added by kernel 2.6.16 or up.
  *
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
- *      symlinkat01.c
- *
- * DESCRIPTION
- *	This test case will verify basic function of symlinkat
- *	added by kernel 2.6.16 or up.
- *
- * Author
- *	Yi Yang <yyangcdl@cn.ibm.com>
- *
- * History
- *      08/25/2006      Created first by Yi Yang <yyangcdl@cn.ibm.com>
- *
- *****************************************************************************/
+ */

 #define _GNU_SOURCE

@@ -38,24 +19,16 @@
 #include <sys/time.h>
 #include <fcntl.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
 #include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
+#include <stdio.h>

 #define MYRETCODE -999
 #ifndef AT_FDCWD
 #define AT_FDCWD -100
 #endif

-struct test_struct;
-static void setup();
-static void cleanup();
-static void setup_every_copy();
-static void mysymlinkat_test(struct test_struct *desc);
-
 #define TEST_DIR1 "olddir"
 #define TEST_DIR2 "newdir"
 #define TEST_DIR3 "deldir"
@@ -67,146 +40,104 @@ static char dpathname[256] = "%s/" TEST_DIR2 "/" TEST_FILE1;
 static int olddirfd, newdirfd = -1, cwd_fd = AT_FDCWD, stdinfd = 0, crapfd =
     -1, deldirfd;

-struct test_struct {
+struct test_case {
 	const char *oldfn;
 	int *newfd;
 	const char *newfn;
 	const char *referencefn1;
 	const char *referencefn2;
 	int expected_errno;
-} test_desc[] = {
+} tcases[] = {
 	/* relative paths */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &newdirfd, TEST_FILE1,
 		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* abs path at dst */
+    /* abs path at dst */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &newdirfd, dpathname,
 		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* relative paths to cwd */
+    /* relative paths to cwd */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &cwd_fd,
 		    TEST_DIR2 "/" TEST_FILE1, TEST_DIR1 "/" TEST_FILE1,
 		    TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* abs path */
+    /* abs path */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &cwd_fd, dpathname,
 		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* relative paths to invalid */
+    /* relative paths to invalid */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &stdinfd,
 		    TEST_DIR2 "/" TEST_FILE1, 0, 0, ENOTDIR},
-	    /* abs path at dst */
+    /* abs path at dst */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &stdinfd, dpathname,
 		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* relative paths to crap */
+    /* relative paths to crap */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &crapfd,
 		    TEST_DIR2 "/" TEST_FILE1, 0, 0, EBADF},
-	    /* abs path at dst */
+    /* abs path at dst */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &crapfd, dpathname,
 		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* relative paths to deleted */
+    /* relative paths to deleted */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &deldirfd,
 		    TEST_DIR2 "/" TEST_FILE1, 0, 0, ENOENT},
-	    /* abs path at dst */
+    /* abs path at dst */
 	{
 	"../" TEST_DIR1 "/" TEST_FILE1, &deldirfd, dpathname,
-		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0},
-	    /* fifo link */
-	    /*      { TEST_FIFO, &newdirfd, TEST_FILE1, TEST_DIR1"/"TEST_FIFO, TEST_DIR2"/"TEST_FILE1, 0 }, */
+		    TEST_DIR1 "/" TEST_FILE1, TEST_DIR2 "/" TEST_FILE1, 0}
 };

-char *TCID = "symlinkat01";
-int TST_TOTAL = sizeof(test_desc) / sizeof(*test_desc);
-
-static int mysymlinkat(const char *oldfilename,
-		       int newdirfd, const char *newfilename)
-{
-	return ltp_syscall(__NR_symlinkat, oldfilename, newdirfd, newfilename);
-}
-
-int main(int ac, char **av)
-{
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
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			setup_every_copy();
-			mysymlinkat_test(&test_desc[i]);
-
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup_every_copy(void)
 {
 	close(newdirfd);
 	unlink(dpathname);
 	rmdir(TEST_DIR2);

-	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
-	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
+	SAFE_MKDIR(TEST_DIR2, 0700);
+	newdirfd = SAFE_OPEN(TEST_DIR2, O_DIRECTORY);
 }

-static void mysymlinkat_test(struct test_struct *desc)
+static void run_test(unsigned int nr)
 {
 	int fd;
+	struct test_case *tc = &tcases[nr];
+
+	setup_every_copy();

-	TEST(mysymlinkat(desc->oldfn, *desc->newfd, desc->newfn));
-
-	/* check return code */
-	if (TEST_ERRNO == desc->expected_errno) {
-		if (TEST_RETURN == 0 && desc->referencefn1 != NULL) {
+	TEST(tst_syscall(__NR_symlinkat, tc->oldfn, *tc->newfd, tc->newfn));
+	if (TST_ERR == tc->expected_errno) {
+		if (TST_RET == 0 && tc->referencefn1 != NULL) {
 			int tnum = rand(), vnum = ~tnum;

-			fd = SAFE_OPEN(cleanup, desc->referencefn1, O_RDWR);
-			SAFE_WRITE(cleanup, 1, fd, &tnum, sizeof(tnum));
-			SAFE_CLOSE(cleanup, fd);
+			fd = SAFE_OPEN(tc->referencefn1, O_RDWR);
+			SAFE_WRITE(1, fd, &tnum, sizeof(tnum));
+			SAFE_CLOSE(fd);

-			fd = SAFE_OPEN(cleanup, desc->referencefn2, O_RDONLY);
-			SAFE_READ(cleanup, 1, fd, &vnum, sizeof(vnum));
-			SAFE_CLOSE(cleanup, fd);
+			fd = SAFE_OPEN(tc->referencefn2, O_RDONLY);
+			SAFE_READ(1, fd, &vnum, sizeof(vnum));
+			SAFE_CLOSE(fd);

 			if (tnum == vnum)
-				tst_resm(TPASS, "Test passed");
+				tst_res(TPASS, "Test passed");
 			else
-				tst_resm(TFAIL,
+				tst_res(TFAIL,
 					 "The link file's content isn't as same as the original file's "
 					 "although symlinkat returned 0");
 		} else {
-			tst_resm(TPASS,
+			tst_res(TPASS,
 				 "symlinkat() returned the expected  errno %d: %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
+				 TST_ERR, strerror(TST_ERR));
 		}
 	} else {
-		tst_resm(TFAIL,
-			 TEST_RETURN ==
+		tst_res(TFAIL,
+			 TST_RET ==
 			 0 ? "symlinkat() surprisingly succeeded" :
-			 "symlinkat() Failed, errno=%d : %s", TEST_ERRNO,
-			 strerror(TEST_ERRNO));
+			 "symlinkat() Failed, errno=%d : %s", TST_ERR,
+			 strerror(TST_ERR));
 	}
 }

@@ -214,27 +145,24 @@ static void setup(void)
 {
 	char *tmp;
 	int fd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	SAFE_MKDIR(cleanup, TEST_DIR1, 0700);
-	SAFE_MKDIR(cleanup, TEST_DIR3, 0700);
-	olddirfd = SAFE_OPEN(cleanup, TEST_DIR1, O_DIRECTORY);
-	deldirfd = SAFE_OPEN(cleanup, TEST_DIR3, O_DIRECTORY);
-	SAFE_RMDIR(cleanup, TEST_DIR3);
-	fd = SAFE_OPEN(cleanup, TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
-	SAFE_CLOSE(cleanup, fd);
+
+	SAFE_MKDIR(TEST_DIR1, 0700);
+	SAFE_MKDIR(TEST_DIR3, 0700);
+	olddirfd = SAFE_OPEN(TEST_DIR1, O_DIRECTORY);
+	deldirfd = SAFE_OPEN(TEST_DIR3, O_DIRECTORY);
+	SAFE_RMDIR(TEST_DIR3);
+	fd = SAFE_OPEN(TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
+	SAFE_CLOSE(fd);

 	/* gratuitous memory leak here */
 	tmp = strdup(dpathname);
 	snprintf(dpathname, sizeof(dpathname), tmp, get_current_dir_name());
-
-	TEST_PAUSE;
 }

-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+    .min_kver = "2.6.16",
+	.setup = setup,
+    .tcnt = ARRAY_SIZE(tcases),
+    .test = run_test,
+    .needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

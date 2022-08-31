Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277D8ECAAD4
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 11:31:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A917B3CA6D0
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 13:30:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1DE23C98BB
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 13:30:48 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 993056007B8
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 13:30:45 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHhjH6wvszlWH3
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 19:27:15 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 19:30:40 +0800
To: <ltp@lists.linux.it>
Date: Wed, 31 Aug 2022 19:26:20 +0800
Message-ID: <20220831112620.54251-1-luoxiaoyu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.155]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/open04.c: Rewrite open04.c using new LTP API
 --------------------
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
From: Luo xiaoyu via ltp <ltp@lists.linux.it>
Reply-To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Luo xiaoyu <luoxiaoyu9@huawei.com>
---
 testcases/kernel/syscalls/open/open04.c | 121 ++++++------------------
 1 file changed, 30 insertions(+), 91 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 7b3b5eb6f..3058ca1a9 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -1,115 +1,51 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
- */
+// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * DESCRIPTION
- *	Testcase to check that open(2) sets EMFILE if a process opens files
- *	more than its descriptor size
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	First get the file descriptor table size which is set for a process.
- *	Use open(2) for creating files till the descriptor table becomes full.
- *	These open(2)s should succeed. Finally use open(2) to open another
- *	file. This attempt should fail with EMFILE.
+ * Testcase to check that open(2) sets EMFILE if a process opens files
+ * more than its descriptor size.
  */
+
+#include <stdlib.h>
 #include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "test.h"
+#include "tst_test.h"
-char *TCID = "open04";
-int TST_TOTAL = 1;
+#define BUF_SIZE 256
-static int fd, ifile, mypid, first;
+static int ifile, mypid, first;
 static int nfile;
 static int *buf;
-static char fname[40];
+static char fname[BUF_SIZE];
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void  verify_open(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(open(fname, O_RDWR | O_CREAT, 0777));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			continue;
-		}
-
-		if (TEST_ERRNO != EMFILE)
-			tst_resm(TFAIL, "Expected EMFILE, got %d", TEST_ERRNO);
-		else
-			tst_resm(TPASS, "call returned expected EMFILE error");
-	}
-
-	close(first);
-	close(fd);
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(open(fname, O_RDWR | O_CREAT, 0777), EMFILE);
 }
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* make a temporary directory and cd to it */
-	tst_tmpdir();
+	int fd;
 	mypid = getpid();
 	nfile = getdtablesize();
 	sprintf(fname, "open04.%d", mypid);
-	first = fd = open(fname, O_RDWR | O_CREAT, 0777);
-	if (first == -1)
-		tst_brkm(TBROK, cleanup, "Cannot open first file");
+	first = fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0777);
-	close(fd);
-	close(first);
-	unlink(fname);
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(fname);
 	/* Allocate memory for stat and ustat structure variables */
-	buf = malloc(sizeof(int) * nfile - first);
-	if (buf == NULL)
-		tst_brkm(TBROK, NULL, "Failed to allocate Memory");
+	buf = SAFE_MALLOC(sizeof(int) * (nfile - first));
 	for (ifile = first; ifile <= nfile; ifile++) {
 		sprintf(fname, "open04.%d.%d", ifile, mypid);
 		fd = open(fname, O_RDWR | O_CREAT, 0777);
 		if (fd == -1) {
-			if (errno != EMFILE) {
-				tst_brkm(TBROK, cleanup, "Expected EMFILE got "
-					 "%d", errno);
-			}
+			if (errno != EMFILE)
+				tst_brk(TBROK | TERRNO, "Expected EMFILE");
 			break;
 		}
 		buf[ifile - first] = fd;
@@ -118,16 +54,19 @@ static void setup(void)
 static void cleanup(void)
 {
-	close(first);
-
 	for (ifile = first; ifile < nfile; ifile++) {
 		sprintf(fname, "open04.%d.%d", ifile, mypid);
-		close(buf[ifile - first]);
-		unlink(fname);
+		SAFE_CLOSE(buf[ifile - first]);
+		SAFE_UNLINK(fname);
 	}
 	free(buf);
-
-	/* delete the test directory created in setup() */
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_open,
+};
+
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C8CC43334
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 09:39:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0310D3CA869
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 11:39:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2743C93B4
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 11:40:26 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 91A511000977
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 11:40:23 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lcd1J1npSzYd3y
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 17:39:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 17:40:19 +0800
To: <ltp@lists.linux.it>
Date: Tue, 5 Jul 2022 17:37:37 +0800
Message-ID: <20220705093737.19569-1-luoxiaoyu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.155]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Jul 2022 11:38:55 +0200
Subject: [LTP] [PATCH] syscalls/open03.c: Rewrite open03.c using new LTP API
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
 testcases/kernel/syscalls/open/open03.c | 103 +++++++-----------------
 1 file changed, 27 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open03.c b/testcases/kernel/syscalls/open/open03.c
index aa15ee9e9..7926e50f4 100644
--- a/testcases/kernel/syscalls/open/open03.c
+++ b/testcases/kernel/syscalls/open/open03.c
@@ -1,90 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
  */

-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
+/*\
+ * [DESCRIPTION]
+ *
+ * Testcase to check that open a new file with O_RDWR | O_CREAT successfully.
+ */

-char *TCID = "open03";
-int TST_TOTAL = 1;
+#include "tst_test.h"

-static char fname[255];
-static int fd;
+#define TEST_FILE "testfile"

-int main(int ac, char **av)
+static void verify_open(void)
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
-		TEST(open(fname, O_RDWR | O_CREAT, 0700));
-		fd = TEST_RETURN;
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "open(%s,O_RDWR|O_CREAT,0700) failed", fname);
-		} else {
-			tst_resm(TPASS,
-				 "open(%s, O_RDWR|O_CREAT,0700) returned %ld",
-				 fname, TEST_RETURN);
-
-			SAFE_CLOSE(cleanup, fd);
-			SAFE_UNLINK(cleanup, fname);
-		}
+	int fd;
+
+	TEST(open(TEST_FILE, O_RDWR | O_CREAT, 0700));
+	fd = TST_RET;
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"open(%s, O_RDWR | O_CREAT, 0700) failed", TEST_FILE);
+	} else {
+		tst_res(TPASS,
+			"open(%s, O_RDWR | O_CREAT, 0700) returned %ld",
+			TEST_FILE, TST_RET);
 	}

-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(TEST_FILE);
 }

-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();

-	sprintf(fname, "tfile_%d", getpid());
-}

-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = verify_open,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

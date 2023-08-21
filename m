Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79137EE49A6
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 11:39:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA19D3CC825
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 13:39:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720283CC7E5
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 13:39:05 +0200 (CEST)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFEAA10000D3
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 13:39:04 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="107666567"
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; d="scan'208";a="107666567"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2023 20:39:01 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 12144CA1E8
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 20:38:59 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D350D4F46
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 20:38:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5388C8897D;
 Mon, 21 Aug 2023 20:38:57 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 21 Aug 2023 19:38:30 +0800
Message-Id: <1692617910-32684-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692617910-32684-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1692617910-32684-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27826.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27826.007
X-TMASE-Result: 10--5.320800-10.000000
X-TMASE-MatchedRID: B9/cONLFiGiwQEC6hpSor6zGfgakLdjawTlc9CcHMZe0sAt86s8nFHlb
 NLJMhGktfgsc3BsCzVhh3rlK7WyPEpNF6jas2+r4fOaYwP8dcX7zZKDA1/pIrjABh2rVVNejBgG
 3GdQLSjCtuu6YxSgT/3wBfyL06jKAPB2bJfaDlfALDU/co8QlD3kh2o5HrbgfcRruq48VKlAWWg
 76IlE/zGs+Dz00KoL2hWNqEuv5lMn+vYrrB0ib30rOO5m0+0gEfrTt+hmA5bL0R1DyIhi7gGtCB
 JGDrKJFnUY+WM9pU6qFzkxNEN20m2wYJ6a6zhumngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIfiAq
 rjYtFiSscmeFCYN1j6CzK/k2HI4qGmw+R3cfLqNsgGbjb4gkt37cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/readlinkat02: Convert to new API
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

1.Move the error test of readlinkat01 to readlinkat02
2.Use TST_ macros

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/readlinkat/readlinkat02.c | 126 ++++++------------
 1 file changed, 44 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat02.c b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
index d30c1917a..2044f9d13 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat02.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
@@ -1,122 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
+ * Copyright (c) Linux Test Project, 2003-2023
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Test for EINVAL, ENOTDIR, EBADF errors.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Library General Public License for more details.
+ * - readlinkat() fails with EINVAL if the bufsiz is 0.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * - readlinkat() fails with EINVAL if the named file is not a symbolic link.
  *
- */
-/*
- * Test Description:
- *  Verify that,
- *   1. bufsiz is 0, EINVAL should be returned.
- *   2. The named file is not a symbolic link, EINVAL should be returned.
- *   3. The component of the path prefix is not a directory, ENOTDIR should be
- *	returned.
- *   4. pathname is relative and dirfd is a file descriptor referring to a file
- *	other than a directory, ENOTDIR should be returned.
+ * - readlinkat() fails with ENOTDIR if the component of the path prefix is
+ *   not a directory.
+ *
+ * - readlinkat() fails with ENOTDIR if the pathname is relative and
+ *   dirfd is a file descriptor referring to a fileother than a directory.
+ *
+ * - readlinkat() fails with EBADF if the file descriptor is invalid.
  */
 
-#include <fcntl.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/readlinkat.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 
 #define TEST_FILE	"test_file"
 #define SYMLINK_FILE	"symlink_file"
 #define BUFF_SIZE	256
 
 static int file_fd, dir_fd;
+static int fd_invalid = -1;
 
-static struct test_case_t {
-	int *dirfd;
+static struct tcase {
+	int *fd;
 	const char *pathname;
 	size_t bufsiz;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	{&dir_fd, SYMLINK_FILE, 0, EINVAL},
 	{&dir_fd, TEST_FILE, BUFF_SIZE, EINVAL},
 	{&file_fd, SYMLINK_FILE, BUFF_SIZE, ENOTDIR},
 	{&dir_fd, "test_file/test_file", BUFF_SIZE, ENOTDIR},
+	{&fd_invalid, SYMLINK_FILE, BUFF_SIZE, EBADF},
 };
 
-char *TCID = "readlinkat02";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void setup(void);
-static void cleanup(void);
-static void readlinkat_verify(const struct test_case_t *);
-
-int main(int argc, char **argv)
+static void verify_readlinkat(unsigned int i)
 {
-	int i, lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	char buf[BUFF_SIZE];
+	struct tcase *tc = &tcases[i];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			readlinkat_verify(&test_cases[i]);
-	}
+	memset(buf, 0, sizeof(buf));
 
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(readlinkat(*tc->fd, tc->pathname, buf, tc->bufsiz),
+		     tc->exp_errno, "readlinkat(%d, %s, NULL, %ld)",
+		     *tc->fd, tc->pathname, tc->bufsiz);
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	dir_fd = SAFE_OPEN(".", O_RDONLY);
 
-	TEST_PAUSE;
+	file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0644);
 
-	tst_tmpdir();
-
-	dir_fd = SAFE_OPEN(cleanup, "./", O_RDONLY);
-
-	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0644);
-
-	SAFE_SYMLINK(cleanup, TEST_FILE, SYMLINK_FILE);
-}
-
-static void readlinkat_verify(const struct test_case_t *test)
-{
-	char buf[BUFF_SIZE];
-	TEST(readlinkat(*test->dirfd, test->pathname, buf, test->bufsiz));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "readlinkat succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "readlinkat failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "readlinkat failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	SAFE_SYMLINK(TEST_FILE, SYMLINK_FILE);
 }
 
 static void cleanup(void)
 {
-	close(dir_fd);
-	close(file_fd);
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

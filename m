Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09109C46CD8
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 09:45:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74A623CEF40
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 10:45:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B01DE3CA9AE
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 10:45:07 +0100 (CET)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C1B1600787
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 10:45:05 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="144563495"
X-IronPort-AV: E=Sophos;i="6.04,296,1695654000"; d="scan'208";a="144563495"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 18:45:03 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E1702D64B3
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 18:45:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 188C1D4FDB
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 18:45:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 956A022DD19
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 18:45:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 27DAC1A0071;
 Fri, 22 Dec 2023 17:45:00 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 22 Dec 2023 04:44:53 -0500
Message-Id: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28072.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28072.006
X-TMASE-Result: 10--7.736100-10.000000
X-TMASE-MatchedRID: XuJFmydYOtjyq/cli2hvDU7nLUqYrlslFIuBIWrdOePEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI9r2qJoNIuCjf+aPQT1cxlG2Lg
 EVfggSljv3R81Uj/6vFq29TMwNyQqa1Tt4wRPVa03vTBeEjQNfjKEtjy6tQe+LEzDQUyQGVmyuh
 piqaRnajSVo/q1FXAZMX80culaIXnOLLwxlMO5PfZNLVgVojn/Mi5cVoUvU/ae38zXnNg9Q9Qa+
 cFl+2ENkgOmcA0F1kcT0+Flol42M46tQ+b081RSutvHF25zoU9M97W09ZKmXeX3QlUHePIKZHE1
 1AH3EK9XPsZguSVIzhUdpx4K1EAjNyl1nd9CIt0URSScn+QSXt0H8LFZNFG7bkV4e2xSge6QKs0
 je2nPUel9C57pB6TTomBeJu1riFFplZF0CruY1VgpWCbva+Mm
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] fchownat01: Convert to new API
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/fchownat/fchownat01.c     | 163 +++++++-----------
 1 file changed, 61 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 7771c111a..c00c6063e 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -1,133 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2006
- *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2006-2023
+ * Author: Yi Yang <yyangcdl@cn.ibm.com>
+ */
+
+/*\
+ * [Description]
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * Check the basic functionality of the faccessat() system call.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-/*
- * DESCRIPTION
- *	This test case will verify basic function of fchownat
- *	added by kernel 2.6.16 or up.
+ * - fchownat() passes if dir_fd is file descriptor to the directory
+ *   where the file is located and pathname is relative path of the file.
+ * - fchownat() passes if pathname is absolute, then dirfd is ignored.
+ * - fchownat() passes if pathname is relative and dirfd is the special
+ *   value AT_FDCWD.
+ * - fchownat() passes if pathname is an empty string, operate on the file
+ *   referred to by dirfd.
+ * - fchownat() passes if pathname is a symbolic link, operate on the link
+ *   itself.
  */
 
 #define _GNU_SOURCE
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
+#include "tst_test.h"
 
-#define TESTFILE	"testfile"
-
-static void setup(void);
-static void cleanup(void);
+#define TESTFILE        "testfile"
+#define TESTFILE_LINK   "testfile_link"
 
 static int dir_fd;
-static int fd;
-static int no_fd = -1;
 static int cu_fd = AT_FDCWD;
+static char *testfile;
+static char *abspath;
+static char *symfile;
+static char *empty;
 
-static struct test_case_t {
-	int exp_ret;
-	int exp_errno;
-	int flag;
+static struct tcase {
 	int *fds;
-	char *filenames;
-} test_cases[] = {
-	{0, 0, 0, &dir_fd, TESTFILE},
-	{-1, ENOTDIR, 0, &fd, TESTFILE},
-	{-1, EBADF, 0, &no_fd, TESTFILE},
-	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
-	{0, 0, 0, &cu_fd, TESTFILE},
+	char **filenames;
+	int flag;
+} tcases[] = {
+	{&dir_fd, &testfile, 0},
+	{&dir_fd, &abspath, 0},
+	{&cu_fd, &testfile, 0},
+	{&cu_fd, &empty, AT_EMPTY_PATH},
+	{&dir_fd, &symfile, AT_SYMLINK_NOFOLLOW}
 };
 
-char *TCID = "fchownat01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void fchownat_verify(const struct test_case_t *);
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
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			fchownat_verify(&test_cases[i]);
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
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
 
-	tst_tmpdir();
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
 
-	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
+	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
 
-	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
+	char *tmpdir = tst_get_tmpdir();
 
-	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
+	abspath = tst_aprintf("%s/" TESTFILE, tmpdir);
+	free(tmpdir);
 }
 
-static void fchownat_verify(const struct test_case_t *test)
+static void fchownat_verify(unsigned int i)
 {
-	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
-		      getegid(), test->flag));
+	struct tcase *tc = &tcases[i];
 
-	if (TEST_RETURN != test->exp_ret) {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() returned %ld, expected %d, errno=%d",
-			 TEST_RETURN, test->exp_ret, test->exp_errno);
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			 "fchownat() returned the expected errno %d: %s",
-			 test->exp_ret, strerror(test->exp_errno));
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	TST_EXP_PASS(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
+		     tc->flag), "fchownat(%d, %s, %d, %d, %d)",
+		     *tc->fds, *tc->filenames, geteuid(), getegid(), tc->flag);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0)
-		close(fd);
-
-	if (dir_fd > 0)
-		close(dir_fd);
-
-	tst_rmdir();
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = fchownat_verify,
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&testfile, .str = TESTFILE},
+		{&empty, .str = ""},
+		{&symfile, .str = TESTFILE_LINK},
+		{},
+	},
+	.needs_tmpdir = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

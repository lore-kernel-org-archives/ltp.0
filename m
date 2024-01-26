Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0E3C47DDB
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 06:26:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD7CB3CFA71
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 07:26:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A6783CE1AE
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 07:25:52 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1576C100022D
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 07:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706250352; x=1737786352;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cshKMWM3NSla4L7/Krcc//GduX5eukVZvfq3qhLWWT0=;
 b=OAg2+rAWqCHC3wc06ssw+sY4UV/GfaV5hBR/fDkl7+r4jdTzSHMthYuR
 RIA2yD/LYZdMor3DrvwzOpixL+cGShHs9e4fOJWMpmUsNnPsYn6pQDKMB
 bIC1vKdCOjnqD+6c1phShlobSY17XKdgo+YiaDQkdVb4tOQG8BRsjgEh+
 FcB/Fc4esjIxMonkuZJoKFp3pcHEIPpMZeVJg9o5l+YOyK+AennxGQURK
 asPmkrSMDGAoM+ZfNJ7cjCT5wXfjv+j+LfGe9kFKTPkxCNhvq+17CRe1J
 EUy6Q4/WXkZMBCY8M6SYfHnacs0a8X8ncLzmYaz3dCdeqKBxpIoUwOFQo w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="126658610"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; d="scan'208";a="126658610"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 15:25:44 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A560D4F60
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:25:42 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B7FEED96C8
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:25:41 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A5C36BA79
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:25:41 +0900 (JST)
Received: from irides.. (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C80391A006A
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 14:25:40 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 14:25:39 +0800
Message-Id: <20240126062540.2596279-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.005
X-TMASE-Result: 10--6.285600-10.000000
X-TMASE-MatchedRID: dk3TBobQ8JDyq/cli2hvDU7nLUqYrlslFIuBIWrdOePEosIs7IJbkIh+
 mL+ciFCpbnRB47KLJ1QzLmfGY6iDkX5uUfhNvnKzOWUWxTQJdI8UZYubbUj2DLt4BAaULwAVJf5
 otvavOZf9vT5evMX4tJhCh8+WImJUkto8AKCDbo7X3j/lf1V8LPlSepWcgdLP3bQqGQJNxNT+D3
 RLoTW33cU5EmK/acPfOtsexkgmzvYZOq+6NU4O5d9JA2lmQRNU9avse85ISVqchtWeykcDiuafU
 xjZqZZRQ8eCpfwDu60airk8LRr5reKOHNhoftDjmIe0I1iNyQw+oe2bfROzIwAheUymmndf2f+h
 whHsvfXi8zVgXoAltsIJ+4gwXrEtIAcCikR3vq/DoSPD/GUQ7YvtTziJa+54rUlcip1qZWD5LZw
 oxXZCKESoM6gqHi7G
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fchownat01: Convert to new API
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

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .../kernel/syscalls/fchownat/fchownat01.c     | 154 ++++++------------
 1 file changed, 49 insertions(+), 105 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 7771c111a..1a5b66d99 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -1,133 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2006
- *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
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
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2007-2024
  */
-/*
- * DESCRIPTION
- *	This test case will verify basic function of fchownat
- *	added by kernel 2.6.16 or up.
+
+/*\
+ * [Description]
+ *
+ * Verify basic function of fchownat() added by kernel 2.6.16 or up.
  */
 
 #define _GNU_SOURCE
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
+#include "tst_test.h"
 
 #define TESTFILE	"testfile"
-
-static void setup(void);
-static void cleanup(void);
+#define TESTFILE2	"testfile2"
 
 static int dir_fd;
 static int fd;
 static int no_fd = -1;
 static int cu_fd = AT_FDCWD;
 
-static struct test_case_t {
+static struct tcase {
 	int exp_ret;
 	int exp_errno;
 	int flag;
-	int *fds;
-	char *filenames;
-} test_cases[] = {
-	{0, 0, 0, &dir_fd, TESTFILE},
-	{-1, ENOTDIR, 0, &fd, TESTFILE},
-	{-1, EBADF, 0, &no_fd, TESTFILE},
-	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
-	{0, 0, 0, &cu_fd, TESTFILE},
+	int *fd;
+	char *filename;
+} tcases[] = {
+	{ 0, 0, 0, &dir_fd, TESTFILE },
+	{ 0, 0, 0, &cu_fd, TESTFILE },
+	{ -1, ENOTDIR, 0, &fd, TESTFILE },
+	{ -1, EBADF, 0, &no_fd, TESTFILE },
+	{ -1, EINVAL, 9999, &dir_fd, TESTFILE },
 };
 
-char *TCID = "fchownat01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void fchownat_verify(const struct test_case_t *);
-
-int main(int ac, char **av)
+static void fchownat_verify(unsigned int n)
 {
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
+	struct tcase *tc = &tcases[n];
+	uid_t euid = geteuid();
+	gid_t egid = getegid();
+	int fd = *tc->fd;
+	int flag = tc->flag;
+	const char *filename = tc->filename;
+
+	if (tc->exp_ret == 0)
+		TST_EXP_PASS(fchownat(fd, filename, euid, egid, flag),
+			     "fchownat(%d, %s, %d, %d, %d)",
+			     fd, filename, euid, egid, flag);
+	else
+		TST_EXP_FAIL(fchownat(fd, filename, euid, egid, flag),
+			     tc->exp_errno,
+			     "fchownat(%d, %s, %d, %d, %d)",
+			     fd, filename, euid, egid, flag);
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
-
-	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
-
-	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
-}
-
-static void fchownat_verify(const struct test_case_t *test)
-{
-	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
-		      getegid(), test->flag));
-
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
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
+	fd = SAFE_OPEN(TESTFILE2, O_CREAT | O_RDWR, 0600);
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
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(dir_fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = fchownat_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

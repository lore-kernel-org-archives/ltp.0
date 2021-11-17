Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E83C433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 03:40:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD87615E1
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 03:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CD87615E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FF593C87D1
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 04:40:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CB773C0726
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 04:40:09 +0100 (CET)
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76B4E1A01483
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 04:40:04 +0100 (CET)
X-QQ-mid: bizesmtp37t1637120399tzebba32
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Wed, 17 Nov 2021 11:39:52 +0800 (CST)
X-QQ-SSF: 0140000000200050D000B00A0000000
X-QQ-FEAT: zkEeU6Ots57clNYTR//TAxROYrZ1e5QS8BzuGarIHSUMNCO56QbfGa3ZEZvwg
 0DKAVRMYpqLdd6HUBm/AOanbALjSjK7bkdFdvATF5sQyk34znRbpedzWBfO6g0WnZnZFPxL
 VeGMZCU/tCLwf/NYPhYGUEbXTi6ZoWgFIg4hybPkd+1WgUM1js//PpNFLD3EL21TNtfEJ15
 YP+hUjzO7xms340VDvkkkxoNYrwzy0bSJJlOlsUMRAV3RjbyUbKzfREZ1ogOPgBuW4wBZrp
 drPLgOUZoV+E1mS/u0ImseB+AEm6na/UuGG4JuV9Meh0TsyKYK6aEX6SKJbOIJm7wYljyw7
 TgK9Sg3SYx1OvY9xxtwa0jmSQXxbQ==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 17 Nov 2021 11:39:50 +0800
Message-Id: <20211117033951.16352-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fchownat/fchownat01: Convert to new API
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
 testcases/kernel/syscalls/fchownat/fchownat.h |  15 +-
 .../kernel/syscalls/fchownat/fchownat01.c     | 131 +++++-------------
 2 files changed, 39 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat.h b/testcases/kernel/syscalls/fchownat/fchownat.h
index a95c26f93..75c435dab 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat.h
+++ b/testcases/kernel/syscalls/fchownat/fchownat.h
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Library General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  */

 #ifndef FCHOWNAT_H
diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 9f4ecded7..b18af54f4 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -1,60 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *   Copyright (c) International Business Machines  Corp., 2006
  *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
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
  */
-/*
- * DESCRIPTION
- *	This test case will verify basic function of fchownat
- *	added by kernel 2.6.16 or up.
+
+/*\
+ * [Description]
+ *
+ * This test case will verify basic function of fchownat
+ * added by kernel 2.6.16 or up.
  */

 #define _GNU_SOURCE

-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "fchownat.h"
 #include "lapi/fcntl.h"

 #define TESTFILE	"testfile"

-static void setup(void);
-static void cleanup(void);
-
 static int dir_fd;
 static int fd;
 static int no_fd = -1;
 static int cu_fd = AT_FDCWD;

-static struct test_case_t {
+static struct tcase {
 	int exp_ret;
 	int exp_errno;
 	int flag;
 	int *fds;
 	char *filenames;
-} test_cases[] = {
+} tcases[] = {
 	{0, 0, 0, &dir_fd, TESTFILE},
 	{-1, ENOTDIR, 0, &fd, TESTFILE},
 	{-1, EBADF, 0, &no_fd, TESTFILE},
@@ -62,77 +38,46 @@ static struct test_case_t {
 	{0, 0, 0, &cu_fd, TESTFILE},
 };

-char *TCID = "fchownat01";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-static void fchownat_verify(const struct test_case_t *);
-
-int main(int ac, char **av)
+static void verify_fchownat(unsigned int i)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct tcase *tc = &tcases[i];

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			fchownat_verify(&test_cases[i]);
+	if (tc->exp_ret == 0) {
+		TST_EXP_PASS(fchownat(*(tc->fds), tc->filenames, geteuid(),
+			getegid(), tc->flag),
+		 	"fchownat() returned %ld, expected %d, errno=%d",
+			 TST_RET, tc->exp_ret, tc->exp_errno);
+	} else {
+		TST_EXP_FAIL(fchownat(*(tc->fds), tc->filenames, geteuid(),
+			getegid(), tc->flag), tc->exp_errno,
+			 "fchownat() expected errno %d: %s",
+			 tc->exp_ret, strerror(tc->exp_errno));
 	}
-
-	cleanup();
-	tst_exit();
 }

 static void setup(void)
 {
-	if ((tst_kvercmp(2, 6, 16)) < 0)
-		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
-
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
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);

-	if (TEST_RETURN != test->exp_ret) {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() returned %ld, expected %d, errno=%d",
-			 TEST_RETURN, test->exp_ret, test->exp_errno);
-		return;
-	}
+	SAFE_TOUCH(TESTFILE, 0600, NULL);

-	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO,
-			 "fchownat() returned the expected errno %d: %s",
-			 test->exp_ret, strerror(test->exp_errno));
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "fchownat() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
-	}
+	fd = SAFE_OPEN("testfile2", O_CREAT | O_RDWR, 0600);
 }

 static void cleanup(void)
 {
-	if (fd > 0)
-		close(fd);
+       if (fd > 0)
+               close(fd);

-	if (dir_fd > 0)
-		close(dir_fd);
-
-	tst_rmdir();
+       if (dir_fd > 0)
+               close(dir_fd);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "2.6.16",
+	.test = verify_fchownat,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
--
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

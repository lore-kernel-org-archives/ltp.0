Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95658C28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 14:37:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED2C53CA411
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:37:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB9A63CA490
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:37:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id DA31310005C3
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:37:04 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 620B5ED1;
 Thu, 25 Aug 2022 07:37:08 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9F823F67D;
 Thu, 25 Aug 2022 07:37:02 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Thu, 25 Aug 2022 15:38:18 +0100
Message-Id: <20220825143819.311023-2-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825143819.311023-1-tudor.cretu@arm.com>
References: <20220825143819.311023-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] syscalls/statfs02,
 fstatfs02: Convert to new API
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

Refactor statfs02 and fstatfs02 to the new LTP API.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c | 102 +++++-------------
 testcases/kernel/syscalls/statfs/statfs02.c   |  97 ++++-------------
 2 files changed, 47 insertions(+), 152 deletions(-)

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index db2230f82..4267bd02b 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -1,37 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
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
  */
 
 /*
- * DESCRIPTION
+ * [Description]
  *	Testcase to check fstatfs() sets errno correctly.
  */
 
-#include <sys/vfs.h>
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/statfs.h>
-#include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "fstatfs02";
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
 static struct statfs buf;
 
@@ -39,76 +21,40 @@ static struct test_case_t {
 	int fd;
 	struct statfs *sbuf;
 	int error;
-} TC[] = {
+} tests[] = {
 	/* EBADF - fd is invalid */
-	{
-	-1, &buf, EBADF},
+	{-1, &buf, EBADF},
 #ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	    /* EFAULT - address for buf is invalid */
-	{
-	-1, (void *)-1, EFAULT}
+	/* Skip since uClinux does not implement memory protection */
+	/* EFAULT - address for buf is invalid */
+	{-1, (void *)-1, EFAULT},
 #endif
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-
-int main(int ac, char **av)
+static void fstatfs_verify(unsigned int n)
 {
-	int lc;
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
-			TEST(fstatfs(TC[i].fd, TC[i].sbuf));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
+	TST_EXP_FAIL(fstatfs(tests[n].fd, tests[n].sbuf), tests[n].error, "fstatfs()");
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
 #ifndef UCLINUX
-	TC[1].fd = SAFE_OPEN(cleanup, "tempfile", O_RDWR | O_CREAT, 0700);
+	tests[1].fd = SAFE_OPEN("tempfile", O_RDWR | O_CREAT, 0700);
 #endif
 }
 
 static void cleanup(void)
 {
 #ifndef UCLINUX
-	if (TC[1].fd > 0 && close(TC[1].fd))
-		tst_resm(TWARN | TERRNO, "Failed to close fd");
+	if (tests[1].fd > 0 && close(tests[1].fd))
+		tst_res(TWARN | TERRNO, "Failed to close fd");
 #endif
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.test = fstatfs_verify,
+	.tcnt = ARRAY_SIZE(tests),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index 279665f86..f906c84ff 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -1,24 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *	07/2001 Ported by Wayne Boyer
  *
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
  */
 
 /*
- * DESCRIPTION
+ * [Description]
  *	1.	Use a component of the pathname, which is not a directory
  *		in the "path" parameter to statfs(). Expect ENOTDIR
  *	2.	Pass a filename which doesn't exist, and expect ENOENT.
@@ -32,25 +20,19 @@
  *		ELOOP.
  */
 
-#include <sys/types.h>
-#include <sys/statfs.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/vfs.h>
-#include <sys/mman.h>
 #include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "statfs02";
-
-static int fd;
+#include <fcntl.h>
+#include <sys/statfs.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
 #define TEST_FILE		"statfs_file"
 #define TEST_FILE1		TEST_FILE"/statfs_file1"
 #define TEST_NOEXIST		"statfs_noexist"
 #define TEST_SYMLINK		"statfs_symlink"
 
+static int fd;
 static char test_toolong[PATH_MAX+2];
 static struct statfs buf;
 
@@ -58,7 +40,7 @@ static struct test_case_t {
 	char *path;
 	struct statfs *buf;
 	int exp_error;
-} TC[] = {
+} tests[] = {
 	{TEST_FILE1, &buf, ENOTDIR},
 	{TEST_NOEXIST, &buf, ENOENT},
 	{test_toolong, &buf, ENAMETOOLONG},
@@ -69,72 +51,39 @@ static struct test_case_t {
 	{TEST_SYMLINK, &buf, ELOOP},
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
 static void setup(void);
 static void cleanup(void);
-static void statfs_verify(const struct test_case_t *);
 
-int main(int ac, char **av)
+static void statfs_verify(unsigned int n)
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
-			statfs_verify(&TC[i]);
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(statfs(tests[n].path, tests[n].buf), tests[n].exp_error, "statfs()");
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd = SAFE_CREAT(cleanup, TEST_FILE, 0444);
+	fd = SAFE_CREAT(TEST_FILE, 0444);
 
 	memset(test_toolong, 'a', PATH_MAX+1);
 
 #if !defined(UCLINUX)
-	TC[3].path = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
+	tests[3].path = SAFE_MMAP(0, 1, PROT_NONE,
 			       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 #endif
 
-	SAFE_SYMLINK(cleanup, TEST_SYMLINK, "statfs_symlink_2");
-	SAFE_SYMLINK(cleanup, "statfs_symlink_2", TEST_SYMLINK);
-}
-
-static void statfs_verify(const struct test_case_t *test)
-{
-	TEST(statfs(test->path, test->buf));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-		return;
-	}
-
-	if (TEST_ERRNO == test->exp_error) {
-		tst_resm(TPASS | TTERRNO, "expected failure");
-	} else {
-		tst_resm(TFAIL | TTERRNO, "unexpected error, expected %d",
-			 TEST_ERRNO);
-	}
+	SAFE_SYMLINK(TEST_SYMLINK, "statfs_symlink_2");
+	SAFE_SYMLINK("statfs_symlink_2", TEST_SYMLINK);
 }
 
 static void cleanup(void)
 {
 	if (fd > 0)
 		close(fd);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.test = statfs_verify,
+	.tcnt = ARRAY_SIZE(tests),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

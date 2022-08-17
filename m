Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D2EC25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 09:33:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4F203C9EFE
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 11:33:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4AD33C9850
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 11:33:02 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC1716007A3
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 11:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1660728780; i=@fujitsu.com;
 bh=bY6s6AH0eGokpahS95DTTb0iMTtnfymTQ05u3RH3W54=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=tuo3Oqa7FZBAk+HE55LsII8WfIif6no/eSDta8ByxMKNxo7Ymeu/c3CUyFPzxmLq1
 UQADrsvapYzJKpEdTJQ8vz2PTtloTE/utt2Ob6w8IvBeVH4/IxYClW05ivRqfK0JgA
 vzpfzNqid/BVtlw7YZGlu6D1B5GjqauSCLzQGjelvO4551u1ZDu11Z0nGg6Im4YFbz
 OJ3hV0sn6leXN9pzkD3K2cNoAbSbxgff8YS9mhhOHb5Zxpy8ggwH9wbsQGZWoB1oeW
 P+59jn+IFSIUfE9K/t6dSAZUF0rifmEi8bQZyclUa78JkzZfrNCO14Fo6TIsJm4XY0
 +V6Mn33ztBZyA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8ORpHtm658
 kg90XRSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oxJj68yFezRrGj9qtDAeEOpi5GLQ0jgFKPE
 6YV3GCGcvUwSvftnsnUxcgI52xklep8Wg9hsAtoSd3pmMILYIgISEh0Nb9lBbGYBTYl7Vw6Dx
 YUFrCQ+HnnHBGKzCKhKHPvWAmbzCrhIHOv/CTZTQkBBYsrD98wgNifQzDm/9gLN4QDapSUx76
 0JRLmgxMmZT1ggxktIHHzxghmiVVHi6um9rBB2hcTrw5eg4moSV89tYp7AKDgLSfssJO0LGJl
 WMdomFWWmZ5TkJmbm6BoaGOgaGppCaEtzvcQq3US91FLdvPyikgxdQ73E8mK91OJiveLK3OSc
 FL281JJNjMAwTilOObqD8di+X3qHGCU5mJREeRe1/0kS4kvKT6nMSCzOiC8qzUktPsQow8GhJ
 MF7fRNQTrAoNT21Ii0zBxhTMGkJDh4lEd7otUBp3uKCxNzizHSI1ClGRSlx3mdbgBICIImM0j
 y4NlgcX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzBuxGWgKT2ZeCdz0V0CLmYAWH7v4G2R
 xSSJCSqqByfPL8QiJJ4lnBVNOh9fu/ql/qd4yJojb/LxUSa2OusGOSUk1PuLBFzSUbnEfM0us
 unF+m5NUyaF7WyYlC6+uU11yU6Kk6/ptn0U5olecA17ceCqavy5k29uHj6zU18U1+zAzLWYSM
 VeRynp5gnFzrnpz4oyv+089nDyR/83zsgDf4o2nHbi4t28rfazJ8/XxE7nLqieWzCzwdkg8GC
 x77Zy94/X5M0+0aVzZkbM5tvV/9bxLyx59lvNwjWSvaXxX2rlVX1dTfNlFH5F9+RU+r9O6WwO
 0a0/6faxPf5fza8Vz21MCUhGZj49JvEqZfrVOX6h6w2S7lpS126JfL+yszU7yySt7tf5n2vUi
 3h45JZbijERDLeai4kQA8SX31F4DAAA=
X-Env-Sender: liaohj.jy@fujitsu.com
X-Msg-Ref: server-16.tower-728.messagelabs.com!1660728779!8251!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26465 invoked from network); 17 Aug 2022 09:33:00 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-16.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 17 Aug 2022 09:33:00 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id B13111AF
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 10:32:59 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id A5F7C1AE
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 10:32:59 +0100 (BST)
Received: from rhel-server--7.5 (10.167.215.42) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 17 Aug 2022 10:32:58 +0100
From: Liao Huangjie <liaohj.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 17 Aug 2022 17:32:45 +0800
Message-ID: <1660728765-4544-1-git-send-email-liaohj.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1862883.hHHqqg6b1x@localhost>
References: <1862883.hHHqqg6b1x@localhost>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.42]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/openat01:Convert into new api
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

From: Huangjie Liao <liaohj.jy@fujitsu.com>

Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
---
 testcases/kernel/syscalls/openat/openat01.c | 148 +++++++++-------------------
 1 file changed, 47 insertions(+), 101 deletions(-)

diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index daed419..eb7f70c 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -1,55 +1,31 @@
-/******************************************************************************
- *
- * Copyright (c) International Business Machines  Corp., 2006
- *  Author: Yi Yang <yyangcdl@cn.ibm.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Internstional Business Machines  Corp., 2006
+ * Author: Yi Yang <yyangcdl@cn.ibm.com>
  * Copyright (c) Cyril Hrubis 2014 <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * DESCRIPTION
- *  This test case will verify basic function of openat
- *  added by kernel 2.6.16 or up.
- *
- *****************************************************************************/
+ * This test case will verify basic function of openat
+ */
 
 #define _GNU_SOURCE
-
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
-#include <signal.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "openat.h"
-
-static void setup(void);
-static void cleanup(void);
+#include <stdio.h>
+#include "tst_test.h"
 
-char *TCID = "openat01";
+#define TEST_FILE "test_file"
+#define TEST_DIR "test_dir/"
 
 static int dir_fd, fd;
 static int fd_invalid = 100;
 static int fd_atcwd = AT_FDCWD;
-
-#define TEST_FILE "test_file"
-#define TEST_DIR "test_dir/"
-
 static char glob_path[256];
 
 static struct test_case {
@@ -65,80 +41,50 @@ static struct test_case {
 	{&fd_atcwd, TEST_DIR TEST_FILE, 0, 0}
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void verify_openat(struct test_case *test)
-{
-	TEST(openat(*test->dir_fd, test->pathname, O_RDWR, 0600));
-
-	if ((test->exp_ret == -1 && TEST_RETURN != -1) ||
-	    (test->exp_ret == 0 && TEST_RETURN < 0)) {
-		tst_resm(TFAIL | TTERRNO,
-		         "openat() returned %ldl, expected %d",
-			 TEST_RETURN, test->exp_ret);
-		return;
-	}
-
-	if (TEST_RETURN > 0)
-		SAFE_CLOSE(cleanup, TEST_RETURN);
-
-	if (TEST_ERRNO != test->exp_errno) {
-		tst_resm(TFAIL | TTERRNO,
-		         "openat() returned wrong errno, expected %s(%d)",
-			 tst_strerrno(test->exp_errno), test->exp_errno);
-		return;
-	}
-
-	tst_resm(TPASS | TTERRNO, "openat() returned %ld", TEST_RETURN);
-}
-
-int main(int ac, char **av)
+static void verify_openat(unsigned int n)
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
-
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_openat(test_cases + i);
+	struct test_case *tc = &test_cases[n];
+
+	if (tc->exp_ret) {
+		if (tc->exp_errno == ENOTDIR) {
+			TST_EXP_FAIL2(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600),
+				ENOTDIR, "openat with a filefd instead of dirfd");
+		} else {
+			TST_EXP_FAIL2(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600),
+				EBADF, "openat with invalid fd");
+		}
+	} else {
+		TST_EXP_FD(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600));
 	}
 
-	cleanup();
-	tst_exit();
+	if (TST_RET > 0)
+		SAFE_CLOSE(TST_RET);
 }
 
 static void setup(void)
 {
-	char *tmpdir;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
-	dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
-	fd = SAFE_OPEN(cleanup, TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
+	char buf[PATH_MAX];
 
-	tmpdir = tst_get_tmpdir();
-	snprintf(glob_path, sizeof(glob_path), "%s/" TEST_DIR TEST_FILE,
-	         tmpdir);
-	free(tmpdir);
+	SAFE_GETCWD(buf, PATH_MAX);
+	SAFE_MKDIR(TEST_DIR, 0700);
+	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	fd = SAFE_OPEN(TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
 
-	TEST_PAUSE;
+	snprintf(glob_path, sizeof(glob_path), "%s/" TEST_DIR TEST_FILE, buf);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "close(fd) failed");
-
-	if (dir_fd > 0 && close(dir_fd))
-		tst_resm(TWARN | TERRNO, "close(dir_fd) failed");
-
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (dir_fd > 0)
+		SAFE_CLOSE(dir_fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_openat,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

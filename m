Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7520CC32772
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 07:57:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D22E3C9A5D
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:57:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9861E3C96E0
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:57:16 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C0CA6008A7
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1660636635; i=@fujitsu.com;
 bh=QhyiWGd2d75cBc2sTynE3cNP+m8WsmU7CMaHM1jW/yg=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=R1pgemOuWfvFShKGDR16z3KZAVQQG3580QRZxsK5dt2EzaAb9pA5Om3A5E0QRrs22
 AnmK5aKUJpfDomnjSLNMzIVtY1+jR1ilEl7H6iRlU7ez87CIdbpy7w/aYWRLAC8PmO
 jUfrRqOOR87FInFqOqBOfoj5BqQFhvstNpU5XiqNVzpA5IaoSoKXNTqRwSSKeyMCn6
 v3JGwTNQayfSEexDon/UKNFbw5e46TSF3CqPIAtzqSigUT4hbyW8KjIBuZyqBXhgJ0
 CBCFn+hxUtfnPygmNLjMCkecCgOWhkSrjmXqlZ5SHDFKlBpUAFEVB0yaKAL57CTOUg
 2RchvyFGbtmrg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8MxSfe27+8
 kg6kvGC1WfN/B6MDose/3OtYAxijWzLyk/IoE1oxtO8IKPmhWLNih38D4SqmLkYtDSOAso8TL
 s99ZIJwDTBLbXzxl7mLkBHK2M0qs7OQDsdkEtCXu9MxgBLFFBCQkOhresoPYzAKaEveuHAaLC
 wtYSFx+3wZmswioSkzYeRXM5hVwkTj9pxOsXkJAQWLKw/fMEHFBiZMzn7BAzJGQOPjiBTNEja
 LE1dN7WSHsConXhy9BxdUkrp7bxDyBkX8WkvZZSNoXMDKtYrROKspMzyjJTczM0TU0MNA1NDT
 VNbbQNTQy10us0k3USy3VLU8tLtE10kssL9ZLLS7WK67MTc5J0ctLLdnECAzJlGK1+h2ML1b+
 1DvEKMnBpCTK22vyO0mILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG86MMiFBItS01Mr0jJzgPEBk
 5bg4FES4a30BkrzFhck5hZnpkOkTjEqSonzqoD0CYAkMkrz4NpgMXmJUVZKmJeRgYFBiKcgtS
 g3swRV/hWjOAejkjBvHcgUnsy8Erjpr4AWMwEt1rv7HWRxSSJCSqqByXJZkf/HA78KNUT9Fgg
 //BayckPnlShrD/P938wbVqypCyqafu241FGPj2bVLfUlvyU2r8zdLJ1Xs2T/jxYnn/iayJPh
 D7n5P7Qc+7cllvGoz+slR+uP3fuwsrpDm/cu737P+zLxP45/frfm5Z+TAXkLmNTnBQavvCwzb
 5dVE6fPXX7zheHCiVyXt7qZhkrUipybs787SP7X0ndrZuR4zYjm07xlUCS55vdZxRMxc+3fai
 pHdrTPPJyeH13yrNefpzNczP91RVLOzKyQSZ9umLQETvpy/IVWzCbrnplfJduZ1+9bfqTM9qX
 KPdO+XxHClqE9re+VL5gvKG2LN73/62johNAlXg5b8jUsb9VyKbEUZyQaajEXFScCAFXsPLpE
 AwAA
X-Env-Sender: liaohj.jy@fujitsu.com
X-Msg-Ref: server-12.tower-548.messagelabs.com!1660636634!92089!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1227 invoked from network); 16 Aug 2022 07:57:15 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-12.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Aug 2022 07:57:15 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id B561A1000CC
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:57:14 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A6DFB1000C2
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:57:14 +0100 (BST)
Received: from rhel-server--7.5 (10.167.215.42) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 16 Aug 2022 08:57:13 +0100
From: Liao Huangjie <liaohj.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 16 Aug 2022 15:57:02 +0800
Message-ID: <1660636622-5252-1-git-send-email-liaohj.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.42]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/openat01: Convert into new api
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
 testcases/kernel/syscalls/openat/openat01.c | 145 ++++++++++------------------
 1 file changed, 51 insertions(+), 94 deletions(-)

diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index daed419..25b3f83 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -1,55 +1,30 @@
-/******************************************************************************
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. ALL Rights Reserved.
+ * Author: Huangjie Liao <liaohj.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
  *
- * Copyright (c) International Business Machines  Corp., 2006
- *  Author: Yi Yang <yyangcdl@cn.ibm.com>
- * Copyright (c) Cyril Hrubis 2014 <chrubis@suse.cz>
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * DESCRIPTION
- *  This test case will verify basic function of openat
- *  added by kernel 2.6.16 or up.
- *
- *****************************************************************************/
-
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
+#include "tst_safe_macros.h"
 
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
@@ -65,80 +40,62 @@ static struct test_case {
 	{&fd_atcwd, TEST_DIR TEST_FILE, 0, 0}
 };
 
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void verify_openat(struct test_case *test)
+static void verify_openat(unsigned int n)
 {
-	TEST(openat(*test->dir_fd, test->pathname, O_RDWR, 0600));
-
-	if ((test->exp_ret == -1 && TEST_RETURN != -1) ||
-	    (test->exp_ret == 0 && TEST_RETURN < 0)) {
-		tst_resm(TFAIL | TTERRNO,
-		         "openat() returned %ldl, expected %d",
-			 TEST_RETURN, test->exp_ret);
+	struct test_case *tc = &test_cases[n];
+
+	TEST(openat(*tc->dir_fd, tc->pathname, O_RDWR, 0600));
+	
+	if ((tc->exp_ret == -1 && TST_RET != -1) ||
+	    (tc->exp_ret == 0 && TST_RET < 0)) {
+		tst_res(TFAIL | TTERRNO,
+		         "openat() returned %ld, expected %d",
+			 TST_RET, tc->exp_ret);
 		return;
 	}
+	
+	if (TST_RET > 0)
+		SAFE_CLOSE(TST_RET);
 
-	if (TEST_RETURN > 0)
-		SAFE_CLOSE(cleanup, TEST_RETURN);
-
-	if (TEST_ERRNO != test->exp_errno) {
-		tst_resm(TFAIL | TTERRNO,
+	if (TST_ERR != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
 		         "openat() returned wrong errno, expected %s(%d)",
-			 tst_strerrno(test->exp_errno), test->exp_errno);
+			 tst_strerrno(tc->exp_errno), tc->exp_errno);
 		return;
 	}
 
-	tst_resm(TPASS | TTERRNO, "openat() returned %ld", TEST_RETURN);
-}
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
-
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_openat(test_cases + i);
-	}
-
-	cleanup();
-	tst_exit();
+	if (tc->exp_ret)
+		tst_res(TPASS | TTERRNO, "openat failed as expected");
+	else
+		tst_res(TPASS, "openat succeeded as expected");
 }
 
 static void setup(void)
 {
 	char *tmpdir;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
-	dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
-	fd = SAFE_OPEN(cleanup, TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
+	SAFE_MKDIR(TEST_DIR, 0700);
+	dir_fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	fd = SAFE_OPEN(TEST_DIR TEST_FILE, O_CREAT | O_RDWR, 0600);
 
 	tmpdir = tst_get_tmpdir();
 	snprintf(glob_path, sizeof(glob_path), "%s/" TEST_DIR TEST_FILE,
-	         tmpdir);
+				tmpdir);
 	free(tmpdir);
-
-	TEST_PAUSE;
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

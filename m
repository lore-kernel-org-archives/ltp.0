Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B2C433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:06:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A49861151
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A49861151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1274D3C6E86
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 10:06:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EFBE3C6F1D
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:05:58 +0200 (CEST)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C032C1000672
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:05:56 +0200 (CEST)
X-QQ-mid: bizesmtp31t1635494751tkgff3km
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 29 Oct 2021 16:05:49 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: ec8fk5hwdl7Gn6IAoV6fTr9LkRL3E4Hc+aP/bnjVsujh8xNXyAx6FFP3A/2nO
 ru5N86tp+jaIQJ50RBAvHLb5enjjD7UB1VT0KV8gmTwWvAOq+1hykUB4RZVOjOz4lNZ4asy
 JcxlA0v7b4DnauovPqvi3uBwkGxU1rpF/GGC6BJdn6d80rO+N41+c1FnQ+rKC4fCF33Wn/n
 Ip45K1KFVokDIRPN1dM7gmujltEQo39psfKsxOxg+B3HU4OP5faw7R+brlekQueU7ew6+Wm
 wa2WImIdFE9Qk8n55khvYrdcWdS8B8CO3o1RcURzeGyk+6xFK/1n+2C8rA9QbP2HQl4u2+/
 ZwrPJdO/XQwUqKjOhw8KNsXIAsP9cB4mIHUISps
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 29 Oct 2021 16:05:27 +0800
Message-Id: <20211029080527.28014-4-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211029080527.28014-1-tangmeng@uniontech.com>
References: <20211029080527.28014-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] link/link07: Convert to new API
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
 testcases/kernel/syscalls/link/link07.c | 104 +++++-------------------
 1 file changed, 20 insertions(+), 84 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link07.c b/testcases/kernel/syscalls/link/link07.c
index 09743b59c..e166fe6e8 100644
--- a/testcases/kernel/syscalls/link/link07.c
+++ b/testcases/kernel/syscalls/link/link07.c
@@ -1,42 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) Bull S.A. 2001
  * Copyright (c) International Business Machines  Corp., 2001
  *  06/2002 Ported by Jacky Malcles
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
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
 
-/*
+/*\
+ * [Description]
+ *
  * Verify that, link() fails with -1 and sets errno to EACCES when one of the
  * directories in oldpath or newpath did not allow search (execute) permission.
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define MODE_TO S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IXOTH|S_IROTH|S_IWOTH
 #define MODE_TE S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH
@@ -45,74 +23,32 @@
 #define TEST_FILE2      "testdir_1/tfile_2"
 #define NEW_TEST_FILE2  "testdir_1/new_tfile_2"
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "link07";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_link(void)
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
-		TEST(link(TEST_FILE2, NEW_TEST_FILE2));
-
-		/* Check return code from link(2) */
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL | TTERRNO, "link() returned %ld, "
-				 "expected -1, errno=%d", TEST_RETURN, EACCES);
-		} else {
-			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS | TTERRNO,
-				         "link() fails with expected error");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "link() failed"
-				         ", expected errno=%d (EACCES)",
-				         EACCES);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(link(TEST_FILE2, NEW_TEST_FILE2), EACCES,
+			"link(%s, %s)", TEST_FILE2, NEW_TEST_FILE2);
 }
 
 static void setup(void)
 {
 	struct passwd *nobody_pwd;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	/* Modify mode permissions on test directory */
-	SAFE_CHMOD(cleanup, ".", MODE_TO);
+	SAFE_CHMOD(".", MODE_TO);
 
-	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	SAFE_TOUCH(cleanup, TEST_FILE2, 0666, NULL);
+	SAFE_MKDIR(DIR_TEMP, MODE_RWX);
+	SAFE_TOUCH(TEST_FILE2, 0666, NULL);
 
 	/* Modify mode permissions on test directory - test conditions */
-	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_TE);
+	SAFE_CHMOD(DIR_TEMP, MODE_TE);
 
-	nobody_pwd = SAFE_GETPWNAM(cleanup, "nobody");
-	SAFE_SETEUID(cleanup, nobody_pwd->pw_uid);
+	nobody_pwd = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(nobody_pwd->pw_uid);
 }
 
-static void cleanup(void)
-{
-	if (seteuid(0))
-		tst_resm(TWARN | TERRNO, "seteuid(o) failed");
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test_all = verify_link,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

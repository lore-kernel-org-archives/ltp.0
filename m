Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A6BC433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:06:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27F361151
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E27F361151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6864E3C6F14
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 10:06:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E4433C6F26
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:05:55 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 486BB140B9A5
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:05:53 +0200 (CEST)
X-QQ-mid: bizesmtp31t1635494748tqfm0o37
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 29 Oct 2021 16:05:46 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: jfdGVjI73+Qj1ntqPp5GmG91TzzAmnxGwjsDOjah6CUQ8Fxa99u5erd6ZcFnO
 hW9cTRdOylz7jz78/HRWUD/lSmUUd5kdhCE5y7awTsPc+tvqX2EwkqJlVqCU76FH9eoqG0Z
 aA7c/YegAISjcN8zGTDhdP8vyCbRKheXcx7DAs88LSCFvMbhaMvlbck2n5h2Rnj3vfctuyx
 Qj7m1gma9Xy8McZeP6IX9kDhkLhXNgE//SDteFzgPBBCIC2VAY4BNp2VcbZL+UWlkwFOc1/
 FTRm5Yh15e+MBpbY2YhQy2T9YZp+Q92ri4FE3wNjL8GZgrhhcEVoVRTIbLG0WC7Y3/uJ55C
 oX58iaWgv5m1wqxz2jJqBue6UBc4hikkhDulcR5
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 29 Oct 2021 16:05:26 +0800
Message-Id: <20211029080527.28014-3-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211029080527.28014-1-tangmeng@uniontech.com>
References: <20211029080527.28014-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] link/link06: Convert to new API
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
 testcases/kernel/syscalls/link/link06.c | 99 +++++--------------------
 1 file changed, 17 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link06.c b/testcases/kernel/syscalls/link/link06.c
index 17b38ad43..305a5417c 100644
--- a/testcases/kernel/syscalls/link/link06.c
+++ b/testcases/kernel/syscalls/link/link06.c
@@ -1,113 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) Bull S.A. 2001
  * Copyright (c) International Business Machines  Corp., 2001
  * 06/2002 Ported by Jacky Malcles
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
  * Verify that, link() fails with -1 and sets errno to EACCES when Write access
  * to the directory containing newpath is not allowed for the process's
  * effective uid.
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
 
 #define NOBODY_USER	99
 #define MODE_TO S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IXOTH|S_IROTH
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "link06";
-int TST_TOTAL = 1;
-
 #define OLDPATH "oldpath"
 #define NEWPATH "newpath"
 
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
-		TEST(link(OLDPATH, NEWPATH));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "link() returned %ld, "
-				 "expected -1, errno=%d", TEST_RETURN,
-				 EACCES);
-		} else {
-			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS, "link() fails with expected "
-					 "error EACCES errno:%d", TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "link() fails with "
-					 "errno=%d, expected errno=%d",
-					 TEST_ERRNO, EACCES);
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(link(OLDPATH, NEWPATH), EACCES);
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
 
-	SAFE_TOUCH(cleanup, OLDPATH, 0777, NULL);
-	nobody_pwd = SAFE_GETPWNAM(cleanup, "nobody");
-	SAFE_SETEUID(cleanup, nobody_pwd->pw_uid);
+	SAFE_TOUCH(OLDPATH, 0777, NULL);
+	nobody_pwd = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(nobody_pwd->pw_uid);
 }
 
-static void cleanup(void)
-{
-	if (seteuid(0))
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
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

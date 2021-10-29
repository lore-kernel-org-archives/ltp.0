Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00CEC433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:06:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1558610D2
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1558610D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A38473C6EEC
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 10:05:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C75C43C55EB
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:05:48 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 10667140B9A5
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:05:45 +0200 (CEST)
X-QQ-mid: bizesmtp31t1635494735t4msj9cb
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 29 Oct 2021 16:05:29 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: Tqag2bMK1HFBRhnO613AoXUeIhDOrCv1lRRMc9avFzF40BqGxamzxij65mGuw
 pKgMxAbOvdCWwXMtfpw0Qd2uMoE0qW2GbqGx7UFezXd80lhEZ0Uaj+MHL7snsjGdaTg9MYW
 SNBZoKluOYgKR4HhwVQuwQJrH5QAjxgFR7flF7Uk8qwzzlLYwbw7MwPY3aKFO0h9UeI2SzH
 kvf4plinOiIEFe53thaZAKN/SSIN8gAbtRZWKJ0MQgFVwmz4ZNOpxx16wDI9Jxmzkb3O3Qb
 22pZlL7UtyU7Q+i8Gr8R7dgXRWpy5mQpCNCfn0oYheTCUBR5HaIM2SbjtSURrTNxr/elMRo
 xQMt0r2kIENR8efZ1NSNkN/TOhvp92jGuOnkdqJ
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Fri, 29 Oct 2021 16:05:24 +0800
Message-Id: <20211029080527.28014-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] link/link04: Convert to new API
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
 testcases/kernel/syscalls/link/link04.c | 140 +++++-------------------
 1 file changed, 29 insertions(+), 111 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/syscalls/link/link04.c
index d9408845e..acc8a7134 100644
--- a/testcases/kernel/syscalls/link/link04.c
+++ b/testcases/kernel/syscalls/link/link04.c
@@ -1,65 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *  AUTHOR		: Richard Logan
  *  CO-PILOT		: William Roske
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
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
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Negative test cases for link(2).
  *
  * This test program should contain test cases where link will fail regardless
  * of who executed it (i.e. joe-user or root)
  */
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <sys/param.h>
 #include <sys/mman.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 static char longpath[PATH_MAX + 2];
 
-struct test_case_t {
+struct tcase_t {
 	char *file1;
 	char *desc1;
 	char *file2;
 	char *desc2;
 	int exp_errno;
-} test_cases[] = {
+} tcases[] = {
 	/* first path is invalid */
 	{"nonexistfile", "non-existent file", "nefile", "nefile", ENOENT},
 	{"", "path is empty string", "nefile", "nefile", ENOENT},
@@ -81,90 +48,41 @@ struct test_case_t {
 	{"regfile", "regfile", "regfile2", "regfile2", EEXIST},
 };
 
-char *TCID = "link04";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
+static unsigned int TST_TOTAL = ARRAY_SIZE(tcases);
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_link(void)
 {
-	int lc;
-	char *fname1, *fname2;
-	char *desc1, *desc2;
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
-			fname1 = test_cases[i].file1;
-			desc1 = test_cases[i].desc1;
-			fname2 = test_cases[i].file2;
-			desc2 = test_cases[i].desc2;
-
-			TEST(link(fname1, fname2));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == test_cases[i].exp_errno) {
-					tst_resm(TPASS | TTERRNO,
-						 "link(<%s>, <%s>)",
-						 desc1, desc2);
-				} else {
-					tst_resm(TFAIL | TTERRNO,
-						 "link(<%s>, <%s>) Failed "
-					         "expected errno: %d",
-						 desc1, desc2,
-						 test_cases[i].exp_errno);
-				}
-			} else {
-				tst_resm(TFAIL,
-					 "link(<%s>, <%s>) returned %ld, "
-				         "expected -1, errno:%d",
-					 desc1, desc2, TEST_RETURN,
-					 test_cases[i].exp_errno);
-			}
-		}
+	unsigned int i;
 
+	for (i = 0; i < TST_TOTAL; i++) {
+		TST_EXP_FAIL(link(tcases[i].file1, tcases[i].file2),
+				tcases[i].exp_errno, "link(<%s>, <%s>)",
+				tcases[i].desc1, tcases[i].desc2);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
 static void setup(void)
 {
-	int n;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	unsigned int i;
 
 	memset(longpath, 'a', PATH_MAX+1);
-	SAFE_TOUCH(cleanup, "regfile", 0777, NULL);
-	SAFE_TOUCH(cleanup, "regfile2", 0777, NULL);
-	SAFE_MKDIR(cleanup, "dir", 0777);
+	SAFE_TOUCH("regfile", 0777, NULL);
+	SAFE_TOUCH("regfile2", 0777, NULL);
+	SAFE_MKDIR("dir", 0777);
 
-	void *bad_addr = tst_get_bad_addr(cleanup);
+	void *bad_addr = tst_get_bad_addr(NULL);
 
-	for (n = 0; n < TST_TOTAL; n++) {
-		if (!test_cases[n].file1)
-			test_cases[n].file1 = bad_addr;
+	for (i = 0; i < TST_TOTAL; i++) {
+		if (!tcases[i].file1)
+			tcases[i].file1 = bad_addr;
 
-		if (!test_cases[n].file2)
-			test_cases[n].file2 = bad_addr;
+		if (!tcases[i].file2)
+			tcases[i].file2 = bad_addr;
 	}
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test_all = verify_link,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
-- 
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

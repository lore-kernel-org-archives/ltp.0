Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B0CC433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 23:26:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB616103C
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 23:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BB616103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E45AB3C72DD
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 00:26:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 139703C552C
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 00:26:22 +0100 (CET)
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A97A01A0088B
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 00:26:20 +0100 (CET)
X-QQ-mid: bizesmtp44t1635981974t13frbxc
Received: from localhost.localdomain (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 04 Nov 2021 07:26:12 +0800 (CST)
X-QQ-SSF: 0140000000000040C000B00A0000000
X-QQ-FEAT: YBQGNezXUizqbpHoBPfBltdQ6YyxsmUPKnxo/yvNZZk/AsSeoJ8ws08eTo/bW
 wmBWMNe9arD3fR1Pmif89YddiVWbxlXMbnY6KYEpdoHJD/wCxcwpFZO9KZW9g+pU88yGMZD
 KC265xazHBtJ2S3lGNMgUQab/41BTOjj0xK6Oq3MTdFRd91eiuACx3B0QBG5aZVV1ZQDXg/
 5+A8szNxUGSEV0/f5wb/Ie1DVMefhgiGUNfLK7+gfyPxinahiel0XWpLfqOxfV5q1n1/PY9
 4PedYqZRbfEzAbUESxh8Q2/JQMiPhGnXsnfHXY39E2VujzFr7I0W8+BUTdFexWAaUaf+/yq
 IKOAdHFYrh55Pf+5uepqSTqZHXkPw==
X-QQ-GoodBg: 2
From: tangmeng <tangmeng@uniontech.com>
To: ltp@lists.linux.it
Date: Thu,  4 Nov 2021 07:26:04 +0800
Message-Id: <20211103232604.7930-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211103232604.7930-1-tangmeng@uniontech.com>
References: <20211103232604.7930-1-tangmeng@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] link/link05: Convert to new API
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
 testcases/kernel/syscalls/link/link05.c | 159 ++++++------------------
 1 file changed, 37 insertions(+), 122 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index 5981ae62f..28d6079f5 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -1,161 +1,76 @@
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
  */
 
 /*
  * Test if link(2) fails with EMLINK.
  */
 
-#include <sys/types.h>
-#include <fcntl.h>
+#include <stdio.h>
 #include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-static void help(void);
-
-char *TCID = "link05";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #define BASENAME	"lkfile"
 
 static char fname[255];
 
-static char *links_arg;
-
-option_t options[] = {
-	{"N:", NULL, &links_arg},
-	{NULL, NULL, NULL}
-};
-
 static int nlinks = 1000;
 
-int main(int ac, char **av)
+static void verify_link(void)
 {
-	int lc;
 	struct stat fbuf, lbuf;
 	int cnt;
 	char lname[255];
 
-	tst_parse_opts(ac, av, options, &help);
-
-	if (links_arg) {
-		nlinks = atoi(links_arg);
-
-		if (nlinks == 0) {
-			tst_brkm(TBROK, NULL,
-			         "nlinks is not a positive number");
-		}
+	for (cnt = 1; cnt < nlinks; cnt++) {
+		sprintf(lname, "%s%d", fname, cnt);
+		TST_EXP_PASS(link(fname, lname), "link(%s, %s)", fname, lname);
 	}
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (cnt = 1; cnt < nlinks; cnt++) {
-			sprintf(lname, "%s%d", fname, cnt);
-			TEST(link(fname, lname));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL,
-					 "link(%s, %s) Failed, errno=%d : %s",
-					 fname, lname, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			}
-		}
-
-		SAFE_STAT(cleanup, fname, &fbuf);
+	SAFE_STAT(fname, &fbuf);
 
-		for (cnt = 1; cnt < nlinks; cnt++) {
-			sprintf(lname, "%s%d", fname, cnt);
+	for (cnt = 1; cnt < nlinks; cnt++) {
+		sprintf(lname, "%s%d", fname, cnt);
 
-			SAFE_STAT(cleanup, lname, &lbuf);
-			if (fbuf.st_nlink <= 1 || lbuf.st_nlink <= 1 ||
-			    (fbuf.st_nlink != lbuf.st_nlink)) {
+		SAFE_STAT(lname, &lbuf);
+		if (fbuf.st_nlink <= 1 || lbuf.st_nlink <= 1 ||
+		    (fbuf.st_nlink != lbuf.st_nlink)) {
 
-				tst_resm(TFAIL,
-					 "link(%s, %s[1-%d]) ret %ld for %d "
-				         "files, stat values do not match %d %d",
-					 fname, fname, nlinks,
-					 TEST_RETURN, nlinks,
-					 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
-				break;
-			}
-		}
-		if (cnt >= nlinks) {
-			tst_resm(TPASS,
-				 "link(%s, %s[1-%d]) ret %ld for %d files, "
-			         "stat linkcounts match %d",
-				 fname, fname, nlinks, TEST_RETURN,
-				 nlinks, (int)fbuf.st_nlink);
-		}
-
-		for (cnt = 1; cnt < nlinks; cnt++) {
-			sprintf(lname, "%s%d", fname, cnt);
-			SAFE_UNLINK(cleanup, lname);
+			tst_res(TFAIL,
+				 "link(%s, %s[1-%d]) ret %ld for %d "
+			         "files, stat values do not match %d %d",
+				 fname, fname, nlinks,
+				 TST_RET, nlinks,
+				 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
+			break;
 		}
 	}
+	if (cnt >= nlinks) {
+		tst_res(TPASS,
+			 "link(%s, %s[1-%d]) ret %ld for %d files, "
+		         "stat linkcounts match %d",
+			 fname, fname, nlinks, TST_RET,
+			 nlinks, (int)fbuf.st_nlink);
+	}
 
-	cleanup();
-	tst_exit();
-}
-
-static void help(void)
-{
-	printf("  -N #links : create #links hard links every iteration\n");
+	for (cnt = 1; cnt < nlinks; cnt++) {
+		sprintf(lname, "%s%d", fname, cnt);
+		SAFE_UNLINK(lname);
+	}
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	sprintf(fname, "%s_%d", BASENAME, getpid());
-	SAFE_TOUCH(cleanup, fname, 0700, NULL);
+	SAFE_TOUCH(fname, 0700, NULL);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+        .test_all = verify_link,
+        .setup = setup,
+        .needs_tmpdir = 1,
+};
-- 
2.20.1




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

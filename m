Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5FEC433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 10:50:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEF76108F
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 10:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DEF76108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40E863C8907
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 12:50:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EC403C8988
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 12:50:02 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBDDC200ADF
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 12:50:01 +0200 (CEST)
Received: by mail-pl1-x632.google.com with SMTP id n2so961783plk.12
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tq8MnR2JiEhfr3GfmoTahjAf7XJcIDqF0peRMVALiho=;
 b=LcC8318iStGRzStxPugem+s7Exk/ngzZf6ykmVIsg/0LR7i2Y/w3A94YoUobdnzS49
 dKIZemCIm40OPzxTWbhXD2o4aMLWrJYslWBhAKcMRIpXNKlHOXPE0AdsnDa0B1Thev9m
 EP3FwbtzXup8YX24JM9pGy5cLNpaDcJ7JLHGK4Cv0tC809z6SnLMLOrN/ntK9sAol6z9
 xkPbjnJdxglED99JwdnmblhLTXpY1OK4G2rc4IYsXwbvPF4fq21EK0/GxmR3tdMbZGZu
 QE75UnJ0s437+vXEgqtC8IAGdfAiy/Bmb5Wyl/7FjqGJkr4G9n8YA691d/JYZ7ev427n
 cQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tq8MnR2JiEhfr3GfmoTahjAf7XJcIDqF0peRMVALiho=;
 b=a0lnpm2M+mGDlpdV4RTwxrYFsww3MQMzsPHVJtL9xgcWBg5Fg+g2K+WMvabGPx/cHW
 vfu3NpjW35SzukTfFdHwFEPLDpuGJYirWeViWs0wNo58NL213KSSDop/u9bjS4GXXl99
 E7YqK8niJgDGvLkn8wCaN01GelCXn7T6hVX5Owg+G+nAbPaX34OPtbl+Qj/mhG6ruuNb
 aWl5/+rNWeQwM36n+AIyeFZDWlUciyseBC7Ad7PJfqsx0LCALPDr2Jh9QNhahreLb6MV
 JNtT6IJYgu5g9t+M1RnO54gSPNnUHxpWypxn7hfsJrBQ6l6W4qndWkrtD8hqW5pEZt1Z
 R39Q==
X-Gm-Message-State: AOAM530qFTifqko0z/2o8rn3klUgBGu2DAFDcX42xD27Q/d+HM5lgNV+
 ocrFf5BDlz4YOqEIAYmI/9925dl2GjPMGYac
X-Google-Smtp-Source: ABdhPJwp5MpyTffBWHqVai7QRiWqRVb5LgLots9MxcGkK9p7QtWqe16g0pAGIKKRHLR6iJz26zrGCQ==
X-Received: by 2002:a17:90a:c982:: with SMTP id
 w2mr5397111pjt.30.1631789400511; 
 Thu, 16 Sep 2021 03:50:00 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id j6sm2831475pgh.17.2021.09.16.03.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 03:50:00 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 19:49:32 +0900
Message-ID: <20210916104933.33409-5-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916104933.33409-1-qi.fuli@fujitsu.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API
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
Cc: QI Fuli <qi.fuli@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210916104932.bx2w0ypDHn4gb5wScPYZe8EQtPtKUSOGCs6PMwMguCI@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup205.c | 166 ++++++++----------------
 1 file changed, 54 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index 0b324531f..0e2766d53 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -1,134 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ */
+
+/*\
+ * [Description]
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * Negative test for dup2() with max open file descriptors.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
 
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
->KEYS:  < dup2()
->WHAT:  < Does dup return -1 on the 21st file?
->HOW:   < Create up to _NFILE files and check for -1 return on the
-	< next attempt
-	< Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
->BUGS:  <
-======================================================================*/
-
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
+#include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
-#include "test.h"
-
-char *TCID = "dup205";
-int TST_TOTAL = 1;
-int *fildes;
-int min;
-int local_flag;
-
-#define PASSED 1
-#define FAILED 0
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char *av[])
-{
-	int ifile;
-	char pfilname[40];
-	int serrno;
-
-	int lc;
-
-	ifile = -1;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	local_flag = PASSED;
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		sprintf(pfilname, "./dup205.%d\n", getpid());
-		unlink(pfilname);
-		serrno = 0;
-		if ((fildes[0] = creat(pfilname, 0666)) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "creat failed");
-		else {
-			fildes[fildes[0]] = fildes[0];
-			for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
-				if ((fildes[ifile] = dup2(fildes[ifile - 1],
-							  ifile)) == -1) {
-					serrno = errno;
-					break;
-				} else {
-					if (fildes[ifile] != ifile) {
-						tst_brkm(TFAIL, cleanup,
-							 "got wrong descriptor "
-							 "number back (%d != %d)",
-							 fildes[ifile], ifile);
-					}
-				}
-			}	/* end for */
-			if (ifile < min) {
-				tst_resm(TFAIL, "Not enough files duped");
-				local_flag = FAILED;
-			} else if (ifile > min) {
-				tst_resm(TFAIL, "Too many files duped");
-				local_flag = FAILED;
-			}
-			if (serrno != EBADF && serrno != EMFILE &&
-			    serrno != EINVAL) {
-				tst_resm(TFAIL, "bad errno on dup2 failure");
-				local_flag = FAILED;
-			}
-		}
-		unlink(pfilname);
-		for (ifile = fildes[0]; ifile < min + 10; ifile++)
-			close(fildes[ifile]);
-		if (local_flag == PASSED) {
-			tst_resm(TPASS, "Test passed.");
-		} else {
-			tst_resm(TFAIL, "Test failed.");
-		}
-
-	}
-	cleanup();
-	tst_exit();
-}
+static int *fildes;
+static int min;
+static char pfilname[40];
 
 static void setup(void)
 {
-	tst_tmpdir();
-
 	min = getdtablesize();	/* get number of files allowed open */
-	fildes = malloc((min + 10) * sizeof(int));
-	if (fildes == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
+	fildes = SAFE_MALLOC((min + 10) * sizeof(int));
+
+	sprintf(pfilname, "./dup205.%d\n", getpid());
 }
 
 static void cleanup(void)
 {
 	if (fildes != NULL)
 		free(fildes);
-	tst_rmdir();
 }
+
+static void run(void)
+{
+	int ifile;
+
+	ifile = -1;
+
+	fildes[0] = SAFE_CREAT(pfilname, 0666);
+	fildes[fildes[0]] = fildes[0];
+	for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
+		TEST(dup2(fildes[ifile - 1], ifile));
+		if ((fildes[ifile] = TST_RET) == -1)
+			break;
+		if (fildes[ifile] != ifile)
+			tst_brk(TFAIL, "got wrong descriptor number back "
+				"(%d != %d)", fildes[ifile], ifile);
+	}	/* end for */
+
+	if (TST_ERR != EBADF)
+		tst_res(TFAIL, "bad errno on dup2 failure");
+
+	if (ifile < min)
+		tst_res(TFAIL, "Not enough files duped");
+	else if (ifile > min)
+		tst_res(TFAIL, "Too many files duped");
+	else
+		tst_res(TPASS, "Test passed.");
+
+	SAFE_CLOSE(fildes[0]);
+	SAFE_UNLINK(pfilname);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

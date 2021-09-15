Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A3AC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:53:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C71260BD3
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C71260BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22D343C9185
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 17:53:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8F0B3C9213
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:26 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 560A1601B12
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:26 +0200 (CEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 me5-20020a17090b17c500b0019af76b7bb4so4586256pjb.2
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t6AoAdu0KdE9XulZew8FFDPlK0tELoY1ntmnuWWSrGY=;
 b=jo2VSZZOOBZIz/BRo5fvRiKVCwLy1oa3MiB7T6fPoDl2YrFNUGyiBFUz0lyXST47Ih
 Q5PZEiPxw86WBRfY6IDx9nO1jqGc5q8xz7El9sPHUMTXUa7Anvc2mppepz3ozKsqG2h+
 ZT7RVEdirstth+c7nEfvLD20A/Yvz8m9cWDqHbpRGCT7BVDGNHUnQBO26XJ9Xk6jqss4
 CQtbix97Mg+LGOeseZj3YQONJVqhiRJhnuVp2uxYZx0XVSjkPVBzSNi2C8aZIkYsnuSA
 F9T6MD8G0dIwg4ydpW7n2R+fomaOBstjVwBk5q504OjFipmnI7SLPdXX5QBTYbMJUvM4
 kbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t6AoAdu0KdE9XulZew8FFDPlK0tELoY1ntmnuWWSrGY=;
 b=ktkcrrMp19o3yEpQYnoyqragRz6mf6fOoYViu+Kug02OZmaJdublxEimbF+02F7qoM
 vfbrXaKJ4TMH8p2DStA8nJJqt1cRUeS6dx6T5QS57cgpB3vK3GkYySa+baFAWRw+OKGd
 PR+7ta22RCTMCiFwGTC7BkPwYIWEDim9JBlUWGyt00PHPmDC//dWFXOt/VvIK0koZ1PC
 D3Hz8v7pxrv7uC3klmW8BDx/ndpBqIXo3yA6po/xGJ0g+f6xUzflh9kKYxPZby97OagC
 8fCP8cMhJLMyY54+xK4YjrcoRUXLHq8u/nem13TXZPSFgE0jNjYXU58Cz528zBuN2RaM
 8VWw==
X-Gm-Message-State: AOAM532f12PrwQZmFTc9hCGM9RSQ8Hg0O05Ubbb+H1t/pxDlYAsnDcjF
 uIK0zSjOv9OVLbnILohBCryN07oKtRx7U+DT
X-Google-Smtp-Source: ABdhPJwviaNSiKctHp5pQoZQKDC1wPhDSHuYqECwCuCeI+5sQ7QrU+8EpbWzUyNab+IJr6d2TRPsEw==
X-Received: by 2002:a17:903:234c:b0:13c:7a6e:4b43 with SMTP id
 c12-20020a170903234c00b0013c7a6e4b43mr455043plh.29.1631721144817; 
 Wed, 15 Sep 2021 08:52:24 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l14sm5452484pjq.13.2021.09.15.08.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 08:52:24 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 00:51:52 +0900
Message-ID: <20210915155152.8515-5-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915155152.8515-1-qi.fuli@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] syscalls/dup2/dup205: Convert to new API
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
Message-ID: <20210915155152.OdSFO96Ez2ym3uTfzoimpyHYjrSl6Rp4DkSAmRUHRtE@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup205.c | 167 ++++++++----------------
 1 file changed, 57 insertions(+), 110 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index 0b324531f..1f4796659 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -1,134 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
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
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-	local_flag = PASSED;
-
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
 
 static void setup(void)
 {
-	tst_tmpdir();
-
 	min = getdtablesize();	/* get number of files allowed open */
 	fildes = malloc((min + 10) * sizeof(int));
 	if (fildes == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
+		tst_brk(TBROK | TERRNO, "malloc error");
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
+	char pfilname[40];
+
+	ifile = -1;
+
+	sprintf(pfilname, "./dup205.%d\n", getpid());
+	unlink(pfilname);
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
+	unlink(pfilname);
+	for (ifile = fildes[0]; ifile < min + 10; ifile++)
+		close(fildes[ifile]);
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

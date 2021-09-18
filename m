Return-Path: <SRS0=tzzg=OI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA8C433FE
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778AE60F93
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 778AE60F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02A453C8811
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 09:27:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 020A63C9073
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:38 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB79360057A
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:37 +0200 (CEST)
Received: by mail-pl1-x62e.google.com with SMTP id t4so7725166plo.0
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KfupAYmoKwlpK58uH1oKbnkMEn9cUrpAZnL7xkoBbi8=;
 b=YiH9LwC2QwOoEEvxwv73tWrIsPDMroCcBoCvPOK8mAmrYOv3K3dsm8BnmHyxqeQsTL
 Huqz4eSQgi6WeLqXyy+LYCm0P8IUEdbg9QXOtxhFZVnIaDJgeVf55EywejlkyEWKrDC0
 3W5MTTPrclVMBJp6rpDRqUYYCcxAw+dM3HE3C8une/4ucheJGNMUi6JK0sydMK9nLGxk
 UWbVhWCYKA4G1Jz2jm6w+f0GGVYTy69z9EOkt/Mmy+25ZuRtekDtkQCTuarO1fnS6pj5
 WMBq0Crh/qqa1cX0jBQzZRY632K9fD521R273Ew31+ew+fQqnA/F/TCMgGzLYNa5ewes
 5X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KfupAYmoKwlpK58uH1oKbnkMEn9cUrpAZnL7xkoBbi8=;
 b=xYeCpEf2VQVntv9yjMroII5t84p4jF+Cvz+6CXeX3VBMAQrADS7QwChrdqjUhvT4zj
 3mZ6CTbx0KcRqKcZKJzFVRMhlkhLRbbZJMDZ3qM5mEJhDOoyr+IPinSHymEnXZNTk7Hp
 wb2MzUHy+OqmDpedpL73suR4iY+w88eAp09KvuNiTGIMNnH4l8+6ZxLaJuK9ZckIRfRk
 uMF/gkTSHg/mDbyoSTft5i61CZjJaGkFQxI/OVnXlXVp5Dli7RVzRMY95jYNTreDTWWu
 JviH7u1xX1HwYnGVF2AWdMTfuvYdXXE6tpLiX6Jtilhr0i9k6jU7cZGZVv4DSkPbpZPI
 SHLA==
X-Gm-Message-State: AOAM530HvwN/xQFAi2ETKj+lJvm/zIAxb2anTW7RzDhvOdZ3YLXH1sP9
 idhxlIDqf17ZC0zTtdxbbPRosMxx9MwU3jDL
X-Google-Smtp-Source: ABdhPJyuG45zyvkgEQV/Foqjel+wAoWC7ELBb4JmK5zWmMq3MUJ+pcsD9HVJ3yBG4pc9FZsIt2XcWw==
X-Received: by 2002:a17:903:230b:b0:13b:a0ec:1136 with SMTP id
 d11-20020a170903230b00b0013ba0ec1136mr13275213plh.63.1631949996176; 
 Sat, 18 Sep 2021 00:26:36 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id 4sm7334159pjb.21.2021.09.18.00.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 00:26:35 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat, 18 Sep 2021 16:26:08 +0900
Message-ID: <20210918072609.8576-5-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918072609.8576-1-qi.fuli@fujitsu.com>
References: <20210918072609.8576-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/5] syscalls/dup2/dup205: Convert to new API
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
Message-ID: <20210918072608.v2vej4KNcmNZSx2ABGJoZ1ewYyuWphqTgUrvJKbjCEk@z>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup205.c | 168 ++++++++----------------
 1 file changed, 52 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index 0b324531f..9942e63a7 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -1,134 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
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
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang
  */
 
-/* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
-
-/*======================================================================
-	=================== TESTPLAN SEGMENT ===================
->KEYS:  < dup2()
->WHAT:  < Does dup return -1 on the 21st file?
->HOW:   < Create up to _NFILE files and check for -1 return on the
-	< next attempt
-	< Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
->BUGS:  <
-======================================================================*/
+/*\
+ * [Description]
+ * Negative test for dup2() with max open file descriptors.
+ */
 
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
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
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
+	int ifile = -1;
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
+	}
+
+	if (TST_ERR != EBADF && TST_ERR != EMFILE && TST_ERR != EINVAL)
+		tst_res(TFAIL, "bad errno on dup2 failure");
+
+	if (ifile < min)
+		tst_res(TFAIL, "Not enough files duped");
+	else if (ifile > min)
+		tst_res(TFAIL, "Too many files duped");
+	else
+		tst_res(TPASS, "Test passed.");
+
+	SAFE_UNLINK(pfilname);
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

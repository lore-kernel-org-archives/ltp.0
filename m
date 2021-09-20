Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60BC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:38:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6378560FF2
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6378560FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4A6A3C207C
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:38:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D06F23C2DB2
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:32 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C7901A0069C
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:31 +0200 (CEST)
Received: by mail-pj1-x102e.google.com with SMTP id
 nn5-20020a17090b38c500b0019af1c4b31fso11631444pjb.3
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 20:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n2QTp+lzQ3hv3mA8hPimA9uJDaQPOcOuc7Gyq/kxKCU=;
 b=AtNk/iepBo4qrYhljbWppYoRucAV7wg5TRoLijQDuhsaeXkXJv8RNJGRIuD7ngQh2l
 iW6WB2+jIiC6aLArH5e23QgQEvbISagxnuTa3RWj+rvHOmt/E/xJou9Ep0r6Lcjv5oQ2
 sJKDeziQ4X/VSFoqvUJyLhGOkSMOECH47TH2IPJUmk7hrm1AwVv6rKAadXcX/fN7h+xh
 WhTZgs56SR4LGdnPSCamNawr0fpsm9sh6Xg+NoCpUTJq4VLV4JRnJcV6GeL1oTKLcKeI
 4KOaa9OkcH+CndwCZCAOPZC0FN0CcGa58zWoMsaeiTu5PSGCTLDiQGLtkn35G46cCvYk
 dYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n2QTp+lzQ3hv3mA8hPimA9uJDaQPOcOuc7Gyq/kxKCU=;
 b=ZtjHlUc+WLvCR2sDU8xCVR3D/rrzpzO1ATuYNkaNiGYzRt29sTAa6+23Pesj2VvGOQ
 9PMUdhzG9o/liNJFLfRboPgfhy44XLXV4HXzcDXwIsJRYv0ngfXKFl5e8b8GyO9GOMx2
 Mg8EkbLCLtT7I2hWQSqUyWO7k98xJZJb4UcIa9N71nhmAwauoAvfDlYDNkKM+UZf3XYH
 Lpdcfey75fxRshsGby7gTDpRGI+2N4AaCybz93cEMlw5NiJGWGEaGAnwgXftkBEe+w3W
 9pSKsax5PQ4mi1B0mxekmhZbP/GsdFNfkRm/RcU8TJ/wgJXAolKfhfsgd/aOQTva2xHL
 X+Aw==
X-Gm-Message-State: AOAM532pyr1nUrEuq84PcmxHRxhKilfLEtecNg0xzPs7v+C9c2KDx+8P
 C8IWvQ9T+EPneE3HtxVMQkSLfUJAdyS0TQ==
X-Google-Smtp-Source: ABdhPJyxUMM2KAdcB4SAC3PMRUcq7B8/C2eCJQOtC9bbDbMgS55GAcA06Gs1kCZt3KyqWgYtalCjDA==
X-Received: by 2002:a17:902:be0f:b0:13a:95e:a51 with SMTP id
 r15-20020a170902be0f00b0013a095e0a51mr20829051pls.44.1632109049945; 
 Sun, 19 Sep 2021 20:37:29 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id v25sm11932301pfm.202.2021.09.19.20.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Sep 2021 20:37:29 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 20 Sep 2021 12:37:05 +0900
Message-Id: <20210920033705.20544-6-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920033705.20544-1-qi.fuli@fujitsu.com>
References: <20210920033705.20544-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 5/5] syscalls/dup2/dup205: Convert to new API
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

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup205.c | 178 +++++++++---------------
 1 file changed, 62 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index 0b324531f..cd4254375 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -1,134 +1,80 @@
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
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
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
+	memset(fildes, -1, (min + 10) * sizeof(int));
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
+	int ifile = -1, rc = 0;
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
+	if (ifile < min) {
+		tst_res(TFAIL, "Not enough files duped");
+		rc++;
+	} else if (ifile > min) {
+		tst_res(TFAIL, "Too many files duped");
+		rc++;
+	}
+	if (TST_ERR != EBADF && TST_ERR != EMFILE && TST_ERR != EINVAL) {
+		tst_res(TFAIL, "bad errno on dup2 failure");
+		rc++;
+	}
+
+	if (rc)
+		tst_res(TFAIL, "Test failed");
+	else
+		tst_res(TPASS, "Test passed");
+
+	SAFE_UNLINK(pfilname);
+	for (ifile = fildes[0]; ifile < min + 10; ifile++) {
+		if (fildes[ifile] > 0)
+			SAFE_CLOSE(fildes[ifile]);
+	}
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

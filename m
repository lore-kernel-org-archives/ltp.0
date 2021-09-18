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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0614C433F5
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 12:12:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2A26127A
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 12:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D2A26127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC9E63C8814
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 14:12:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 967553C8821
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 14:11:48 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A07351A0021E
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 14:11:47 +0200 (CEST)
Received: by mail-pj1-x1029.google.com with SMTP id
 on12-20020a17090b1d0c00b001997c60aa29so9592772pjb.1
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KIHQobkQvIdvwGmOe8pUygpz+BPP7oD8nP+AaiFm+fc=;
 b=iXufvFrPjvwW2V7n0vh6A921HjRNwKi4rGQ9/nfl40dr2MDNeXt8DCq6WiMoFkM2L4
 UrqGYojhI8lBRfEZ77TCsAGCQDJLnPES7lB94EXqMm6Dd2jtl44Hbu+EBqRBqxy8hvra
 CACBsqSrm8dEX8Xm38MRKPGcLTW3YBAQJHkTebb5/qL7C9mHxMsp9c2rA+BqhWi5IbzM
 8yu+mlHCgYvpFTXgohQCXt1sZ+dfRa2KN4jfa4UuZpfSgSkgRapj21ILAT0WxlgevkGZ
 PY9a4bAvMjGQ7VREZlSBE/3n2eskLA/OMF11bb++kqVKYPF5KsyNCDRAI50u/Om5fkrI
 /CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KIHQobkQvIdvwGmOe8pUygpz+BPP7oD8nP+AaiFm+fc=;
 b=sm0q53RmcRJHsmUrXHaTZ1OXz50i+pPiR+V1V0sJlM4ycTXxkdk2N0e/uz0Icnd2qX
 BVJp44HqLqSHsKcL1lRlF6BO7R3UvCgbmL4YeOhjfzNhPa3G+zE9EkiAibtkbWighzIX
 h0E3g7VRhFJ24etL3pUYdDH0n9A1lQSkyEEy1G3tLiwNvaZRsNlxQ8sjyRUPBxgFyIII
 aGuU3Z3HATck0GXi97VvKb9ty3UJTQ2+AezrHu/YtuJ0wJ69l023jR2jlACQa+3yHcxs
 cNOAJ0S85TAwm5B16IE3Ec5ThbE4M9UPP8bEZkzpc/khnOEedhWiGM6O2dT4jKarc1+V
 c9OA==
X-Gm-Message-State: AOAM532KiAk3qk68GxX30fNgSj3bsOsD+jb8FpqV55c341/QJhsIoydQ
 av/Ky10U7tLKI4iHHxBzSBz3OpLcGak70+TN
X-Google-Smtp-Source: ABdhPJxInjVRHJoRuFcaq4f4/ObIMWuGDQY8ZryuF/PBJ8ruCtAvqxAAueDMSsr93Z2ZOWLnw4OwaQ==
X-Received: by 2002:a17:90a:8b8e:: with SMTP id
 z14mr26307597pjn.127.1631967106116; 
 Sat, 18 Sep 2021 05:11:46 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id g13sm9255556pfi.176.2021.09.18.05.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 05:11:45 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat, 18 Sep 2021 21:11:13 +0900
Message-ID: <20210918121114.10694-5-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918121114.10694-1-qi.fuli@fujitsu.com>
References: <20210918121114.10694-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/5] syscalls/dup2/dup205: Convert to new API
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
Message-ID: <20210918121113.W70sHAeALdJX5pPeJI1E8uDPEqsmbkvjEv_yzqk9ei4@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup205.c | 171 ++++++++----------------
 1 file changed, 55 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index 0b324531f..e6fc175c3 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -1,134 +1,73 @@
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
+	if (TST_ERR != EBADF && TST_ERR != EMFILE && TST_ERR != EINVAL) {
+		tst_res(TFAIL, "bad errno on dup2 failure");
+		goto close;
+	}
+
+	if (ifile < min)
+		tst_res(TFAIL, "Not enough files duped");
+	else if (ifile > min)
+		tst_res(TFAIL, "Too many files duped");
+	else
+		tst_res(TPASS, "Test passed.");
+
+close:
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

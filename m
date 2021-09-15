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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BCC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD37C61157
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD37C61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55A313C89AF
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 17:52:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8ED93C9205
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:24 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C9A1601BCC
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:24 +0200 (CEST)
Received: by mail-pg1-x532.google.com with SMTP id f129so3160963pgc.1
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/8JNuYFP98FpAzv5nBPwtdWIIzq96lyAl8TpeiB9zyg=;
 b=qMgKHQKcP4yUqfiTmTJP39kMPMAyIPjjOLd06snDyGATKOAKbYPlj+wrSjQLhEV+2T
 eD/Ku0yVTLS1kaynMwqANRYLni/9U+fMGaRX/xRnnHMJiQ7JTRSXrthswq5BWZaBfbGs
 EgW98Ua+fY6v72AnFneOE5SitUfbJMxDSMdUSOikcWac/bXH4qIeTBSyeGmge2cHM8QD
 m2midMPWIQ+PE7HW6oJVYVb9el39ps+eL3NCGNivgdmiJzPAzt4oYsnjOndeoOod4SvJ
 g1duHuGCoH5Ak+778k4FDqROgtNxR6nTQE7EL+eojIhmvk5f3p1DxkXwMfX2F4F7WPIh
 OaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/8JNuYFP98FpAzv5nBPwtdWIIzq96lyAl8TpeiB9zyg=;
 b=epjsqfmSxjH23O8vvBAaDZMcqk3siorQjs6zJPTOOpAGk07/9fZzTpX2Z1eQlfX7lR
 KFa6rB1pnD37vtcEZZ1Yu2+Br53jMC8ZKqOApyn/IqPrkzkJxUVj8mkN8BtCeKqvEBtC
 FnKF57uBhn+7Bt327kB7HBeaPMalFasTHhUkiSFGWKM0uLlLXNvlFI2/mIu4P6WLBCEp
 cb52OvnLL38f1P48AfJMNMqCZiK5+yC77HbPozm5ampXIjJ6ttqdgaBizdF6gftc30Kr
 tGdtQsPn9/f+8u6xuOzP2cheXdlkebw9yZ3bdRMutdAzpk7tIaVSatnpOlXmUIqxzwgf
 O+/Q==
X-Gm-Message-State: AOAM530gwXpIkgQlf5ThHfRlmjm5dQabUNJcv88W0gWdnKOVHVPyC8bR
 ntMN6Sus6QAk/z8Bu/cIZ7EyPitVCjPspJud
X-Google-Smtp-Source: ABdhPJxph8udBA6XhE1n3pj1ToPos2AnQY9drc7l3ygplbuloQELKEZSpyKMg7okSWjKOHHUj/UIrA==
X-Received: by 2002:a62:2703:0:b0:42b:5319:cbbc with SMTP id
 n3-20020a622703000000b0042b5319cbbcmr598061pfn.66.1631721142527; 
 Wed, 15 Sep 2021 08:52:22 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l14sm5452484pjq.13.2021.09.15.08.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 08:52:22 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 00:51:51 +0900
Message-ID: <20210915155152.8515-4-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915155152.8515-1-qi.fuli@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] syscalls/dup2/dup203: Convert to new API
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
Message-ID: <20210915155151.MFzW06T5bvMJaDsPefg4UMXl7FcrSCVfdThFyCPolYo@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup203.c | 282 +++++++++---------------
 1 file changed, 101 insertions(+), 181 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index e6f281adf..a840f4638 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -1,208 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
+ * Copyright (c) International Business Machines  Corp., 2001
  */
 
-/*
- * NAME
- *	dup203.c
- *
- * DESCRIPTION
+/*\
+ * [Description]
  *	Testcase to check the basic functionality of dup2().
- *
- * ALGORITHM
- *	1.	Attempt to dup2() on an open file descriptor.
- *	2.	Attempt to dup2() on a close file descriptor.
- *
- * USAGE:  <for command-line>
- *  dup203 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
+ *	1. Attempt to dup2() on an open file descriptor.
+ *	2. Attempt to dup2() on a close file descriptor.
  */
 
-#include <fcntl.h>
-#include <sys/param.h>
 #include <errno.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+static int fd0, fd1, fd2, rval;
+static char filename0[40], filename1[40];
+static char buf[40];
+
+static void verify_open(void);
+static void verify_close(void);
+
+static struct tcase {
+	char *desc;
+	void (*verify)();
+} tcases [] = {
+	{"Test duping over an open fd", verify_open},
+	{"Test close on exec flag", verify_close},
+};
+
+static void verify_open(void)
+{
+	sprintf(filename0, "dup203.file0.%d\n", getpid());
+	sprintf(filename1, "dup203.file1.%d\n", getpid());
+	unlink(filename0);
+	unlink(filename1);
+
+	fd0 = SAFE_CREAT(filename0, 0666);
+	SAFE_WRITE(1, fd0, filename0, strlen(filename0));
+	SAFE_CLOSE(fd0);
+
+	fd1 = SAFE_CREAT(filename1, 0666);
+	SAFE_WRITE(1, fd1, filename1, strlen(filename1));
+	SAFE_CLOSE(fd1);
+
+	fd0 = SAFE_OPEN(filename0, O_RDONLY);
+	fd1 = SAFE_OPEN(filename1, O_RDONLY);
+
+	TEST(dup2(fd0, fd1));
+
+	if ((fd2 = TST_RET) == -1)
+		tst_res(TFAIL, "call failed unexpectedly");
+	else {
+		if (fd1 != fd2) {
+			tst_res(TFAIL, "file descriptors don't match");
+			return;
+		}
 
-void setup(void);
-void cleanup(void);
+		memset(buf, 0, sizeof(buf));
+		SAFE_READ(0, fd2, buf, sizeof(buf));
+		if (strcmp(buf, filename0) != 0)
+			tst_res(TFAIL, "read from file got bad data");
+		tst_res(TPASS, "dup2 test 1 functionality is correct");
+	}
 
-char *TCID = "dup203";
-int TST_TOTAL = 1;
+	SAFE_CLOSE(fd0);
+	SAFE_CLOSE(fd1);
+	close(fd2);
+}
 
-int main(int ac, char **av)
+static void verify_close(void)
 {
-	int fd0, fd1, fd2, rval;
-	char filename0[40], filename1[40];
-	char buf[40];
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-//block1:
-		tst_resm(TINFO, "Enter block 1");
-		tst_resm(TINFO, "Test duping over an open fd");
-
-		sprintf(filename0, "dup202.file0.%d\n", getpid());
-		sprintf(filename1, "dup202.file1.%d\n", getpid());
-		unlink(filename0);
-		unlink(filename1);
-
-		if ((fd0 = creat(filename0, 0666)) == -1)
-			tst_brkm(TBROK, cleanup, "cannot create first file");
-		if (write(fd0, filename0, strlen(filename0)) == -1)
-			tst_brkm(TBROK, cleanup, "filename0: write(2) failed");
-
-		if ((fd1 = creat(filename1, 0666)) == -1)
-			tst_brkm(TBROK, cleanup, "Cannot create second file");
-		if (write(fd1, filename1, strlen(filename1)) == -1)
-			tst_brkm(TBROK, cleanup, "filename1: write(2) failed");
-
-		SAFE_CLOSE(cleanup, fd0);
-		if ((fd0 = open(filename0, O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open(2) on filename0 failed");
-
-		SAFE_CLOSE(cleanup, fd1);
-		if ((fd1 = open(filename1, O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open(2) on filename1 failed");
-
-		TEST(dup2(fd0, fd1));
-
-		if ((fd2 = TEST_RETURN) == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly");
-		} else {
-			if (fd1 != fd2) {
-				tst_resm(TFAIL, "file descriptors don't match");
-				break;
-			}
-
-			memset(buf, 0, sizeof(buf));
-			if (read(fd2, buf, sizeof(buf)) == -1)
-				tst_brkm(TBROK, cleanup, "read(2) failed");
-			if (strcmp(buf, filename0) != 0)
-				tst_resm(TFAIL, "read from file got bad data");
-			tst_resm(TPASS, "dup2 test 1 functionality is correct");
-		}
-
-		close(fd0);
-		close(fd1);
-		close(fd2);
-		unlink(filename0);
-		unlink(filename1);
+	sprintf(filename0, "dup203.%d\n", getpid());
+	unlink(filename0);
 
-		tst_resm(TINFO, "Exit block 1");
+	fd0 = SAFE_CREAT(filename0, 0666);
+	SAFE_FCNTL(fd0, F_SETFD, 1);
 
-//block2:
-		tst_resm(TINFO, "Enter block 2");
-		tst_resm(TINFO, "Test close on exec flag");
+	fd2 = SAFE_CREAT(filename1, 0666);
 
-		sprintf(filename0, "dup02.%d\n", getpid());
-		unlink(filename0);
+	/* SAFE_CLOSE() sets the fd to -1 avoid it here */
+	rval = fd2;
+	SAFE_CLOSE(rval);
 
-		if ((fd0 = creat(filename0, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create first file");
-		}
-		if (fcntl(fd0, F_SETFD, 1) == -1) {
-			tst_brkm(TBROK, cleanup, "setting close on exec flag "
-				 "on fd0 failed");
-		}
+	TEST(dup2(fd0, fd2));
 
-		if ((fd2 = creat(filename1, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create second file");
+	if ((fd1 = TST_RET) == -1)
+		tst_res(TFAIL, "call failed unexpectedly");
+	else {
+		if (fd1 != fd2) {
+			tst_res(TFAIL, "bad dup2 descriptor %d", fd1);
+			return;
 		}
-
-		/* SAFE_CLOSE() sets the fd to -1 avoid it here */
-		rval = fd2;
-		SAFE_CLOSE(cleanup, rval);
-
-		TEST(dup2(fd0, fd2));
-
-		if ((fd1 = TEST_RETURN) == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly");
-		} else {
-			if (fd1 != fd2) {
-				tst_resm(TFAIL, "bad dup2 descriptor %d", fd1);
-				break;
-			}
-
-			if ((rval = fcntl(fd1, F_GETFD, 0)) != 0) {
-				tst_resm(TBROK | TERRNO,
-					 "fcntl F_GETFD on fd1 failed; expected a "
-					 "return value of 0x0, got %#x", rval);
-				break;
-			}
-			if ((rval = (fcntl(fd0, F_GETFL, 0) & O_ACCMODE)) !=
-			    O_WRONLY) {
-				tst_resm(TFAIL, "fctnl F_GETFL bad rval on fd0 "
-					 "Expected %#x got %#x", O_WRONLY,
-					 rval);
-			}
-			tst_resm(TPASS, "dup2 test 2 functionality is correct");
+		rval = SAFE_FCNTL(fd1, F_GETFD, 0);
+		if (rval != 0) {
+			tst_res(TFAIL | TERRNO,
+				"fcntl F_GETFD on fd1 failed; expected a "
+				"return value of 0x0, got %#x", rval);
+			return;
 		}
-
-		close(fd0);
-		close(fd1);
-
-		unlink(filename0);
-		unlink(filename1);
-		tst_resm(TINFO, "Exit block 2");
+		rval = SAFE_FCNTL(fd0, F_GETFD, 0);
+		if ((rval & O_ACCMODE) != O_WRONLY)
+			tst_res(TFAIL, "fctnl F_GETFL bad rval on fd0 "
+				"Expected %#x got %#x", O_WRONLY, rval);
+		tst_res(TPASS, "dup2 test 2 functionality is correct");
 	}
 
-	cleanup();
-	tst_exit();
+	SAFE_CLOSE(fd0);
+	SAFE_CLOSE(fd1);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(unsigned int i)
 {
+	struct tcase *tc = tcases + i;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_res(TINFO, tc->desc);
+	tc->verify();
 
-	TEST_PAUSE;
-
-	tst_tmpdir();
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.test = run,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

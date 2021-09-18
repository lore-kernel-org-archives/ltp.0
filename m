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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB51C433F5
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EF460F93
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1EF460F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D8663C8812
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 09:27:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4C5C3C9087
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:36 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 51C121400349
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:35 +0200 (CEST)
Received: by mail-pg1-x52a.google.com with SMTP id m21so2696697pgu.13
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VX63xWZ/eWKT1gWPJ+1lYRdYxclO0GQR+P/1jDDHskU=;
 b=B8qBuHRKt0yF/A5I8ixgxQ1vKbJZcUNMo98me7mMx22g5t+2AuKSlXv0LKg+hLfMW3
 DpEhto9tvYn3fDRvM9aWOl1ZPmqQLNu9iXZYsFGlTpmethIrJHG5KvEU0ZqNWAhGWeIH
 ptVqlB4UCHys/6uq2BZVe9jpYSjxx51Mf+1ARhZU/b3PYQlOlyP5wiGbMj9EwBjG5rxX
 XsLzBRC+pAWXYrMVCTUfDu8zxB2J823NstEGblpftoxffcQaZcx9uHUUeFBEkzEIo2Zj
 +3jR8csaNaOk0Tv1PybJotyj6NgjE9qJ/cLbCSui2LKoWEZztusTtoXT8xxfTim8wdLO
 p5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VX63xWZ/eWKT1gWPJ+1lYRdYxclO0GQR+P/1jDDHskU=;
 b=jx/aNYTroBvva92pP1g/ywdeVOm3/9D48CmGq+neMUbFoVYM4FJMd8r/zk58gpraqo
 B13jz92tv3oFxyPO+uNSFwyFVA008E0f9xxS4YjIqfAacwLq1hWfJbCN5Qs0gUsnVAX8
 Nz4vz8pK9W21G34yEJ/rgRQKflrSMr5QFNLSSp0Gol5qgEmvFkqxt5CWevVSpnBPZsBc
 abJp/aKm4+VNMIZIGsDAVU6UpMM/myuLSHU8yFYuoIG93A3Ge7F1mw7Zu/Lcqmt8j0ri
 5zvmhi8YPtR+RWgEgkTgC3MvzCIfQT1rFyzr8Q4REXVq73DcFXnVp5leSPAB0wUZ6zZq
 PcAQ==
X-Gm-Message-State: AOAM531N32M6rfTUnjzzZBspamNEKkw91bimaKI0KNHuR5HYPTvtfixz
 Ke3Hz4mi2Sj5JSxcsfdbJuPlj4jPhuzbtMFd
X-Google-Smtp-Source: ABdhPJyz5TotikB/FNkUHyQOfTBuY4noQjxS+6bbP/vG80G0eovznzUyCGm78c4ViMuvEqhDiHi/dw==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr13646768pgk.322.1631949993768; 
 Sat, 18 Sep 2021 00:26:33 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id 4sm7334159pjb.21.2021.09.18.00.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 00:26:33 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat, 18 Sep 2021 16:26:07 +0900
Message-ID: <20210918072609.8576-4-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918072609.8576-1-qi.fuli@fujitsu.com>
References: <20210918072609.8576-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/5] syscalls/dup2/dup203: Convert to new API
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
Message-ID: <20210918072607.7v4RwxKpajbWF80bDGIqB3W2JOY8jfy5F7Nt6ctS6zg@z>

From: QI Fuli <qi.fuli@fujitsu.com>

 - divide original testcase into two
 - check the content of file and FD_CLOEXEC flag on both open and close
   file descriptors

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup203.c | 259 +++++++-----------------
 1 file changed, 75 insertions(+), 184 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index e6f281adf..d920dcda0 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -1,208 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * 07/2001 Ported by Wayne Boyer
  */
 
-/*
- * NAME
- *	dup203.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of dup2().
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
+/*\
+ * [Description]
+ * Testcase to check the basic functionality of dup2().
+ * - Attempt to dup2() on an open file descriptor.
+ * - Attempt to dup2() on a close file descriptor.
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
 
-void setup(void);
-void cleanup(void);
+static char filename0[40], filename1[40];
 
-char *TCID = "dup203";
-int TST_TOTAL = 1;
+static struct tcase {
+	char *desc;
+	int is_close;
+} tcases [] = {
+	{"Test duping over an open fd", 0},
+	{"Test duping over a close fd", 1},
+};
 
-int main(int ac, char **av)
+static void run(unsigned int i)
 {
-	int fd0, fd1, fd2, rval;
-	char filename0[40], filename1[40];
+	int fd0, fd1, fd2, rval, rc = 0;
 	char buf[40];
 
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
-
-		tst_resm(TINFO, "Exit block 1");
-
-//block2:
-		tst_resm(TINFO, "Enter block 2");
-		tst_resm(TINFO, "Test close on exec flag");
+	struct tcase *tc = tcases + i;
+	tst_res(TINFO, tc->desc);
 
-		sprintf(filename0, "dup02.%d\n", getpid());
-		unlink(filename0);
+	fd0 = SAFE_CREAT(filename0, 0666);
+	SAFE_WRITE(1, fd0, filename0, strlen(filename0));
+	SAFE_CLOSE(fd0);
 
-		if ((fd0 = creat(filename0, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create first file");
-		}
-		if (fcntl(fd0, F_SETFD, 1) == -1) {
-			tst_brkm(TBROK, cleanup, "setting close on exec flag "
-				 "on fd0 failed");
-		}
-
-		if ((fd2 = creat(filename1, 0666)) == -1) {
-			tst_brkm(TBROK, cleanup, "Cannot create second file");
-		}
+	fd1 = SAFE_CREAT(filename1, 0666);
+	SAFE_WRITE(1, fd1, filename1, strlen(filename1));
+	fd0 = SAFE_OPEN(filename0, O_RDONLY);
+	SAFE_FCNTL(fd0, F_SETFD, 1);
 
+	if (tc->is_close) {
 		/* SAFE_CLOSE() sets the fd to -1 avoid it here */
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
-		}
-
-		close(fd0);
-		close(fd1);
-
-		unlink(filename0);
-		unlink(filename1);
-		tst_resm(TINFO, "Exit block 2");
+		rval = fd1;
+		SAFE_CLOSE(rval);
+	} 
+
+	TEST(dup2(fd0, fd1));
+	fd2 = TST_RET;
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "call failed unexpectedly");
+		goto free;
+	}
+	if (fd1 != fd2) {
+		tst_res(TFAIL, "file descriptors don't match");
+		goto free;
 	}
 
-	cleanup();
-	tst_exit();
+	memset(buf, 0, sizeof(buf));
+	SAFE_READ(0, fd2, buf, sizeof(buf));
+	if (strcmp(buf, filename0) != 0)
+		tst_res(TFAIL, "read from file got bad data");
+	else
+		tst_res(TPASS, "test the content of file is correct");
+
+	rval = SAFE_FCNTL(fd2, F_GETFD, 0);
+	if (rval != 0) {
+		tst_res(TFAIL, "fcntl F_GETFD on fd2 failed; expected a "
+			"return value of 0x0, got %#x", rval);
+		rc++;
+	}
+	if (!rc)
+		tst_res(TPASS, "test the FD_CLOEXEC flag is correct");
+free:
+	SAFE_CLOSE(fd0);
+	SAFE_CLOSE(fd1);
+	SAFE_UNLINK(filename0);
+	SAFE_UNLINK(filename1);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	int pid;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	pid = getpid();
+	sprintf(filename0, "dup203.file0.%d\n", pid);
+	sprintf(filename1, "dup203.file1.%d\n", pid);
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
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.test = run,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

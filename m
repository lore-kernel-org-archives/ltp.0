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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC10BC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:38:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F3B60FE6
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59F3B60FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046733C2A62
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:38:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9D063C4D0A
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:27 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C1C6100092F
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:27 +0200 (CEST)
Received: by mail-pf1-x433.google.com with SMTP id w14so4462074pfu.2
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 20:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UVTC6roXEW2WOYlZ4KsAyZEtp2GPKd9vdQbrWuea/rc=;
 b=Olz4OFlNEyMIzeOQZjYXLOc50OXTxvNoEQYetD2fUz/qvyzi5CE13rbrlQQzKMy9SC
 YK8Gafhv2zH4+9EuNrtK9xIlaDAQWHHpIqEmJuD2SsZp3hEQxZdX1ICZcDmd3v/1DySI
 i0uU0H6fz7TBdxfyQ92+6ZR4mg4Qm+LAnWmTkB3igTZesDaV3pOZn6BOadxF7j9kplVd
 5Ge5SJGkiTe3SGDYQAA+mhYu3l/ct4xNk7XiQrYs1JqsMYsyUpLAgkNtG52FL5s837OM
 9EU5bnYQ6yFDsj3BAF6Wv9bnduUJ7q2OZLky2OkZp1TLrpCpn82T07rbCQ09cJtBDJXA
 lduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UVTC6roXEW2WOYlZ4KsAyZEtp2GPKd9vdQbrWuea/rc=;
 b=BDF1EwJ8zlkXnJVKYMEZkrjkgnj2mHHdxAPb19X85Tu11HRdB87NGYWr0ijEOBWhBY
 C3GJS0qWCQCQvQUK8Hd1Er8TEhBDmfxuVloWqugQ3vfSMCNEXxAK4FvdpnuhYyBoFb4W
 Dg9oXMxi27ELBSue3TbZMMcO0lFI340gvMeF9MdlUMUJVjZoRd5Q3yxxmAomnckGOeuY
 OzXv85/ZMNU3d1rRJ6ZKQS4yf37CEBPUVo43HZcJX1+FaHdg1uHEEpBmSWnEf6bL7Rmv
 Ffnj6/LMCOhVLAss2Ad/5jaNepyANoOYVCalcFdhtZo7go/+0ESihEsqoLLu7uxD/bV4
 7/lA==
X-Gm-Message-State: AOAM533JO2r/iW7gxXM/P/M3oQs5ctur2P7momabP8U0pWDR0TwO3vr/
 qGyux+6vU2dCAahP17emdRdRwsmtq/Khgw==
X-Google-Smtp-Source: ABdhPJzout2Z4Kxsk6udQCdY4buxAi79907nLUJIxyEaQn5VRJKwYvZ8NHON+m9ZeLrVfUai4ndvSA==
X-Received: by 2002:aa7:9115:0:b029:359:69db:bc89 with SMTP id
 21-20020aa791150000b029035969dbbc89mr23303283pfh.32.1632109045450; 
 Sun, 19 Sep 2021 20:37:25 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id v25sm11932301pfm.202.2021.09.19.20.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Sep 2021 20:37:25 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 20 Sep 2021 12:37:03 +0900
Message-Id: <20210920033705.20544-4-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920033705.20544-1-qi.fuli@fujitsu.com>
References: <20210920033705.20544-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/5] syscalls/dup2/dup203: Convert to new API
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
 testcases/kernel/syscalls/dup2/dup203.c | 265 ++++++++----------------
 1 file changed, 83 insertions(+), 182 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index e6f281adf..d2f54304d 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -1,208 +1,109 @@
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
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	Testcase to check the basic functionality of dup2().
+ * Testcase to check the basic functionality of dup2().
  *
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
+ * - Attempt to dup2() on an open file descriptor.
+ * - Attempt to dup2() on a close file descriptor.
  */
 
-#include <fcntl.h>
-#include <sys/param.h>
 #include <errno.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup(void);
-void cleanup(void);
-
-char *TCID = "dup203";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+#include <stdio.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+static char filename0[40], filename1[40];
+static int fd0, fd1;
+
+static struct tcase {
+	char *desc;
+	int is_close;
+} tcases[] = {
+	{"Test duping over an open fd", 0},
+	{"Test duping over a close fd", 1},
+};
+
+static void run(unsigned int i)
 {
-	int fd0, fd1, fd2, rval;
-	char filename0[40], filename1[40];
+	int fd2, rval;
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
+	struct tcase *tc = tcases + i;
 
-		SAFE_CLOSE(cleanup, fd0);
-		if ((fd0 = open(filename0, O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open(2) on filename0 failed");
+	tst_res(TINFO, tc->desc);
 
-		SAFE_CLOSE(cleanup, fd1);
-		if ((fd1 = open(filename1, O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open(2) on filename1 failed");
+	fd0 = SAFE_CREAT(filename0, 0666);
+	SAFE_WRITE(1, fd0, filename0, strlen(filename0));
+	SAFE_CLOSE(fd0);
 
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
-
-		sprintf(filename0, "dup02.%d\n", getpid());
-		unlink(filename0);
-
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
+	rval = SAFE_FCNTL(fd2, F_GETFD);
+	if (rval != 0)
+		tst_res(TFAIL, "fcntl F_GETFD on fd2 failed; expected a "
+			"return value of 0x0, got %#x", rval);
+	else
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
+static void cleanup(void)
 {
-	tst_rmdir();
+	close(fd0);
+	close(fd1);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.test = run,
+	.cleanup = cleanup,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

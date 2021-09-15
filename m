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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FEC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432C361179
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 432C361179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C355F3C89B1
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 17:52:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1328B3C9203
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:19 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 163E920020C
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:19 +0200 (CEST)
Received: by mail-pg1-x535.google.com with SMTP id w7so3101681pgk.13
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=25eCUVVWMrYYqJeAL7KTyx10XTFxt2gb26yLTGOmpq0=;
 b=IzEahCfPsdYIKhHNXFv5EV5YGTNsFR5p5TmCewqH5dJbh042HPU7zcl6yDCP6zEL/9
 N4UJlSGqCATFP7sTo93kf4DjK/H2MbPBGFu9z+X4wTJXINBd0JQ1HX5KV6NnioKRP/6q
 nV51ECQiMVWghySZS+3cx2rGqzITPNwqahJcziFkzI2i66l0SDp5xzF1/LDPXmUdgRJL
 +kYsTNaq0gfnpi9Qjsc5Dtqvd5cbrqtMnl4K6l/H4RTuAabRZYGENoN7d85sNtV4+mxf
 bA5YxUB4x+IUgNOzJwStUCLV43p55RtMQD8v7BB7W5c7HhhZxDauYzujAVdhbYk3qHI0
 FMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=25eCUVVWMrYYqJeAL7KTyx10XTFxt2gb26yLTGOmpq0=;
 b=TZgczBwmhtYrXW9I2cF4kto8x2bdjneSz6nrJ4WrQHxzXlbvirTG/R5/MU5yIhh6io
 AWydZweemrpB7ENm++sj8lrraPtpM42vPIGL9DXYOs+/G4lhtLnsp+TQHrVis5elzDUt
 vm5MDswRwetMBbQyGtHJ/JJAbaoPtncy0C8VFDKo8kQqM8ABAN+7icTkS3kJE9S6nYe1
 n8jMJLoikS/lAAg0S5Rujn7n+FoWcT+a+GupriOcJFAYAm6JXvy5NUcd8hD2t7KoWU0v
 9MQYe9BZiMMaKTtw6ZIIHwS0RRe2LCiwVBZtDb8NK5+BbISIKwozNq2xPLgMStnCW6uA
 r7sQ==
X-Gm-Message-State: AOAM532kf6hQIi/adNMdcURh+FzxdiDstp5LE61nQTKX88eoJjgyzNp8
 uI7lg0EUmqXNR2m9ahKowtQU4mYFEGIfA9En
X-Google-Smtp-Source: ABdhPJxwD+DWVULOZ+5w7tYsueYOdQ8W7c0ETWr5ONNg1Q+3jNzXlmNqR2tv7FfmptH3Qx8+92yszw==
X-Received: by 2002:a62:88d3:0:b0:43d:df95:3426 with SMTP id
 l202-20020a6288d3000000b0043ddf953426mr619271pfd.26.1631721137536; 
 Wed, 15 Sep 2021 08:52:17 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l14sm5452484pjq.13.2021.09.15.08.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 08:52:16 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 00:51:49 +0900
Message-ID: <20210915155152.8515-2-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915155152.8515-1-qi.fuli@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] syscalls/dup2/dup201: Convert to new API
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
Message-ID: <20210915155149.3QgLzzb69nbCXi9KDlesUBCe3qCPYGEnm3J3OIcuN3E@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup201.c | 174 +++++-------------------
 1 file changed, 33 insertions(+), 141 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
index 4fa34466a..8e47a2244 100644
--- a/testcases/kernel/syscalls/dup2/dup201.c
+++ b/testcases/kernel/syscalls/dup2/dup201.c
@@ -1,163 +1,55 @@
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
- *	dup201.c
- *
- * DESCRIPTION
- *	Negative tests for dup2() with bad fd (EBADF)
- *
- * ALGORITHM
- * 	Setup:
- *	a.	Setup signal handling.
- *	b.	Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	a.	Loop if the proper options are given.
- *	b.	Loop through the test cases
- * 	c.	Execute dup2() system call
- *	d.	Check return code, if system call failed (return=-1), test
- *		for EBADF.
- *
- * 	Cleanup:
- * 	a.	Print errno log and/or timing stats if options given
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *  dup201 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Negative tests for dup2() with bad fd (EBADF)
+ * First fd argument is less than 0
+ * First fd argument is getdtablesize()
+ * Second fd argument is less than 0
+ * Second fd argument is getdtablesize()
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *	01/2002 Removed EMFILE test - Paul Larson
- *
- * RESTRICTIONS
- * 	NONE
  */
 
-#include <sys/types.h>
-#include <fcntl.h>
 #include <errno.h>
-#include <sys/time.h>
-#include <sys/resource.h>
 #include <unistd.h>
-#include <signal.h>
-#include "test.h"
-
-void setup(void);
-void cleanup(void);
-
-char *TCID = "dup201";
-int TST_TOTAL = 4;
+#include "tst_test.h"
 
-int maxfd;
-int goodfd = 5;
-int badfd = -1;
-int mystdout = 0;
+static int maxfd;
+static int goodfd = 5;
+static int badfd = -1;
+static int mystdout = 0;
 
-struct test_case_t {
+static struct tcase {
 	int *ofd;
 	int *nfd;
-	int error;
-	void (*setupfunc) ();
-} TC[] = {
-	/* First fd argument is less than 0 - EBADF */
-	{&badfd, &goodfd, EBADF, NULL},
-	    /* First fd argument is getdtablesize() - EBADF */
-	{&maxfd, &goodfd, EBADF, NULL},
-	    /* Second fd argument is less than 0 - EBADF */
-	{&mystdout, &badfd, EBADF, NULL},
-	    /* Second fd argument is getdtablesize() - EBADF */
-	{&mystdout, &maxfd, EBADF, NULL},
+} tcases[] = {
+	{&badfd, &goodfd},
+	{&maxfd, &goodfd},
+	{&mystdout, &badfd},
+	{&mystdout, &maxfd},
 };
 
-int main(int ac, char **av)
-{
-	int lc;
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
-		/* loop through the test cases */
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/* call the test case setup routine if necessary */
-			if (TC[i].setupfunc != NULL)
-				(*TC[i].setupfunc) ();
-
-			TEST(dup2(*TC[i].ofd, *TC[i].nfd));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS,
-					 "failed as expected - errno = %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "failed unexpectedly; "
-					 "expected %d: %s", TC[i].error,
-					 strerror(TC[i].error));
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	/* get some test specific values */
 	maxfd = getdtablesize();
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void run(unsigned int i)
 {
-	tst_rmdir();
+	struct tcase *tc = tcases + i;
+
+	TST_EXP_FAIL2(dup2(*tc->ofd, *tc->nfd), EBADF,
+			"failed as expected - %s", strerror(EBADF));
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

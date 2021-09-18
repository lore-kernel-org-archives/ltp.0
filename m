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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA9DC433F5
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:26:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EE3603E9
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7EE3603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 195193C8812
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 09:26:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2733C19F3
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:31 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8EAE5200A03
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:30 +0200 (CEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 m21-20020a17090a859500b00197688449c4so9065148pjn.0
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c9lwazyG+1IaGiR6vYko5EKfGbbG05Zib1J5xKZChbU=;
 b=pkbCYIiRqi6Pbewg33AgRGCZ9HgOM7ESXfObEkqHMif289UlVlWhc7RvXet2kKtFCv
 OC7ISSoO13DGtN6a966UhMY30uUqDUlVpMB48jQ7Ze7ZtQWMNAgKQMb0TlZ7v4ID6p/f
 GAPPJ5yhKIeGqlCnRTe3FPSgt8usKNYRjdwd3gVGRpRadUXfgQ0JFXUeDEOMhffdaTY/
 MrYBktIR415tJ7SrFqPBNvvWkyMSnjJNURgdIgRwZFwGgqcwB+qOQdEMk9xGOcNS5s9B
 saOH0+235DdPfrHIX/C/Xt2mAnaFpoqa/8WqTFZD+1OYSWbyXyekNeTIGK7DLqdCUnmO
 U2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c9lwazyG+1IaGiR6vYko5EKfGbbG05Zib1J5xKZChbU=;
 b=1ZI+QKdH9JAF3dlwif3W0V5s/omxR5DHGHa8kY5iMzhnkNBeILecOMif4bKuDzzSSE
 zHEAzF0OsbsLPZpEq3Vm2aqE5O27dW66oFkyT2CzRB1i4TokgJeb+tcy/m32P7stgxF5
 T6FzBib0Nd/j6qqP0RDL9fJenSL7qG9PXD2va216q9SBP392uIQQBWKq5j27I7LYtb5j
 m7UjhyL4IuBe7kEcsj8mPP/s0pCF/CFlYhno1O9CwL+HaAqFiX62hDhWKWJDOZbyaaEC
 Yw1DmA0k7j9HoJm5x8fRbV3TaZWx27PGMIQ3eZhGxcitcG0RgQRpq3PTRwfVCLfBmBB2
 H5ag==
X-Gm-Message-State: AOAM530oGxOyAQJoZY+gDGL0XpqTb884Nay5wOmsSYoza9+O2qu1PeP1
 2YKrhGs8Z9j7tlrL9ris/QrmHFm7cZVgQPXX
X-Google-Smtp-Source: ABdhPJyzHSG40YtlGiox/hMg9f9J39WjCR2YG2Kn1674ydP2crnZrA5620C7NsCKqJHP8+uv31Vtlw==
X-Received: by 2002:a17:90a:5d01:: with SMTP id
 s1mr16840333pji.5.1631949988877; 
 Sat, 18 Sep 2021 00:26:28 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id 4sm7334159pjb.21.2021.09.18.00.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 00:26:28 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat, 18 Sep 2021 16:26:05 +0900
Message-ID: <20210918072609.8576-2-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918072609.8576-1-qi.fuli@fujitsu.com>
References: <20210918072609.8576-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/5] syscalls/dup2/dup201: Convert to new API
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
Message-ID: <20210918072605.dewsbxL-m6hJoalqca_f-Mrx_m2t7ZfccnS4cNB1KBI@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup201.c | 175 +++++-------------------
 1 file changed, 33 insertions(+), 142 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
index 4fa34466a..03f0bb4bd 100644
--- a/testcases/kernel/syscalls/dup2/dup201.c
+++ b/testcases/kernel/syscalls/dup2/dup201.c
@@ -1,163 +1,54 @@
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
+ * 01/2002 Removed EMFILE test - Paul Larson
  */
-
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
+ * - First fd argument is less than 0
+ * - First fd argument is getdtablesize()
+ * - Second fd argument is less than 0
+ * - Second fd argument is getdtablesize()
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
+static int maxfd, mystdout;
+static int goodfd = 5;
+static int badfd = -1;
 
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
+			"dup2(%d, %d)", *tc->ofd, *tc->nfd);
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

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37FDC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:37:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E7660FF2
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34E7660FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E85A63C2CAF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:37:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2A263C4CF6
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:25 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D8D3410005C3
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:24 +0200 (CEST)
Received: by mail-pg1-x52f.google.com with SMTP id f129so15986016pgc.1
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 20:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9oRya5gv0uqn2LVWx3hiNRcH6XbYORQXsei93SUqn80=;
 b=axP1M1C/r7rljDJJqISgjXc+M2w0fOWXfAyLICzDZNQnCS1CDw2o2+KQdh2z1XLils
 Y+myzZ7AaF4XfA7etTXHJVGke6VPVlM/BlnQ5IyxWUZCB/5nug9Wl7RfLScGBE5fepcv
 0EcyLRE7onZIfT2/uqYqleZFlTthOj6unmdaS6XmKjLFrgqPqGp6g0hsSRf7A34ev2VC
 H3PVbzwvIerFKO8bdWkadx0U8bVAHMhT3rL7Ewhu9lSBVJf5OTCJ1OjWXy0nd5E/jDp7
 XDvpKZtFCDcVyJMewrY9XtPweOuqXsidMoFXJ3yKAVti2CrCjbdCgWI2XqO0OCfM5CUj
 Efkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9oRya5gv0uqn2LVWx3hiNRcH6XbYORQXsei93SUqn80=;
 b=wYo47Km04qubkX1/mpeArfPt2fk1pR4qj97m9COEQ5ySMjuXXgAdPPvZLeYYxizd2b
 XsPzznEEbWGOQgCPODI+FwgvwC3OOZSeKdh80csZAFwBbadwENuLq0RMSmGESkkuACbw
 2hORmoB1ysj1vq00XE+3DRnGiSeLDvZ5cMmg6gajm5H8uexEqOOEQUjU73f3YOOZd8ED
 ppBY8l7/dPzRfLG3Q+DubVO9zMEOup6sDeNkLdcJd9oPMoegQ8HiXMQRPY/0CIMsqesK
 uPCmh2siD6F9jIrYsn3r22Pu96XYzBrbpBSVcB00cYunfU1M8ty+siOACHJcfGnm/HTe
 56Mw==
X-Gm-Message-State: AOAM5336LL3bt9HtjxgwPdEgf2tyes61inFzwRIOtXG0GiGXQFcczuRu
 C3EboSFWN4Xfawhn+XOVdN3S6HQWqut4GA==
X-Google-Smtp-Source: ABdhPJyl64TYVwwLrL3e7bM1Vbg5JgrUmpd+WrmLZNg2xqmUnc6D6lL2eI6HHg36IFbR68tvxfCh8Q==
X-Received: by 2002:aa7:9e9a:0:b0:447:a1be:ee48 with SMTP id
 p26-20020aa79e9a000000b00447a1beee48mr5950838pfq.48.1632109043263; 
 Sun, 19 Sep 2021 20:37:23 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id v25sm11932301pfm.202.2021.09.19.20.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Sep 2021 20:37:22 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 20 Sep 2021 12:37:02 +0900
Message-Id: <20210920033705.20544-3-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920033705.20544-1-qi.fuli@fujitsu.com>
References: <20210920033705.20544-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/5] syscalls/dup2/dup202: Convert to new API
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
 testcases/kernel/syscalls/dup2/dup202.c | 196 +++++++-----------------
 1 file changed, 58 insertions(+), 138 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index c87769fa9..feba0469a 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -1,167 +1,87 @@
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
- *	dup202.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	Is the access mode the same for both file descriptors?
- *		0: read only ?	"0444"
- *		1: write only ? "0222"
- *		2: read/write ? "0666"
+ * Test whether the access mode are the same for both file descriptors.
  *
- * ALGORITHM
- *	Creat a file with each access mode; dup each file descriptor;
- *	stat each file descriptor and compare modes of each pair
- *
- * USAGE:  <for command-line>
- *  dup202 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
- *	None
+ * - 0: read only ? "0444"
+ * - 1: write only ? "0222"
+ * - 2: read/write ? "0666"
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <stdio.h>
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "dup202";
-int TST_TOTAL = 3;
-
-void setup(void);
-void cleanup(void);
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-char testfile[40];
-int fail;
-int newfd;
+static char testfile[40];
+static int ofd = -1, nfd = -1;
 
 /* set these to a known index into our local file descriptor table */
-int duprdo = 10, dupwro = 20, duprdwr = 30;
+static int duprdo = 10, dupwro = 20, duprdwr = 30;
 
-struct test_case_t {
+static struct tcase {
 	int *nfd;
 	mode_t mode;
-} TC[] = {
-	/* The first test creat(es) a file with mode 0444 */
-	{
-	&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
-	    /* The second test creat(es) a file with mode 0222 */
-	{
-	&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
-	    /* The third test creat(es) a file with mode 0666 */
-	{
-	&duprdwr,
-		    (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)}
+} tcases[]= {
+	{&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
+	{&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
+	{&duprdwr, (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)},
 };
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-	int i, ofd;
-	struct stat oldbuf, newbuf;
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
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if ((ofd = creat(testfile, TC[i].mode)) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "creat failed");
-
-			TEST(dup2(ofd, *TC[i].nfd));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO,
-					 "call failed unexpectedly");
-				continue;
-			}
-
-			/* stat the original file */
-			SAFE_FSTAT(cleanup, ofd, &oldbuf);
-
-			/* stat the duped file */
-			SAFE_FSTAT(cleanup, *TC[i].nfd, &newbuf);
-
-			if (oldbuf.st_mode != newbuf.st_mode)
-				tst_resm(TFAIL, "original and dup "
-					 "modes do not match");
-			else
-				tst_resm(TPASS, "fstat shows new and "
-					 "old modes are the same");
-
-			/* remove the file so that we can use it again */
-			if (close(*TC[i].nfd) == -1)
-				perror("close failed");
-			if (close(ofd) == -1)
-				perror("close failed");
-			if (unlink(testfile) == -1)
-				perror("unlink failed");
-		}
-	}
+	umask(0);
+	sprintf(testfile, "dup202.%d", getpid());
+}
 
-	cleanup();
-	tst_exit();
+static void cleanup(void)
+{
+	close(ofd);
+	close(nfd);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(unsigned int i)
 {
+	struct stat oldbuf, newbuf;
+	struct tcase *tc = tcases + i;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	ofd = SAFE_CREAT(testfile, tc->mode);
+	nfd = *tc->nfd;
 
-	TEST_PAUSE;
+	TEST(dup2(ofd, nfd));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
+		goto free;
+	}
 
-	tst_tmpdir();
+	SAFE_FSTAT(ofd, &oldbuf);
 
-	(void)umask(0);
+	SAFE_FSTAT(nfd, &newbuf);
 
-	sprintf(testfile, "dup202.%d", getpid());
-}
+	if (oldbuf.st_mode != newbuf.st_mode)
+		tst_res(TFAIL, "original(%o) and duped(%o) are not same mode",
+					oldbuf.st_mode, newbuf.st_mode);
+	else
+		tst_res(TPASS, "original(%o) and duped(%o) are the same mode",
+					oldbuf.st_mode, newbuf.st_mode);
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-	tst_rmdir();
+	SAFE_CLOSE(nfd);
+free:
+	SAFE_CLOSE(ofd);
+	SAFE_UNLINK(testfile);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

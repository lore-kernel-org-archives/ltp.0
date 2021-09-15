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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B366C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185E0606A5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 15:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 185E0606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 860D23C91FF
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 17:52:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4A3D3C9201
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:22 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9564D6010F0
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 17:52:21 +0200 (CEST)
Received: by mail-pl1-x62a.google.com with SMTP id w6so1906599pll.3
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=un2XeuRCKTC0mo6KkNrQwJXdqt330fA3PNlOG5WyL9E=;
 b=YyuREseWX70TByW7xSrrx39uWdYYhE8KOZJ8K2yj17quzIA7OXPJOTHxTel6DfW1ec
 KfXniF1Nhy+WVNQWWQ7Dc+M3PGmBsLsW+k0AklYJ1Bl7nUmYI4TpDfFNWJax9WI5J0+2
 4d/gMBBsjxD9Z21zRJEV5OlLTTW2OfrmONVF2i+vtc5TMa9jzVXk3lYnP+yX4nQC4x3G
 hzFuT5ogRsB0D4C8twxqQc4DwS4E+dv8RdIl9ON8HjhUt/ymwV8617fA7fwSqxt8Cp3a
 +Gt7/LDEnKZFZJ6AOlofpD0qQ2+hGA+kFip1efKz02lz0PbV3YaganHVYIe8bhdp7TRo
 d5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=un2XeuRCKTC0mo6KkNrQwJXdqt330fA3PNlOG5WyL9E=;
 b=oIwsZAD6F6VLTsqJ1Fw7aaK6ZLwHF+tn8d73J5vmd17ihHYpEvJ1zMfIUB51dT/os5
 TL1/O8IUeGXG/EoCUDXT0hyW7FkG4LSxeyPCQ+w/x4/GZNTOK2hIBixX6FKOFymhtvPb
 gFOJ/9PdiNQkukW29N00oCUNT+KNdQIQAnZaYPnkOwyFUjS4PBaSetnL6tk/QYxHazzb
 wUOLA7Ef5xfCFKaVciInPKEzH+3xd4RHeS4kfOIPtXApalknUQ+GqOwklpfvzwb3i8KL
 IjoeIqoQ/eMXobiPA/HvD+JcSyqbUnI9xr+MxLxb/2I+9loSn5u1QfeGVgGtHfXVOO8K
 tZvw==
X-Gm-Message-State: AOAM530YSV42NHFkzXZ10l+tZmc7+85GJNjOFcFZkSAhjBfC14sTeLKB
 46ZFzb/vWRvexB+6JBr1WN6SsC14m76ulqwa
X-Google-Smtp-Source: ABdhPJyoCThbuqCt+aQXyTJgH9nozyPybS92/HyqIhtd3iffPaHG1iKXNnI1eWeitilXXqh/Lpxquw==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr540999pjp.56.1631721140009; 
 Wed, 15 Sep 2021 08:52:20 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id l14sm5452484pjq.13.2021.09.15.08.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 08:52:19 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 16 Sep 2021 00:51:50 +0900
Message-ID: <20210915155152.8515-3-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915155152.8515-1-qi.fuli@fujitsu.com>
References: <20210915155152.8515-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] syscalls/dup2/dup202: Convert to new API and
 merge dup204 into dup202
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
Message-ID: <20210915155150.XTbOyQTM2bBC-0GMHh5seBJXz9ZbPVSEtJ21CmDzMRI@z>

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup202.c | 190 +++++++-----------------
 testcases/kernel/syscalls/dup2/dup204.c | 128 ----------------
 2 files changed, 52 insertions(+), 266 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/dup2/dup204.c

diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index c87769fa9..fd8aeb84e 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -1,167 +1,81 @@
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
- *	dup202.c
- *
- * DESCRIPTION
- *	Is the access mode the same for both file descriptors?
- *		0: read only ?	"0444"
- *		1: write only ? "0222"
- *		2: read/write ? "0666"
- *
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
+/*\
+ * [Description]
  *
- * RESTRICTIONS
- *	None
+ * Is the access mode the same for both file descriptors?
+ *	0: read only ?	"0444"
+ *	1: write only ? "0222"
+ *	2: read/write ? "0666"
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <stdio.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-char *TCID = "dup202";
-int TST_TOTAL = 3;
-
-void setup(void);
-void cleanup(void);
-
-char testfile[40];
-int fail;
-int newfd;
+static char testfile[40];
 
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
+	umask(0);
+	sprintf(testfile, "dup202.%d", getpid());
+}
 
-			/* stat the original file */
-			SAFE_FSTAT(cleanup, ofd, &oldbuf);
+static void run(unsigned int i)
+{
+	int ofd;
+	struct stat oldbuf, newbuf;
+	struct tcase *tc = tcases + i;
 
-			/* stat the duped file */
-			SAFE_FSTAT(cleanup, *TC[i].nfd, &newbuf);
+	ofd = SAFE_OPEN(testfile, O_CREAT, tc->mode);
 
-			if (oldbuf.st_mode != newbuf.st_mode)
-				tst_resm(TFAIL, "original and dup "
-					 "modes do not match");
-			else
-				tst_resm(TPASS, "fstat shows new and "
-					 "old modes are the same");
+	TEST(dup2(ofd, *tc->nfd));
 
-			/* remove the file so that we can use it again */
-			if (close(*TC[i].nfd) == -1)
-				perror("close failed");
-			if (close(ofd) == -1)
-				perror("close failed");
-			if (unlink(testfile) == -1)
-				perror("unlink failed");
-		}
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	/* stat the original file */
+	SAFE_FSTAT(ofd, &oldbuf);
 
-	TEST_PAUSE;
+	/* stat the duped file */
+	SAFE_FSTAT(*tc->nfd, &newbuf);
 
-	tst_tmpdir();
+	if (oldbuf.st_mode != newbuf.st_mode)
+		tst_res(TFAIL, "original and duped modes do not match");
+	else
+		tst_res(TPASS, "original and duped modes are the same");
 
-	(void)umask(0);
+	if (oldbuf.st_ino != newbuf.st_ino)
+		tst_res(TFAIL, "original and duped inodes do not match");
+	else
+		tst_res(TPASS, "original and duped inodes are the same");
 
-	sprintf(testfile, "dup202.%d", getpid());
+	SAFE_CLOSE(*tc->nfd);
+	SAFE_CLOSE(ofd);
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
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
deleted file mode 100644
index a357bc17e..000000000
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
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
- */
-
-/*
- * NAME
- *	dup204.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of dup2(2).
- *
- * ALGORITHM
- *	attempt to call dup2() on read/write ends of a pipe
- *
- * USAGE:  <for command-line>
- *  dup204 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * RESTRICTION
- *	NONE
- */
-
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "dup204";
-int TST_TOTAL = 2;
-
-int fd[2];
-int nfd[2];
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
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
-			TEST(dup2(fd[i], nfd[i]));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "call failed unexpectedly");
-				continue;
-			}
-
-			SAFE_FSTAT(cleanup, fd[i], &oldbuf);
-			SAFE_FSTAT(cleanup, nfd[i], &newbuf);
-
-			if (oldbuf.st_ino != newbuf.st_ino)
-				tst_resm(TFAIL, "original and duped "
-					 "inodes do not match");
-			else
-				tst_resm(TPASS, "original and duped "
-					 "inodes are the same");
-
-			SAFE_CLOSE(cleanup, TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	fd[0] = -1;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	SAFE_PIPE(cleanup, fd);
-}
-
-void cleanup(void)
-{
-	int i;
-
-	for (i = 0; i < (int)ARRAY_SIZE(fd); i++) {
-		close(fd[i]);
-		close(nfd[i]);
-	}
-
-	tst_rmdir();
-}
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

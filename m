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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36018C433EF
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488CE60F93
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 488CE60F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDD663C6EA9
	for <ltp@archiver.kernel.org>; Sat, 18 Sep 2021 09:26:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33C9D3C9051
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:33 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E75292009FA
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 09:26:32 +0200 (CEST)
Received: by mail-pj1-x102f.google.com with SMTP id j1so8460477pjv.3
 for <ltp@lists.linux.it>; Sat, 18 Sep 2021 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IsitHdVvSKRJSo6wi9R8n6PqaxWz5EWXUGqJxk00Awc=;
 b=oeYBLX7615vfk53B/4VRZPqgrUydLT/QpIy+HeLJ6hUX8NsQI0a0bYqBH5uYXq74VC
 8lNehhfcGt1P1gKWRTitVkHg40EV3AtF7SON3qcuvduY8xMFIMYpsamsKvbCWO1uuGxo
 wO89bPW/KmilM2sH4QOxtFFLMgd4Jlnjz6Ksk69H+c5XuKUKREJ7+dkvpUgsf8Dw0vpu
 ReXNSpefzA/X+2FrmZhPc6gVdfb3EEdYVnm/q1B2zaPmOZ5SyfhQdG1DDEjXEWRRZGEv
 pD6CH3n2L5NhoFMVB9XU6eCs+Dc8H45pRfNScYjMKn3ikmqpHvFAAkvwPDnWEEdExM96
 scTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IsitHdVvSKRJSo6wi9R8n6PqaxWz5EWXUGqJxk00Awc=;
 b=UIEULiUHVQElkZ1opej780rKH59dkgaThFj8V58KaFMvzmn8+ubOV29hjUDWIY7Xfz
 RlK9nwVu1I7V7UAChg+18rEr6hi+inCILnT2olLy24YxqsezUKSmZ/viyU664mmtCtVe
 p3TUFGUMOtIxWeTcTpzx7r7oU5MkUDDvmJEXaVv/iO+8xCvQLVFnwNxUq/4vV++IGzJx
 q+jvIqaQCFqUNa4k0f4TXtnlg5aPFkvxTE91R4uRWiMQVvhTO7fOfof6sJ4aNQA3jjgM
 //NoyXWcOuRA4OBXmLqkV+N+kDfadsR2KQDaNRTQ10uXvDNd7E4kkFDFvDaaZ5qTHq7z
 twDQ==
X-Gm-Message-State: AOAM533eEle7LniCNpFXlnAFmPjLVxpO0HZAKJuGRg74o9SXpvPF6lzD
 Pv/x22imhlp6hlHPfp70Mfq/EUfq82v2iovE
X-Google-Smtp-Source: ABdhPJzA9+xIGrNlRvkctc+3zDu/Dasj/nXRcfy9mCEro6yKR1jBeTV7Oyd8KmQJ3+sTUhaL1Hr95g==
X-Received: by 2002:a17:90a:193:: with SMTP id 19mr38070pjc.164.1631949991355; 
 Sat, 18 Sep 2021 00:26:31 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id 4sm7334159pjb.21.2021.09.18.00.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 00:26:30 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat, 18 Sep 2021 16:26:06 +0900
Message-ID: <20210918072609.8576-3-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918072609.8576-1-qi.fuli@fujitsu.com>
References: <20210918072609.8576-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/5] syscalls/dup2/dup202: Convert to new API and
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
Message-ID: <20210918072606.Amy8I2Sv2xK9EJSNzj21vUkNl_8vgsuW8DJJMLDzgP8@z>

From: QI Fuli <qi.fuli@fujitsu.com>

 - merge dup204 (check whether the inode number are the same) into dup202

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup2/dup202.c | 205 ++++++++----------------
 testcases/kernel/syscalls/dup2/dup204.c | 128 ---------------
 2 files changed, 64 insertions(+), 269 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/dup2/dup204.c

diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index c87769fa9..1d179f1d7 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -1,167 +1,90 @@
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
- *
- * RESTRICTIONS
- *	None
+ * Test whether the access mode and inode number are the same for both file
+ * descriptors.
+ * Is the access mode the same for both file descriptors?
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
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
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
-
-	cleanup();
-	tst_exit();
+	umask(0);
+	sprintf(testfile, "dup202.%d", getpid());
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(unsigned int i)
 {
+	int ofd, nfd;
+	struct stat oldbuf, newbuf;
+	struct tcase *tc = tcases + i;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	ofd = SAFE_CREAT(testfile, tc->mode);
+	nfd = *tc->nfd;
 
-	tst_tmpdir();
+	TEST(dup2(ofd, nfd));
 
-	(void)umask(0);
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
+		goto free;
+	}
 
-	sprintf(testfile, "dup202.%d", getpid());
+	/* stat the original file */
+	SAFE_FSTAT(ofd, &oldbuf);
+
+	/* stat the duped file */
+	SAFE_FSTAT(nfd, &newbuf);
+
+	if (oldbuf.st_mode != newbuf.st_mode)
+		tst_res(TFAIL, "original(%o) and duped(%o) are not same mode",
+					oldbuf.st_mode, newbuf.st_mode);
+	else
+		tst_res(TPASS, "original(%o) and duped(%o) are the same mode",
+					oldbuf.st_mode, newbuf.st_mode);
+
+	if (oldbuf.st_ino != newbuf.st_ino)
+		tst_res(TFAIL, "original(%ld) and duped(%ld) are not same inode",
+					oldbuf.st_ino, newbuf.st_ino);
+	else
+		tst_res(TPASS, "original(%ld) and duped(%ld) are not same inode",
+					oldbuf.st_ino, newbuf.st_ino);
+
+	SAFE_CLOSE(nfd);
+free:
+	SAFE_CLOSE(ofd);
+	SAFE_UNLINK(testfile);
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

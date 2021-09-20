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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E035C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:38:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E907160FE6
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 03:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E907160FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73CE43C29E2
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 05:38:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E14933C31F6
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:29 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38E8A200275
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 05:37:29 +0200 (CEST)
Received: by mail-pg1-x536.google.com with SMTP id h3so15971365pgb.7
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 20:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U68Ql/MLGJ1D00I9dYDqSUExgIbxpDn1WIY28wFaM90=;
 b=AcDPAgamhVjRjeiQjYP8uhp3s48ul8/XeI0EDOzARl/FAz1cMExXyAsrSEl5Tq63AY
 QcdQltLFZ36nFYro42IcDeon1i3HvPE6vCYZN86CUIPm+9EkZliJi9TTq/ZiR92aWRWG
 a7LPcdXJnHzyiIrDL6hCtr19ShrowAPfYGmgcCtkspc1+OofdwbUdfW4oWIXSfz06RYV
 RZUQFl+Z8IDSr/oGykRlj9Rjuu9qaNwt/BQyo2KLqlzCiNKRRXbqJT4VJHV6ZVhe6Lcz
 CijrfXnj+j6mPRe3ytvmWAuyMv8I1iz2En/lNnMVzPtfpfGKxePJ2ra0Ll7m5jRpMiFB
 RVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U68Ql/MLGJ1D00I9dYDqSUExgIbxpDn1WIY28wFaM90=;
 b=EM4hEx2ZbPZUu1UAqtUagvEqe6ulJm0E6efzGKSppfsvNO4MTDxubkX4w2T6JhlMlc
 8ETDOOxn/7z2pxdMoEqe31jKYpevrE+uOiPd51Z2uTbeOmnvKOyufSDQijKzwyzI+j6X
 ETC9/MN7Kgg1uwUn5H0+HdKZ8OxJ9UecKfStVULa1Nku7UbB0HG9WFur2DiAC+3Xbz1C
 0pQdherpk29/wla7xSm0XtX0TmQRBYeiT/wC3kpsAE0RSL9IHz+qsIabM4cspTwwLs/u
 1uXfIUJC7J2MwTvYP9RtFNGj3gJN5BDFkhvqbkkK8gu9M5k17buZfK0ie7zgdISZzzUi
 g2KQ==
X-Gm-Message-State: AOAM532XZkjHoMa5RhRmiM3RAOP7Cy48Vg4h2Ccf1yV72I8wkFKC+wMh
 BdEVsdMUWlwOq3hqlnRqH5F2xVmcO2kk7A==
X-Google-Smtp-Source: ABdhPJxUBQEZYld3V1V+1ymIImtIQ28cV49d75RvdaqBGPzG3/5cPrB8qQu3zvVXg+XYQCz5ndlpbw==
X-Received: by 2002:a65:64d7:: with SMTP id t23mr21306678pgv.237.1632109047633; 
 Sun, 19 Sep 2021 20:37:27 -0700 (PDT)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id v25sm11932301pfm.202.2021.09.19.20.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Sep 2021 20:37:27 -0700 (PDT)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 20 Sep 2021 12:37:04 +0900
Message-Id: <20210920033705.20544-5-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920033705.20544-1-qi.fuli@fujitsu.com>
References: <20210920033705.20544-1-qi.fuli@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/5] syscalls/dup2/dup204: Convert to new API
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
 testcases/kernel/syscalls/dup2/dup204.c | 147 +++++++-----------------
 1 file changed, 40 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index a357bc17e..c9304d5c3 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -1,128 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * [Description]
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Test whether the inode number are the same for both file descriptors.
  *
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
  */
 
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
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-void setup();
-void cleanup();
+static int fd[2] = {-1, -1};
+static int nfd[2] = {10, 20};
 
-char *TCID = "dup204";
-int TST_TOTAL = 2;
-
-int fd[2];
-int nfd[2];
-
-int main(int ac, char **av)
+static void setup(void)
 {
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
+	SAFE_PIPE(fd);
+}
 
-			if (oldbuf.st_ino != newbuf.st_ino)
-				tst_resm(TFAIL, "original and duped "
-					 "inodes do not match");
-			else
-				tst_resm(TPASS, "original and duped "
-					 "inodes are the same");
+static void cleanup(void)
+{
+	unsigned int i;
 
-			SAFE_CLOSE(cleanup, TEST_RETURN);
-		}
+	for (i = 0; i < ARRAY_SIZE(fd); i++) {
+		close(fd[i]);
+		close(nfd[i]);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
+static void run(unsigned int i)
 {
-	fd[0] = -1;
+	struct stat oldbuf, newbuf;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST(dup2(fd[i], nfd[i]));
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "call failed unexpectedly");
+		return;
+	}
 
-	TEST_PAUSE;
+	SAFE_FSTAT(fd[i], &oldbuf);
+	SAFE_FSTAT(nfd[i], &newbuf);
 
-	tst_tmpdir();
+	if (oldbuf.st_ino != newbuf.st_ino)
+		tst_res(TFAIL, "original inode(%ld) and duped inode(%ld) "
+				"do not match", oldbuf.st_ino, newbuf.st_ino);
+	else
+		tst_res(TPASS, "original inode(%ld) and duped inode(%ld) "
+				"are the same", oldbuf.st_ino, newbuf.st_ino);
 
-	SAFE_PIPE(cleanup, fd);
+	SAFE_CLOSE(TST_RET);
 }
 
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
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(fd),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

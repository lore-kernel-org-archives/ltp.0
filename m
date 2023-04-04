Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2DFC6FD1D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 10:37:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCA673CA72B
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 12:37:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B36BD3CAD34
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:34 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8840B14002CE
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 12:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680604652; i=@fujitsu.com;
 bh=hDx3jwcWtS2UBKi/KbLEFrAcK24nXvF/CJhj+u3XUAE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=LB+YH2bZWZ3TGAIy222xVal6xcsQI9nOh8XRaAuG+1J35IRDVi8mUF41T5KOwkHFE
 fuj9EW4Ut3r9nhsBtDsimd+EKiQnerGDD7NacqDXtEhROP72NWymQGT130COo9xRQe
 fJxALmhcLJ8NELqhsV9FOdAF6qZJCL97mHRaCEqyPOAU5wg/DjBRejgDj8PBU3A9kT
 35MKG6H8uIxJp2uO0MLJPLzy9ag4vfHGjPczjxBK1bYsoMpHlcIjwxu3KYeqKf7wKz
 Q1alNXz4w51iV21oTkzYWxYRVo0QFnYmj9vIAgZ7NDkihXAyqnxaRcG7WeRMCAnU1Y
 98yFt/B0HAXUg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRWlGSWpSXmKPExsViZ8OxWffNX+0
 Ug923BS1WfN/B6MDose/3OtYAxijWzLyk/IoE1oy/a6wLvitXXGx6wdbA+FK2i5GTQ0jgFKPE
 /UYbCHsvk8TJOcJdjFxA9h5GiXuff7GCJNgENCWedS5gBrFFBCQkOhresoPYzALqEssn/WICs
 YUFrCX+3voAVs8ioCLRs+UEG4jNK+Ap0XlvDiOILSGgIDHl4XuwOZwCXhK/lq9khljsKbH5cz
 8jRL2gxMmZT1gg5ktIHHzxghmiV0mirfUKK4RdIdE4/RAThK0mcfXcJuYJjIKzkLTPQtK+gJF
 pFaNZcWpRWWqRrqGBXlJRZnpGSW5iZo5eYpVuol5qqW55anGJrpFeYnmxXmpxsV5xZW5yTope
 XmrJJkZg4KYUK7LuYLzU91fvEKMkB5OSKO+jjdopQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR47
 V4D5QSLUtNTK9Iyc4BRBJOW4OBREuEV/gOU5i0uSMwtzkyHSJ1iVJQS5zUCxp6QAEgiozQPrg
 0WuZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfPO/wU0hSczrwRu+iugxUxAi1ujNEAWlyQ
 ipKQamEy+z7a64np4y7S0gtDLfT9KDTeJatzk4b1opHrJ1FhogWrF8aAL77N5yp9INRZ//XV6
 Z1BgnHlGxpTGJy4+jRvuurc4yCr+TtQ81pU0rWDqQ54ZYZrcG/KOfGup6PuY9PbJnInSM53XS
 xw69L05sua230O7q7eyc0482CJ66NPjFqfeZz0d58r1N214GfLOLUKR6abI6YM/rUV3bz2eIB
 PSfMkuos/hWrvsQdWPHdmz/99Z2sIXXHzWcn3Agq1fl8QXf5RSml+xrr68VFXLqNr4+7Wm5de
 UVDZbn3YPXmXL6FftcH+2MGv1TeZ3k+bn/n69/ui//2/NbE932JW2cD+1OZ8//d6zH3qFtvu/
 NCmxFGckGmoxFxUnAgBu7mDeVwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-571.messagelabs.com!1680604652!455372!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11371 invoked from network); 4 Apr 2023 10:37:32 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-16.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 10:37:32 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id EFBBA172
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:31 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id E36C0155
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 11:37:31 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 11:37:30 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 18:36:34 +0800
Message-ID: <1680604594-16596-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] syscalls/mlock04: Convert into new api
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Also add linux tag and useful url.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock04.c | 112 ++++++++--------------
 1 file changed, 39 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock04.c b/testcases/kernel/syscalls/mlock/mlock04.c
index 8ac884583..c90cc3556 100644
--- a/testcases/kernel/syscalls/mlock/mlock04.c
+++ b/testcases/kernel/syscalls/mlock/mlock04.c
@@ -1,102 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * This is a reproducer copied from one of LKML patch submission,
+ * Copyright (C) 2010  Red Hat, Inc.
+ */
+
+/*\
+ * [Description]
+ *
+ * This is a reproducer copied from one of LKML patch submission
  * which subject is
  *
  * [PATCH] mlock: revert the optimization for dirtying pages and triggering writeback.
+ * url see https://www.spinics.net/lists/kernel/msg1141090.html
  *
- * "In 5ecfda0, we do some optimization in mlock, but it causes
+ *  "In 5ecfda0, we do some optimization in mlock, but it causes
  * a very basic test case(attached below) of mlock to fail. So
  * this patch revert it with some tiny modification so that it
  * apply successfully with the lastest 38-rc2 kernel."
  *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
+ * This bug was fixed by kernel
+ * commit fdf4c587a7 ("mlock: operate on any regions with protection != PROT_NONE")
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * As this case does, mmaps a file with PROT_WRITE permissions but without
+ * PROT_READ, so attempt to not unnecessarity break COW during mlock ended up
+ * causing mlock to fail with a permission problem on unfixed kernel.
  */
-#include "test.h"
-#include "safe_macros.h"
-#include "config.h"
-
-char *TCID = "mlock04";
-int TST_TOTAL = 1;
 
 #include <sys/mman.h>
 #include <stdio.h>
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <sys/types.h>
-
-int fd, file_len = 40960;
-char *testfile = "test_mlock";
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 
-static void setup(void);
-static void cleanup(void);
+static int fd = -1, file_len = 40960;
+static char *testfile = "test_mlock";
 
-int main(void)
+static void verify_mlock(void)
 {
 	char *buf;
-	int lc;
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		buf = mmap(NULL, file_len, PROT_WRITE, MAP_SHARED, fd, 0);
-
-		if (buf == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
 
-		if (mlock(buf, file_len) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "mlock");
-
-		tst_resm(TINFO, "locked %d bytes from %p", file_len, buf);
-
-		if (munlock(buf, file_len) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munlock");
-
-		SAFE_MUNMAP(cleanup, buf, file_len);
-	}
-
-	tst_resm(TPASS, "test succeeded.");
-
-	cleanup();
-
-	tst_exit();
+	buf = SAFE_MMAP(NULL, file_len, PROT_WRITE, MAP_SHARED, fd, 0);
+	TST_EXP_PASS(mlock(buf, file_len), "mlock(%p, %d)", buf, file_len);
+	SAFE_MUNLOCK(buf, file_len);
+	SAFE_MUNMAP(buf, file_len);
 }
 
 static void setup(void)
 {
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-
-	SAFE_FTRUNCATE(cleanup, fd, file_len);
-
-	TEST_PAUSE;
+	fd = SAFE_OPEN(testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+	SAFE_FTRUNCATE(fd, file_len);
 }
 
 static void cleanup(void)
 {
-	close(fd);
-
-	tst_rmdir();
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_mlock,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "fdf4c587a793"},
+		{}
+	}
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

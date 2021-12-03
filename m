Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F89C433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 08:16:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F9113C9085
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 09:16:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 710803C901E
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 09:16:16 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 56EDF1401721
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 09:16:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638519374; i=@fujitsu.com;
 bh=mrCsWNEiF0N88nubS5GJCL6WSRKVFn1MYVvHBOJDDkQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=hnKmjsv0YhMRJKEF7GENGMMQ8AgaHaKP7NAKE9ur3B+1AkWoEgcA4n31FCc5XoOKf
 Um6Q10yVUsKtjDLPrgbF5jzIfG2hzwKGyq9nJUNbLpA2ILB+GoSOIRefHGeJk2LP41
 ak1p8rVsh2V1Qu4u2Lp/V13cyU4AOPx3nCDoUUYnSEl6wjuCY5jMe0RqqGY3TIQk2D
 afg/jq5LQabzU8JBXkCzvxJAo7i7SlXzbo835taovhad1yAW4lz9Fb1dVpoM3Ie9nY
 Mvo0XTTOtpJ7Xazwdh2fllaks+xoNdxsRiq3xFv+wGncCEUA7qeukuZtnNIfJRP1vA
 Uqr37sVU8VDGw==
Received: from [100.113.0.112] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.symcld.net id CE/BF-32197-E42D9A16;
 Fri, 03 Dec 2021 08:16:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8ORqOt3aWW
 iQc8TZosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPe7zbmgkfqFbtmzGdtYFyo0MXIxSEkcJZR
 ovHfPhYIZyeTxKV7/WwQzj5Gif59b9i7GDk52AQ0JK49bmcGsUUEJCQ6Gt6CxZkF1CR2Xz3GB
 mILC1hKtL5dA1bDIqAicXTqIsYuRg4OXgFXidmn/UDCEgIKElMevgcr4RRwk3j6G6JcCKjk5a
 LvjCA2r4CgxMmZT1ggxktIHHzxghmiV1Fi/96NjBB2hcSMGdvYIGw1iavnNjFPYBSchaR9FpL
 2BYxMqxgtk4oy0zNKchMzc3QNDQx0DQ2NdQ11jYzN9BKrdBP1Ukt1k1PzSooSgbJ6ieXFesWV
 uck5KXp5qSWbGIEhnFLI+GYH49fXH/QOMUpyMCmJ8rrKr0wU4kvKT6nMSCzOiC8qzUktPsQow
 8GhJMGbdgEoJ1iUmp5akZaZA4wnmLQEB4+SCO+vs0Bp3uKCxNzizHSI1ClGXY4PT+YuYhZiyc
 vPS5US570AMkMApCijNA9uBCy2LzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5j1+EWgKT2Z
 eCdymV0BHMAEdcXjWcpAjShIRUlINTOEsnj/3eygeX2Z3buvz7TMErh977xZoaX0pWvrcf4v/
 647c1ug5GvM+d0KLStbhj6pyZ6zmFbJtufbh1uX++xutNU7H9fJ8XnP5VVDvnM8fd9rHJ197f
 1uHI1RgkpLP1Un2Fq6bqn88P3zd4l7HAzervlp2h/v7Q7nef+Qov/3D9lX6tem1JeqGnefd+v
 K2nf25WVU0tSVV5PCvi2ffLDgqkNzM+vRJ3HyehiVzjOYatH+x2Lr/yoQXKbq7BTS2H1OyvrA
 rxMY29CRjmJbwB76GiKaUxG8XN665s9e8jE3/ns7UXTFbDPstllgtDCmQ3hl8+a6iyt0X+9Sk
 zlkzrj88xdrAx3Hjjh2VAbaRRZFKLMUZiYZazEXFiQCG+sgnaAMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-14.tower-228.messagelabs.com!1638519373!97489!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22554 invoked from network); 3 Dec 2021 08:16:14 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-14.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Dec 2021 08:16:14 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 8D74D10022D
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 08:16:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 668A51009E8
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 08:16:13 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 3 Dec 2021 08:16:06 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 3 Dec 2021 16:16:44 -0500
Message-ID: <1638566204-6212-2-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638566204-6212-1-git-send-email-daisl.fnst@fujitsu.com>
References: <1638566204-6212-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/fcntl13: Convert to new API
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

1) use TST_EXP_FAIL2 macro
2) remove uclinux code
3) remove duplicate cases

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fcntl/fcntl13.c | 160 +++++++++---------------------
 1 file changed, 48 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl13.c b/testcases/kernel/syscalls/fcntl/fcntl13.c
index dae4c37..33c4460 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl13.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl13.c
@@ -1,127 +1,63 @@
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
+ * Copyright (c) Linux Test Project, 2021
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 Ported by Wayne Boyer
  */
 
-/*
- * NAME
- *	fcntl13.c
- *
- * DESCRIPTION
- *	Testcase to test that fcntl() sets errno correctly.
+/*\
+ * [Description]
  *
- * USAGE
- *	fcntl13
+ * Tests basic error handling of the fcntl syscall.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
+ * - EFAULT when cmd argument is F_SETLK and the data pointed to by arg is not valid
+ * - EINVAL when cmd argument is not recognized by this kernel
+ * - EINVAL when cmd argument is F_GETLK, F_SETLK, or F_SETLKW and fd does not support locking
+ * - EBADF when fd refers to an invalid file descriptor
  */
 
 #include <fcntl.h>
-#include <errno.h>
-#include "test.h"
-
-#define F_BADCMD 99999
-
-char *TCID = "fcntl13";
-int TST_TOTAL = 1;
-
-void setup(void);
-
-int main(int ac, char **av)
+#include "tst_test.h"
+
+#define F_BADCMD 999
+#define DATA    "ABCDEFGHIJ"
+
+static struct flock flock;
+
+static struct tcase {
+	int fd;
+	int cmd;
+	struct flock *flock;
+	char *desc;
+	int exp_errno;
+} tcases[] = {
+	{1, F_SETLK, NULL, "F_SETLK", EFAULT},
+	{1, F_BADCMD, &flock, "F_BADCMD", EINVAL},
+	{1, F_SETLK, &flock,  "F_SETLK", EINVAL},
+	{-1, F_GETLK, &flock, "F_GETLK", EBADF}
+};
+
+static void verify_fcntl(unsigned int n)
 {
-	int lc;
-
-	struct flock flock;
+	struct tcase *tc = &tcases[n];
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	if (!tc->flock)
+		tc->flock = tst_get_bad_addr(NULL);
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if (fcntl(1, F_BADCMD, 1) != -1)
-			tst_resm(TFAIL, "fcntl(2) failed to FAIL");
-		else if (errno != EINVAL)
-			tst_resm(TFAIL, "Expected EINVAL got %d", errno);
-		else
-			tst_resm(TPASS, "got EINVAL");
-
-#ifndef UCLINUX
-		if (fcntl(1, F_SETLK, (void *)-1) != -1) {
-			tst_resm(TFAIL, "F_SETLK: fcntl(2) failed to FAIL");
-		} else if (errno != EFAULT) {
-			tst_resm(TFAIL, "F_SETLK: Expected EFAULT got %d",
-				 errno);
-		} else {
-			tst_resm(TPASS, "F_SETLK: got EFAULT");
-		}
-
-		if (fcntl(1, F_SETLKW, (void *)-1) != -1) {
-			tst_resm(TFAIL, "F_SETLKW: fcntl(2) failed to FAIL");
-		} else if (errno != EFAULT) {
-			tst_resm(TFAIL, "F_SETLKW: Expected EFAULT got %d",
-				 errno);
-		} else {
-			tst_resm(TPASS, "F_SETLKW: got EFAULT");
-		}
-
-		if (fcntl(1, F_GETLK, (void *)-1) != -1) {
-			tst_resm(TFAIL, "F_GETLK: fcntl(2) failed to FAIL");
-		} else if (errno != EFAULT) {
-			tst_resm(TFAIL, "F_GETLK: Expected EFAULT got %d",
-				 errno);
-		} else {
-			tst_resm(TPASS, "F_GETLK: got EFAULT");
-		}
-
-#else
-		tst_resm(TCONF, "Skip EFAULT on uClinux");
-#endif
-		flock.l_whence = -1;
-		flock.l_type = F_WRLCK;
-		flock.l_start = 0L;
-		flock.l_len = 0L;
-
-		if (fcntl(1, F_SETLK, &flock) != -1)
-			tst_resm(TFAIL, "fcntl(2) failed to FAIL");
-		else if (errno != EINVAL)
-			tst_resm(TFAIL, "Expected EINVAL, got %d", errno);
-		else
-			tst_resm(TPASS, "got EINVAL");
-
-		if (fcntl(-1, F_GETLK, &flock) != -1)
-			tst_resm(TFAIL, "fcntl(2) failed to FAIL");
-		else if (errno != EBADF)
-			tst_resm(TFAIL, "Expected EBADF, got %d", errno);
-		else
-			tst_resm(TPASS, "got EBADFD");
-	}
-
-	tst_exit();
+	TST_EXP_FAIL2(fcntl(tc->fd, tc->cmd, tc->flock), tc->exp_errno,
+		"fcntl(%d, %s, %d)", tc->fd, tc->desc, tc->exp_errno);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
+	flock.l_whence = -1;
+	flock.l_type = F_WRLCK;
+	flock.l_start = 0L;
+	flock.l_len = 0L;
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_fcntl,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

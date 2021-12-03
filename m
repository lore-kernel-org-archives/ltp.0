Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12539C433F5
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 08:16:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E38EC3C9037
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 09:16:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 650BB3C6F5D
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 09:16:16 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5C1CA10011CB
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 09:16:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638519374; i=@fujitsu.com;
 bh=VdQyIG3UP1NGiWDCvQmCa65XLIfXSLyfkyqO7ZmWphg=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=tC0aRGHdPQbLGcYuiX0WT8mSsbFN0DY5sQOvSFEAGAF6zB8gL8jaPS1X16Yv0UlPd
 o4v6LOW6GEdp3DZCc2z5rnZqfpUFBQ1H9dR+WTsxt8ELeMeNLmkz/6jawkAmCiZxj6
 0swfmwwlxqKFKDF3j4eA16S0CW6fkY5HWVgWjkAiTW6jN8TKIcEls/1Kl4XGTBF7y5
 tV6ebO5EZ9XJWigg+Vefrk65DzObW36W1n8IajpKPb/oeR2TLWr4vQPvPS6SnxkMdZ
 m3Xur7ponlDeUgH4YR+M5TWDTYCBG+LQWW6b2e4b5I7sE8CdDBJ6HRzGE+PrQKa9BE
 06o4NzcxS6maQ==
Received: from [100.115.2.64] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id D7/65-06911-E42D9A16;
 Fri, 03 Dec 2021 08:16:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8ORqOt7aWW
 iwZYbVhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aWtsfMBfMUK949WMTUwHhGqouRi0NI4Cyj
 xNdPu1ggnJ1MElfuPGeHcPYxSvTNOM7UxcjJwSagIXHtcTsziC0iICHR0fCWHcRmFlCT2H31G
 BuILSxgKdH54hhYDYuAikTnueNgNq+Aq8Tp1lVgNRICChJTHr6HigtKnJz5hAVijoTEwRcvmC
 FqFCX2793ICGFXSMyYsQ2qV03i6rlNzBMY+WchaZ+FpH0BI9MqRqukosz0jJLcxMwcXUMDA11
 DQ1NdIGlkrJdYpZuol1qqW55aXKJrqJdYXqyXWlysV1yZm5yTopeXWrKJERiWKcUM1TsY//f+
 1DvEKMnBpCTK6yq/MlGILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG/aBaCcYFFqempFWmYOMEZg0
 hIcPEoivL/OAqV5iwsSc4sz0yFSpxh1OT48mbuIWYglLz8vVUqct+ciUJEASFFGaR7cCFi8Xm
 KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzHscZApPZl4J3KZXQEcwAR1xeNZykCNKEhFSUg1
 MTWbcBedjYl4nHTQqTf9y9PfPq28YW/NENnhJRZ6SdhecYG/x4dzDCk1bi3tWpT7zoha8PsO1
 7mekK9veRG3dq7tfvPRLZV4z91eizfNVqx6pLXbUkyjMLK6z3Gq8mGcrVyh7HLfiE3d+q7jYy
 WKCJ6b+nXLh2bVJjNc0Sh+El6ZErIrrNWiskDxxs1QpP2r2Dan3CWnO8cwOJyNTde5ot/xUyu
 myb1doV/296bEoxyLH6Fu/Hqx/6Xh0+WnmK6aOB3PWqWhMthPZ8+zP1F1S3GKdskdlFMNN7KY
 /nBV0ZtmBKclczbxeOYo8mWJ7ZQ5M3LpPwKdS8Jm5+bGJf5j7mmuq22adWef/P/HJg5tKLMUZ
 iYZazEXFiQDipArIUgMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-19.tower-587.messagelabs.com!1638519373!264388!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29106 invoked from network); 3 Dec 2021 08:16:13 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-19.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Dec 2021 08:16:13 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 767051009F3
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 08:16:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 64934100243
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 08:16:13 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 3 Dec 2021 08:16:02 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 3 Dec 2021 16:16:43 -0500
Message-ID: <1638566204-6212-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/fcntl12: Convert to new API
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

1) use SAFE macro
2) use TST_EXP_FAIL2 macro

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fcntl/fcntl12.c | 135 ++++++++----------------------
 1 file changed, 36 insertions(+), 99 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl12.c b/testcases/kernel/syscalls/fcntl/fcntl12.c
index ae382dd..e4dbe42 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl12.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl12.c
@@ -1,120 +1,57 @@
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
- *	fcntl12.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	Testcase to test that fcntl() sets EMFILE for F_DUPFD command.
+ * Tests basic error handling of the fcntl syscall.
  *
- * ALGORITHM
- *	Get the size of the descriptor table of a process, by calling the
- *	getdtablesize() system call. Then attempt to use the F_DUPFD command
- *	for fcntl(), which should fail with EMFILE.
- *
- * USAGE
- *	fcntl12
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	NONE
+ * - EMFILE when cmd refers to F_DUPFD after gets the size of the descriptor table of a process
  */
 
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <errno.h>
-#include "test.h"
+#include <stdlib.h>
+#include "tst_test.h"
 
-char *TCID = "fcntl12";
-int TST_TOTAL = 1;
+static pid_t pid;
+static char fname[20] = "testfile";
+static int fd = -1;
+static int i, max_files;
 
-int fail;
-char fname[20];
-void setup(void);
-void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_fcntl(void)
 {
-	int lc;
-
-	pid_t pid;
-	int fd, i, status, max_files;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		tst_resm(TINFO, "Test for errno EMFILE");
-		fail = 0;
-
-		pid = FORK_OR_VFORK();
-		if (pid < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup, "Fork failed");
-		} else if (pid == 0) {
-			max_files = getdtablesize();
-			for (i = 0; i < max_files; i++) {
-				if ((fd = open(fname, O_CREAT | O_RDONLY,
-					       0444)) == -1) {
-					break;
-				}
-			}
-
-			if (fcntl(1, F_DUPFD, 1) != -1) {
-				tst_resm(TFAIL, "fcntl failed to FAIL");
-				exit(1);
-			} else if (errno != EMFILE) {
-				tst_resm(TFAIL, "Expected EMFILE got %d",
-					 errno);
-				exit(1);
-			}
-			exit(0);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		max_files = getdtablesize();
+		for (i = 0; i < max_files; i++) {
+			fd = open(fname, O_CREAT | O_RDONLY, 0444);
+			if (fd == -1)
+				break;
 		}
-		waitpid(pid, &status, 0);
-		if (WEXITSTATUS(status) == 0)
-			tst_resm(TPASS, "block 1 PASSED");
-		else
-			tst_resm(TFAIL, "block 1 FAILED");
+		TST_EXP_FAIL2(fcntl(1, F_DUPFD, 1), EMFILE,
+		"fcntl() got EMFILE");
 	}
-	cleanup();
-	tst_exit();
+	tst_reap_children();
+
 }
 
-void setup(void)
+static void cleanup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 
-	sprintf(fname, "fcnlt12.%d", getpid());
-	tst_tmpdir();
+	SAFE_UNLINK(fname);
 }
 
-void cleanup(void)
-{
-	unlink(fname);
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.cleanup = cleanup,
+	.test_all = verify_fcntl,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

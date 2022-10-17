Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573F0C4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 01:48:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61B603CAFDC
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 03:47:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4CF93CAFC2
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:17 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F2A410005E3
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:15 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrKVt53N2z1P7Xv
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:42:30 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:47:11 +0800
To: <ltp@lists.linux.it>
Date: Mon, 17 Oct 2022 09:43:31 +0800
Message-ID: <20221017014333.42180-4-luoxiaoyu9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
References: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.155]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] signal03.c: Rewrite using new LTP API
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
From: Luo xiaoyu via ltp <ltp@lists.linux.it>
Reply-To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rewrite using new LTP API.

Signed-off-by: Luo xiaoyu <luoxiaoyu9@huawei.com>
---
 testcases/kernel/syscalls/signal/signal03.c | 161 +++-----------------
 1 file changed, 20 insertions(+), 141 deletions(-)

diff --git a/testcases/kernel/syscalls/signal/signal03.c b/testcases/kernel/syscalls/signal/signal03.c
index 7975c770d..ad4c565ab 100644
--- a/testcases/kernel/syscalls/signal/signal03.c
+++ b/testcases/kernel/syscalls/signal/signal03.c
@@ -1,70 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2001
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
  */

-/*
- * NAME
- *	signal03.c
- *
- * DESCRIPTION
- *	signal03 - set signals to be ignored
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	check the return value
- *	  if return value == -1
- *	    issue a FAIL message, break remaining tests and cleanup
- *	  if we are doing functional testing
- *	    send the signal with kill()
- *	    if we catch the signal
- *	      issue a FAIL message
- *	    else
- *	      issue a PASS message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  signal01 [-c n] [-f] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
+/*\
+ * [Description]
  *
- * Restrictions
- *	none
+ * Set signals to be ignored.
  */

-#include "test.h"
+#include "tst_test.h"

-#include <errno.h>
-#include <signal.h>
+static void sighandler(int);

-void cleanup(void);
-void setup(void);
-void sighandler(int);
-
-int siglist[] = { SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGABRT, SIGIOT,
+static int siglist[] = { SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGABRT, SIGIOT,
 	SIGBUS, SIGFPE, SIGUSR1, SIGSEGV, SIGUSR2, SIGPIPE, SIGALRM,
 	SIGTERM,
 #ifdef SIGSTKFLT
@@ -78,97 +27,27 @@ int siglist[] = { SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGABRT, SIGIOT,
 #endif
 };

-char *TCID = "signal03";
-int TST_TOTAL = ARRAY_SIZE(siglist);
-
-typedef void (*sighandler_t) (int);
-
-sighandler_t Tret;
+static int ign_handler;

-int fail = 0;
-
-int main(int ac, char **av)
+static void do_test(unsigned int n)
 {
-	int lc;
 	pid_t pid;
-	int i, rval;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * loop through the list of signals and test each one
-		 */
-		for (i = 0; i < TST_TOTAL; i++) {

-			errno = 0;
-			Tret = signal(siglist[i], SIG_IGN);
-			TEST_ERRNO = errno;
+	SAFE_SIGNAL(siglist[n], sighandler);
+	SAFE_SIGNAL(siglist[n], SIG_IGN);

-			if (Tret == SIG_ERR) {
-				tst_brkm(TFAIL, cleanup, "%s call failed - "
-					 "errno = %d : %s", TCID,
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
+	pid = getpid();

-			/*
-			 * Send the signal.  If the signal is truly set
-			 * to be ignored, then the signal handler will
-			 * never be invoked and the test will pass.
-			 */
-			pid = getpid();
-
-			if ((rval = kill(pid, siglist[i])) != 0) {
-				tst_brkm(TBROK, cleanup, "call to "
-					 "kill failed");
-			}
-
-			if (fail == 0) {
-				tst_resm(TPASS, "%s call succeeded",
-					 TCID);
-			} else {
-				/* the signal was caught so we fail */
-				tst_resm(TFAIL, "signal caught when "
-					 "suppose to be ignored");
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	SAFE_KILL(pid, siglist[n]);
+	TST_EXP_EQ_SSZ(ign_handler, 0);
 }

-/*
- * sighandler() - the test fails if we ever get here.
- */
-void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	fail = 1;
+	ign_handler = 1;
 }

-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-	/* capture signals in our own handler */
-	tst_sig(NOFORK, sighandler, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(siglist),
+	.test = do_test,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

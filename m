Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3B7C4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 01:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ABF53CAFE0
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 03:48:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F07083CAFDA
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:17 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 465D2600685
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:16 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrKVw6t6dz1P7Z8
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:42:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:47:13 +0800
To: <ltp@lists.linux.it>
Date: Mon, 17 Oct 2022 09:43:32 +0800
Message-ID: <20221017014333.42180-5-luoxiaoyu9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
References: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.155]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] signal04.c: Rewrite using new LTP API
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
 testcases/kernel/syscalls/signal/signal04.c | 179 +++-----------------
 1 file changed, 25 insertions(+), 154 deletions(-)

diff --git a/testcases/kernel/syscalls/signal/signal04.c b/testcases/kernel/syscalls/signal/signal04.c
index 5a18fa604..73b24754f 100644
--- a/testcases/kernel/syscalls/signal/signal04.c
+++ b/testcases/kernel/syscalls/signal/signal04.c
@@ -1,181 +1,52 @@
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
  */

-/*
- * NAME
- *	signal04.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	signal04 - restore signals to default behavior
- *
- * ALGORITHM
- *	loop if that option was specified
- *	for each signal in siglist[]
- *	  set the signal handler to our own and save the return value
- *	  issue the signal system call to restore the default behavior
- *	  check the return value
- *	  if return value == -1
- *	    issue a FAIL message, break remaining tests and cleanup
- *	  if we are doing functional testing
- *	    set the signal handler to our own again and save second return value
- *	    if the first return value matches the second return value
- *	      issue a PASS message
- *	    else
- *	      issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  signal04 [-c n] [-f] [-i n] [-I x] [-p x] [-t]
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
- *
- * Restrictions
- *	none
+ * Restore signals to default behavior.
  */

-#include "test.h"
-
-#include <errno.h>
-#include <signal.h>
+#include "tst_test.h"

-void cleanup(void);
-void setup(void);
-void sighandler(int);
+static void sighandler(int);

-char *TCID = "signal04";
-
-int siglist[] = { SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGABRT,
+static int siglist[] = { SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGABRT,
 	SIGBUS, SIGFPE, SIGUSR1, SIGSEGV, SIGUSR2, SIGPIPE, SIGALRM,
 	SIGTERM, SIGCHLD, SIGCONT, SIGTSTP, SIGTTIN,
 	SIGTTOU, SIGURG, SIGXCPU, SIGXFSZ, SIGVTALRM, SIGPROF,
 	SIGWINCH, SIGIO, SIGPWR, SIGSYS
 };

-int TST_TOTAL = sizeof(siglist) / sizeof(int);
-
 typedef void (*sighandler_t) (int);

-sighandler_t Tret;
-
-int main(int ac, char **av)
+static void do_test(unsigned int n)
 {
-	int lc;
-	int i;
 	sighandler_t rval, first;

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
-
-			/* First reset the signal to the default
-			   action to clear out any pre-test
-			   execution settings */
-			signal(siglist[i], SIG_DFL);
-
-			/* then set the handler to our own handler */
-			if ((rval = signal(siglist[i], &sighandler)) == SIG_ERR) {
-				tst_brkm(TBROK, cleanup, "initial signal call"
-					 " failed");
-			}
+	SAFE_SIGNAL(siglist[n], SIG_DFL);
+	first = SAFE_SIGNAL(siglist[n], &sighandler);

-			/* store the return value */
-			first = rval;
+	SAFE_SIGNAL(siglist[n], SIG_DFL);
+	rval = SAFE_SIGNAL(siglist[n], &sighandler);

-			/* restore the default signal action */
-			errno = 0;
-			Tret = signal(siglist[i], SIG_DFL);
-			TEST_ERRNO = errno;
-
-			if (Tret == SIG_ERR) {
-				tst_brkm(TFAIL, cleanup, "%s call failed - "
-					 "errno = %d : %s", TCID, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			}
-
-			/* now set the handler back to our own */
-			if ((rval = signal(siglist[i], &sighandler))
-			    == SIG_ERR) {
-				tst_brkm(TBROK, cleanup, "initial "
-					 "signal call failed");
-			}
-
-			/*
-			 * the first return value should equal the
-			 * second one.
-			 */
-			if (rval == first) {
-				tst_resm(TPASS, "%s call succeeded "
-					 "received %p.", TCID, rval);
-			} else {
-				tst_brkm(TFAIL, cleanup, "return "
-					 "values for signal(%d) don't "
-					 "match. Got %p, expected %p.",
-					 siglist[i], rval, first);
-			}
-		}
+	if (rval == first) {
+		tst_res(TPASS, "signal(%d) restore succeeded "
+				"received %p.", siglist[n], rval);
+	} else {
+		tst_res(TFAIL, "return values for signal(%d) don't match. "
+				"Got %p, expected %p.",
+				siglist[n], rval, first);
 	}
-
-	cleanup();
-	tst_exit();
-
 }

-/*
- * sighandler() - handle the signals
- */
-void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
 }

-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
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

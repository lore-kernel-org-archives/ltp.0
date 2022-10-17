Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B12C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 01:47:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF3A93CAFD4
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 03:47:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D6853CAFCD
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:13 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2BC671400553
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:12 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKVr2YbgzmVC5
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:42:28 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:47:09 +0800
To: <ltp@lists.linux.it>
Date: Mon, 17 Oct 2022 09:43:30 +0800
Message-ID: <20221017014333.42180-3-luoxiaoyu9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
References: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.155]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] signal02.c: Rewrite using new LTP API
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
 testcases/kernel/syscalls/signal/signal02.c | 144 ++------------------
 1 file changed, 13 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/syscalls/signal/signal02.c b/testcases/kernel/syscalls/signal/signal02.c
index 8eb95b52b..54948646f 100644
--- a/testcases/kernel/syscalls/signal/signal02.c
+++ b/testcases/kernel/syscalls/signal/signal02.c
@@ -1,142 +1,24 @@
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
- *	signal02.c
- *
- * DESCRIPTION
- *	signal02 - Test that we get an error using illegal signals
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	check the return value
- *	  if return value != -1
- *	    issue a FAIL message, break remaining tests and cleanup
- *	  if we get an EINVAL
- *	    issue a PASS message
- *	  else
- *	    issue a FAIL message, break remaining tests and cleanup
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  signal02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on error logging.
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
+ * Test that we get an error using illegal signals.
  */

-#include "test.h"
-
-#include <errno.h>
-#include <signal.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "signal02";
-int TST_TOTAL = 3;
-
-typedef void (*sighandler_t) (int);
-
-sighandler_t Tret;
-int sigs[] = { _NSIG + 1, SIGKILL, SIGSTOP };
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
+#include "tst_test.h"

-	/* The following loop checks looping state if -i option given */
+static int sigs[] = { _NSIG + 1, SIGKILL, SIGSTOP };

-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * There are three cases where we should get an EINVAL
-		 */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			errno = 0;
-			Tret = signal(sigs[i], SIG_IGN);
-			TEST_ERRNO = errno;
-
-			if (Tret != SIG_ERR) {
-				tst_brkm(TFAIL, cleanup, "%s call failed - "
-					 "errno = %d : %s", TCID, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			}
-
-			switch (TEST_ERRNO) {
-			case EINVAL:
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d - %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-				break;
-			default:
-				tst_resm(TFAIL, "call failed to produce "
-					 "expected error - errno = %d "
-					 "- %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			}
-		}
-		tst_count++;	/* incr. TEST_LOOP counter */
-	}
-
-	cleanup();
-
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void do_test(unsigned int n)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	TST_EXP_FAIL2((long)signal(sigs[n], SIG_IGN), EINVAL);
 }

-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(sigs),
+	.test = do_test,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

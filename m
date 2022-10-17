Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68EAC433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 01:47:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6DFA3CAFBF
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 03:47:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 330B23CAFCF
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:12 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBE1B1400549
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:47:10 +0200 (CEST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrKVx4SfWzVjGY
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:42:33 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:47:07 +0800
To: <ltp@lists.linux.it>
Date: Mon, 17 Oct 2022 09:43:29 +0800
Message-ID: <20221017014333.42180-2-luoxiaoyu9@huawei.com>
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
Subject: [LTP] [PATCH 1/5] signal01.c: Rewrite using new LTP API
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

Rewrite using new LTP API and remove the UCLinux support.

Signed-off-by: Luo xiaoyu <luoxiaoyu9@huawei.com>
---
 testcases/kernel/syscalls/signal/signal01.c | 197 +++++---------------
 1 file changed, 43 insertions(+), 154 deletions(-)

diff --git a/testcases/kernel/syscalls/signal/signal01.c b/testcases/kernel/syscalls/signal/signal01.c
index d99e35cb7..c39190a73 100644
--- a/testcases/kernel/syscalls/signal/signal01.c
+++ b/testcases/kernel/syscalls/signal/signal01.c
@@ -1,67 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *  AUTHOR           :  Dave Baumgartner
- *                   :  Rewrote 12/92 by Richard Logan
- *  CO-PILOT         :  Barrie Kletscher
- *  DATE STARTED     :  10/17/85
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
+ * AUTHOR	: Dave Baumgartner
+ * CO-PILOT	: Barrie Kletscher
  */
-/*
- * TEST ITEMS
+
+/*\
+ * [Description]
  *
- *	1. SIGKILL can not be set to be caught, errno:EINVAL (POSIX).
- *	2. SIGKILL can not be caught.
- *	3. SIGKILL can not be set to be ignored, errno:EINVAL (POSIX).
+ * Test SIGKILL for these items:
+ *	1. SIGKILL can not be set to be ignored, errno:EINVAL (POSIX).
+ *	2. SIGKILL can not be reset to default, errno:EINVAL (POSIX).
+ *	3. SIGKILL can not be set to be caught, errno:EINVAL (POSIX).
  *	4. SIGKILL can not be ignored.
- *	5. SIGKILL can not be reset to default, errno:EINVAL (POSIX).
+ *	5. SIGKILL is reset to default failed but processed by default.
+ *	6. SIGKILL can not be caught.
  */
-#include <signal.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <sys/wait.h>

-#include "test.h"
-#include "safe_macros.h"
+#include <stdlib.h>
+#include "tst_test.h"

-static void setup(void);
-static void do_test(int tc);
-static void do_child(void);
 static void catchsig(int sig);

 static struct tcase {
-	void (*sighandler)(int);
+	void (*sighandler)(int i);
 	int kill;
 } tcases[] = {
 	{SIG_IGN, 0},
@@ -72,71 +35,37 @@ static struct tcase {
 	{catchsig, 1},
 };

-char *TCID = "signal01";
-int TST_TOTAL = ARRAY_SIZE(tcases);
-
-static int tcase;
-
-int main(int argc, char *argv[])
-{
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "d", &tcase);
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			do_test(i);
-	}
-
-	tst_exit();
-}
-
-static void do_test(int tc)
+static void do_test(unsigned int n)
 {
 	pid_t pid;
 	int res;
-	pid = FORK_OR_VFORK();
+
+	struct tcase *tc = &tcases[n];
+
+	pid = SAFE_FORK();

 	switch (pid) {
 	case 0:
-#ifdef UCLINUX
-		if (self_exec(argv0, "d", tc) < 0)
-			tst_brkm(TBROK | TERRNO, NULL, "self_exec() failed");
-#else
-		tcase = tc;
-		do_child();
-#endif
-	break;
-	case -1:
-		tst_resm(TBROK | TERRNO, "fork() failed");
+		if (tc->kill) {
+			signal(SIGKILL, tc->sighandler);
+			pause();
+		}
+
+		TST_EXP_FAIL2((long)signal(SIGKILL, tc->sighandler), EINVAL);
+		return;
 	break;
 	default:
-		if (tcases[tc].kill) {
-			TST_PROCESS_STATE_WAIT(NULL, pid, 'S');
-
-			SAFE_KILL(NULL, pid, SIGKILL);
-
-			SAFE_WAITPID(NULL, pid, &res, 0);
-
-			if (WIFSIGNALED(res)) {
-				if (WTERMSIG(res) == SIGKILL) {
-					tst_resm(TPASS, "Child killed with SIGKILL");
-				} else {
-					tst_resm(TFAIL, "Child killed with %s",
-					         tst_strsig(WTERMSIG(res)));
-				}
-			} else {
-				tst_resm(TFAIL, "Child not killed by signal");
-			}
-		} else {
-			tst_record_childstatus(NULL, pid);
-		}
+		if (tc->kill) {
+			TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+			SAFE_KILL(pid, SIGKILL);
+			SAFE_WAITPID(pid, &res, 0);
+
+			if (WIFSIGNALED(res))
+				TST_EXP_EQ_SSZ(WTERMSIG(res), SIGKILL);
+			else
+				tst_res(TFAIL, "Child not killed by signal");
+		} else
+			SAFE_WAITPID(pid, &res, 0);
 	break;
 	}
 }
@@ -146,48 +75,8 @@ static void catchsig(int sig)
 	(void)sig;
 }

-static const char *strhandler(void *sighandler)
-{
-	switch ((long)sighandler) {
-	case (long)SIG_DFL:
-		return "SIG_DFL";
-	case (long)SIG_IGN:
-		return "SIG_IGN";
-	default:
-		return "catchsig()";
-	}
-}
-
-static void do_child(void)
-{
-	void *ret;
-	void (*sighandler)(int) = tcases[tcase].sighandler;
-
-	ret = signal(SIGKILL, sighandler);
-
-	if (tcases[tcase].kill)
-		pause();
-
-	if (ret == SIG_ERR || errno == EINVAL) {
-		tst_resm(TPASS, "signal(SIGKILL, %p(%s)) failed with EINVAL",
-		         sighandler, strhandler(sighandler));
-	} else {
-		if (ret != SIG_ERR) {
-			tst_resm(TFAIL, "signal(SIGKILL, %p(%s)) didn't fail",
-			         sighandler, strhandler(sighandler));
-		} else {
-			tst_resm(TFAIL | TERRNO,
-			         "signal(SIGKILL, %p(%s)) should fail with EINVAL",
-			          sighandler, strhandler(sighandler));
-		}
-	}
-
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.test = do_test,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

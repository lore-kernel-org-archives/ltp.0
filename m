Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3CEC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 09:14:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A29A93C9AE1
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 10:14:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192F93C0309
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 10:13:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD0CC601562
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 10:13:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 976FD1F3A3;
 Wed, 23 Feb 2022 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645607630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rsbF3c2HruRI+enO1pzX/uVa1sHW4ZA1H1f5z/q8NHU=;
 b=oTF+6r55ObFvwNvO2I7PNITBybV4XzLyeJtt8F1cU3UGKTxWp2Gilheof+M6+6YGSaLCnt
 ifHlmmMrmdVmZ4J5TVcc3H/ISF0C/zlNe9iGc05h4sewzZjz5wWCbDB/KkHtgPF8pR4syn
 m0o+ezo9Lw0aYGRAZFZc68DzrKz5EoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645607630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rsbF3c2HruRI+enO1pzX/uVa1sHW4ZA1H1f5z/q8NHU=;
 b=8fEJjH9BVVW4/uPimVtd3265S4hHIBrwEqm3p4aJEmsdPYhVQAoGXS8gsj4DsZEPrRfR8t
 qmGb9UII3BiOqfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46ED113C6A;
 Wed, 23 Feb 2022 09:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HxV+C876FWKEJAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Feb 2022 09:13:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 23 Feb 2022 10:13:49 +0100
Message-Id: <20220223091349.30833-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Split waitid01.c test into multiple tests
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

Introduced LTP API usage and splitted waitid01.c into three tests:
waitid01, waitid10 and waitid11.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/waitid/.gitignore |   2 +
 testcases/kernel/syscalls/waitid/waitid01.c | 151 +++++---------------
 testcases/kernel/syscalls/waitid/waitid10.c |  47 ++++++
 testcases/kernel/syscalls/waitid/waitid11.c |  48 +++++++
 5 files changed, 133 insertions(+), 117 deletions(-)
 create mode 100644 testcases/kernel/syscalls/waitid/waitid10.c
 create mode 100644 testcases/kernel/syscalls/waitid/waitid11.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d48216a15..59e495193 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1706,6 +1706,8 @@ waitid06 waitid06
 waitid07 waitid07
 waitid08 waitid08
 waitid09 waitid09
+waitid10 waitid10
+waitid11 waitid11
 
 write01 write01
 write02 write02
diff --git a/testcases/kernel/syscalls/waitid/.gitignore b/testcases/kernel/syscalls/waitid/.gitignore
index 315af1690..089d860c7 100644
--- a/testcases/kernel/syscalls/waitid/.gitignore
+++ b/testcases/kernel/syscalls/waitid/.gitignore
@@ -7,3 +7,5 @@
 /waitid07
 /waitid08
 /waitid09
+/waitid10
+/waitid11
diff --git a/testcases/kernel/syscalls/waitid/waitid01.c b/testcases/kernel/syscalls/waitid/waitid01.c
index b6579d91d..60ecf9022 100644
--- a/testcases/kernel/syscalls/waitid/waitid01.c
+++ b/testcases/kernel/syscalls/waitid/waitid01.c
@@ -1,126 +1,43 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007                                   */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software Foundation,   */
-/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* Description: This tests the waitid() syscall                               */
-/*                                                                            */
-/* Test Name:   waitid01                                                      */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test is checking if waitid() syscall does wait for WEXITED and check for
+ * the return value.
+ */
 
-#include <stdio.h>
-#include <errno.h>
 #include <stdlib.h>
 #include <sys/wait.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <sys/stat.h>
+#include "tst_test.h"
 
-#include "test.h"
+static siginfo_t *infop;
 
-char *TCID = "waitid01";
-int testno;
-int TST_TOTAL = 3;
-
-void setup(void)
-{
-	TEST_PAUSE;
-}
-
-void display_status(siginfo_t * infop)
+static void run(void)
 {
-	tst_resm(TINFO, "Process %d terminated:", infop->si_pid);
-	tst_resm(TINFO, "code = %d", infop->si_code);
-	if (infop->si_code == CLD_EXITED)
-		tst_resm(TINFO, "exit value = %d", infop->si_status);
-	else
-		tst_resm(TINFO, "signal = %d", infop->si_status);
-}
-
-int main(int ac, char **av)
-{
-	id_t pid;
-	siginfo_t infop;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	pid_t pidchild;
 
-	setup();
+	pidchild = SAFE_FORK();
+	if (!pidchild)
+		exit(123);
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			TEST(fork());
-			if (TEST_RETURN < 0)
-				tst_brkm(TBROK | TTERRNO, NULL,
-					"fork() failed");
-
-			if (TEST_RETURN == 0) {
-				exit(123);
-			} else {
-				TEST(waitid(P_ALL, getpid(), &infop, WEXITED));
-				if (TEST_RETURN == -1) {
-					tst_brkm(TFAIL | TTERRNO,
-						 NULL,
-						 "waitid(getpid()) failed");
-				} else
-					display_status(&infop);	//CLD_EXITED = 1
-			}
-
-			TEST(fork());
-			if (TEST_RETURN < 0)
-				tst_brkm(TBROK | TTERRNO, NULL,
-					"fork() failed");
-
-			if (TEST_RETURN == 0) {
-				int a, b = 0;
-				a = 1 / b;
-				tst_exit();
-			} else {
-				TEST(waitid(P_ALL, 0, &infop, WEXITED));
-				if (TEST_RETURN == -1) {
-					tst_brkm(TFAIL | TTERRNO,
-						 NULL, "waitid(0) failed");
-				} else
-					display_status(&infop);	//CLD_DUMPED = 3 ; SIGFPE = 8
-			}
-
-			TEST(pid = fork());
-			if (TEST_RETURN < 0)
-				tst_brkm(TBROK | TTERRNO, NULL,
-					"fork() failed");
-
-			if (TEST_RETURN == 0) {
-				TEST(sleep(10));
-				tst_exit();
-			}
-			TEST(kill(pid, SIGHUP));
-			TEST(waitid(P_ALL, 0, &infop, WEXITED));
-			if (TEST_RETURN == -1) {
-				tst_brkm(TFAIL | TTERRNO, NULL,
-					 "waitid(0) failed");
-			} else
-				display_status(&infop);	//CLD_KILLED = 2 ; SIGHUP = 1
-		}
-	}
-	tst_resm(TPASS, "waitid(): system call passed");
-	tst_exit();
+	TST_EXP_PASS(waitid(P_ALL, getpid(), infop, WEXITED));
+	TST_EXP_EQ_LI(infop->si_pid, pidchild);
+	TST_EXP_EQ_LI(infop->si_status, 123);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_EXITED);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.bufs =
+		(struct tst_buffers[]){
+			{ &infop, .size = sizeof(*infop) },
+			{},
+		},
+};
diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
new file mode 100644
index 000000000..3b2b0fae9
--- /dev/null
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test is checking if waitid() syscall recognizes a process that ended
+ * with division by zero error.
+ */
+
+#include <stdlib.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+
+static siginfo_t *infop;
+
+static void run(void)
+{
+	pid_t pidchild;
+
+	pidchild = SAFE_FORK();
+	if (!pidchild) {
+		volatile int a, zero = 0;
+
+		a = 1 / zero;
+		exit(0);
+	}
+
+	TST_EXP_PASS(waitid(P_ALL, pidchild, infop, WEXITED));
+	TST_EXP_EQ_LI(infop->si_pid, pidchild);
+	TST_EXP_EQ_LI(infop->si_status, SIGFPE);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_DUMPED);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.bufs =
+		(struct tst_buffers[]){
+			{ &infop, .size = sizeof(*infop) },
+			{},
+		},
+};
diff --git a/testcases/kernel/syscalls/waitid/waitid11.c b/testcases/kernel/syscalls/waitid/waitid11.c
new file mode 100644
index 000000000..8f2b847ea
--- /dev/null
+++ b/testcases/kernel/syscalls/waitid/waitid11.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test is checking if waitid() syscall recognizes a process that has been
+ * killed with SIGKILL.
+ */
+
+#include <time.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+
+static siginfo_t *infop;
+
+static void run(void)
+{
+	pid_t pidchild;
+
+	pidchild = SAFE_FORK();
+	if (!pidchild) {
+		sleep(10);
+		return;
+	}
+
+	SAFE_KILL(pidchild, SIGKILL);
+
+	TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
+	TST_EXP_EQ_LI(infop->si_pid, pidchild);
+	TST_EXP_EQ_LI(infop->si_status, SIGKILL);
+	TST_EXP_EQ_LI(infop->si_signo, SIGCHLD);
+	TST_EXP_EQ_LI(infop->si_code, CLD_KILLED);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.bufs =
+		(struct tst_buffers[]){
+			{ &infop, .size = sizeof(*infop) },
+			{},
+		},
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

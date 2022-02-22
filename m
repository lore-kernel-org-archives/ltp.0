Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C3BC433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 14:36:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DF403CA1AD
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 15:36:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AE113C97EB
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:35:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5674B1401627
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:35:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9842321129;
 Tue, 22 Feb 2022 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645540551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mITFFO2AQQXx3OsIMnaqp1ylNS/cA+ROnYEtBrQ+CbQ=;
 b=Was4DUeODstJkDTZTRRFdOvVdy710B9ySUzODObvsEg2HRnKkls/MtsH5aBZDwAtJlgOKA
 EjkXb4pRzLfcKoG1JqwoQVfRiUakfNzzL9tLfbx3TvB1CJUB9vm6JYjJISo4U/A3VhtZA5
 Mk4NmfT9HysZDA6PNnv1l7en4/J4fls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645540551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mITFFO2AQQXx3OsIMnaqp1ylNS/cA+ROnYEtBrQ+CbQ=;
 b=cdIsx+CjZsLvwmr/8jwQcTcgU7A9J2v2iFxJM1abwgQFNHXdd6JFmcw3tWA2Kg8vkUIkUT
 NtwbgNFqdAlP+LDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F26FA13BE0;
 Tue, 22 Feb 2022 14:35:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F0T1NMb0FGL0BgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 22 Feb 2022 14:35:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 22 Feb 2022 15:35:49 +0100
Message-Id: <20220222143549.3286-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Rewrite waitid01.c test using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/syscalls/waitid/waitid01.c | 151 +++++---------------
 1 file changed, 34 insertions(+), 117 deletions(-)

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
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

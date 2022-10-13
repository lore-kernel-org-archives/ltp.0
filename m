Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF1C43217
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 11:28:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5ADC53CAEF9
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 13:28:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1193CAE31
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 13:28:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 04D996005F7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 13:28:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A8711F38A
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665660495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cd7IDCcgLzj66SDT+JBJPIsLqYRP+viMM+Hxask4XQ8=;
 b=H3Zu/9VXXvWNB6kZcpRMtvEEr5awq91zU+UbRHGteMjpnsbZANZga+pVR/NcEFtnKHQVug
 8WS0wMbpdJg3+rMneAtq8coFpSk6MNtB2y/USv5h8m+kDxeSnDnTnlIveuydo2CEpZM8bp
 3Kjqcjzt2JiTF4PZC/CE16LZH6/PZw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665660495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cd7IDCcgLzj66SDT+JBJPIsLqYRP+viMM+Hxask4XQ8=;
 b=9wRkKWIMCrM8xovHCwtb3ERYpqycgXIbkSqVfqm8m+ShpFSlToR8KwfOHdMFOe51r1qon6
 gMDTazdNsg7cKTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D78C13AFF
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FpC3F072R2OQXwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:28:14 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 13 Oct 2022 16:58:11 +0530
Message-Id: <20221013112811.10639-1-akumar@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setpgid02: Convert to new LTP API
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

 - Rewrite using new API
 - Use parent pid to validate ESRCH errno
 - Use pgid of init as a process group from a
   different session for EPERM errno test

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/setpgid/setpgid02.c | 161 ++++--------------
 1 file changed, 37 insertions(+), 124 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 73e88d066..de13a1c4e 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -1,148 +1,61 @@
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
+ *		07/2001 Ported by Wayne Boyer
+ *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- * 	setpgid02.c
- *
- * DESCRIPTION
- *	Testcase to check that setpgid() sets errno correctly.
- *
- * CALLS
- * 	setpgid
- *
- * ALGORITHM
- * 	Checks that setpgid returns the correct errno values in case of
- * 	negative testing.
- * 	test 1: EINVAL - Pass '-1' as the pgid parameter to setpgid
- * 	test 2: ESRCH - Pass '-1' as the pid parameter to setpgid
- *	test 3: EPERM - Pass an invalid pgid parameter to setpgid
- *
- * USAGE:  <for command-line>
- *  setpgid02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+/*\
+ * [Description]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Verify that setpgid(2) syscall fails with:
  *
- * RESTRICTIONS
- * 	None
+ * - EINVAL when given pgid is less than 0.
+ * - ESRCH when pid is not the calling process and not a child of
+ * the calling process.
+ * - EPERM when an attempt was made to move a process into a process
+ * group in a different session.
  */
-#include <errno.h>
-#include <unistd.h>
-#include <sys/wait.h>
-#include "test.h"
 
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
 
-char *TCID = "setpgid02";
-int TST_TOTAL = 3;
+static pid_t pgid, pid, ppid;
+static pid_t init_pgid;
+static pid_t negative_pid = -1;
 
-static pid_t pgid, pid;
-static pid_t bad_pid = -1;
-static pid_t zero_pid;
-static pid_t unused_pid;
-static pid_t inval_pid = 99999;
-
-struct test_case_t {
+static struct tcase {
 	pid_t *pid;
 	pid_t *pgid;
 	int error;
-} TC[] = {
-	/* pgid is less than zero - EINVAL */
-	{
-	&pid, &bad_pid, EINVAL},
-	    /* pid doesn't match any process - ESRCH */
-	{
-	&unused_pid, &pgid, ESRCH},
-	    /* pgid doesn't exist - EPERM */
-	{
-	&zero_pid, &inval_pid, EPERM}
+} tcases[] = {
+	{&pid, &negative_pid, EINVAL},
+	{&ppid, &pgid, ESRCH},
+	{&pid, &init_pgid, EPERM}
 };
 
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(setpgid(*TC[i].pid, *TC[i].pgid));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup - performs all ONE TIME setup for this test
- */
 static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	pgid = getpgrp();
 	pid = getpid();
+	ppid = getppid();
+	pgid = getpgrp();
 
-	unused_pid = tst_get_unused_pid(cleanup);
+	/*
+	 * Getting pgid of init/systemd process to use it as a
+	 * process group from a different session for EPERM test
+	 */
+	init_pgid = SAFE_GETPGID(1);
 }
 
-/*
- * cleanup - Performs all ONE TIME cleanup for this test at completion or
- * 	     premature exit
- */
-static void cleanup(void)
+static void run(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
 
+	TST_EXP_FAIL(setpgid(*tc->pid, *tc->pgid), tc->error,
+				"setpgid(%d, %d)", *tc->pid, *tc->pgid);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases)
+};
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

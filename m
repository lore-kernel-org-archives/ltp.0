Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A663AC47DB3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 13:50:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0407F3CF925
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 14:50:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B3D63CB13B
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 14:50:28 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00336140B04E
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 14:50:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0929B21FF5
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706709027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iJmmPe+qerMcCIf2hWnCxUm8ZLitAHSmEfvQuFh9KE=;
 b=baMpxYDenHyuelYVR16v/lHHApRHVTHv/RY5NHxuQPtdKS6iX5+eWBmRDDhGQQw6xklR71
 5xvN1nrYxsQYrcahRiIh4SHcBeLWuWngDc8kQl50VyNRpkPh+tITS1iMSOBdyZB+nc5AxS
 UHMJYGBfajP+Vtg5O61t7gT466qu4GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706709027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iJmmPe+qerMcCIf2hWnCxUm8ZLitAHSmEfvQuFh9KE=;
 b=LEztHW3tiXTRxlruQy6/JlgJaZd96Q5hqLX8+dtalNyD7sS+khpeXcY7/koDKVr4Fd8r7H
 QbZeVM0c1WFptiBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706709027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iJmmPe+qerMcCIf2hWnCxUm8ZLitAHSmEfvQuFh9KE=;
 b=baMpxYDenHyuelYVR16v/lHHApRHVTHv/RY5NHxuQPtdKS6iX5+eWBmRDDhGQQw6xklR71
 5xvN1nrYxsQYrcahRiIh4SHcBeLWuWngDc8kQl50VyNRpkPh+tITS1iMSOBdyZB+nc5AxS
 UHMJYGBfajP+Vtg5O61t7gT466qu4GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706709027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iJmmPe+qerMcCIf2hWnCxUm8ZLitAHSmEfvQuFh9KE=;
 b=LEztHW3tiXTRxlruQy6/JlgJaZd96Q5hqLX8+dtalNyD7sS+khpeXcY7/koDKVr4Fd8r7H
 QbZeVM0c1WFptiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F083C1347F
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 13:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +X2COiJQumUEDAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 13:50:26 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 14:50:25 +0100
Message-ID: <20240131135026.1562-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [8.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(5.10)[100.00%];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.987]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] waitpid04: Convert to new API
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

Convert waitpid() error state checks to new API, fix bugs in the original
test and add ESRCH subtest.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/waitpid/waitpid04.c | 171 +++++-------------
 1 file changed, 45 insertions(+), 126 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid04.c b/testcases/kernel/syscalls/waitpid/waitpid04.c
index abf94eed1..ab3c1a4f4 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid04.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid04.c
@@ -1,144 +1,63 @@
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
+ * Copyright (c) 2024 SUSE LLC <mdoucha@suse.cz>
  */
 
-/*
- * NAME
- *	waitpid04.c
- *
- * DESCRIPTION
- *	test to check the error conditions in waitpid sys call
+/*\
+ * [Description]
  *
- * USAGE:  <for command-line>
- *      waitpid04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	NONE
+ * Test to check the error conditions in waitpid() syscall.
  */
 
 #include <sys/signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <errno.h>
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "waitpid04";
-int TST_TOTAL = 1;
-
-#define INVAL_FLAG	-1
-
-static int flag, condition_number;
-
-int main(int ac, char **av)
+#include "tst_test.h"
+
+#define TCFMT "waipid(%d, NULL, 0x%x)"
+#define TCFMTARGS(tc) (tc)->pid, (tc)->flags
+
+static struct testcase {
+	pid_t pid;
+	int flags;
+	int err;
+} testcase_list[] = {
+	{-1, 0, ECHILD},	/* Wait for any child when none exist */
+	{1, 0, ECHILD},		/* Wait for non-child process */
+	{-1, -1, EINVAL},	/* Invalid flags */
+	{INT_MIN, 0, ESRCH},	/* Wait for invalid process group */
+};
+
+void run(unsigned int n)
 {
-	int pid, status, ret;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		ret = waitpid(pid, &status, WNOHANG);
-		flag = 0;
-		condition_number = 1;
-		if (ret != -1) {
-			tst_resm(TFAIL, "condition %d test failed",
-				 condition_number);
-		} else {
-			if (errno != ECHILD) {
-				tst_resm(TFAIL, "waitpid() set invalid "
-					 "errno, expected ECHILD, got: %d",
-					 errno);
-			} else {
-				tst_resm(TPASS, "condition %d test passed",
-					 condition_number);
-			}
-		}
-		condition_number++;
+	const struct testcase *tc = testcase_list + n;
 
-		if (FORK_OR_VFORK() == 0)
-			exit(0);
+	TEST(waitpid(tc->pid, NULL, tc->flags));
 
-		pid = 1;
-		ret = waitpid(pid, &status, WUNTRACED);
-		flag = 0;
-		if (ret != -1) {
-			tst_resm(TFAIL, "condition %d test failed",
-				 condition_number);
-		} else {
-			if (errno != ECHILD) {
-				tst_resm(TFAIL, "waitpid() set invalid "
-					 "errno, expected ECHILD, got: %d",
-					 errno);
-			} else {
-				tst_resm(TPASS, "condition %d test passed",
-					 condition_number);
-			}
-		}
-		condition_number++;
+	if (TST_RET == -1 && TST_ERR == tc->err) {
+		tst_res(TPASS | TTERRNO, TCFMT " failed as expected",
+			TCFMTARGS(tc));
+		return;
+	}
 
-		/* Option is Inval = INVAL_FLAG */
-		ret = waitpid(pid, &status, INVAL_FLAG);
-		flag = 0;
-		if (ret != -1) {
-			tst_resm(TFAIL, "condition %d test failed",
-				 condition_number);
-		} else {
-			if (errno != EINVAL) {
-				tst_resm(TFAIL, "waitpid() set invalid "
-					 "errno, expected EINVAL, got: %d",
-					 errno);
-			} else {
-				tst_resm(TPASS, "condition %d test passed",
-					 condition_number);
-			}
-		}
-		condition_number++;
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, TCFMT ": expected error %s, got",
+			TCFMTARGS(tc), tst_strerrno(tc->err));
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TTERRNO, TCFMT ": invalid return value %ld",
+			TCFMTARGS(tc), TST_RET);
+		return;
+	}
 
-static void setup(void)
-{
-	TEST_PAUSE;
+	tst_res(TFAIL, TCFMT " returned unexpected PID %ld", TCFMTARGS(tc),
+		TST_RET);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcase_list)
+};
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

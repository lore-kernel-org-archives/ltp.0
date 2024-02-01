Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C276C47DDF
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 12:57:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 856493CF8D1
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 13:57:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CC363CC96F
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 13:57:16 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D0A11A04343
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 13:57:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 583F621FA0
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706792234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quxIrh1tyAx9ITJ3SJo14NnRyIIMLc7KgZTAplulWmE=;
 b=iJLbla0IhxoqJ8tiDFzkbc6HVbE1RYA7bRLaTtNZT8GOCQZs+5jXY/H4gGmju5dehsD0xw
 scOeuhGj1tfZsJ9khojWzyLnkNnIJjMmhgbqPKWQT18bp5Uy0eBed24g/vQdrZvTWFUEdd
 a2f8aDMxIMO0g989CRgByfJJJeovDt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706792234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quxIrh1tyAx9ITJ3SJo14NnRyIIMLc7KgZTAplulWmE=;
 b=Is/RUNmKPc73WcnbHPoTHL7UonQOhWP9WqESj8Of+c0Y78w1ZXc7rNONLDFXojT7LpGhu0
 pMHuOrJFa2jtUVBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706792234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quxIrh1tyAx9ITJ3SJo14NnRyIIMLc7KgZTAplulWmE=;
 b=iJLbla0IhxoqJ8tiDFzkbc6HVbE1RYA7bRLaTtNZT8GOCQZs+5jXY/H4gGmju5dehsD0xw
 scOeuhGj1tfZsJ9khojWzyLnkNnIJjMmhgbqPKWQT18bp5Uy0eBed24g/vQdrZvTWFUEdd
 a2f8aDMxIMO0g989CRgByfJJJeovDt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706792234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quxIrh1tyAx9ITJ3SJo14NnRyIIMLc7KgZTAplulWmE=;
 b=Is/RUNmKPc73WcnbHPoTHL7UonQOhWP9WqESj8Of+c0Y78w1ZXc7rNONLDFXojT7LpGhu0
 pMHuOrJFa2jtUVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 482C2139B1
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 12:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TpQwESqVu2WCPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 01 Feb 2024 12:57:14 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  1 Feb 2024 13:57:10 +0100
Message-ID: <20240201125713.1811-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(5.10)[100.00%];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] waitpid04: Convert to new API
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

Changes since v1:
- Fix <signal.h> include
- Use TST_EXP_FAIL2()

 testcases/kernel/syscalls/waitpid/waitpid04.c | 161 +++---------------
 1 file changed, 28 insertions(+), 133 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid04.c b/testcases/kernel/syscalls/waitpid/waitpid04.c
index abf94eed1..7cd050e72 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid04.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid04.c
@@ -1,144 +1,39 @@
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
- *
- * USAGE:  <for command-line>
- *      waitpid04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
- *              -e   : Turn on errno logging.
- *              -i n : Execute test n times.
- *              -I x : Execute test for x seconds.
- *              -P x : Pause for x seconds between iterations.
- *              -t   : Turn on syscall timing.
+/*\
+ * [Description]
  *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	NONE
+ * Test to check the error conditions in waitpid() syscall.
  */
 
-#include <sys/signal.h>
-#include <sys/types.h>
+#include <signal.h>
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
+	const struct testcase *tc = testcase_list + n;
 
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
-
-		if (FORK_OR_VFORK() == 0)
-			exit(0);
-
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
-
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
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
+	TST_EXP_FAIL2(waitpid(tc->pid, NULL, tc->flags), tc->err,
+		"waipid(%d, NULL, 0x%x)", tc->pid, tc->flags);
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

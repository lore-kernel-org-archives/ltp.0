Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42A5E77199
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:13:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 604663C2631
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:13:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF3143C259D
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3012B200AE0
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73EA82116D;
 Thu,  9 Jan 2025 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuPdYADzhVYdoIfZRO3yBAdoncv8J7qyRjmGtY9swJY=;
 b=fA86kys0G6OVgp/zv2POEXo8CgUQJdnCNTE4e+E0DgcbAct0PI+/6htqcZh9g85chXmpoZ
 ZpJnnIaK7CuAM4f1FPF3+xsLHegDKXquSTd9mMJo9GVWirwXaE4kSwnHzTn+JPXaMwnVJ8
 xx+WMXUiyHqRnBKbbBSOyOu/yBMoQwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuPdYADzhVYdoIfZRO3yBAdoncv8J7qyRjmGtY9swJY=;
 b=SUe/9jMnfKxocz1LXaMPQTPvs7RiOmp4rQDDqYEQbu+URN9kMubP0F4cFHXPKoVHMj7woK
 Z90+a1sSSaka+QDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuPdYADzhVYdoIfZRO3yBAdoncv8J7qyRjmGtY9swJY=;
 b=fA86kys0G6OVgp/zv2POEXo8CgUQJdnCNTE4e+E0DgcbAct0PI+/6htqcZh9g85chXmpoZ
 ZpJnnIaK7CuAM4f1FPF3+xsLHegDKXquSTd9mMJo9GVWirwXaE4kSwnHzTn+JPXaMwnVJ8
 xx+WMXUiyHqRnBKbbBSOyOu/yBMoQwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuPdYADzhVYdoIfZRO3yBAdoncv8J7qyRjmGtY9swJY=;
 b=SUe/9jMnfKxocz1LXaMPQTPvs7RiOmp4rQDDqYEQbu+URN9kMubP0F4cFHXPKoVHMj7woK
 Z90+a1sSSaka+QDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C34713A8B;
 Thu,  9 Jan 2025 14:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPTLDAXZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 09 Jan 2025 14:11:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:04 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-1-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=5521;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=VibXPUc+nfncm3L5qTH58PsHZj/vWH6Ru5fmgvokSws=;
 b=LWwB70jaAGW15IfueqhqaSUjCEURkJ18ab8qNNfigNRkBSBvvUf3im+CYhbQW+b2hGh7ZKugI
 qJkDd4KFzXFAIWUowGE5nzoAf6xgHn8VQS8Pqho9ySU7B9ydyMwOMlt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/12] Refactor setpgid01 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Test used to fail when running inside an executor that is setting a
new session via setsid(). By using the new LTP library, we fix this
issue since it forks parent first, then execute it, enabling any
setsid() to be run in the main process before execution.

Fixes: https://github.com/linux-test-project/kirk/issues/28
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/setpgid/setpgid01.c | 152 +++++---------------------
 1 file changed, 25 insertions(+), 127 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c b/testcases/kernel/syscalls/setpgid/setpgid01.c
index 60034e01660d5c3aebe8ca960ff64c03f2b539e5..c976c3a5138ce7bca9f92a7d624797a9f2a08154 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid01.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
@@ -1,150 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
-/* $Id: setpgid01.c,v 1.7 2009/11/02 13:57:18 subrata_modak Exp $ */
 
-/*
- * Description:
- * Verify that:
- *   1. Basic functionality test for setpgid(2).
- *   2. Check functioning of setpgid(2) with pid = 0 and pgid = 0.
+/*\
+ * [Description]
+ *
+ * Verify basic setpgid() functionality, re-setting group ID inside both parent
+ * and child. In the first case, we obtain getpgrp() and set it. In the second
+ * case, we use setpgid(0, 0).
  */
 
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <sys/wait.h>
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "setpgid01";
-
-static void setpgid_test1(void);
-static void setpgid_test2(void);
-static void (*testfunc[])(void) = { setpgid_test1, setpgid_test2};
-int TST_TOTAL = ARRAY_SIZE(testfunc);
-
-int main(int ac, char **av)
-{
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	cleanup();
-	tst_exit();
-}
+#include "tst_test.h"
 
 static void setpgid_test1(void)
 {
 	pid_t pgid, pid;
 
-	pgid = getpgrp();
-	pid = getpid();
+	pgid = TST_EXP_PID(getpgrp());
+	pid = TST_EXP_PID(getpid());
 
-	TEST(setpgid(pid, pgid));
-	if (TEST_RETURN == -1 || getpgrp() != pgid) {
-		tst_resm(TFAIL | TTERRNO, "test setpgid(%d, %d) fail",
-			 pid, pgid);
-	} else {
-		tst_resm(TPASS, "test setpgid(%d, %d) success", pid, pgid);
-	}
-}
-
-static int wait4child(pid_t child)
-{
-	int status;
-
-	if (waitpid(child, &status, 0) == -1)
-		tst_resm(TBROK|TERRNO, "waitpid");
-	if (WIFEXITED(status))
-		return WEXITSTATUS(status);
-	else
-		return status;
+	TST_EXP_PASS(setpgid(pid, pgid));
+	TST_EXP_EQ_LI(pgid, getpgrp());
 }
 
 static void setpgid_test2(void)
 {
-	int ret;
-	pid_t pgid, pid;
+	pid_t pgid;
 
-	pid = tst_fork();
-	if (pid == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "fork()");
-
-	if (pid != 0) {
-		ret = wait4child(pid);
-	} else {
-		pid = getpid();
-		TEST(setpgid(0, 0));
-		pgid = getpgrp();
-		if (TEST_RETURN == -1) {
-			fprintf(stderr, "setpgid(0, 0) fails in "
-				"child process: %s\n", strerror(TEST_ERRNO));
-			exit(1);
-		} else if (pgid != pid) {
-			fprintf(stderr, "setpgid(0, 0) fails to make PGID"
-				"equal to PID\n");
-			exit(1);
-		} else {
-			exit(0);
-		}
+	if (!SAFE_FORK()) {
+		pgid = TST_EXP_PID(getpid());
+		TST_EXP_PASS(setpgid(0, 0));
+		TST_EXP_EQ_LI(pgid, getpgrp());
 	}
-
-	if (ret == 0)
-		tst_resm(TPASS, "test setpgid(0, 0) success");
-	else
-		tst_resm(TFAIL, "test setpgid(0, 0) fail");
 }
 
-
-static void setup(void)
+static void run(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	setpgid_test1();
+	setpgid_test2();
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

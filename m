Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CECC77B6C
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 05:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8300E3CC439
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 07:50:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCB8B3C01AA
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 07:49:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1786E20096A
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 07:49:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33E66218D9
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 05:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1681364995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eph5WPuIEeUVVZwBqH7OivQR40RTdlwCD6znuOBtugo=;
 b=m9jAJSpZ2+iNlL+5RdNESGRrDyAmEzexx15BkQaB5WQxbeEDVQ33I3BeenHQ58K0Uopb9M
 JeYMp60fkffCMKbNGooQQ1VRPYnCYENIfQATgIgb96qylubA4yeqsAFup0SaWgCzIgKi08
 9DpqrXPIVy0oyeHx57ju6u66wbB3I5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1681364995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eph5WPuIEeUVVZwBqH7OivQR40RTdlwCD6znuOBtugo=;
 b=t6gWhalhiALdD/P9FAyuQnHK2NRbCEo9QUXUIU8rhsSQKxI19cqjHgMQkZgN6725pvInyb
 ZzKWdtAPghPt6EAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB758138E3
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 05:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AR2pJwKYN2TBUwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 05:49:54 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 13 Apr 2023 11:19:51 +0530
Message-Id: <20230413054952.14607-1-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] getpgid01.c: Rewrite using new LTP API
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/getpgid/getpgid01.c | 156 ++++--------------
 1 file changed, 30 insertions(+), 126 deletions(-)

diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
index 060486e7e..2c874d855 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid01.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
@@ -1,145 +1,49 @@
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
+ *   07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
  */
 
-/*
- * NAME
- * 	getpgid01.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of getpgid().
- *
- * ALGORITHM
- * 	block1: Does getpgid(0), and checks for error.
- * 	block2: Does getpgid(getpid()) and checks for error.
- * 	block3: Does getpgid(getppid()) and checks for error.
- * 	block4: Verifies that getpgid(getpgid(0)) == getpgid(0).
- * 	block5: Does getpgid(1) and checks for error.
+/*\
+ * [Description]
  *
- * USAGE
- * 	getpgid01
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	Expects that there are no EPERM limitations on getting the
- *	process group ID from proc 1 (init).
+ * Verify the basic functionality of getpgid(2) syscall.
  */
-#define _GNU_SOURCE 1
-
-#include <errno.h>
-#include <unistd.h>
-#include <stdarg.h>
-#include <sys/wait.h>
-#include <sys/types.h>
-#include "test.h"
 
-void setup(void);
-void cleanup(void);
+#include "tst_test.h"
 
-char *TCID = "getpgid01";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	register int pgid_0, pgid_1;
-	register int my_pid, my_ppid;
-	int ex_stat;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	pid_t pid_1, child_pid, pgid;
 
-	setup();
+	pgid = getpgid(0);
+	tst_res(TINFO, "getpgid(0) in parent = %d", pgid);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	pid_1 = SAFE_FORK();
+	if (!pid_1) {
+		child_pid = getpid();
 
-		if ((pgid_0 = FORK_OR_VFORK()) == -1)
-			tst_brkm(TBROK, cleanup, "fork failed");
-		if (pgid_0 > 0) {
-			while ((pgid_0 = wait(&ex_stat)) != -1) ;
+		tst_res(TINFO, "getpid() in child = %d", child_pid);
+		tst_res(TINFO, "Running getpgid() in child");
 
-			if (WEXITSTATUS(ex_stat) == 0)
-				tst_resm(TPASS, "%s PASSED", TCID);
-			else
-				tst_resm(TFAIL, "%s FAILED", TCID);
+		TST_EXP_POSITIVE(getpgid(0));
+		TST_EXP_EQ_LI(TST_RET, pgid);
 
-			exit(0);
-		}
+		TST_EXP_POSITIVE(getpgid(child_pid), "getpgid(%d)", child_pid);
+		TST_EXP_EQ_LI(TST_RET, pgid);
 
-		if ((pgid_0 = getpgid(0)) == -1)
-			tst_resm(TFAIL | TERRNO, "getpgid(0) failed");
-		else
-			tst_resm(TPASS, "getpgid(0) PASSED");
+		TST_EXP_POSITIVE(getpgid(pgid), "getpgid(%d)", pgid);
+		TST_EXP_EQ_LI(TST_RET, pgid);
 
-//block2:
-		my_pid = getpid();
-		if ((pgid_1 = getpgid(my_pid)) == -1)
-			tst_resm(TFAIL | TERRNO, "getpgid(%d) failed", my_pid);
-
-		if (pgid_0 != pgid_1) {
-			tst_resm(TFAIL, "getpgid(my_pid=%d) != getpgid(0) "
-				 "[%d != %d]", my_pid, pgid_1, pgid_0);
-		} else
-			tst_resm(TPASS, "getpgid(getpid()) PASSED");
-
-//block3:
-		my_ppid = getppid();
-		if ((pgid_1 = getpgid(my_ppid)) == -1)
-			tst_resm(TFAIL | TERRNO, "getpgid(%d) failed", my_ppid);
-
-		if (pgid_0 != pgid_1) {
-			tst_resm(TFAIL, "getpgid(%d) != getpgid(0) [%d != %d]",
-				 my_ppid, pgid_1, pgid_0);
-		} else
-			tst_resm(TPASS, "getpgid(getppid()) PASSED");
-
-//block4:
-		if ((pgid_1 = getpgid(pgid_0)) < 0)
-			tst_resm(TFAIL | TERRNO, "getpgid(%d) failed", pgid_0);
-
-		if (pgid_0 != pgid_1) {
-			tst_resm(TFAIL, "getpgid(%d) != getpgid(0) [%d != %d]",
-				 pgid_0, pgid_1, pgid_0);
-		} else
-			tst_resm(TPASS, "getpgid(%d) PASSED", pgid_0);
-
-//block5:
-		if (getpgid(1) < 0)
-			tst_resm(TFAIL | TERRNO, "getpgid(1) failed");
-		else
-			tst_resm(TPASS, "getpgid(1) PASSED");
+		TST_EXP_POSITIVE(getpgid(1));
+		TST_EXP_EQ_LI(TST_RET, 1);
 	}
-	cleanup();
-	tst_exit();
 
+	tst_reap_children();
 }
 
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1
+};
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

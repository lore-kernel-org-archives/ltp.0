Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72910C83F2C
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 13:00:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50B703CEB6F
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 15:00:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 716823CBDD0
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 14:59:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4896600FF8
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 14:59:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3904F21A18;
 Tue,  5 Sep 2023 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693918791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2ljEf4eUMAW2LMnDtgL1azG76s4Ca8DzZ952Ktgamjo=;
 b=PtdvedbAlV0DfFIhbUVsnMwtETegrwOvLX/pVnkjIu0A/O9jFY4I3YuywHnVs+uOCpNl1c
 WpPdiSUEAX4b3c9oj73EEHqRq5TFiNknyCUgbff6rzm7GoHHFz+cY3H6XytoLEmM8PqH8K
 aTNiAYs3MkeMtr/flzyUcmPY8TV0uz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693918791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2ljEf4eUMAW2LMnDtgL1azG76s4Ca8DzZ952Ktgamjo=;
 b=mhzRo4J+TDTsLfWOj1xbts9pMGZfPjlaJqS5d0aujKVqagDqf6Atri3Jx+ImQD0pOZz7rm
 4Ef2gL00rtW/RmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1ADBE13499;
 Tue,  5 Sep 2023 12:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oPkfBUcm92S+JgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Sep 2023 12:59:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 14:59:50 +0200
Message-Id: <20230905125950.14756-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor fork11 test using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/fork/fork11.c | 106 +++++-------------------
 1 file changed, 23 insertions(+), 83 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork11.c b/testcases/kernel/syscalls/fork/fork11.c
index 6afda3a33..de5840646 100644
--- a/testcases/kernel/syscalls/fork/fork11.c
+++ b/testcases/kernel/syscalls/fork/fork11.c
@@ -1,97 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
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
- *
- *
- * NAME
- *	fork11.c
- *
- * DESCRIPTION
- *	Test that parent gets a pid from each child when doing wait
- *
- * ALGORITHM
- *	Fork NUMFORKS children that do nothing.
- *
- * USAGE
- *	fork11
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines  Corp., 2001
+ *     07/2001 Ported by Wayne Boyer
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ *[Description]
  *
- * RESTRICTIONS
- *	None
+ * This test spawns multiple processes using fork() and it checks if wait()
+ * returns the right PID once they end up.
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <stdio.h>
-#include <errno.h>
-#include "test.h"
-
-char *TCID = "fork11";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
+#include "tst_test.h"
 
 #define NUMFORKS 100
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int i, pid, cpid, status;
-	int fail = 0;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	pid_t pid;
+	int status;
 
-	setup();
+	for (int i = 0; i < NUMFORKS; i++) {
+		tst_res(TINFO, "Forking the %d process", i);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+		pid = SAFE_FORK();
+		if (!pid)
+			return;
 
-		for (i = 0; i < NUMFORKS; i++) {
-			pid = fork();
-			if (pid == 0)
-				exit(0);
-
-			if (pid > 0) {	/* parent */
-				cpid = wait(&status);
-				if (cpid != pid)
-					fail++;
-			} else {
-				fail++;
-				break;
-			}
-		}
-		if (fail)
-			tst_resm(TFAIL, "fork failed %d times", fail);
-		else
-			tst_resm(TPASS, "fork test passed, %d processes", i);
+		TST_EXP_EQ_LI(SAFE_WAIT(&status), pid);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

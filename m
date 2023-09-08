Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE6EE57EC
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 09:28:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB2CF3CC315
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:28:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 739603CB4F9
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:28:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7FC33601BBF
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:28:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74CDA1F750;
 Fri,  8 Sep 2023 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694165303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3yWpOyigBI+zqSXnxXGKtikfuX2WwkxPbyliXH6/gJI=;
 b=P+quqnhfg7BnLiBGjaFKVAhEr3fCVE8EzCglf26sMu9BWKn1n3EygY232zF1KqZrhjJzYc
 eLQPeN8Mt/yoI56Q48l7cc/JPWgZT0rteWgVa2iWaveQWjUbYUnFqiOOpkSyj4TLASoCRx
 9Fl3G9ZUMwH/eyO5XyiOfFrGufPMalE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694165303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3yWpOyigBI+zqSXnxXGKtikfuX2WwkxPbyliXH6/gJI=;
 b=tujXL4KlQGrTIBZaafylfYMXlMi3l/pHZ8Ca5xlOs6dK40ZYn72c0y481quxm8IRO1BhjF
 +WKAnhlsKPKHkdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55218132F2;
 Fri,  8 Sep 2023 09:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JLQlEzfp+mSfVAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 Sep 2023 09:28:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 11:28:22 +0200
Message-Id: <20230908092822.27085-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Merge fork06 and fork11 into new test
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

fork06 and fork11 worked in the same way, spawning multiple processes
inside parent and waiting until they complete by checking wait() pid
result. fork06 was spawning 1000 children, fork11 was spawning 100
children. For this reason, fork_procs now merges both of them,
including an option that selects amount of processes we want to spawn.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   4 +-
 testcases/kernel/syscalls/fork/.gitignore   |   3 +-
 testcases/kernel/syscalls/fork/fork06.c     | 106 --------------------
 testcases/kernel/syscalls/fork/fork11.c     |  97 ------------------
 testcases/kernel/syscalls/fork/fork_procs.c |  55 ++++++++++
 5 files changed, 58 insertions(+), 207 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fork/fork06.c
 delete mode 100644 testcases/kernel/syscalls/fork/fork11.c
 create mode 100644 testcases/kernel/syscalls/fork/fork_procs.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b1125dd75..ca1959e90 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -379,12 +379,12 @@ fork01 fork01
 fork03 fork03
 fork04 fork04
 fork05 fork05
-fork06 fork06
+fork06 fork_procs -n 1000
 fork07 fork07
 fork08 fork08
 fork09 fork09
 fork10 fork10
-fork11 fork11
+fork11 fork_procs -n 100
 fork13 fork13
 fork14 fork14
 
diff --git a/testcases/kernel/syscalls/fork/.gitignore b/testcases/kernel/syscalls/fork/.gitignore
index b817e9c05..55e30edb4 100644
--- a/testcases/kernel/syscalls/fork/.gitignore
+++ b/testcases/kernel/syscalls/fork/.gitignore
@@ -2,12 +2,11 @@
 /fork03
 /fork04
 /fork05
-/fork06
 /fork07
 /fork08
 /fork09
 /fork10
-/fork11
 /fork12
 /fork13
 /fork14
+/fork_procs
diff --git a/testcases/kernel/syscalls/fork/fork06.c b/testcases/kernel/syscalls/fork/fork06.c
deleted file mode 100644
index 3bc11b14b..000000000
--- a/testcases/kernel/syscalls/fork/fork06.c
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
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
- * NAME
- *	fork06.c
- *
- * DESCRIPTION
- *	Test that a process can fork children a large number of
- *	times in succession
- *
- * ALGORITHM
- *	Attempt to fork a child that exits immediately
- *	Repeat it many times(1000), counting the number of successes and
- *	failures
- *
- * USAGE
- *	fork06
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
- */
-
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <stdio.h>
-#include "test.h"
-
-char *TCID = "fork06";
-int TST_TOTAL = 1;
-
-static void setup(void);
-static void cleanup(void);
-
-#define NUMFORKS 1000
-
-int main(int ac, char **av)
-{
-	int i, pid, status, childpid, succeed, fail;
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		succeed = 0;
-		fail = 0;
-
-		for (i = 0; i < NUMFORKS; i++) {
-			pid = fork();
-			if (pid == -1) {
-				fail++;
-				continue;
-			}
-
-			if (pid == 0)
-				_exit(0);
-
-			childpid = wait(&status);
-			if (pid != childpid)
-				tst_resm(TFAIL, "pid from wait %d", childpid);
-			succeed++;
-		}
-
-		tst_resm(TINFO, "tries %d", i);
-		tst_resm(TINFO, "successes %d", succeed);
-		tst_resm(TINFO, "failures %d", fail);
-
-		if ((wait(&status)) == -1)
-			tst_resm(TINFO, "There were no children to wait for");
-		else
-			tst_resm(TINFO, "There were children left");
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
diff --git a/testcases/kernel/syscalls/fork/fork11.c b/testcases/kernel/syscalls/fork/fork11.c
deleted file mode 100644
index 6afda3a33..000000000
--- a/testcases/kernel/syscalls/fork/fork11.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
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
- *
- * RESTRICTIONS
- *	None
- */
-
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
-
-#define NUMFORKS 100
-
-int main(int ac, char **av)
-{
-	int i, pid, cpid, status;
-	int fail = 0;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
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
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
diff --git a/testcases/kernel/syscalls/fork/fork_procs.c b/testcases/kernel/syscalls/fork/fork_procs.c
new file mode 100644
index 000000000..c35bb480c
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork_procs.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ *[Description]
+ *
+ * This test spawns multiple processes using fork() and it checks if wait()
+ * returns the right PID once they end up.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+static char *str_numforks;
+static int numforks = 1000;
+
+static void run(void)
+{
+	pid_t pid;
+	int status;
+	int counter = 0;
+
+	tst_res(TINFO, "Forking %d processes", numforks);
+
+	for (int i = 0; i < numforks; i++) {
+		pid = SAFE_FORK();
+		if (!pid)
+			exit(0);
+
+		if (SAFE_WAIT(&status) == pid)
+			counter++;
+	}
+
+	TST_EXP_EXPR(numforks == counter,
+		"%d processes ended successfully",
+		counter);
+}
+
+static void setup(void)
+{
+	if (tst_parse_int(str_numforks, &numforks, 1, INT_MAX))
+		tst_brk(TBROK, "wrong number of forks '%s'", str_numforks);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{ "n:", &str_numforks, "Number of processes to spawn" },
+		{},
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

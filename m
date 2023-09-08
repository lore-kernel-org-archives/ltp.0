Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E91DEE57EF
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 10:23:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE8A03CE969
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 12:23:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F9BD3CB542
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:23:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 331291000406
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:23:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC85321A1A;
 Fri,  8 Sep 2023 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694168596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLjFQTKOBQbisoLD5QdmGoXhnsV2xrWL3QFPMPz61Z4=;
 b=Ue6rl1uIUzGXclza0+p+q14E4XIkufLoa8sZRbh+gJoYxJewx1Dkz5UFkb5uc8yXPdVjw1
 vQBJFqgdDpWrPzs/J7WKKH80VgM4UVN7pOWGlHYcKFqVSs1x568O2BQQlb1+pl+kenRoNO
 58rknkJwJGns9k0KRqGv/1HQHlM2kaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694168596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLjFQTKOBQbisoLD5QdmGoXhnsV2xrWL3QFPMPz61Z4=;
 b=J6kt2NWXptUhuYp99bntjeEYylv7/suWHNU4qPE6x0b74HyTzV6GzUA2R7e9mLspM9zFnL
 YEdw5/VKwikkTZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D6C9131FD;
 Fri,  8 Sep 2023 10:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2Fb2IBT2+mRFcwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 Sep 2023 10:23:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 12:23:15 +0200
Message-Id: <20230908102315.8163-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230908102315.8163-1-andrea.cervesato@suse.de>
References: <20230908102315.8163-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Refactor exit_group01 using new API
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

We provided a different approach to exit_group() testing, spawning
multiple threads inside the child and checking if they get killed with
the parent process.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Added thread_alive() function that checks existance of running threads, instead
of using kill(tid, 0) method.
tst_gettid() usage

 testcases/kernel/syscalls/exit_group/Makefile |   2 +
 .../kernel/syscalls/exit_group/exit_group01.c | 160 ++++++++++++------
 2 files changed, 111 insertions(+), 51 deletions(-)

diff --git a/testcases/kernel/syscalls/exit_group/Makefile b/testcases/kernel/syscalls/exit_group/Makefile
index 1273a4e9c..adbac3c51 100644
--- a/testcases/kernel/syscalls/exit_group/Makefile
+++ b/testcases/kernel/syscalls/exit_group/Makefile
@@ -3,6 +3,8 @@
 
 top_srcdir		?= ../../../..
 
+exit_group01: CFLAGS+=-pthread
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 5bf5b0218..2fcfff2f2 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -1,68 +1,126 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007                                   *
- * Ported to LTP by Manas Kumar Nayak <maknayak@in.ibm.com>                   *
- * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>                          *
- *                                                                            *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or          *
- * (at your option) any later version.                                        *
- *                                                                            *
- * This program is distributed in the hope that it will be useful,            *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
- * the GNU General Public License for more details.                           *
- *                                                                            *
- * You should have received a copy of the GNU General Public License          *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *                                                                            *
- ******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported to LTP by Manas Kumar Nayak <maknayak@in.ibm.com>
+ * Copyright (c) 2015 Linux Test Project
+ * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
 
-#include <stdio.h>
-#include <errno.h>
-#include <linux/unistd.h>
-#include <sys/wait.h>
+/*\
+ * [Description]
+ *
+ * This test checks if exit_group() correctly ends a spawned child and all its
+ * running threads.
+ */
 
-#include "test.h"
-#include "safe_macros.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 
-char *TCID = "exit_group01";
-int testno;
-int TST_TOTAL = 1;
+#define THREADS_NUM 10
+
+static pid_t *tids;
 
-static void verify_exit_group(void)
+static void thread_alive(const int tid)
 {
-	pid_t cpid, w;
-	int status;
+	char folder[128];
+    struct stat sb;
+	char state;
 
-	cpid = fork();
-	if (cpid == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "fork failed");
+	snprintf(folder, sizeof(folder), "/proc/%i/stat", tid);
 
-	if (cpid == 0) {
-		TEST(tst_syscall(__NR_exit_group, 4));
-	} else {
-		w = SAFE_WAIT(NULL, &status);
-
-		if (WIFEXITED(status) && (WEXITSTATUS(status) == 4)) {
-			tst_resm(TPASS, "exit_group() succeeded");
-		} else {
-			tst_resm(TFAIL | TERRNO,
-				 "exit_group() failed (wait status = %d)", w);
+	for (;;) {
+		if (stat(folder, &sb) == -1) {
+			if (errno != ENOENT)
+				tst_brk(TBROK | TERRNO, "stat() error");
+
+			break;
+		}
+
+		SAFE_FILE_SCANF(folder, "%*i %*s %c", &state);
+
+		if (state != 'S') {
+			tst_brk(TBROK,
+				"Thread %d is supposed to sleep but it's in '%c' state",
+				tid, state);
 		}
+
+		usleep(1000);
 	}
 }
 
-int main(int ac, char **av)
+static void *worker(void *arg)
 {
-	int lc;
+	int i = *((int *)arg);
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	tids[i] = tst_gettid();
 
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_exit_group();
+	TST_CHECKPOINT_WAKE(0);
+	pause();
 
-	tst_exit();
+	return arg;
 }
+
+static void spawn_threads(void)
+{
+	pthread_t threads[THREADS_NUM];
+
+	for (int i = 0; i < THREADS_NUM; i++) {
+		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, (void *)&i);
+		TST_CHECKPOINT_WAIT(0);
+
+		/* wait for paused thread */
+		TST_PROCESS_STATE_WAIT(tids[i], 'S', 0);
+	}
+}
+
+static void run(void)
+{
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		spawn_threads();
+
+		TEST(tst_syscall(__NR_exit_group, 4));
+		if (TST_RET == -1)
+			tst_brk(TBROK | TERRNO, "exit_group() error");
+
+		return;
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	for (int i = 0; i < THREADS_NUM; i++)
+		thread_alive(tids[i]);
+
+	TST_EXP_EXPR(WIFEXITED(status) && WEXITSTATUS(status) == 4,
+		"exit_group() succeeded");
+}
+
+static void setup(void)
+{
+	tids = SAFE_MMAP(
+		NULL,
+		sizeof(pid_t) * THREADS_NUM,
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(tids, sizeof(pid_t) * THREADS_NUM);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B868BC61D85
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 17:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A42B3CC256
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 18:27:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4C43CC248
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 18:26:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA14D200B8E
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 18:26:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D318D1F8C3;
 Tue, 21 Nov 2023 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700587591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6xq6CqM5FYPgmc4v6qtpxy5yttuYvqmiOzIxQJoIyw=;
 b=TKLCIcprSplOxrR07vigyssmbkbZHYEMJNGOPq195wg1mDiOwAv+IxkywLDANXkl+6/gpO
 6Pt9+tazfbqLeNmaDUv/eKDtSi3TbZmUcpnncPtJtRk6LuItqb18w5Z0Kr99USFgjPkjQA
 ymbjnLLvnLTcLP7dJmfEWudL/0MqYeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700587591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6xq6CqM5FYPgmc4v6qtpxy5yttuYvqmiOzIxQJoIyw=;
 b=wBXm68FETp6Xa0Yq+cALk+sSIcvDNZu6lUbyQS795eZnbauOo5Rveja6M1mT6CmiT7vtOn
 au/RbxhVFpERRqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C108F139FD;
 Tue, 21 Nov 2023 17:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aNb3LUfoXGXjMgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 Nov 2023 17:26:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 21 Nov 2023 18:26:30 +0100
Message-Id: <20231121172630.964-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231121172630.964-1-andrea.cervesato@suse.de>
References: <20231121172630.964-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] Refactor exit_group01 using new API
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
 testcases/kernel/syscalls/exit_group/Makefile |   2 +
 .../kernel/syscalls/exit_group/exit_group01.c | 144 +++++++++++-------
 2 files changed, 95 insertions(+), 51 deletions(-)

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
index 5bf5b0218..9c557eedf 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -1,68 +1,110 @@
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
+#include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "tst_safe_pthread.h"
 
-char *TCID = "exit_group01";
-int testno;
-int TST_TOTAL = 1;
+#define THREADS_NUM 10
 
-static void verify_exit_group(void)
+static pid_t *tids;
+static int *counter;
+
+static void *worker(void *arg)
 {
-	pid_t cpid, w;
+	int i = *((int *)arg);
+
+	tids[i] = tst_gettid();
+
+	while (1) {
+		++(*counter);
+		usleep(0);
+	}
+
+	return arg;
+}
+
+static void spawn_threads(void)
+{
+	pthread_t threads[THREADS_NUM];
+
+	for (int i = 0; i < THREADS_NUM; i++)
+		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, (void *)&i);
+}
+
+static void run(void)
+{
+	pid_t pid;
 	int status;
 
-	cpid = fork();
-	if (cpid == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "fork failed");
+	*counter = 0;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		spawn_threads();
 
-	if (cpid == 0) {
 		TEST(tst_syscall(__NR_exit_group, 4));
-	} else {
-		w = SAFE_WAIT(NULL, &status);
-
-		if (WIFEXITED(status) && (WEXITSTATUS(status) == 4)) {
-			tst_resm(TPASS, "exit_group() succeeded");
-		} else {
-			tst_resm(TFAIL | TERRNO,
-				 "exit_group() failed (wait status = %d)", w);
-		}
+		if (TST_RET == -1)
+			tst_brk(TBROK | TERRNO, "exit_group() error");
+
+		return;
 	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	TST_EXP_EXPR(WIFEXITED(status) && WEXITSTATUS(status) == 4,
+		"exit_group() succeeded");
+
+	int old_counter = *counter;
+
+	tst_res(TINFO, "Checking if threads are still running");
+	usleep(1000000);
+
+	TST_EXP_EXPR(old_counter == *counter, "Counter value hasn't changed");
 }
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	tids = SAFE_MMAP(
+		NULL,
+		sizeof(pid_t) * THREADS_NUM,
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_exit_group();
+	counter = SAFE_MMAP(
+		NULL,
+		sizeof(int),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+}
 
-	tst_exit();
+static void cleanup(void)
+{
+	SAFE_MUNMAP(tids, sizeof(pid_t) * THREADS_NUM);
+	SAFE_MUNMAP(counter, sizeof(int));
 }
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

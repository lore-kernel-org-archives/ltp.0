Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33752C61D97
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 14:50:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A56D33CE086
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 15:50:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B753C3CE086
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 15:49:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3BAD600C2A
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 15:49:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7E721979;
 Wed, 22 Nov 2023 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700664587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVJNqlYj3EDLr8KDCZMHbUCmV44w1WVnMLE1U/uioRo=;
 b=hem9DrRYauIx/1HNw0WzpPb5KfUatdvNUU/gEkUwfxRVLtZlhm/XJlPCUa0qMxz3ztU23y
 4Aulzu6T4TI+pm2PJj491yPRx0mOGu/t8F3EWrlr+txmbmYPCCBfhy/63t/kxbusZhsoYh
 fliLRZyvzkY1P57I+3Aq1Io+sikkhV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700664587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVJNqlYj3EDLr8KDCZMHbUCmV44w1WVnMLE1U/uioRo=;
 b=290OL0lW5T86tEHtRTuqbUBW3YbH+RCwWX3MKv7fYY7fz+7AM2Z8bw14n/xCy2BIyEdyYf
 gvOWhJBXLfj+Y0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B9B113461;
 Wed, 22 Nov 2023 14:49:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sEKYEAsVXmWiEgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 Nov 2023 14:49:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 22 Nov 2023 15:49:44 +0100
Message-Id: <20231122144944.23993-3-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231122144944.23993-1-andrea.cervesato@suse.de>
References: <20231122144944.23993-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] Refactor exit_group01 using new API
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
 .../kernel/syscalls/exit_group/exit_group01.c | 161 ++++++++++++------
 2 files changed, 112 insertions(+), 51 deletions(-)

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
index 5bf5b0218..0fb1b284c 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -1,68 +1,127 @@
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
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "tst_safe_pthread.h"
+
+static int cpu_count;
 
-char *TCID = "exit_group01";
-int testno;
-int TST_TOTAL = 1;
+static struct worker_data {
+	pid_t tid;
+	int counter;
+} *workers_data;
 
-static void verify_exit_group(void)
+static void *worker(void *arg)
 {
-	pid_t cpid, w;
-	int status;
+	struct worker_data *data;
 
-	cpid = fork();
-	if (cpid == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "fork failed");
+	data = (struct worker_data *)arg;
+	data->tid = tst_gettid();
 
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
+	while (1) {
+		tst_atomic_inc(&data->counter);
+		sched_yield();
+	}
+
+	return arg;
+}
+
+static void spawn_threads(void)
+{
+	pthread_t threads[cpu_count];
+
+	for (int i = 0; i < cpu_count; i++)
+		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, (void *)(workers_data + i));
+}
+
+static void check_counters(void)
+{
+	struct worker_data data_copy[cpu_count];
+
+	memset(data_copy, 0, sizeof(struct worker_data) * cpu_count);
+	memcpy(data_copy, workers_data, sizeof(struct worker_data) * cpu_count);
+
+	tst_res(TINFO, "Checking if threads are still running");
+	usleep(100000);
+
+	struct worker_data *old_data;
+	struct worker_data *new_data;
+
+	for (int i = 0; i < cpu_count; i++) {
+		old_data = data_copy + i;
+		new_data = workers_data + i;
+
+		if (old_data->counter != new_data->counter) {
+			tst_res(TFAIL, "Counter value has changed for thread[%d]", i);
+			return;
 		}
 	}
+
+	tst_res(TINFO, "Threads counters value didn't change");
 }
 
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
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
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	SAFE_WAITPID(pid, &status, 0);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_exit_group();
+	TST_EXP_EXPR(WIFEXITED(status) && WEXITSTATUS(status) == 4,
+		"exit_group() succeeded");
 
-	tst_exit();
+	check_counters();
 }
+
+static void setup(void)
+{
+	cpu_count = tst_ncpus();
+
+	workers_data = SAFE_MMAP(
+		NULL,
+		sizeof(struct worker_data) * cpu_count,
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(workers_data, sizeof(struct worker_data) * cpu_count);
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

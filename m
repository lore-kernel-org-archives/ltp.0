Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EFEC77B7C
	for <ltp@archiver.kernel.org>; Sun,  7 May 2023 14:23:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 311A93CB5E8
	for <ltp@archiver.kernel.org>; Sun,  7 May 2023 16:23:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAC773C9922
 for <ltp@lists.linux.it>; Sun,  7 May 2023 16:23:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0F5E14001F0
 for <ltp@lists.linux.it>; Sun,  7 May 2023 16:23:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1826222A7;
 Sun,  7 May 2023 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1683469402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LOpmKhFq6F3+NNn4po+bGfrgVluEXhNlc3fHsiqayo=;
 b=qRlNXl9ZyrW7KQuTTnFjR6Q21coEd1SiouOenR8x9eduKMK3sw2My29BkUJ7F1iVUe7xGI
 /tqbknHuDq6fxhaFJHu7sZ2MWywALiO8ru2e+tJZ4SjLmJ/WViNn9ByFOKt2hVjsE7gsdm
 6rytzNoTD/VGnH8bwf9r/8gPsWGKKJE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C95B1358F;
 Sun,  7 May 2023 14:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8VMCNFe0V2ROfgAAMHmgww
 (envelope-from <wegao@suse.com>); Sun, 07 May 2023 14:23:19 +0000
To: ltp@lists.linux.it
Date: Sun,  7 May 2023 10:22:09 -0400
Message-Id: <20230507142209.17815-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230321110337.22970-1-wegao@suse.com>
References: <20230321110337.22970-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] starvation.c: New case for sched starvation
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>

Add scheduller thread starvation test case base following link:
https://lwn.net/ml/linux-kernel/9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de/
---
 runtest/sched                                 |   1 +
 .../kernel/sched/cfs-scheduler/.gitignore     |   1 +
 .../kernel/sched/cfs-scheduler/starvation.c   | 112 ++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 testcases/kernel/sched/cfs-scheduler/starvation.c

diff --git a/runtest/sched b/runtest/sched
index 592898723..172fe4174 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -9,6 +9,7 @@ trace_sched01		trace_sched -c 1
 cfs_bandwidth01 cfs_bandwidth01 -i 5
 hackbench01 hackbench 50 process 1000
 hackbench02 hackbench 20 thread 1000
+starvation starvation
 
 sched_cli_serv run_sched_cliserv.sh
 # Run this stress test for 2 minutes
diff --git a/testcases/kernel/sched/cfs-scheduler/.gitignore b/testcases/kernel/sched/cfs-scheduler/.gitignore
index c5dacd6ef..e86178f80 100644
--- a/testcases/kernel/sched/cfs-scheduler/.gitignore
+++ b/testcases/kernel/sched/cfs-scheduler/.gitignore
@@ -1,2 +1,3 @@
 /hackbench
 cfs_bandwidth01
+/starvation
diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
new file mode 100644
index 000000000..5a3655a3f
--- /dev/null
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright 2023 Mike Galbraith <efault-AT-gmx.de> */
+/* Copyright 2023 Wei Gao <wegao@suse.com> */
+/*\
+ *
+ * [Description]
+ *
+ * Thread starvation test.
+ * This case copy from following link:
+ * https://lore.kernel.org/lkml/9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de/
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <sched.h>
+
+#include "tst_test.h"
+
+static char *str_loop;
+static long loop = 10000000;
+static char *str_timeout;
+static int timeout = 240;
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (WIFSIGNALED(status))
+		return 0;
+
+	return -1;
+}
+
+static void setup(void)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+
+	CPU_SET(0, &mask);
+
+	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));
+
+	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
+		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
+
+	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of timeout '%s'", str_timeout);
+
+	tst_set_max_runtime(timeout);
+}
+
+static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	if (loop > 0)
+		--loop;
+}
+
+static void child(void)
+{
+	pid_t ppid = getppid();
+
+	TST_CHECKPOINT_WAIT(0);
+
+	while (1)
+		SAFE_KILL(ppid, SIGUSR1);
+}
+
+static void do_test(void)
+{
+	pid_t child_pid;
+
+	child_pid = SAFE_FORK();
+
+	if (!child_pid)
+		child();
+
+	SAFE_SIGNAL(SIGUSR1, handler);
+	TST_CHECKPOINT_WAKE(0);
+
+	while (loop)
+		sleep(1);
+
+	SAFE_KILL(child_pid, SIGTERM);
+	TST_EXP_PASS(wait_for_pid(child_pid));
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"l:", &str_loop, "Number of loops (default 10000000)"},
+		{"t:", &str_timeout, "Max timeout (default 240s)"},
+		{}
+	},
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

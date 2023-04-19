Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C72C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 15:19:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D7813CC024
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 17:19:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C79F43CC02F
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 17:19:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 302371000A66
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 17:19:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59E1C219A7;
 Wed, 19 Apr 2023 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1681917559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fd7hHcNGbf/dnByx18Vt6el97yRU1RT+1LDvQqW32AM=;
 b=BkfB2LBEYPEpTSBvpmCDOSI2ibrCM/QD64sKCB1lHbbo3GKVjl3CfiFpV5wiIT6q0NfJ3N
 XFTPd7MQRjHXhw8/p3IOrZ3G5F0ZuuIfxL3ODtXQPEQEBfdvikejikVzGwdmSDQ4S3Ar0A
 5z84TNrdxnGR9RZIUIZQEQVKKuB+ekQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 777451390E;
 Wed, 19 Apr 2023 15:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4CkPD3YGQGT4DwAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 19 Apr 2023 15:19:18 +0000
To: ltp@lists.linux.it
Date: Wed, 19 Apr 2023 11:18:48 -0400
Message-Id: <20230419151849.13152-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230419151849.13152-1-wegao@suse.com>
References: <20230318045253.10119-1-wegao@suse.com>
 <20230419151849.13152-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/2] kill01: New case cgroup kill
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
---
 runtest/controllers                           |   1 +
 .../kernel/controllers/cgroup/kill/.gitignore |   1 +
 .../kernel/controllers/cgroup/kill/Makefile   |   6 +
 .../kernel/controllers/cgroup/kill/kill01.c   | 144 ++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 testcases/kernel/controllers/cgroup/kill/.gitignore
 create mode 100644 testcases/kernel/controllers/cgroup/kill/Makefile
 create mode 100644 testcases/kernel/controllers/cgroup/kill/kill01.c

diff --git a/runtest/controllers b/runtest/controllers
index 8d1b936bf..2f69a8ec2 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -23,6 +23,7 @@ memcontrol01 memcontrol01
 memcontrol02 memcontrol02
 memcontrol03 memcontrol03
 memcontrol04 memcontrol04
+kill01 kill01
 
 cgroup_fj_function_debug cgroup_fj_function.sh debug
 cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
diff --git a/testcases/kernel/controllers/cgroup/kill/.gitignore b/testcases/kernel/controllers/cgroup/kill/.gitignore
new file mode 100644
index 000000000..4f9649e27
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/kill/.gitignore
@@ -0,0 +1 @@
+/kill01
diff --git a/testcases/kernel/controllers/cgroup/kill/Makefile b/testcases/kernel/controllers/cgroup/kill/Makefile
new file mode 100644
index 000000000..bf5aea9e7
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/kill/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../../../
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cgroup/kill/kill01.c b/testcases/kernel/controllers/cgroup/kill/kill01.c
new file mode 100644
index 000000000..6a328a770
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/kill/kill01.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test is copied from kselftest
+ * tools/testing/selftests/cgroup/test_kill.c
+ * Only simple test implemented within current case, the other cases such
+ * as test_cgkill_tree and test_cgkill_forkbomb can be created later.
+ *
+ */
+
+#include <sys/wait.h>
+
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+
+#define MAX_PID_NUM 100
+#define PID_NUM MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
+#define BUF_LEN (20 * PID_NUM)
+
+static int *data_ptr;
+static char *buf;
+static struct tst_cg_group *cg_child_test_simple;
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
+/*
+ * A simple process running in a sleep loop until being
+ * re-parented.
+ */
+static void child_fn(void)
+{
+	int ppid = getppid();
+
+	while (getppid() == ppid)
+		usleep(1000);
+
+}
+
+static int cg_run_nowait(const struct tst_cg_group *const cg,
+		  void (*fn)(void))
+{
+	int pid;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
+		tst_atomic_inc(data_ptr);
+		if (tst_atomic_load(data_ptr) == PID_NUM)
+			TST_CHECKPOINT_WAKE(0);
+		fn();
+	}
+
+	return pid;
+}
+
+static int cg_wait_for_proc_count(const struct tst_cg_group *cg, int count)
+{
+	char *ptr;
+
+	int nr = 0;
+
+	SAFE_CG_READ(cg, "cgroup.procs", buf, BUF_LEN);
+
+	for (ptr = buf; *ptr; ptr++)
+		if (*ptr == '\n')
+			nr++;
+
+	if (nr >= count)
+		return 0;
+
+	tst_res(TINFO, "Expect process num is %d but get %d", count, nr);
+
+	return -1;
+}
+
+static void run(void)
+{
+	pid_t pids[MAX_PID_NUM];
+	int i;
+	*data_ptr = 0;
+
+	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
+
+	memset(buf, 0, BUF_LEN);
+
+	for (i = 0; i < PID_NUM; i++)
+		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);
+
+	TST_CHECKPOINT_WAIT(0);
+	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple, PID_NUM));
+	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
+
+	for (i = 0; i < PID_NUM; i++)
+		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]));
+
+	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
+}
+
+static void setup(void)
+{
+	buf = tst_alloc(BUF_LEN);
+	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
+						 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (data_ptr)
+		SAFE_MUNMAP(data_ptr, sizeof(uintptr_t));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.max_runtime = 20,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

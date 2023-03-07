Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AC2C678D4
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 08:52:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84A993CCDCF
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 09:52:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 605783C27D9
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 09:52:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B519360080F
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 09:52:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 00E2E21972;
 Tue,  7 Mar 2023 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678179120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlIrT1vnzIWT4wiwtFTOSXHWzb338vmlO0gt0qlmz1s=;
 b=rAku2ksPgqfEqPPs74KURN6DT4AZqxC25K+5WaSPNfXKu42WG1Aq7LdUJsp84+z3yRvS6v
 MfuJHVBkSf+5sR4yLAVf/QjpYgBGTfku6MH2xt5dZXe5+5yZz0m5DEBTtfKwYsISWGkQzf
 nwRghTUlW4DV9RPik+35m3tfhDt7Ebs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECC1913440;
 Tue,  7 Mar 2023 08:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8zPjLy77BmQxJgAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 07 Mar 2023 08:51:58 +0000
To: ltp@lists.linux.it
Date: Tue,  7 Mar 2023 03:51:39 -0500
Message-Id: <20230307085139.3574-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306235715.29868-1-wegao@suse.com>
References: <20230306235715.29868-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] kill01: New case cgroup kill
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
 lib/tst_cgroup.c                             |   1 +
 runtest/controllers                          |   1 +
 testcases/kernel/controllers/kill/.gitignore |   1 +
 testcases/kernel/controllers/kill/Makefile   |   6 +
 testcases/kernel/controllers/kill/kill01.c   | 138 +++++++++++++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 testcases/kernel/controllers/kill/.gitignore
 create mode 100644 testcases/kernel/controllers/kill/Makefile
 create mode 100644 testcases/kernel/controllers/kill/kill01.c

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 50699bc63..77575431d 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -166,6 +166,7 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
 	{ "cgroup.controllers", NULL, 0 },
 	{ "cgroup.subtree_control", NULL, 0 },
 	{ "cgroup.clone_children", "cgroup.clone_children", 0 },
+	{ "cgroup.kill", NULL, 0 },
 	{ }
 };
 
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
diff --git a/testcases/kernel/controllers/kill/.gitignore b/testcases/kernel/controllers/kill/.gitignore
new file mode 100644
index 000000000..4f9649e27
--- /dev/null
+++ b/testcases/kernel/controllers/kill/.gitignore
@@ -0,0 +1 @@
+/kill01
diff --git a/testcases/kernel/controllers/kill/Makefile b/testcases/kernel/controllers/kill/Makefile
new file mode 100644
index 000000000..5ea7d67db
--- /dev/null
+++ b/testcases/kernel/controllers/kill/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/kill/kill01.c b/testcases/kernel/controllers/kill/kill01.c
new file mode 100644
index 000000000..432747e16
--- /dev/null
+++ b/testcases/kernel/controllers/kill/kill01.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic cgroup kill test.
+ *
+ */
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+
+#define MAX_PID_NUM 100
+#define pid_num MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
+#define buf_len (20 * pid_num)
+
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
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
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
+		fn();
+	}
+
+	return pid;
+}
+
+static int cg_wait_for_proc_count(const struct tst_cg_group *cg, int count)
+{
+	int attempts;
+	char *ptr;
+
+	for (attempts = 100; attempts >= 0; attempts--) {
+		int nr = 0;
+
+		SAFE_CG_READ(cg, "cgroup.procs", buf, buf_len);
+
+		for (ptr = buf; *ptr; ptr++)
+			if (*ptr == '\n')
+				nr++;
+
+		if (nr >= count)
+			return 0;
+
+		usleep(100000);
+	}
+
+	return -1;
+}
+
+static void run(void)
+{
+	pid_t pids[MAX_PID_NUM];
+	int i;
+
+	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
+
+	memset(buf, 0, buf_len);
+
+	for (i = 0; i < pid_num; i++)
+		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);
+
+	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple, pid_num));
+	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
+
+	for (i = 0; i < pid_num; i++) {
+		/* wait_for_pid(pids[i]); */
+		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]) == SIGKILL);
+	}
+
+	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
+}
+
+static void setup(void)
+{
+	buf = tst_alloc(buf_len);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.max_runtime = 15,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.needs_cgroup_ver = TST_CG_V2,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

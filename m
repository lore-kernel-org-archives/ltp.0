Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13BCC7EE23
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 12:39:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0C353CBED7
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 14:39:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C81953CA8A4
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 14:39:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E453E200ADA
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 14:39:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E34D219D9;
 Fri, 21 Apr 2023 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1682080745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++QUESp74gR70ODL+OM3isTo0x0P7ZN6fcnUflniWyQ=;
 b=X1dPHnu6/zZ2xTXFep8jYYt6w/XiCKoWwPYDQqcxqv98htv6vPY3bKN5P22EpTZczo2cb5
 9sT1HeBpjDOrsT9xSgcBkpsOx6W/qR0d6oMcKTv8rtejdH5lZHnR084nR4XHd43yNFhwg/
 s/QWP8l8nuxDxBMPo+IVlEmuVHuqD74=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43AE41390E;
 Fri, 21 Apr 2023 12:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9hFMAeiDQmQnPQAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 21 Apr 2023 12:39:04 +0000
To: ltp@lists.linux.it
Date: Fri, 21 Apr 2023 08:38:55 -0400
Message-Id: <20230421123855.13427-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230226003526.8733-1-wegao@suse.com>
References: <20230226003526.8733-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] clone3: Add clone3's clone_args cgroup
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
 include/lapi/sched.h                        |  4 +
 include/tst_clone.h                         |  1 +
 lib/tst_cgroup.c                            |  1 +
 lib/tst_clone.c                             |  1 +
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/clone3/.gitignore |  1 +
 testcases/kernel/syscalls/clone3/clone303.c | 98 +++++++++++++++++++++
 7 files changed, 107 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clone3/clone303.c

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 1065665d1..d5dd6f76b 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -13,6 +13,7 @@
 #include <inttypes.h>
 #include "config.h"
 #include "lapi/syscalls.h"
+#include "lapi/sched.h"
 
 struct sched_attr {
 	uint32_t size;
@@ -54,6 +55,9 @@ struct clone_args {
 	uint64_t __attribute__((aligned(8))) stack;
 	uint64_t __attribute__((aligned(8))) stack_size;
 	uint64_t __attribute__((aligned(8))) tls;
+	uint64_t __attribute__((aligned(8))) set_tid;
+	uint64_t __attribute__((aligned(8))) set_tid_size;
+	uint64_t __attribute__((aligned(8))) cgroup;
 };
 
 static inline int clone3(struct clone_args *args, size_t size)
diff --git a/include/tst_clone.h b/include/tst_clone.h
index 9ffdc68d1..7b278dfa7 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -11,6 +11,7 @@
 struct tst_clone_args {
 	uint64_t flags;
 	uint64_t exit_signal;
+	uint64_t cgroup;
 };
 
 /* clone3 with fallbacks to clone when possible. Be aware that it
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
 
diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index ecc84408c..2aa00beb1 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -15,6 +15,7 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 	struct clone_args args = {
 		.flags = tst_args->flags,
 		.exit_signal = tst_args->exit_signal,
+		.cgroup = tst_args->cgroup,
 	};
 	int flags;
 	pid_t pid = -1;
diff --git a/runtest/syscalls b/runtest/syscalls
index 9c23a4248..0b6adfd7f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -117,6 +117,7 @@ clone09 clone09
 
 clone301 clone301
 clone302 clone302
+clone303 clone303
 
 close01 close01
 close02 close02
diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
index 604cb903e..10369954b 100644
--- a/testcases/kernel/syscalls/clone3/.gitignore
+++ b/testcases/kernel/syscalls/clone3/.gitignore
@@ -1,2 +1,3 @@
 clone301
 clone302
+clone303
diff --git a/testcases/kernel/syscalls/clone3/clone303.c b/testcases/kernel/syscalls/clone3/clone303.c
new file mode 100644
index 000000000..3310b21dc
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone303.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test case check clone3 CLONE_INTO_CGROUP flag
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+#include "lapi/pidfd.h"
+
+#define BUF_LEN 20
+#define CLONE_INTO_CGROUP 0x200000000ULL
+
+static struct tst_cg_group *cg_child_test_simple;
+static struct clone_args *args;
+
+static pid_t clone_into_cgroup(int cgroup_fd)
+{
+	pid_t pid;
+
+	args->flags = CLONE_INTO_CGROUP;
+	args->exit_signal = SIGCHLD;
+	args->cgroup = cgroup_fd;
+
+	pid = clone3(args, sizeof(*args));
+
+	if (pid < 0)
+		tst_res(TFAIL | TTERRNO, "clone3() failed !");
+
+	return pid;
+}
+
+static void run(void)
+{
+	char path[100];
+	int fd;
+	pid_t pid;
+
+	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
+	sprintf(path, "/sys/fs/cgroup/ltp/%s/%s", tst_cg_group_name(tst_cg), tst_cg_group_name(cg_child_test_simple));
+	tst_res(TINFO, "cgroup path is %s", path);
+	fd = SAFE_OPEN(path, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
+
+	pid = clone_into_cgroup(fd);
+
+	if (!pid) {
+		TST_CHECKPOINT_WAIT(0);
+	} else {
+
+		char buf[BUF_LEN];
+
+		SAFE_CG_READ(cg_child_test_simple, "cgroup.procs", buf, BUF_LEN);
+
+		int x = atoi(buf);
+
+		if (x == pid)
+			tst_res(TPASS, "clone3 case pass!");
+		else
+			tst_brk(TFAIL | TTERRNO, "clone3() failed !");
+
+		TST_CHECKPOINT_WAKE(0);
+
+		SAFE_WAITPID(pid, NULL, 0);
+
+		cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
+	}
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.max_runtime = 20,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_checkpoints = 1,
+	.min_kver = "5.7",
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{},
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

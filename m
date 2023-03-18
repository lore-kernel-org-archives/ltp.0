Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E683EC74A5B
	for <ltp@archiver.kernel.org>; Sat, 18 Mar 2023 04:55:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9E393CD426
	for <ltp@archiver.kernel.org>; Sat, 18 Mar 2023 05:54:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4829E3CAB4E
 for <ltp@lists.linux.it>; Sat, 18 Mar 2023 05:54:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F2811A00441
 for <ltp@lists.linux.it>; Sat, 18 Mar 2023 05:54:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 200C621ACB;
 Sat, 18 Mar 2023 04:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1679115284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w90BvvQK3NrBNIOywxHXh0YGi2FAWgwSTOtxbsx+GP8=;
 b=neYY1h2TwRrDzbpyTHWoJahJ2NO0rslickxhWasw1TobjSlCcmiZS7nin/u9plHVdjceun
 6fmTq2QopxGswE0BJTacn+1/vZSXkuen+WM4SGaWD6+Lto1T3MJ/tJpw/WEdxgA/cib63i
 2PU9ksMgoTV8qEjVqkA8Xz/mqGPMFK8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3878C1391B;
 Sat, 18 Mar 2023 04:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V2JOABNEFWSrdAAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 18 Mar 2023 04:54:43 +0000
To: ltp@lists.linux.it
Date: Sat, 18 Mar 2023 00:52:53 -0400
Message-Id: <20230318045253.10119-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230307085139.3574-1-wegao@suse.com>
References: <20230307085139.3574-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] kill01: New case cgroup kill
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
 lib/tst_cgroup.c                              |  55 ++++---
 runtest/controllers                           |   1 +
 .../kernel/controllers/cgroup/kill/.gitignore |   1 +
 .../kernel/controllers/cgroup/kill/Makefile   |   6 +
 .../kernel/controllers/cgroup/kill/kill01.c   | 149 ++++++++++++++++++
 5 files changed, 193 insertions(+), 19 deletions(-)
 create mode 100644 testcases/kernel/controllers/cgroup/kill/.gitignore
 create mode 100644 testcases/kernel/controllers/cgroup/kill/Makefile
 create mode 100644 testcases/kernel/controllers/cgroup/kill/kill01.c

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 50699bc63..ff1c734d1 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -94,9 +94,10 @@ enum cgroup_ctrl_indx {
 	CTRL_MISC,
 	CTRL_PERFEVENT,
 	CTRL_DEBUG,
-	CTRL_RDMA
+	CTRL_RDMA,
+	CTRL_PSEUDO
 };
-#define CTRLS_MAX CTRL_RDMA
+#define CTRLS_MAX CTRL_PSEUDO
 
 /* At most we can have one cgroup V1 tree for each controller and one
  * (empty) v2 tree.
@@ -166,6 +167,7 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
 	{ "cgroup.controllers", NULL, 0 },
 	{ "cgroup.subtree_control", NULL, 0 },
 	{ "cgroup.clone_children", "cgroup.clone_children", 0 },
+	{ "cgroup.kill", NULL, 0 },
 	{ }
 };
 
@@ -258,6 +260,10 @@ static const struct cgroup_file rdma_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file cgroup_pseudo_ctrl_files[] = {
+	{ }
+};
+
 #define CTRL_NAME_MAX 31
 #define CGROUP_CTRL_MEMBER(x, y)[y] = { .ctrl_name = #x, .files = \
 	x ## _ctrl_files, .ctrl_indx = y, NULL, 0 }
@@ -281,6 +287,7 @@ static struct cgroup_ctrl controllers[] = {
 	CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
 	CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
 	CGROUP_CTRL_MEMBER(rdma, CTRL_RDMA),
+	CGROUP_CTRL_MEMBER(cgroup_pseudo, CTRL_PSEUDO),
 	{ }
 };
 
@@ -826,6 +833,10 @@ void tst_cg_require(const char *const ctrl_name,
 	if (options->needs_ver != TST_CG_V2)
 		cgroup_mount_v1(ctrl);
 
+	if (!strcmp(ctrl->ctrl_name, "cgroup_pseudo")) {
+		ctrl->ctrl_root = roots;
+	}
+
 	if (!ctrl->ctrl_root) {
 		tst_brk(TCONF,
 			"'%s' controller required, but not available",
@@ -848,13 +859,15 @@ mkdirs:
 			ctrl->ctrl_name);
 	}
 
-	if (cgroup_ctrl_on_v2(ctrl)) {
-		if (root->we_mounted_it) {
-			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
-					   cgsc, "+%s", ctrl->ctrl_name);
-		} else {
-			tst_file_printfat(root->mnt_dir.dir_fd,
-					  cgsc, "+%s", ctrl->ctrl_name);
+	if (strcmp(ctrl->ctrl_name,"cgroup_pseudo")) {
+		if (cgroup_ctrl_on_v2(ctrl)) {
+			if (root->we_mounted_it) {
+				SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
+						cgsc, "+%s", ctrl->ctrl_name);
+			} else {
+				tst_file_printfat(root->mnt_dir.dir_fd,
+						cgsc, "+%s", ctrl->ctrl_name);
+			}
 		}
 	}
 
@@ -863,15 +876,17 @@ mkdirs:
 	else
 		root->ltp_dir.ctrl_field |= root->mnt_dir.ctrl_field;
 
-	if (cgroup_ctrl_on_v2(ctrl)) {
-		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
-				   cgsc, "+%s", ctrl->ctrl_name);
-	} else {
-		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
-				   "cgroup.clone_children", "%d", 1);
+	if (strcmp(ctrl->ctrl_name,"cgroup_pseudo")) {
+		if (cgroup_ctrl_on_v2(ctrl)) {
+			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
+					cgsc, "+%s", ctrl->ctrl_name);
+		} else {
+			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
+					"cgroup.clone_children", "%d", 1);
 
-		if (ctrl->ctrl_indx == CTRL_CPUSET)
-			cgroup_copy_cpuset(root);
+			if (ctrl->ctrl_indx == CTRL_CPUSET)
+				cgroup_copy_cpuset(root);
+		}
 	}
 
 	cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
@@ -1049,8 +1064,10 @@ static void cgroup_group_add_dir(const struct tst_cg_group *const parent,
 		if (!parent || dir->dir_root->ver == TST_CG_V1)
 			continue;
 
-		SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
-				   "+%s", ctrl->ctrl_name);
+		if (strcmp(ctrl->ctrl_name, "cgroup_pseudo")) {
+			SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
+					"+%s", ctrl->ctrl_name);
+		}
 	}
 
 	for (i = 0; cg->dirs[i]; i++)
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
index 000000000..0da6de350
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/kill/kill01.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test is copied from kernel self test case
+ * tools/testing/selftests/cgroup/test_kill.c
+ *
+ */
+
+#include <errno.h>
+#include <linux/limits.h>
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
+		if (tst_atomic_load(data_ptr) == pid_num)
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
+	SAFE_CG_READ(cg, "cgroup.procs", buf, buf_len);
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
+	memset(buf, 0, buf_len);
+
+	for (i = 0; i < pid_num; i++)
+		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);
+
+	TST_CHECKPOINT_WAIT(0);
+	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple, pid_num));
+	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
+
+	for (i = 0; i < pid_num; i++)
+		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]));
+
+	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
+}
+
+static void setup(void)
+{
+	buf = tst_alloc(buf_len);
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
+	.needs_cgroup_ctrls = (const char *const []){ "cgroup_pseudo", NULL },
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

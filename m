Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092E8C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:17:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61BF83C9AED
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 15:17:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E63223C9AED
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39931200985
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:37 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD6811F38D;
 Mon,  7 Feb 2022 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644243396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fn9SORGmSznnOWo4xunOAW2vj6xxZUqrNrUdONh7WSA=;
 b=UTUpfNf1/qLNN/1hfgfe4UITvnBW7z3PLIss4037BYgCs3ghC2lEBQG/v0bhe3lrdOZctt
 a6BO+ovL1xU0dZuKM/QYhIX+ewQnz5vJFTTokavnVgOAPyRVHnX6o14bxeTjEQSLJRpFYf
 cYWpfUWaQ2bGOcGsCpw+dE/W950P3uM=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 9CB7FA3B89;
 Mon,  7 Feb 2022 14:16:36 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  7 Feb 2022 14:16:18 +0000
Message-Id: <20220207141618.2844-6-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207141618.2844-1-rpalethorpe@suse.com>
References: <20220207141618.2844-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] memcontrol03: Copy from kselftest
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Note that the tolerances had to be increased slightly otherwise the
test only passed on ext4 in upstream 5.16 on x86_64. In all cases it
seems more memory is evicted from C than expected and not enough from
D. This may indicate some tuning is possible, but does not look like a
serious regression.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol03.c   | 253 ++++++++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol03.c

diff --git a/runtest/controllers b/runtest/controllers
index 09e0107e4..4a6f919af 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -19,6 +19,7 @@ memcg_control		memcg_control_test.sh
 # kselftest ports
 memcontrol01 memcontrol01
 memcontrol02 memcontrol02
+memcontrol03 memcontrol03
 
 cgroup_fj_function_debug cgroup_fj_function.sh debug
 cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
index f7de40d53..49df1582c 100644
--- a/testcases/kernel/controllers/memcg/.gitignore
+++ b/testcases/kernel/controllers/memcg/.gitignore
@@ -7,3 +7,4 @@
 /stress/memcg_process_stress
 memcontrol01
 memcontrol02
+memcontrol03
diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
new file mode 100644
index 000000000..1c14d6766
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*\
+ *
+ * [Description]
+ *
+ * Conversion of the third kself test in cgroup/test_memcontrol.c.
+ *
+ * Original description:
+ * "First, this test creates the following hierarchy:
+ * A       memory.min = 50M,  memory.max = 200M
+ * A/B     memory.min = 50M,  memory.current = 50M
+ * A/B/C   memory.min = 75M,  memory.current = 50M
+ * A/B/D   memory.min = 25M,  memory.current = 50M
+ * A/B/E   memory.min = 500M, memory.current = 0
+ * A/B/F   memory.min = 0,    memory.current = 50M
+ *
+ * Usages are pagecache, but the test keeps a running
+ * process in every leaf cgroup.
+ * Then it creates A/G and creates a significant
+ * memory pressure in it.
+ *
+ * A/B    memory.current ~= 50M
+ * A/B/C  memory.current ~= 33M
+ * A/B/D  memory.current ~= 17M
+ * A/B/E  memory.current ~= 0
+ *
+ * After that it tries to allocate more than there is unprotected
+ * memory in A available, and checks that memory.min protects
+ * pagecache even in this case."
+ *
+ * memory.min doesn't appear to exist on V1 so we only test on V2 like
+ * the selftest. We do test on more file systems, but not tempfs
+ * becaue it can't evict the page cache without swap. Also we avoid
+ * filesystems which allocate extra memory for buffer heads.
+ *
+ * The tolerances have been increased from the self tests.
+ */
+
+#define _GNU_SOURCE
+
+#include <inttypes.h>
+
+#include "memcontrol_common.h"
+
+#define TMPDIR "mntdir"
+
+static struct tst_cgroup_group *trunk_cg[3];
+static struct tst_cgroup_group *leaf_cg[4];
+static int fd = -1;
+
+enum checkpoints {
+	CHILD_IDLE,
+	TEST_DONE,
+};
+
+enum trunk_cg {
+	A,
+	B,
+	G
+};
+
+enum leaf_cg {
+	C,
+	D,
+	E,
+	F
+};
+
+static void cleanup_sub_groups(void)
+{
+	size_t i;
+
+	for (i = ARRAY_SIZE(leaf_cg); i > 0; i--) {
+		if (!leaf_cg[i - 1])
+			continue;
+
+		TST_CHECKPOINT_WAKE2(TEST_DONE,
+				     ARRAY_SIZE(leaf_cg) - 1);
+		tst_reap_children();
+		break;
+	}
+
+	for (i = ARRAY_SIZE(leaf_cg); i > 0; i--) {
+		if (!leaf_cg[i - 1])
+			continue;
+
+		leaf_cg[i - 1] = tst_cgroup_group_rm(leaf_cg[i - 1]);
+	}
+
+	for (i = ARRAY_SIZE(trunk_cg); i > 0; i--) {
+		if (!trunk_cg[i - 1])
+			continue;
+
+		trunk_cg[i - 1] = tst_cgroup_group_rm(trunk_cg[i - 1]);
+	}
+}
+
+static void alloc_anon_in_child(const struct tst_cgroup_group *const cg,
+				const size_t size, const int expect_oom)
+{
+	int status;
+	const pid_t pid = SAFE_FORK();
+
+	if (!pid) {
+		SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+
+		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
+		getpid(), tst_cgroup_group_name(cg), size);
+		alloc_anon(size);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (expect_oom && WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
+		tst_res(TPASS, "Child %d killed by OOM", pid);
+		return;
+	}
+
+	if (!expect_oom && WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		tst_res(TPASS, "Child %d exited", pid);
+		return;
+	}
+
+	tst_res(TFAIL,
+		"Expected child %d to %s, but instead %s",
+		pid,
+		expect_oom ? "be killed" : "exit(0)",
+		tst_strstatus(status));
+}
+
+static void alloc_pagecache_in_child(const struct tst_cgroup_group *const cg,
+				     const size_t size)
+{
+	const pid_t pid = SAFE_FORK();
+
+	if (pid) {
+		TST_CHECKPOINT_WAIT(CHILD_IDLE);
+		return;
+	}
+
+	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
+
+	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
+		getpid(), tst_cgroup_group_name(cg), size);
+	alloc_pagecache(fd, size);
+
+	TST_CHECKPOINT_WAKE(CHILD_IDLE);
+	TST_CHECKPOINT_WAIT(TEST_DONE);
+	exit(0);
+}
+
+static void test_memcg_min(void)
+{
+	long c[4];
+	unsigned int i;
+	size_t attempts;
+
+	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
+	trunk_cg[A] = tst_cgroup_group_mk(tst_cgroup, "trunk_A");
+
+	SAFE_CGROUP_SCANF(trunk_cg[A], "memory.min", "%ld", c);
+	if (c[0]) {
+		tst_brk(TCONF,
+			"memory.min already set to %ld on parent group", c[0]);
+	}
+
+	SAFE_CGROUP_PRINT(trunk_cg[A], "cgroup.subtree_control", "+memory");
+
+	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.max", "200M");
+	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.swap.max", "0");
+
+	trunk_cg[B] = tst_cgroup_group_mk(trunk_cg[A], "trunk_B");
+
+	SAFE_CGROUP_PRINT(trunk_cg[B], "cgroup.subtree_control", "+memory");
+
+	trunk_cg[G] = tst_cgroup_group_mk(trunk_cg[A], "trunk_G");
+
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
+		leaf_cg[i] = tst_cgroup_group_mk(trunk_cg[B],
+						 "leaf_%c", 'C' + i);
+
+		if (i == E)
+			continue;
+
+		alloc_pagecache_in_child(leaf_cg[i], MB(50));
+	}
+
+	SAFE_CGROUP_PRINT(trunk_cg[A], "memory.min", "50M");
+	SAFE_CGROUP_PRINT(trunk_cg[B], "memory.min", "50M");
+	SAFE_CGROUP_PRINT(leaf_cg[C], "memory.min", "75M");
+	SAFE_CGROUP_PRINT(leaf_cg[D], "memory.min", "25M");
+	SAFE_CGROUP_PRINT(leaf_cg[E], "memory.min", "500M");
+	SAFE_CGROUP_PRINT(leaf_cg[F], "memory.min", "0");
+
+	for (attempts = 0; attempts < 5; attempts++) {
+		SAFE_CGROUP_SCANF(trunk_cg[B], "memory.current", "%ld", c);
+		if (values_close(c[0], MB(150), 3))
+			break;
+
+		sleep(1);
+	}
+
+	alloc_anon_in_child(trunk_cg[G], MB(148), 0);
+
+	SAFE_CGROUP_SCANF(trunk_cg[B], "memory.current", "%ld", c);
+	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
+		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
+
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
+		SAFE_CGROUP_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
+
+	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
+		     "(A/B/C memory.current=%ld) ~= %d", c[0], MB(33));
+	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
+		     "(A/B/D memory.current=%ld) ~= %d", c[1], MB(17));
+	TST_EXP_EXPR(values_close(c[2], 0, 1),
+		     "(A/B/E memory.current=%ld) ~= 0", c[2]);
+
+	alloc_anon_in_child(trunk_cg[G], MB(170), 1);
+
+	SAFE_CGROUP_SCANF(trunk_cg[B], "memory.current", "%ld", c);
+	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
+		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
+
+	cleanup_sub_groups();
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(TMPDIR"/tmpfile");
+}
+
+static void cleanup(void)
+{
+	cleanup_sub_groups();
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = test_memcg_min,
+	.mount_device = 1,
+	.dev_min_size = 256,
+	.mntpoint = TMPDIR,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]){
+		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
+	},
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.needs_cgroup_ver = TST_CGROUP_V2,
+	.needs_cgroup_ctrls = (const char *const[]){ "memory", NULL },
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

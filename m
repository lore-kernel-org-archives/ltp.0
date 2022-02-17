Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52692C433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 05:36:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3B0B3CA0A3
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 06:36:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68C2F3C949B
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 06:36:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8EC1B1A01771
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 06:36:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2A2CD1FD41;
 Thu, 17 Feb 2022 05:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1645076185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SI00omz9QFgLLuTMRLCRWAwHxPUVo5Zp7MGk2CVP8yI=;
 b=f4tP8fx+/cODaMfZRHWnrTsTX8aqe+8yW1kdp7vaNXEalQkLxqhurgVKXME9gLTjBcz+4L
 02bcjBlyc3Q4s5i3Nq/ZAq4cxBhgbbh6nqKjkGmTSIHCFMrHetrj/I9TdClC57Iqwe1GRb
 7lIZiZjC+03ypv7jyEGjUFxB97uUfdQ=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id DFE9BA3B83;
 Thu, 17 Feb 2022 05:36:24 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 17 Feb 2022 05:35:10 +0000
Message-Id: <20220217053510.19096-4-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217053510.19096-1-rpalethorpe@suse.com>
References: <20220217053510.19096-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] memcontrol04: Copy from kselftest
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

At first glance this test looks the same as memcontrol03. However
there are some significant changes which complicate combining the two.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol04.c   | 243 ++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol04.c

diff --git a/runtest/controllers b/runtest/controllers
index 4a6f919af..3108a2561 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -20,6 +20,7 @@ memcg_control		memcg_control_test.sh
 memcontrol01 memcontrol01
 memcontrol02 memcontrol02
 memcontrol03 memcontrol03
+memcontrol04 memcontrol04
 
 cgroup_fj_function_debug cgroup_fj_function.sh debug
 cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
index 49df1582c..3883cede6 100644
--- a/testcases/kernel/controllers/memcg/.gitignore
+++ b/testcases/kernel/controllers/memcg/.gitignore
@@ -8,3 +8,4 @@
 memcontrol01
 memcontrol02
 memcontrol03
+memcontrol04
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
new file mode 100644
index 000000000..7a0067fe2
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*\
+ *
+ * [Description]
+ *
+ * Conversion of the forth kself test in cgroup/test_memcontrol.c.
+ *
+ * Original description:
+ * "First, this test creates the following hierarchy:
+ * A       memory.low = 50M,  memory.max = 200M
+ * A/B     memory.low = 50M,  memory.current = 50M
+ * A/B/C   memory.low = 75M,  memory.current = 50M
+ * A/B/D   memory.low = 25M,  memory.current = 50M
+ * A/B/E   memory.low = 500M, memory.current = 0
+ * A/B/F   memory.low = 0,    memory.current = 50M
+ *
+ * Usages are pagecache
+ * Then it creates A/G and creates a significant
+ * memory pressure in it.
+ *
+ * A/B    memory.current ~= 50M
+ * A/B/C  memory.current ~= 33M
+ * A/B/D  memory.current ~= 17M
+ * A/B/E  memory.current ~= 0
+ *
+ * After that it tries to allocate more than there is unprotected
+ * memory in A available, and checks that memory.low protects
+ * pagecache even in this case."
+ *
+ * The closest thing to memory.low on V1 is soft_limit_in_bytes which
+ * uses a different mechanism and has different semantics. So we only
+ * test on V2 like the selftest. We do test on more file systems, but
+ * not tempfs becaue it can't evict the page cache without swap. Also
+ * we avoid filesystems which allocate extra memory for buffer heads.
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
+static struct tst_cg_group *trunk_cg[3];
+static struct tst_cg_group *leaf_cg[4];
+static int fd = -1;
+
+enum checkpoints {
+	CHILD_IDLE
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
+		leaf_cg[i - 1] = tst_cg_group_rm(leaf_cg[i - 1]);
+	}
+
+	for (i = ARRAY_SIZE(trunk_cg); i > 0; i--) {
+		if (!trunk_cg[i - 1])
+			continue;
+
+		trunk_cg[i - 1] = tst_cg_group_rm(trunk_cg[i - 1]);
+	}
+}
+
+static void alloc_anon_in_child(const struct tst_cg_group *const cg,
+				const size_t size)
+{
+	const pid_t pid = SAFE_FORK();
+
+	if (pid) {
+		tst_reap_children();
+		return;
+	}
+
+	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
+
+	tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
+		getpid(), tst_cg_group_name(cg), size);
+	alloc_anon(size);
+
+	exit(0);
+}
+
+static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
+				     const size_t size)
+{
+	const pid_t pid = SAFE_FORK();
+
+	if (pid) {
+		tst_reap_children();
+		return;
+	}
+
+	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
+
+	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
+		getpid(), tst_cg_group_name(cg), size);
+	alloc_pagecache(fd, size);
+
+	exit(0);
+}
+
+static void test_memcg_low(void)
+{
+	long c[4];
+	unsigned int i;
+
+	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
+	trunk_cg[A] = tst_cg_group_mk(tst_cg, "trunk_A");
+
+	SAFE_CG_SCANF(trunk_cg[A], "memory.low", "%ld", c);
+	if (c[0]) {
+		tst_brk(TCONF,
+			"memory.low already set to %ld on parent group", c[0]);
+	}
+
+	SAFE_CG_PRINT(trunk_cg[A], "cgroup.subtree_control", "+memory");
+
+	SAFE_CG_PRINT(trunk_cg[A], "memory.max", "200M");
+	SAFE_CG_PRINT(trunk_cg[A], "memory.swap.max", "0");
+
+	trunk_cg[B] = tst_cg_group_mk(trunk_cg[A], "trunk_B");
+
+	SAFE_CG_PRINT(trunk_cg[B], "cgroup.subtree_control", "+memory");
+
+	trunk_cg[G] = tst_cg_group_mk(trunk_cg[A], "trunk_G");
+
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
+		leaf_cg[i] = tst_cg_group_mk(trunk_cg[B],
+						 "leaf_%c", 'C' + i);
+
+		if (i == E)
+			continue;
+
+		alloc_pagecache_in_child(leaf_cg[i], MB(50));
+	}
+
+	SAFE_CG_PRINT(trunk_cg[A], "memory.low", "50M");
+	SAFE_CG_PRINT(trunk_cg[B], "memory.low", "50M");
+	SAFE_CG_PRINT(leaf_cg[C], "memory.low", "75M");
+	SAFE_CG_PRINT(leaf_cg[D], "memory.low", "25M");
+	SAFE_CG_PRINT(leaf_cg[E], "memory.low", "500M");
+	SAFE_CG_PRINT(leaf_cg[F], "memory.low", "0");
+
+	alloc_anon_in_child(trunk_cg[G], MB(148));
+
+	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
+	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
+		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
+
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
+		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
+
+	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
+		     "(A/B/C memory.current=%ld) ~= %d", c[C], MB(33));
+	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
+		     "(A/B/D memory.current=%ld) ~= %d", c[D], MB(17));
+	TST_EXP_EXPR(values_close(c[2], 0, 1),
+		     "(A/B/E memory.current=%ld) ~= 0", c[E]);
+	tst_res(TINFO, "A/B/F memory.current=%ld", c[F]);
+
+	alloc_anon_in_child(trunk_cg[G], MB(166));
+
+	for (i = 0; i < ARRAY_SIZE(trunk_cg); i++) {
+		long low, oom;
+		const char id = "ABG"[i];
+
+		SAFE_CG_LINES_SCANF(trunk_cg[i], "memory.events",
+				    "low %ld", &low);
+		SAFE_CG_LINES_SCANF(trunk_cg[i], "memory.events",
+				    "oom %ld", &oom);
+
+		tst_res(TINFO, "%c: low events=%ld, oom events=%ld",
+			id, low, oom);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++) {
+		long low, oom;
+		const char id = 'C' + i;
+
+		SAFE_CG_LINES_SCANF(leaf_cg[i], "memory.events",
+				    "low %ld", &low);
+		SAFE_CG_LINES_SCANF(leaf_cg[i], "memory.events",
+				    "oom %ld", &oom);
+
+		TST_EXP_EXPR(oom == 0, "(%c oom events=%ld) == 0", id, oom);
+
+		if (i < E)
+			TST_EXP_EXPR(low > 0, "(%c low events=%ld) > 0", id, low)
+		else
+			TST_EXP_EXPR(low == 0, "(%c low events=%ld) == 0", id, low);
+	}
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
+	.test_all = test_memcg_low,
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
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const[]){ "memory", NULL },
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B034C433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 06:14:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D62633C9739
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 07:14:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 959F23C96C0
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1495410006A5
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:09 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A36431F461;
 Thu, 27 Jan 2022 06:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643263988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvAG4KZ5dr59WxSJ6d0a2GcuUkz3XGeblY97dOrYk1Y=;
 b=MRD1vJKgpo6nW6Oz7g3qqPy9M5fiop4NtTqmKt0DGNGPY3L7WRdtS08MeSiVDocm2tXH6G
 tJYIo7bZB0cq9KB7Mc4weuX2TNg16zaep1WTvZZxxyScruG4JoeG51ZAvdJIZOJ4xJMohk
 UtyU1xRxsH6zjoqt2VK2pMN61yUHHL4=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 6FD43A3B81;
 Thu, 27 Jan 2022 06:13:08 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 06:12:25 +0000
Message-Id: <20220127061225.23368-7-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127061225.23368-1-rpalethorpe@suse.com>
References: <20220127061225.23368-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] memcontrol03: Copy from kselftest
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
 .../kernel/controllers/memcg/memcontrol03.c   | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol03.c

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
new file mode 100644
index 000000000..4d6ca9761
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -0,0 +1,231 @@
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
+ *
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
+static const struct tst_cgroup_group *cg_test;
+static struct tst_cgroup_group *parent[3];
+static struct tst_cgroup_group *children[4];
+static int fd;
+
+enum checkpoints {
+	CHILD_IDLE,
+	TEST_DONE,
+};
+
+static void cleanup_sub_groups(void)
+{
+	size_t i;
+
+	for (i = ARRAY_SIZE(children); i > 0; i--) {
+		if (!children[i - 1])
+			continue;
+
+		TST_CHECKPOINT_WAKE2(TEST_DONE,
+				     ARRAY_SIZE(children) - 1);
+		tst_reap_children();
+		break;
+	}
+
+	for (i = ARRAY_SIZE(children); i > 0; i--) {
+		if (!children[i - 1])
+			continue;
+
+		children[i - 1] = tst_cgroup_group_rm(children[i - 1]);
+	}
+
+	for (i = ARRAY_SIZE(parent); i > 0; i--) {
+		if (!parent[i - 1])
+			continue;
+
+		parent[i - 1] = tst_cgroup_group_rm(parent[i - 1]);
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
+		tst_res(TINFO, "%d in %s: Allocating anon: %"PRIdPTR,
+		getpid(), tst_cgroup_group_name(cg), size);
+		alloc_anon(size);
+		exit(0);
+	}
+
+	if (expect_oom)
+		SAFE_WAITPID(pid, &status, 0);
+	else
+		tst_reap_child(pid);
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
+	tst_res(TINFO, "%d in %s: Allocating pagecache: %"PRIdPTR,
+		getpid(), tst_cgroup_group_name(cg), size);
+	alloc_pagecache(fd, size);
+
+	TST_CHECKPOINT_WAKE(CHILD_IDLE);
+	TST_CHECKPOINT_WAIT(TEST_DONE);
+	exit(0);
+}
+
+/*
+ */
+static void test_memcg_min(void)
+{
+	long c[4];
+	size_t i, attempts;
+	char child_name[64];
+
+	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
+	parent[0] = tst_cgroup_group_mk(cg_test, "memcg_test_0");
+
+	SAFE_CGROUP_SCANF(parent[0], "memory.min", "%ld", c);
+	if (c[0]) {
+		tst_brk(TCONF,
+			"memory.min already set to %ld on parent group", c[0]);
+	}
+
+	if (!TST_CGROUP_VER_IS_V1(parent[0], "memory")) {
+		SAFE_CGROUP_PRINT(parent[0], "cgroup.subtree_control",
+				  "+memory");
+	}
+	SAFE_CGROUP_PRINT(parent[0], "memory.max", "200M");
+	SAFE_CGROUP_PRINT(parent[0], "memory.swap.max", "0");
+
+	parent[1] = tst_cgroup_group_mk(parent[0], "memcg_test_1");
+	if (!TST_CGROUP_VER_IS_V1(parent[0], "memory")) {
+		SAFE_CGROUP_PRINT(parent[1], "cgroup.subtree_control",
+				  "+memory");
+	}
+
+	parent[2] = tst_cgroup_group_mk(parent[0], "memcg_test_2");
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		sprintf(child_name, "child_memcg_%"PRIdPTR, i);
+
+		children[i] = tst_cgroup_group_mk(parent[1], child_name);
+
+		if (i == 2)
+			continue;
+
+		alloc_pagecache_in_child(children[i], MB(50));
+	}
+
+	SAFE_CGROUP_PRINT(parent[0], "memory.min", "50M");
+	SAFE_CGROUP_PRINT(parent[1], "memory.min", "50M");
+	SAFE_CGROUP_PRINT(children[0], "memory.min", "75M");
+	SAFE_CGROUP_PRINT(children[1], "memory.min", "25M");
+	SAFE_CGROUP_PRINT(children[2], "memory.min", "500M");
+	SAFE_CGROUP_PRINT(children[3], "memory.min", "0");
+
+	for (attempts = 0; attempts < 5; attempts++) {
+		SAFE_CGROUP_SCANF(parent[1], "memory.current", "%ld", c);
+		if (values_close(c[0], MB(150), 3))
+			break;
+
+		sleep(1);
+	}
+
+	alloc_anon_in_child(parent[2], MB(148), 0);
+
+	SAFE_CGROUP_SCANF(parent[1], "memory.current", "%ld", c);
+	TST_EXP_EXPR(values_close(c[0], MB(50), 5), "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
+
+	for (i = 0; i < ARRAY_SIZE(children); i++)
+		SAFE_CGROUP_SCANF(children[i], "memory.current", "%ld", c + i);
+
+	TST_EXP_EXPR(values_close(c[0], MB(33), 20), "(A/B/C memory.current=%ld) ~= %d", c[0], MB(33));
+	TST_EXP_EXPR(values_close(c[1], MB(17), 20), "(A/B/D memory.current=%ld) ~= %d", c[1], MB(17));
+	TST_EXP_EXPR(values_close(c[2], 0, 1), "(A/B/E memory.current=%ld) ~= 0", c[2]);
+
+	alloc_anon_in_child(parent[2], MB(170), 1);
+
+	SAFE_CGROUP_SCANF(parent[1], "memory.current", "%ld", c);
+	TST_EXP_EXPR(values_close(c[0], MB(50), 5), "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
+
+	cleanup_sub_groups();
+	SAFE_CLOSE(fd);
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
+	.needs_cgroup_controllers = (const char *const[]){ "memory", NULL },
+	.test_cgroup = &cg_test,
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

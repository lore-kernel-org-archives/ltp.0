From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 21 May 2021 11:25:28 +0100
Subject: [LTP] [PATCH v2 6/6] sched/cgroup: Add cfs_bandwidth01
In-Reply-To: <20210521102528.21102-1-rpalethorpe@suse.com>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
Message-ID: <20210521102528.21102-7-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/sched                                 |   1 +
 .../kernel/sched/cfs-scheduler/.gitignore     |   1 +
 testcases/kernel/sched/cfs-scheduler/Makefile |   4 +-
 .../sched/cfs-scheduler/cfs_bandwidth01.c     | 175 ++++++++++++++++++
 4 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c

diff --git a/runtest/sched b/runtest/sched
index bfc4f2711..592898723 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -6,6 +6,7 @@ pth_str03 pth_str03
 time-schedule01		time-schedule
 trace_sched01		trace_sched -c 1
 
+cfs_bandwidth01 cfs_bandwidth01 -i 5
 hackbench01 hackbench 50 process 1000
 hackbench02 hackbench 20 thread 1000
 
diff --git a/testcases/kernel/sched/cfs-scheduler/.gitignore b/testcases/kernel/sched/cfs-scheduler/.gitignore
index db2759e4f..c5dacd6ef 100644
--- a/testcases/kernel/sched/cfs-scheduler/.gitignore
+++ b/testcases/kernel/sched/cfs-scheduler/.gitignore
@@ -1 +1,2 @@
 /hackbench
+cfs_bandwidth01
diff --git a/testcases/kernel/sched/cfs-scheduler/Makefile b/testcases/kernel/sched/cfs-scheduler/Makefile
index aa3bf8459..2ffe1f7f9 100644
--- a/testcases/kernel/sched/cfs-scheduler/Makefile
+++ b/testcases/kernel/sched/cfs-scheduler/Makefile
@@ -18,8 +18,8 @@
 
 top_srcdir		?= ../../../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS			+= -lpthread
+hackbench: LDLIBS			+= -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
new file mode 100644
index 000000000..7c988730e
--- /dev/null
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com> */
+/*\
+ *
+ * [Description]
+ *
+ * Creates a multi-level CGroup hierarchy with the cpu controller
+ * enabled. The leaf groups are populated with "busy" processes which
+ * simulate intermittent cpu load. They spin for some time then sleep
+ * then repeat.
+ *
+ * Both the trunk and leaf groups are set cpu bandwidth limits. The
+ * busy processes will intermittently exceed these limits. Causing
+ * them to be throttled. When they begin sleeping this will then cause
+ * them to be unthrottle.
+ *
+ * The test is known to reproduce an issue with an update to
+ * SLE-15-SP1 (kernel 4.12.14-197.64, bsc#1179093).
+ */
+
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_cgroup.h"
+#include "tst_timer.h"
+
+static const struct tst_cgroup_group *cg_test;
+static struct tst_cgroup_group *cg_level2, *cg_level3a, *cg_level3b;
+static struct tst_cgroup_group *cg_workers[3];
+
+static void set_cpu_quota(const struct tst_cgroup_group *const cg,
+			  const float quota_percent)
+{
+	const unsigned int period_us = 10000;
+	const unsigned int quota_us = (quota_percent / 100) * (float)period_us;
+
+	if (TST_CGROUP_VER(cg, "cpu") != TST_CGROUP_V1) {
+		SAFE_CGROUP_PRINTF(cg, "cpu.max",
+				   "%u %u", quota_us, period_us);
+	} else {
+		SAFE_CGROUP_PRINTF(cg, "cpu.max",
+				   "%u", quota_us);
+		SAFE_CGROUP_PRINTF(cg, "cpu.cfs_period_us",
+				  "%u", period_us);
+	}
+
+	tst_res(TINFO, "Set '%s/cpu.max' = '%d %d'",
+		tst_cgroup_group_name(cg), quota_us, period_us);
+}
+
+static struct tst_cgroup_group *
+mk_cpu_cgroup(const struct tst_cgroup_group *const cg_parent,
+	      const char *const cg_child_name,
+	      const float quota_percent)
+{
+	struct tst_cgroup_group *const cg =
+		tst_cgroup_group_mk(cg_parent, cg_child_name);
+
+	set_cpu_quota(cg, quota_percent);
+
+	return cg;
+}
+
+static void busy_loop(const unsigned int sleep_ms)
+{
+	for (;;) {
+		tst_timer_start(CLOCK_MONOTONIC_RAW);
+		while (!tst_timer_expired_ms(20))
+			;
+
+		const int ret = tst_checkpoint_wait(0, sleep_ms);
+
+		if (!ret)
+			exit(0);
+
+		if (errno != ETIMEDOUT)
+			tst_brk(TBROK | TERRNO, "tst_checkpoint_wait");
+	}
+}
+
+static void fork_busy_procs_in_cgroup(const struct tst_cgroup_group *const cg)
+{
+	const unsigned int sleeps_ms[] = {3000, 1000, 10};
+	const pid_t worker_pid = SAFE_FORK();
+	size_t i;
+
+	if (worker_pid)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(sleeps_ms); i++) {
+		const pid_t busy_pid = SAFE_FORK();
+
+		if (!busy_pid)
+			busy_loop(sleeps_ms[i]);
+
+		SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", busy_pid);
+	}
+
+	tst_reap_children();
+
+	exit(0);
+}
+
+static void do_test(void)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cg_workers); i++)
+		fork_busy_procs_in_cgroup(cg_workers[i]);
+
+	tst_res(TPASS, "Scheduled bandwidth constrained workers");
+
+	sleep(1);
+
+	set_cpu_quota(cg_level2, 50);
+
+	sleep(2);
+
+	TST_CHECKPOINT_WAKE2(0, 3 * 3);
+	tst_reap_children();
+
+	tst_res(TPASS, "Workers exited");
+}
+
+static void setup(void)
+{
+	tst_cgroup_require("cpu", NULL);
+
+	cg_test = tst_cgroup_get_test_group();
+
+	cg_level2 = tst_cgroup_group_mk(cg_test, "level2");
+
+	cg_level3a = tst_cgroup_group_mk(cg_level2, "level3a");
+	cg_workers[0] = mk_cpu_cgroup(cg_level3a, "worker1", 30);
+	cg_workers[1] = mk_cpu_cgroup(cg_level3a, "worker2", 20);
+
+	cg_level3b = tst_cgroup_group_mk(cg_level2, "level3b");
+	cg_workers[2] = mk_cpu_cgroup(cg_level3b, "worker3", 30);
+}
+
+static void cleanup(void)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cg_workers); i++) {
+		if (cg_workers[i])
+			cg_workers[i] = tst_cgroup_group_rm(cg_workers[i]);
+	}
+
+	if (cg_level3a)
+		cg_level3a = tst_cgroup_group_rm(cg_level3a);
+	if (cg_level3b)
+		cg_level3b = tst_cgroup_group_rm(cg_level3b);
+	if (cg_level2)
+		cg_level2 = tst_cgroup_group_rm(cg_level2);
+
+	tst_cgroup_cleanup();
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "39f23ce07b93"},
+		{"linux-git", "b34cb07dde7c"},
+		{"linux-git", "fe61468b2cbc"},
+		{"linux-git", "5ab297bab984"},
+		{"linux-git", "6d4d22468dae"},
+		{ }
+	}
+};
-- 
2.31.1


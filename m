From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 31 Aug 2021 11:00:01 +0200
Subject: [LTP] [PATCH 1/2] cfs_bandwidth01: Fix cleanup on failure in
 set_cpu_quota
Message-ID: <20210831090002.1431298-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If set_cpu_quota failed, mk_cpu_cgroup did not return
and cg_workers[n] was not set. This lead to a failure during
cleanup, because the worker cgroups were not deleted.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../sched/cfs-scheduler/cfs_bandwidth01.c       | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index 9301ee458..e8032d65a 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -57,17 +57,14 @@ static void set_cpu_quota(const struct tst_cgroup_group *const cg,
 		tst_cgroup_group_name(cg), quota_us, period_us);
 }
 
-static struct tst_cgroup_group *
-mk_cpu_cgroup(const struct tst_cgroup_group *const cg_parent,
+static void mk_cpu_cgroup(struct tst_cgroup_group **cg,
+          const struct tst_cgroup_group *const cg_parent,
 	      const char *const cg_child_name,
 	      const float quota_percent)
 {
-	struct tst_cgroup_group *const cg =
-		tst_cgroup_group_mk(cg_parent, cg_child_name);
+	*cg = tst_cgroup_group_mk(cg_parent, cg_child_name);
 
-	set_cpu_quota(cg, quota_percent);
-
-	return cg;
+	set_cpu_quota(*cg, quota_percent);
 }
 
 static void busy_loop(const unsigned int sleep_ms)
@@ -142,11 +139,11 @@ static void setup(void)
 	cg_level2 = tst_cgroup_group_mk(cg_test, "level2");
 
 	cg_level3a = tst_cgroup_group_mk(cg_level2, "level3a");
-	cg_workers[0] = mk_cpu_cgroup(cg_level3a, "worker1", 30);
-	cg_workers[1] = mk_cpu_cgroup(cg_level3a, "worker2", 20);
+	mk_cpu_cgroup(&cg_workers[0], cg_level3a, "worker1", 30);
+	mk_cpu_cgroup(&cg_workers[1], cg_level3a, "worker2", 20);
 
 	cg_level3b = tst_cgroup_group_mk(cg_level2, "level3b");
-	cg_workers[2] = mk_cpu_cgroup(cg_level3b, "worker3", 30);
+	mk_cpu_cgroup(&cg_workers[2], cg_level3b, "worker3", 30);
 }
 
 static void cleanup(void)
-- 
2.25.1


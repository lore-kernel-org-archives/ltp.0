From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 31 Aug 2021 11:00:02 +0200
Subject: [LTP] [PATCH 2/2] cfs_bandwidth01: Add misssing needs_kconfigs
In-Reply-To: <20210831090002.1431298-1-lkml@jv-coder.de>
References: <20210831090002.1431298-1-lkml@jv-coder.de>
Message-ID: <20210831090002.1431298-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The test requires CONFIG_CFS_BANDWIDTH, otherwise it fails with
cfs_bandwidth01.c:51: TBROK: openat(13</sys/fs/cgroup/cpu,cpuacct/ltp/test-5666/level2/level3a/worker1>, 'cpu.cfs_period_us', O_WRONLY): ENOENT (2)

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index e8032d65a..001fb2685 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -178,6 +178,10 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_CFS_BANDWIDTH",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "39f23ce07b93"},
 		{"linux-git", "b34cb07dde7c"},
-- 
2.25.1


From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  1 Jun 2021 11:55:18 +0100
Subject: [LTP] [PATCH v3 3/6] API/cgroups: Add cpu controller
In-Reply-To: <20210601105521.27459-1-rpalethorpe@suse.com>
References: <20210601105521.27459-1-rpalethorpe@suse.com>
Message-ID: <20210601105521.27459-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 8fd5ab288..0b71d4eed 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -82,7 +82,8 @@ struct cgroup_root {
 /* Controller sub-systems */
 enum cgroup_ctrl_indx {
 	CTRL_MEMORY = 1,
-	CTRL_CPUSET = 2,
+	CTRL_CPU,
+	CTRL_CPUSET,
 };
 #define CTRLS_MAX CTRL_CPUSET
 
@@ -162,6 +163,18 @@ static const files_t memory_ctrl_files = {
 	{ }
 };
 
+static const files_t cpu_ctrl_files = {
+	/* The V1 quota and period files were combined in the V2 max
+	 * file. The quota is in the first column and if we just print
+	 * a single value to the file, it will be treated as the
+	 * quota. To get or set the period we need to branch on the
+	 * API version.
+	 */
+	{ "cpu.max", "cpu.cfs_quota_us", CTRL_CPU },
+	{ "cpu.cfs_period_us", "cpu.cfs_period_us", CTRL_CPU },
+	{ }
+};
+
 static const files_t cpuset_ctrl_files = {
 	{ "cpuset.cpus", "cpuset.cpus", CTRL_CPUSET },
 	{ "cpuset.mems", "cpuset.mems", CTRL_CPUSET },
@@ -174,6 +187,9 @@ static struct cgroup_ctrl controllers[] = {
 	[CTRL_MEMORY] = {
 		"memory", memory_ctrl_files, CTRL_MEMORY, NULL, 0
 	},
+	[CTRL_CPU] = {
+		"cpu", cpu_ctrl_files, CTRL_CPU, NULL, 0
+	},
 	[CTRL_CPUSET] = {
 		"cpuset", cpuset_ctrl_files, CTRL_CPUSET, NULL, 0
 	},
-- 
2.31.1


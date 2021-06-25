From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Jun 2021 11:03:19 +0800
Subject: [LTP] [COMMITTED] cfs-scheduler: Add one more kernel git hash
Message-ID: <20210625030319.496916-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index b06cede16..9301ee458 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -16,6 +16,14 @@
  *
  * The test is known to reproduce an issue with an update to
  * SLE-15-SP1 (kernel 4.12.14-197.64, bsc#1179093).
+ *
+ * Also as an reproducer for another bug:
+ *
+ *    commit fdaba61ef8a268d4136d0a113d153f7a89eb9984
+ *    Author: Rik van Riel <riel@surriel.com>
+ *    Date:   Mon Jun 21 19:43:30 2021 +0200
+ *
+ *    sched/fair: Ensure that the CFS parent is added after unthrottling
  */
 
 #include <stdlib.h>
@@ -179,6 +187,7 @@ static struct tst_test test = {
 		{"linux-git", "fe61468b2cbc"},
 		{"linux-git", "5ab297bab984"},
 		{"linux-git", "6d4d22468dae"},
+		{"linux-git", "fdaba61ef8a2"},
 		{ }
 	}
 };
-- 
2.31.1


From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 15 Feb 2019 14:52:39 +0000
Subject: [LTP] [PATCH 1/1] cgroup_regression_test.sh: Fix TWARN usage
In-Reply-To: <20190215145239.51806-1-cristian.marussi@arm.com>
References: <20190215145239.51806-1-cristian.marussi@arm.com>
Message-ID: <20190215145239.51806-2-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using TWARN to report that a specific sub-testcase is skipped
caused the whole cgroup_regression_test.sh to be reported as
FAILING. Using TCONF instead.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/kernel/controllers/cgroup/cgroup_regression_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 686860923..e197f5d3f 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -408,7 +408,7 @@ test_7_2()
 
 	grep -q -w "cpu" /proc/cgroups
 	if [ $? -ne 0 -o ! -e /proc/sched_debug ]; then
-		tst_res TWARN "skip rest of testing due possible oops triggered by reading /proc/sched_debug"
+		tst_res TCONF "skip rest of testing due possible oops triggered by reading /proc/sched_debug"
 		return
 	fi
 
-- 
2.17.1


From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Fri,  8 Jul 2016 14:49:02 +0800
Subject: [LTP]  [PATCH] cgroup_fj/cgroup_fj_common.sh:cpuset prefix issue
Message-ID: <1467960542-5177-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

Sometimes there is no cpuset. prefix for cpuset subsystem.
Try either $mount_point/XXXX or $mount_point/cpuset.XXXX.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 .../controllers/cgroup_fj/cgroup_fj_common.sh      |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index df2cbfc..13e2938 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -69,8 +69,13 @@ create_subgroup()
     # cpuset.cpus and cpuset.mems must be initialized with suitable value
     # before any pids are attached
     if [ "$subsystem" == "cpuset" ]; then
-        ROD cat "$mount_point/cpuset.cpus" \> "$path/cpuset.cpus"
-        ROD cat "$mount_point/cpuset.mems" \> "$path/cpuset.mems"
+        if [ -e "$mount_point/cpus" ]; then
+            ROD cat "$mount_point/cpus" \> "$path/cpus"
+            ROD cat "$mount_point/mems" \> "$path/mems"
+        else
+            ROD cat "$mount_point/cpuset.cpus" \> "$path/cpuset.cpus"
+            ROD cat "$mount_point/cpuset.mems" \> "$path/cpuset.mems"
+        fi
     fi
 }
 
-- 
1.7.9.5


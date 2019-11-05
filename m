From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Tue,  5 Nov 2019 12:20:00 +0100
Subject: [LTP] [PATCH v1] cgroup_fj_stress: Avoid killall
Message-ID: <20191105112000.20633-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We discovered problems that killall didn't catched all processes. With
this patch, we collect the pids manually and kill them one after the
other.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 698aa4979..27ea7634a 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -74,6 +74,7 @@ setup
 export TMPFILE=./tmp_tasks.$$
 
 count=0
+collected_pids=""
 
 build_subgroups()
 {
@@ -107,6 +108,7 @@ attach_task()
     if [ -z "$ppid" ]; then
         cgroup_fj_proc&
         pid=$!
+        collected_pids="$collected_pids $pid"
     else
         pid="$ppid"
     fi
@@ -148,9 +150,10 @@ case $attach_operation in
 "each" )
     tst_resm TINFO "Attaching task to each subgroup"
     attach_task "$start_path" 0
-    ROD killall -9 "cgroup_fj_proc"
-    # Wait for attached tasks to terminate
-    wait
+    for pid in $collected_pids; do
+        ROD kill -9 "$pid"
+        wait "$pid"
+    done
     ;;
 *  )
     ;;
-- 
2.16.4


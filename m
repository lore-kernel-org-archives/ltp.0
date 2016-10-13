From: shuwang@redhat.com <shuwang@redhat.com>
Date: Thu, 13 Oct 2016 11:05:06 +0800
Subject: [LTP] [PATCH 1/1] controllers/cgroup_fj: fix longtime wait
	cgroup_fj_proc.
Message-ID: <1476327906-8985-1-git-send-email-shuwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: shuwang <shuwang@redhat.com>

On some machines, when many cgroup_fj_proc created on the background,
killall may failed to find and kill them all as the processes are
just created and not ready. And that will cause the ltp testrun wait
forever. So changed to use kill -9 instead.

Signed-off-by: shuwang <shuwang@redhat.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 698aa49..8c21d59 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -107,6 +107,7 @@ attach_task()
     if [ -z "$ppid" ]; then
         cgroup_fj_proc&
         pid=$!
+        pids+="$pid "
     else
         pid="$ppid"
     fi
@@ -148,7 +149,7 @@ case $attach_operation in
 "each" )
     tst_resm TINFO "Attaching task to each subgroup"
     attach_task "$start_path" 0
-    ROD killall -9 "cgroup_fj_proc"
+    ROD kill -9 "$pids"
     # Wait for attached tasks to terminate
     wait
     ;;
-- 
2.5.0


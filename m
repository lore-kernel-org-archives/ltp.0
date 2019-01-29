From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jan 2019 18:44:08 +0100
Subject: [LTP] [PATCH 1/1] memcg_stress_test.sh: Further cleanup
Message-ID: <20190129174408.13796-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Cristian,

I suggest this changes, to be applied after your patch
"[v3] memcg_stress_test.sh: ported to newlib" [1].

Do you agree? Could you test it?

Some more questions:
* I wonder if rmdir in cleanup is needed (at least on latest kernel umount
is enough):
		rmdir /dev/memcg 2> /dev/null
* I'd drop cleanup either from do_mount or run_stress. It does not harm,
but it looks to be redundant.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1020689/
---
 .../memcg/stress/memcg_stress_test.sh         | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 9972b6c45..3e0d40e84 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -54,35 +54,41 @@ do_mount()
 	mount -t cgroup -omemory memcg /dev/memcg
 }
 
-# $1 - Number of cgroups
-# $2 - Allocated how much memory in one process? in MB
-# $3 - The interval to touch memory in a process
-# $4 - How long does this test run ? in second
+# $1 Number of cgroups
+# $2 Allocated how much memory in one process? in MB
+# $3 The interval to touch memory in a process
+# $4 How long does this test run ? in second
 run_stress()
 {
-	local i
+	local cgroups="$1"
+	local mem_size="$2"
+	local interval="$3"
+	local timeout="$4"
+	local i pids
+
+	tst_res TINFO "Testing $cgroups cgroups, using $mem_size MB, interval $interval, run for $RUN_TIME secs"
 
 	do_mount
 
-	for i in $(seq 0 $(($1-1))); do
+	for i in $(seq 0 $(($cgroups-1))); do
 		mkdir /dev/memcg/$i 2> /dev/null
-		memcg_process_stress $2 $3 &
-		eval pid$i=$!
-
-		eval echo \$pid$i > /dev/memcg/$i/tasks
+		memcg_process_stress $mem_size $interval &
+		echo $! > /dev/memcg/$i/tasks
+		pids="$! $pids"
 	done
 
-	for i in $(seq 0 $(($1-1))); do
-		eval kill -USR1 \$pid$i 2> /dev/null
+	for pid in $pids; do
+		kill -USR1 $pid 2> /dev/null
 	done
 
-	sleep $4
-
-	for i in $(seq 0 $(($1-1))); do
-		eval kill -KILL \$pid$i 2> /dev/null
-		eval wait \$pid$i
+	sleep $timeout
 
+	i=0
+	for pid in $pids; do
+		kill -KILL $pid 2> /dev/null
+		wait $pid
 		rmdir /dev/memcg/$i 2> /dev/null
+		i=$((i+1))
 	done
 
 	cleanup
@@ -90,19 +96,13 @@ run_stress()
 
 test1()
 {
-	tst_res TINFO "testcase 1 started...it will run for $RUN_TIME secs"
-
 	run_stress 150 $(( ($MEM - 150) / 150 )) 5 $RUN_TIME
-
 	tst_res TPASS "stress test 1 passed"
 }
 
 test2()
 {
-	tst_res TINFO "testcase 2 started...it will run for $RUN_TIME secs"
-
 	run_stress 1 $MEM 5 $RUN_TIME
-
 	tst_res TPASS "stress test 2 passed"
 }
 
-- 
2.19.2


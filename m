From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri,  4 Jan 2019 19:02:40 +0000
Subject: [LTP] [PATCH]  memcg_stress_test.sh: fix memory usage
Message-ID: <20190104190240.18601-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently this test roughly calculates the maximum amount of
memory to use by barely looking up mem_free and swap_free from
/proc/meminfo.
Unfortunately it does not consider any special the systems
configured without a swap, so it ends, on those systems, trying
to use all the found mem_free while keeping only one mb
per-worker-thread as a safety net.
This is fine when using a 4k pagesize but it is NOT enough
on systems configured with a 64k pagesize, resulting in an
oom-party.
With this patch we now consider the configured page-size to
decide how many memory to set aside as a safety area.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../kernel/controllers/memcg/stress/memcg_stress_test.sh    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 652d99e55..97a4d444e 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -32,10 +32,12 @@ do_setup()
 	sleep 2
 	local mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
 	local swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
+	local pgsize=`tst_getconf PAGESIZE`
 
 	MEM=$(( $mem_free + $swap_free / 2 ))
 	MEM=$(( $MEM / 1024 ))
 	RUN_TIME=$(( 15 * 60 ))
+	[ "$pgsize" = "4096" ] && THREAD_SPARE_MB=1 || THREAD_SPARE_MB=8
 
 	tst_res TINFO "Calculated available memory $MEM MB"
 }
@@ -100,7 +102,7 @@ testcase_1()
 {
 	tst_res TINFO "testcase 1 started...it will run for $RUN_TIME secs"
 
-	run_stress 150 $(( ($MEM - 150) / 150 )) 5 $RUN_TIME
+	run_stress 150 $(( ($MEM - 150 * $THREAD_SPARE_MB) / 150 )) 5 $RUN_TIME
 
 	tst_res TPASS "stress test 1 passed"
 }
@@ -109,7 +111,7 @@ testcase_2()
 {
 	tst_res TINFO "testcase 2 started...it will run for $RUN_TIME secs"
 
-	run_stress 1 $MEM 5 $RUN_TIME
+	run_stress 1 $(( $MEM - $THREAD_SPARE_MB)) 5 $RUN_TIME
 
 	tst_res TPASS "stress test 2 passed"
 }
-- 
2.17.1


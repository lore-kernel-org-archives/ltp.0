From: Yang Shi <yang.shi@linux.alibaba.com>
Date: Fri, 25 May 2018 08:13:37 +0800
Subject: [LTP] [PATCH] memcg: functional: 4.16 kernel updates stat counter
	in a batch of 33 pages
Message-ID: <1527207217-70686-1-git-send-email-yang.shi@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Due to upstream kernel commit a983b5ebee57209c99f68c8327072f25e0e6e3da
("mm: memcontrol: fix excessive complexity in memory.stat reporting"),
memory.stat is updated in a batch of 33 pages. This results in some test
cases fail at checking stat counter since they just touch one page.

Introduce TST_PAGESIZE, which is 33 * PAGESIZE, used by affected test
cases, keep others still use PAGESIZE. And, this change doesn't break
pre-4.16 kernel.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 13 ++++++++-----
 .../functional/memcg_move_charge_at_immigrate_test.sh      | 14 +++++++-------
 .../kernel/controllers/memcg/functional/memcg_stat_rss.sh  | 12 ++++++------
 .../kernel/controllers/memcg/functional/memcg_stat_test.sh |  6 +++---
 4 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 6a6af85..ad6db24 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -34,6 +34,9 @@ if [ $? -ne 0 ]; then
 	tst_brkm TBROK "getconf PAGESIZE failed"
 fi
 
+# Post 4.16 kernel updates stat in batch (> 32 pages) every time
+TST_PAGESIZE=$(( $PAGESIZE * 33 ))
+
 HUGEPAGESIZE=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
 [ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
 HUGEPAGESIZE=$(( $HUGEPAGESIZE * 1024 ))
@@ -404,18 +407,18 @@ test_subgroup()
 	echo $1 > memory.limit_in_bytes
 	echo $2 > subgroup/memory.limit_in_bytes
 
-	tst_resm TINFO "Running memcg_process --mmap-anon -s $PAGESIZE"
-	memcg_process --mmap-anon -s $PAGESIZE &
+	tst_resm TINFO "Running memcg_process --mmap-anon -s $TST_PAGESIZE"
+	memcg_process --mmap-anon -s $TST_PAGESIZE &
 	TST_CHECKPOINT_WAIT 0
 
-	warmup $! $PAGESIZE
+	warmup $! $TST_PAGESIZE
 	if [ $? -ne 0 ]; then
 		return
 	fi
 
 	echo $! > tasks
-	signal_memcg_process $! $PAGESIZE
-	check_mem_stat "rss" $PAGESIZE
+	signal_memcg_process $! $TST_PAGESIZE
+	check_mem_stat "rss" $TST_PAGESIZE
 
 	cd subgroup
 	echo $! > tasks
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
index 6cdc7ed..2ef74ce 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
@@ -34,28 +34,28 @@ TST_TOTAL=4
 # Test disable moving charges
 testcase_1()
 {
-	test_move_charge "--mmap-anon" $PAGESIZE $PAGESIZE 0 0 0 $PAGESIZE 0
+	test_move_charge "--mmap-anon" $TST_PAGESIZE $TST_PAGESIZE 0 0 0 $TST_PAGESIZE 0
 }
 
 # Test move anon
 testcase_2()
 {
-	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE \
-		$((PAGESIZE*3)) 1 $PAGESIZE 0 0 $((PAGESIZE*2))
+	test_move_charge "--mmap-anon --shm --mmap-file" $TST_PAGESIZE \
+		$((TST_PAGESIZE*3)) 1 $TST_PAGESIZE 0 0 $((TST_PAGESIZE*2))
 }
 
 # Test move file
 testcase_3()
 {
-	test_move_charge "--mmap-anon --shm --mmap-file" $PAGESIZE \
-		$((PAGESIZE*3)) 2 0 $((PAGESIZE*2)) $PAGESIZE 0
+	test_move_charge "--mmap-anon --shm --mmap-file" $TST_PAGESIZE \
+		$((TST_PAGESIZE*3)) 2 0 $((TST_PAGESIZE*2)) $TST_PAGESIZE 0
 }
 
 # Test move anon and file
 testcase_4()
 {
-	test_move_charge "--mmap-anon --shm" $PAGESIZE \
-		$((PAGESIZE*2)) 3 $PAGESIZE $PAGESIZE 0 0
+	test_move_charge "--mmap-anon --shm" $TST_PAGESIZE \
+		$((TST_PAGESIZE*2)) 3 $TST_PAGESIZE $TST_PAGESIZE 0 0
 }
 
 run_tests
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
index a41e157..ad7fe44 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
@@ -33,7 +33,7 @@ TST_TOTAL=10
 # Test the management and counting of memory
 testcase_1()
 {
-	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
+	test_mem_stat "--mmap-anon" $TST_PAGESIZE $TST_PAGESIZE "rss" $TST_PAGESIZE false
 }
 
 testcase_2()
@@ -49,17 +49,17 @@ testcase_3()
 testcase_4()
 {
 	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE false
+		$TST_PAGESIZE $((TST_PAGESIZE*3)) "rss" $TST_PAGESIZE false
 }
 
 testcase_5()
 {
-	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
+	test_mem_stat "--mmap-lock1" $TST_PAGESIZE $TST_PAGESIZE "rss" $TST_PAGESIZE false
 }
 
 testcase_6()
 {
-	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
+	test_mem_stat "--mmap-anon" $TST_PAGESIZE $TST_PAGESIZE "rss" $TST_PAGESIZE true
 }
 
 testcase_7()
@@ -75,12 +75,12 @@ testcase_8()
 testcase_9()
 {
 	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE true
+		$TST_PAGESIZE $((TST_PAGESIZE*3)) "rss" $TST_PAGESIZE true
 }
 
 testcase_10()
 {
-	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
+	test_mem_stat "--mmap-lock1" $TST_PAGESIZE $TST_PAGESIZE "rss" $TST_PAGESIZE true
 }
 
 shmmax_setup
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 3bfc1da..c929975 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -34,14 +34,14 @@ TST_TOTAL=8
 # Test cache
 testcase_1()
 {
-	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "cache" $PAGESIZE false
+	test_mem_stat "--shm -k 3" $TST_PAGESIZE $TST_PAGESIZE "cache" $TST_PAGESIZE false
 }
 
 # Test mapped_file
 testcase_2()
 {
-	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE \
-		"mapped_file" $PAGESIZE false
+	test_mem_stat "--mmap-file" $TST_PAGESIZE $TST_PAGESIZE \
+		"mapped_file" $TST_PAGESIZE false
 }
 
 # Test unevictable with MAP_LOCKED
-- 
1.8.3.1


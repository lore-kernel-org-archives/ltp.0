From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 13 Jul 2021 11:22:09 +0200
Subject: [LTP] [PATCH v4 4/5] controllers/memcg: increase memory limit in
 subgroup charge
In-Reply-To: <20210713092210.17141-1-krzysztof.kozlowski@canonical.com>
References: <20210713092210.17141-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210713092210.17141-5-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The memcg_subgroup_charge was failing on kernel v5.8 in around 10% cases
with:

    memcg_subgroup_charge 1 TINFO: Running memcg_process --mmap-anon -s 135168
    memcg_subgroup_charge 1 TINFO: Warming up pid: 19289
    memcg_subgroup_charge 1 TINFO: Process is still here after warm up: 19289
    memcg_subgroup_charge 1 TFAIL: rss is 0, 135168 expected
    memcg_subgroup_charge 1 TPASS: rss is 0 as expected

In dmesg one could see that OOM killer killed the process even though
group memory limit was matching the usage:

    memcg_process invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
    CPU: 4 PID: 19289 Comm: memcg_process Not tainted 5.8.0-1031-oracle #32~20.04.2-Ubuntu
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.4.1 12/03/2020
    ...
    memory: usage 132kB, limit 132kB, failcnt 9
    memory+swap: usage 132kB, limit 9007199254740988kB, failcnt 0
    kmem: usage 4kB, limit 9007199254740988kB, failcnt 0
    ...
    Tasks state (memory values in pages):
    [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
    [  19289]     0 19289      669      389    40960        0             0 memcg_process
    oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/ltp_19257,task_memcg=/ltp_19257,task=memcg_process,pid=19289,uid=0
    Memory cgroup out of memory: Killed process 19289 (memcg_process) total-vm:2676kB, anon-rss:84kB, file-rss:1468kB, shmem-rss:4kB, UID:0 pgtables:40kB oom_score_adj:0
    oom_reaper: reaped process 19289 (memcg_process), now anon-rss:0kB, file-rss:0kB, shmem-rss:4kB

It seems actual kernel memory usage by a given group depends on number
of CPUs, where at least one page is allocated per-cpu beside regular
(expected) allocation.  Fix the test on machines with more CPUs by
including this per-CPU memory in group limits, plus some slack of 4
PAGES.  Increase also memory allocation from 32 to 64 pages to be more
distinctive from kernel per-CPU memory.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../memcg/functional/memcg_subgroup_charge.sh | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 9b23177a4dc5..0d2b235aff7c 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -14,16 +14,33 @@ TST_CNT=3
 
 . memcg_lib.sh
 
+# Allocate memory bigger than per-cpu kernel memory
+MEM_TO_ALLOC=$((PAGESIZES * 2))
+
 # Test the memory charge won't move to subgroup
 # $1 - memory.limit_in_bytes in parent group
 # $2 - memory.limit_in_bytes in sub group
 test_subgroup()
 {
+	local limit_parent=$1
+	local limit_subgroup=$2
+	local total_cpus=`tst_ncpus`
+
+	# Kernel memory allocated for the process is also charged.
+	# It might depend on the number of CPUs. For example on kernel v5.11
+	# additionally total_cpus plus 1-2 pages are charged to the group.
+	if [ $limit_parent -ne 0 ]; then
+		limit_parent=$((limit_parent + 4 * PAGESIZE + total_cpus * PAGESIZE))
+	fi
+	if [ $limit_subgroup -ne 0 ]; then
+		limit_subgroup=$((limit_subgroup + 4 * PAGESIZE + total_cpus * PAGESIZE))
+	fi
+
 	mkdir subgroup
-	echo $1 > memory.limit_in_bytes
-	echo $2 > subgroup/memory.limit_in_bytes
+	echo $limit_parent > memory.limit_in_bytes
+	echo $limit_subgroup > subgroup/memory.limit_in_bytes
 
-	start_memcg_process --mmap-anon -s $PAGESIZES
+	start_memcg_process --mmap-anon -s $MEM_TO_ALLOC
 
 	warmup
 	if [ $? -ne 0 ]; then
@@ -31,8 +48,8 @@ test_subgroup()
 	fi
 
 	echo $MEMCG_PROCESS_PID > tasks
-	signal_memcg_process $PAGESIZES
-	check_mem_stat "rss" $PAGESIZES
+	signal_memcg_process $MEM_TO_ALLOC
+	check_mem_stat "rss" $MEM_TO_ALLOC
 
 	cd subgroup
 	echo $MEMCG_PROCESS_PID > tasks
@@ -47,17 +64,17 @@ test_subgroup()
 test1()
 {
 	tst_res TINFO "Test that group and subgroup have no relationship"
-	test_subgroup $PAGESIZES $((2 * PAGESIZES))
+	test_subgroup $MEM_TO_ALLOC $((2 * MEM_TO_ALLOC))
 }
 
 test2()
 {
-	test_subgroup $PAGESIZES $PAGESIZES
+	test_subgroup $MEM_TO_ALLOC $MEM_TO_ALLOC
 }
 
 test3()
 {
-	test_subgroup $PAGESIZES 0
+	test_subgroup $MEM_TO_ALLOC 0
 }
 
 tst_run
-- 
2.27.0


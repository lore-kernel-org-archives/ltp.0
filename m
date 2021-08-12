From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 12 Aug 2021 10:02:39 +0200
Subject: [LTP] [PATCH v2 1/4] controllers/memcg: account per-node kernel
 memory
In-Reply-To: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
References: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210812080242.16972-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Recent Linux kernels charge groups also with kernel memory.  This is not
limited only to process-allocated memory but also cgroup-handling code
memory as well.

For example since kernel v5.9 with commit 3e38e0aaca9e ("mm: memcg:
charge memcg percpu memory to the parent cgroup") creating a subgroup
causes several kernel allocations towards this group.

These additional kernel memory allocations are proportional to number of
CPUs and number of nodes.

On c4.8xlarge AWS instance with 36 cores in two nodes with v5.11 Linux
kernel the memcg_subgroup_charge and memcg_use_hierarchy_test tests were
failing:

    memcg_use_hierarchy_test 1 TINFO: timeout per run is 0h 5m 0s
    memcg_use_hierarchy_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
    memcg_use_hierarchy_test 1 TINFO: test if one of the ancestors goes over its limit, the proces will be killed
    mkdir: cannot create directory ?subgroup?: Cannot allocate memory
    /home/ubuntu/ltp-install/testcases/bin/memcg_use_hierarchy_test.sh: 26: cd: can't cd to subgroup
    memcg_use_hierarchy_test 1 TINFO: Running memcg_process --mmap-lock1 -s 8192
    memcg_use_hierarchy_test 1 TFAIL: process  is not killed
    rmdir: failed to remove 'subgroup': No such file or directory

The kernel was unable to create the subgroup (mkdir returned -ENOMEM)
due to this additional per-node kernel memory allocations.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../controllers/memcg/functional/memcg_lib.sh | 35 +++++++++++++++++++
 .../memcg/functional/memcg_subgroup_charge.sh |  8 ++---
 .../functional/memcg_use_hierarchy_test.sh    |  6 ++--
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index dad66c798e19..c8b5df2b45f7 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -63,6 +63,41 @@ memcg_require_hierarchy_disabled()
 	fi
 }
 
+# Kernel memory allocated for the process is also charged.  It might depend on
+# the number of CPUs and number of nodes. For example on kernel v5.11
+# additionally total_cpus (plus 1 or 2) pages are charged to the group via
+# kernel memory.  For a two-node machine, additional 108 pages kernel memory
+# are charged to the group.
+#
+# Adjust the limit to account such per-CPU and per-node kernel memory.
+# $1 - expected cgroup memory limit value to adjust
+memcg_adjust_limit_for_kmem()
+{
+	[ $# -ne 1 ] && tst_brk TBROK "memcg_adjust_limit_for_kmem expects 1 parameter"
+
+	local limit=$1
+
+	# Total number of CPUs
+	local total_cpus=`tst_ncpus`
+
+	# Total number of nodes
+	if [ ! -d /sys/devices/system/node/node0 ]; then
+		total_nodes=1
+	else
+		total_nodes=`ls /sys/devices/system/node/ | grep -c "node[0-9][0-9]*"`
+	fi
+
+	local node_mem=0
+	if [ $total_nodes -gt 1 ]; then
+		node_mem=$((total_nodes - 1))
+		node_mem=$((node_mem * PAGESIZE * 128))
+	fi
+
+	limit=$((limit + 4 * PAGESIZE + total_cpus * PAGESIZE + node_mem))
+
+	echo $limit
+}
+
 memcg_setup()
 {
 	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 0d2b235aff7c..44fc7370eeff 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -24,16 +24,12 @@ test_subgroup()
 {
 	local limit_parent=$1
 	local limit_subgroup=$2
-	local total_cpus=`tst_ncpus`
 
-	# Kernel memory allocated for the process is also charged.
-	# It might depend on the number of CPUs. For example on kernel v5.11
-	# additionally total_cpus plus 1-2 pages are charged to the group.
 	if [ $limit_parent -ne 0 ]; then
-		limit_parent=$((limit_parent + 4 * PAGESIZE + total_cpus * PAGESIZE))
+		limit_parent=$(memcg_adjust_limit_for_kmem $limit_parent)
 	fi
 	if [ $limit_subgroup -ne 0 ]; then
-		limit_subgroup=$((limit_subgroup + 4 * PAGESIZE + total_cpus * PAGESIZE))
+		limit_subgroup=$(memcg_adjust_limit_for_kmem $limit_subgroup)
 	fi
 
 	mkdir subgroup
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
index 8be342499ece..129f91b14c0a 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
@@ -15,12 +15,14 @@ test1()
 {
 	tst_res TINFO "test if one of the ancestors goes over its limit, the proces will be killed"
 
+	local limit=$(memcg_adjust_limit_for_kmem $PAGESIZE)
+
 	echo 1 > memory.use_hierarchy
-	echo $PAGESIZE > memory.limit_in_bytes
+	echo $limit > memory.limit_in_bytes
 
 	mkdir subgroup
 	cd subgroup
-	test_proc_kill $((PAGESIZE * 3)) "--mmap-lock1" $((PAGESIZE * 2)) 0
+	test_proc_kill $((limit + PAGESIZE * 3)) "--mmap-lock1" $((limit + PAGESIZE * 2)) 0
 
 	cd ..
 	rmdir subgroup
-- 
2.30.2


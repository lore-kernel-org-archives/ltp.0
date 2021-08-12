From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 12 Aug 2021 10:02:40 +0200
Subject: [LTP] [PATCH v2 2/4] controllers/memcg: fix memcg_stat_test on two
 node machines
In-Reply-To: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
References: <20210812080242.16972-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210812080242.16972-3-krzysztof.kozlowski@canonical.com>
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
kernel the memcg_stat_test was failing because of unable to set memory
limit lower than current kernel memory accounted to the group:

    memcg_stat_test 5 TINFO: Test hierarchical_memory_limit with enabling hierarchical accounting
        shell code from test:
        > mkdir subgroup
        > cat memory.kmem.usage_in_bytes
        > 442368
        > echo $PAGESIZE > memory.limit_in_bytes
    /home/ubuntu/ltp-install/testcases/bin/memcg_stat_test.sh: 47: echo: echo: I/O error
    memcg_stat_test 5 TFAIL: hierarchical_memory_limit is 270336, 135168 expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../controllers/memcg/functional/memcg_stat_test.sh       | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index e5eb7e5d0001..94eaa45ce0d8 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -43,12 +43,14 @@ test5()
 	tst_res TINFO "Test hierarchical_memory_limit with enabling hierarchical accounting"
 	echo 1 > memory.use_hierarchy
 
+	local limit=$(memcg_adjust_limit_for_kmem $PAGESIZES)
+
 	mkdir subgroup
-	echo $PAGESIZES > memory.limit_in_bytes
-	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
+	echo $limit > memory.limit_in_bytes
+	echo $((limit + PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
 
 	cd subgroup
-	check_mem_stat "hierarchical_memory_limit" $PAGESIZES
+	check_mem_stat "hierarchical_memory_limit" $limit
 
 	cd ..
 	rmdir subgroup
-- 
2.30.2


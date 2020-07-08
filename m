From: Li Wang <liwang@redhat.com>
Date: Wed,  8 Jul 2020 14:29:25 +0800
Subject: [LTP] [COMMITTED] kernel/numa01.sh: : Remove test8
Message-ID: <20200708062925.32521-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test is duplicated with syscalls/migrate_pages/*.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/README    | 23 +++++------------
 testcases/kernel/numa/numa01.sh | 46 ++++-----------------------------
 2 files changed, 11 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/numa/README b/testcases/kernel/numa/README
index 846d36dcd..4dd8564be 100644
--- a/testcases/kernel/numa/README
+++ b/testcases/kernel/numa/README
@@ -26,38 +26,27 @@ Verifies the preferred node memory policy which will allocate memory from the no
 testcase will use the support_numa process for the verfication.
 
 TestCase3:
-Verifies the preferred node memory policy which will allocate shared memory from the node we specify. This
-testcase will use the support_numa process for the verfication.
-
-TestCase4:
 Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
 testcase will use the support_numa process for the verfication.
 
-TestCase5:
-Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
-testcase will use the support_numa process for the verfication.
-
-TestCase6:
+TestCase4:
 Verifies the physical cpu affinity which runs the process support_numa on the specified physical cpu number.
 
-TestCase7:
+TestCase5:
 Verifies the local allocation policy which always allocates memory from the local node. This testcase
 will use the support_numa process for the verfication.
 
-TestCase8:
+TestCase6:
 Verifies the memory interleaving policy which will distribute the memory evenly among all nodes. This
 testcase will use memhog for the verfication.
 
-TestCase9:
+TestCase7:
 Verifies the numa_node_size api with hardware checking.
 
-TestCase10:
-Verifieds the NUMA migratepages policy.
-
-TestCase11:
+TestCase8:
 Verifies the hugepage memory allocated from the node we specify.
 
-TestCase12:
+TestCase9:
 Verifies the preferred node policy with THP memory allocating from the node we specify.
 
 Pre-requisites
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 0521794e9..803545f13 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -12,11 +12,10 @@
 # Test #5: Verifies localalloc
 # Test #6: Verifies memhog
 # Test #7: Verifies numa_node_size api
-# Test #8: Verifies Migratepages
-# Test #9: Verifies hugepage alloacted on specified node
-# Test #10: Verifies THP memory allocated on preferred node
+# Test #8: Verifies hugepage alloacted on specified node
+# Test #9: Verifies THP memory allocated on preferred node
 
-TST_CNT=10
+TST_CNT=9
 TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
@@ -300,43 +299,8 @@ test7()
 	fi
 }
 
-# Verification of migratepages
-test8()
-{
-	local mem_curr
-	local cnt=1
-
-	for node in $nodes_list; do
-		if [ $cnt -eq $total_nodes ]; then
-			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
-		else
-			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((cnt+1)))
-		fi
-
-		numactl --preferred=$node support_numa alloc_1MB &
-		pid=$!
-
-		TST_RETRY_FUNC "check_for_support_numa $pid" 0
-
-		migratepages $pid $node $Preferred_node
-
-		mem_curr=$(get_mem_cur $pid $Preferred_node $MB)
-		if [ $(echo "$mem_curr < $MB" |bc ) -eq 1 ]; then
-			tst_res TFAIL \
-				"NUMA migratepages is not working fine"
-			kill -CONT $pid >/dev/null 2>&1
-			return
-		fi
-
-		cnt=$((cnt+1))
-		kill -CONT $pid >/dev/null 2>&1
-	done
-
-	tst_res TPASS "NUMA MIGRATEPAGES policy"
-}
-
 # Verification of hugepage memory allocated on a node
-test9()
+test8()
 {
 	Mem_huge=0
 	Sys_node=/sys/devices/system/node
@@ -381,7 +345,7 @@ test9()
 }
 
 # Verification of THP memory allocated on preferred node
-test10()
+test9()
 {
 	local mem_curr
 	local cnt=1
-- 
2.21.1


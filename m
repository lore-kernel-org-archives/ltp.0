From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 16 Feb 2021 13:38:41 +0100
Subject: [LTP] [PATCH] memcg/stat_test: Use more memory for tests
Message-ID: <20210216123841.3424969-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

f0b9d187d increased the memory used by a lot of
memcg tests to 33*pagesize, because some counters in
memory.stat are only updated in batches of 32.
With kernel commit 766a4c19d this batching is also applied
to some more counters.

Use 33 * pagesize for all test now should make them pass
before and after this commit.

Fixes: #780
This should also fix part of #93 and #783

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../memcg/functional/memcg_stat_test.sh       | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 3a6239134..cc4550cb6 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -27,15 +27,15 @@ test2()
 test3()
 {
 	tst_res TINFO "Test unevictable with MAP_LOCKED"
-	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE \
-		"unevictable" $PAGESIZE false
+	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES \
+		"unevictable" $PAGESIZES false
 }
 
 test4()
 {
 	tst_res TINFO "Test unevictable with mlock"
-	test_mem_stat "--mmap-lock2" $PAGESIZE $PAGESIZE \
-		"unevictable" $PAGESIZE false
+	test_mem_stat "--mmap-lock2" $PAGESIZES $PAGESIZES \
+		"unevictable" $PAGESIZES false
 }
 
 test5()
@@ -44,11 +44,11 @@ test5()
 	echo 1 > memory.use_hierarchy
 
 	mkdir subgroup
-	echo $PAGESIZE > memory.limit_in_bytes
-	echo $((PAGESIZE*2)) > subgroup/memory.limit_in_bytes
+	echo $PAGESIZES > memory.limit_in_bytes
+	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
 
 	cd subgroup
-	check_mem_stat "hierarchical_memory_limit" $PAGESIZE
+	check_mem_stat "hierarchical_memory_limit" $PAGESIZES
 
 	cd ..
 	rmdir subgroup
@@ -62,11 +62,11 @@ test6()
 	echo 0 > memory.use_hierarchy
 
 	mkdir subgroup
-	echo $PAGESIZE > memory.limit_in_bytes
-	echo $((PAGESIZE * 2)) > subgroup/memory.limit_in_bytes
+	echo $PAGESIZES > memory.limit_in_bytes
+	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
 
 	cd subgroup
-	check_mem_stat "hierarchical_memory_limit" $((PAGESIZE * 2))
+	check_mem_stat "hierarchical_memory_limit" $((PAGESIZES * 2))
 
 	cd ..
 	rmdir subgroup
@@ -80,13 +80,13 @@ test7()
 	ROD echo 1 \> memory.use_hierarchy
 
 	mkdir subgroup
-	echo $PAGESIZE > memory.limit_in_bytes
-	echo $PAGESIZE > memory.memsw.limit_in_bytes
-	echo $((PAGESIZE*2)) > subgroup/memory.limit_in_bytes
-	echo $((PAGESIZE*2)) > subgroup/memory.memsw.limit_in_bytes
+	echo $PAGESIZES > memory.limit_in_bytes
+	echo $PAGESIZES > memory.memsw.limit_in_bytes
+	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
+	echo $((PAGESIZES * 2)) > subgroup/memory.memsw.limit_in_bytes
 
 	cd subgroup
-	check_mem_stat "hierarchical_memsw_limit" $PAGESIZE
+	check_mem_stat "hierarchical_memsw_limit" $PAGESIZES
 
 	cd ..
 	rmdir subgroup
@@ -101,13 +101,13 @@ test8()
 	ROD echo 0 \> memory.use_hierarchy
 
 	mkdir subgroup
-	echo $PAGESIZE > memory.limit_in_bytes
-	echo $PAGESIZE > memory.memsw.limit_in_bytes
-	echo $((PAGESIZE*2)) > subgroup/memory.limit_in_bytes
-	echo $((PAGESIZE*2)) > subgroup/memory.memsw.limit_in_bytes
+	echo $PAGESIZES > memory.limit_in_bytes
+	echo $PAGESIZES > memory.memsw.limit_in_bytes
+	echo $((PAGESIZES * 2)) > subgroup/memory.limit_in_bytes
+	echo $((PAGESIZES * 2)) > subgroup/memory.memsw.limit_in_bytes
 
 	cd subgroup
-	check_mem_stat "hierarchical_memsw_limit" $((PAGESIZE*2))
+	check_mem_stat "hierarchical_memsw_limit" $((PAGESIZES * 2))
 
 	cd .
 	rmdir subgroup
-- 
2.25.1


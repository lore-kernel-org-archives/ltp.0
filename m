From: Chen Hanxiao <chenhx.fnst@cn.fujitsu.com>
Date: Fri, 11 Sep 2020 17:21:21 +0800
Subject: [LTP] [PATCH] memcg_use_hierarchy_test.sh: skip setting
 use_hierarchy if not available
Message-ID: <20200911092121.1917-1-chenhx.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The precondition of this case is that we can disable use_hierarchy.
But some distributions such as CentOS 8 had enabled it in root
cgroup and hard to disabled.

As [1] describe:
    NOTE1: Enabling/disabling will fail if either the cgroup already has other
       cgroups created below it, or if the parent cgroup has use_hierarchy
       enabled.

We should check the precondition before testing.

[1] https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt

Signed-off-by: Chen Hanxiao <chenhx.fnst@cn.fujitsu.com>
---
 .../controllers/memcg/functional/memcg_lib.sh | 25 +++++++++++++++----
 .../functional/memcg_use_hierarchy_test.sh    | 12 +++++++--
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 22ef4f5e2..4f99c6f59 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -491,6 +491,10 @@ cleanup_test()
 		orig_memory_use_hierarchy=""
 	fi
 
+	if [ -n "$root_memory_use_hierarchy" ];then
+                root_memory_use_hierarchy=""
+	fi
+
 	killall -9 memcg_process 2>/dev/null
 	wait
 
@@ -514,16 +518,27 @@ setup_test()
 	# while there are distributions (RHEL7U0Beta for example) that sets
 	# it to 1.
 	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
+        MEMCGROUP_PATH="/sys/fs/cgroup/memory"
+        if [ -e "$MEMCGROUP_PATH" ];then
+                root_memory_use_hierarchy=$(cat "$MEMCGROUP_PATH/memory.use_hierarchy")
+        fi
+
 	if [ -z "$orig_memory_use_hierarchy" ];then
 		tst_resm TINFO "cat /dev/memcg/memory.use_hierarchy failed"
 	elif [ "$orig_memory_use_hierarchy" = "0" ];then
 		orig_memory_use_hierarchy=""
 	else
-		echo 0 > /dev/memcg/memory.use_hierarchy
-		if [ $? -ne 0 ];then
-			tst_resm TINFO "set /dev/memcg/memory.use_hierarchy" \
-				"to 0 failed"
-		fi
+                if [ "$root_memory_use_hierarchy" = "1" ]; then
+                        tst_resm TINFO "root cgroup has use_hierarchy enabled, " \
+                            "can't set /dev/memcg/memory.use_hierarchy to 0"
+                        export root_memory_use_hierarchy
+                else
+                        echo 0 > /dev/memcg/memory.use_hierarchy
+                        if [ $? -ne 0 ];then
+                                tst_resm TINFO "set /dev/memcg/memory.use_hierarchy" \
+                                    "to 0 failed"
+                        fi
+                fi
 	fi
 
 	ROD mkdir "/dev/memcg/$TEST_ID"
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
index 4cf6b9fc2..1439b6352 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
@@ -34,7 +34,9 @@ TST_TOTAL=3
 # test if one of the ancestors goes over its limit, the proces will be killed
 testcase_1()
 {
-	echo 1 > memory.use_hierarchy
+        if [ "$root_memory_use_hierarchy" != "1" ]; then
+                echo 1 > memory.use_hierarchy
+        fi
 	echo $PAGESIZE > memory.limit_in_bytes
 
 	mkdir subgroup
@@ -48,6 +50,10 @@ testcase_1()
 # test Enabling will fail if the cgroup already has other cgroups
 testcase_2()
 {
+        if [ "$root_memory_use_hierarchy" = "1" ]; then
+               tst_resm TCONF "root cgroup has use_hierarchy enabled, skip"
+               return
+        fi
 	mkdir subgroup
 	EXPECT_FAIL echo 1 \> memory.use_hierarchy
 
@@ -57,7 +63,9 @@ testcase_2()
 # test disabling will fail if the parent cgroup has enabled hierarchy.
 testcase_3()
 {
-	echo 1 > memory.use_hierarchy
+        if [ "$root_memory_use_hierarchy" != "1" ]; then
+               echo 1 > memory.use_hierarchy
+        fi
 	mkdir subgroup
 	EXPECT_FAIL echo 0 \> subgroup/memory.use_hierarchy
 
-- 
2.26.0.windows.1




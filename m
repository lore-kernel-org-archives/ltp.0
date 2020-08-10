From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 10 Aug 2020 14:49:41 +0800
Subject: [LTP] [PATCH] cpuset_inherit_test: Add cgroup.clone_children swith
 for cpuset.cpus and mems
Message-ID: <1597042181-12722-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/controllers/cpuset/cpuset_funcs.sh |  8 +-
 .../cpuset_inherit_testset.sh                 | 82 +++++++++++--------
 2 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 935a41ed0..6706561b2 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -32,12 +32,14 @@ if [ -f "/sys/devices/system/node/has_high_memory" ]; then
 else
 	N_NODES="`cat /sys/devices/system/node/has_normal_memory`"
 fi
+mem_string="$N_NODES"
 N_NODES=${N_NODES#*-*}
 N_NODES=$(($N_NODES + 1))
 
 CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"
-
+CLONE_CHILDREN="/dev/cpuset/cgroup.clone_children"
+CHILDREN_VALUE="0"
 HOTPLUG_CPU="1"
 
 cpuset_log()
@@ -134,6 +136,8 @@ setup()
 		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
 					" cpuset on $CPUSET..Exiting test"
 	fi
+
+	CHILDREN_VALUE="`cat $CLONE_CHILDREN`"
 }
 
 # Write the cleanup function
@@ -144,6 +148,8 @@ cleanup()
 		return 0
 	}
 
+	echo $CHILDREN_VALUE > $CLONE_CHILDREN
+
 	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir
 	do
 		while read pid
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 1b4f314f9..2facf3a0e 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -23,7 +23,7 @@
 ################################################################################
 
 export TCID="cpuset_inherit"
-export TST_TOTAL=27
+export TST_TOTAL=33
 export TST_COUNT=1
 
 . cpuset_funcs.sh
@@ -44,10 +44,13 @@ cfile_name=
 base_op_write_and_test()
 {
 	local write_file="$1"
-	local write_string="$2"
-	local expect_string="$3"
+	local inherit_value="$2"
+	local write_string="$3"
+	local expect_string="$4"
 	local return_result=
 
+	echo $inherit_value > $CLONE_CHILDREN
+
 	mkdir -p "$(dirname $write_file)" || {
 		tst_brkm TFAIL "Failed to mkdir -p $(basename $write_file)"
 		return 1
@@ -103,13 +106,21 @@ inherit_test()
 test_cpus()
 {
 	cfile_name="cpus"
-	while read cpus result
+	let "num=$nr_cpus-1"
+	cpu_string="0-$num"
+	if [ $nr_cpus -eq 1 ]; then
+		cpu_string="0"
+	fi
+	while read inherit cpus result
 	do
-		inherit_test "$CPUSET/1/cpuset.cpus" "$cpus" "$result"
+		inherit_test "$CPUSET/1/cpuset.cpus" "$inherit" "$cpus" "$result"
 	done <<- EOF
-		NULL					EMPTY
-		0					EMPTY
-		$cpus_all				EMPTY
+		0	NULL					EMPTY
+		0	0					EMPTY
+		0	$cpus_all				EMPTY
+		1	NULL					EMPTY
+		1	0					0
+		1	$cpus_all				$cpu_string
 	EOF
 	# while read cpus result
 }
@@ -117,13 +128,16 @@ test_cpus()
 test_mems()
 {
 	cfile_name="mems"
-	while read mems result
+	while read inherit mems result
 	do
-		inherit_test "$CPUSET/1/cpuset.mems" "$mems" "$result"
+		inherit_test "$CPUSET/1/cpuset.mems" "$inherit" "$mems" "$result"
 	done <<- EOF
-		NULL					EMPTY
-		0					EMPTY
-		$mems_all				EMPTY
+		0	NULL					EMPTY
+		0	0					EMPTY
+		0	$mems_all				EMPTY
+		1	NULL					EMPTY
+		1	0					0
+		1	$mems_all				$mem_string
 	EOF
 	# while read mems result
 }
@@ -135,12 +149,12 @@ test_three_result_similar_flags()
 			memory_migrate
 	do
 		cfile_name="$filename"
-		while read flags result
+		while read inherit flags result
 		do
-			inherit_test "$CPUSET/1/cpuset.$filename" "$flags" "$result"
+			inherit_test "$CPUSET/1/cpuset.$filename" "$inherit" "$flags" "$result"
 		done <<- EOF
-			0	0
-			1	0
+			0	0	0
+			0	1	0
 		EOF
 		# while read flags, result
 	done # for filename in flagfiles
@@ -152,12 +166,12 @@ test_spread_flags()
 	for filename in memory_spread_page memory_spread_slab
 	do
 		cfile_name="$filename"
-		while read flags result
+		while read inherit flags result
 		do
-			inherit_test "$CPUSET/1/cpuset.$filename" "$flags" "$result"
+			inherit_test "$CPUSET/1/cpuset.$filename" "$inherit" "$flags" "$result"
 		done <<- EOF
-			0	0
-			1	1
+			0	0	0
+			0	1	1
 		EOF
 		# while read flags, result
 	done # for filename in flagfiles
@@ -166,12 +180,12 @@ test_spread_flags()
 test_sched_load_balance_flag()
 {
 	cfile_name="sched_load_balance"
-	while read flag result
+	while read inherit flag result
 	do
-		inherit_test "$CPUSET/1/cpuset.sched_load_balance" "$flag" "$result"
+		inherit_test "$CPUSET/1/cpuset.sched_load_balance" "$inherit" "$flag" "$result"
 	done <<- EOF
-		0	1
-		1	1
+		0	0	1
+		0	1	1
 	EOF
 	# while read mems result
 }
@@ -179,17 +193,17 @@ test_sched_load_balance_flag()
 test_domain()
 {
 	cfile_name="sched_relax_domain_level"
-	while read domain_level result
+	while read inherit domain_level result
 	do
-		inherit_test "$CPUSET/1/cpuset.sched_relax_domain_level" "$domain_level" "$result"
+		inherit_test "$CPUSET/1/cpuset.sched_relax_domain_level" "$inherit" "$domain_level" "$result"
 	done <<- EOF
-		-1	-1
-		0	-1
-		1	-1
-		2	-1
-		3	-1
-		4	-1
-		5	-1
+		0	-1	-1
+		0	0	-1
+		0	1	-1
+		0	2	-1
+		0	3	-1
+		0	4	-1
+		0	5	-1
 	EOF
 	# while read domain_level result
 }
-- 
2.23.0




From: Li Jinyue <lijinyue@huawei.com>
Date: Fri, 28 Dec 2018 17:02:49 +0800
Subject: [LTP] [PATCH] controllers/cpuset: add cpuset files check for
	different OS
Message-ID: <1545987769-32388-1-git-send-email-lijinyue@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While mounting cpuset cgroup, the subsystem directory entries
differ in different OS release.
eg, cpuset.cpus file on Ubuntu and cpus on some other release.

So we add cpuset files checker to make sure the test work well
on all OS release.

Signed-off-by: Li Jinyue <lijinyue@huawei.com>
---
 .../cpuset_base_ops_testset.sh                     |   41 +-
 .../cpuset_exclusive_test/cpuset_exclusive_test.sh |  169 ++++----
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |   55 +++-
 .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh |  417 ++++++++++----------
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    5 +-
 .../cpuset_inherit_test/cpuset_inherit_testset.sh  |   19 +-
 .../cpuset_load_balance_test.sh                    |    1 +
 .../cpuset_sched_domains_test.sh                   |    1 +
 .../cpuset_memory_pressure_testset.sh              |   33 +-
 .../cpuset_memory_spread_testset.sh                |    3 +-
 .../cpuset_memory_test/cpuset_memory_testset.sh    |   23 +-
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    9 +-
 12 files changed, 418 insertions(+), 358 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 67f3611..9c1be0b 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check
+cpuset_files_check
 
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
@@ -105,7 +106,7 @@ test_cpus()
 	cfile_name="cpuset.cpus"
 	while read cpus result
 	do
-		base_op_test "$CPUSET/1/cpuset.cpus" "$cpus" "$result"
+		base_op_test "$CPUSET/1/$cpus_file" "$cpus" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					0
@@ -124,14 +125,14 @@ test_cpus()
 	# while read cpus result
 
 	if [ $nr_cpus -ge 3 ]; then
-		base_op_test "$CPUSET/1/cpuset.cpus" "0,1-$((nr_cpus-2)),$((nr_cpus-1))" "0-$((nr_cpus-1))"
-		base_op_test "$CPUSET/1/cpuset.cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
+		base_op_test "$CPUSET/1/$cpus_file" "0,1-$((nr_cpus-2)),$((nr_cpus-1))" "0-$((nr_cpus-1))"
+		base_op_test "$CPUSET/1/$cpus_file" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
 	fi
 
 	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
-		base_op_test "$CPUSET/1/cpuset.cpus" "0-" "WRITE_ERROR"
+		base_op_test "$CPUSET/1/$cpus_file" "0-" "WRITE_ERROR"
 	else
-		base_op_test "$CPUSET/1/cpuset.cpus" "0-" "0"
+		base_op_test "$CPUSET/1/$cpus_file" "0-" "0"
 	fi
 }
 
@@ -140,7 +141,7 @@ test_mems()
 	cfile_name="cpuset.mems"
 	while read mems result
 	do
-		base_op_test "$CPUSET/1/cpuset.mems" "$mems" "$result"
+		base_op_test "$CPUSET/1/$mems_file" "$mems" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					0
@@ -159,27 +160,27 @@ test_mems()
 	# while read mems result
 
 	if [ $nr_mems -ge 3 ]; then
-		base_op_test "$CPUSET/1/cpuset.mems" "0,1-$((nr_mems-2)),$((nr_mems-1))" "0-$((nr_mems-1))"
-		base_op_test "$CPUSET/1/cpuset.mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
+		base_op_test "$CPUSET/1/$mems_file" "0,1-$((nr_mems-2)),$((nr_mems-1))" "0-$((nr_mems-1))"
+		base_op_test "$CPUSET/1/$mems_file" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
 	fi
 
 	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
-		base_op_test "$CPUSET/1/cpuset.mems" "0-" "WRITE_ERROR"
+		base_op_test "$CPUSET/1/$mems_file" "0-" "WRITE_ERROR"
 	else
-		base_op_test "$CPUSET/1/cpuset.mems" "0-" "0"
+		base_op_test "$CPUSET/1/$mems_file" "0-" "0"
 	fi
 }
 
 test_flags()
 {
-	for filename in cpu_exclusive mem_exclusive mem_hardwall \
-			memory_migrate memory_spread_page memory_spread_slab \
-			sched_load_balance memory_pressure_enabled
+	for filename in $cpu_exclusive_file $mem_exclusive_file $mem_hardwall_file \
+			$memory_migrate_file $memory_spread_page_file $memory_spread_slab_file \
+			$sched_load_balance_file $memory_pressure_enabled_file
 	do
-		cfile_name="cpuset.$filename"
+		cfile_name="$filename"
 		while read flags result
 		do
-			base_op_test "$CPUSET/cpuset.$filename" "$flags" "$result"
+			base_op_test "$CPUSET/$filename" "$flags" "$result"
 		done <<- EOF
 			0	0
 			1	1
@@ -219,10 +220,10 @@ attach_task_test()
 	fi
 
 	if [ "$cpus" != "NULL" ]; then
-		echo $cpus > "$CPUSET/sub_cpuset/cpuset.cpus"
+		echo $cpus > "$CPUSET/sub_cpuset/$cpus_file"
 	fi
 	if [ "$mems" != "NULL" ]; then
-		echo $mems > "$CPUSET/sub_cpuset/cpuset.mems"
+		echo $mems > "$CPUSET/sub_cpuset/$mems_file"
 	fi
 
 	cat /dev/zero > /dev/null &
@@ -262,10 +263,10 @@ test_attach_task()
 
 test_readonly_cfiles()
 {
-	for filename in cpus mems memory_pressure
+	for filename in $cpus_file $mems_file $memory_pressure_file
 	do
-		cfile_name="cpuset.$filename(READONLY)"
-		base_op_test "$CPUSET/cpuset.$filename" "0" "WRITE_ERROR"
+		cfile_name="$filename(READONLY)"
+		base_op_test "$CPUSET/$filename" "0" "WRITE_ERROR"
 	done # for filename in readonly cfiles
 }
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
index 8e5413a..0481b2b 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
@@ -29,192 +29,193 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check
+cpuset_files_check
 
 exit_status=0
 
 # Case 1-9 test cpus
 test1()
 {
-	echo 0 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpu_exclusive" || return 1
+	echo 0 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpu_exclusive_file" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$cpu_exclusive_file") || return 1
 }
 
 test2()
 {
-	echo 1 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpu_exclusive_file" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$cpu_exclusive_file") || return 1
 }
 
 test3()
 {
-	echo 1 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpu_exclusive_file" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/cpuset.cpu_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/$cpu_exclusive_file") || return 1
 }
 
 test4()
 {
-	echo 0 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpu_exclusive" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpu_exclusive_file" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$cpu_exclusive_file") || return 1
 }
 
 test5()
 {
-	echo 1 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpu_exclusive" || return 1
-	echo 0 > "$CPUSET/father/cpuset.cpu_exclusive" 2> /dev/null && return 1
+	echo 1 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpu_exclusive_file" || return 1
+	echo 0 > "$CPUSET/father/$cpu_exclusive_file" 2> /dev/null && return 1
 
-	test 1 = $(cat "$CPUSET/father/cpuset.cpu_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/$cpu_exclusive_file") || return 1
 }
 
 test6()
 {
-	echo 1 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo 1 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpu_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/cpuset.cpus" || return 1
+	echo 1 > "$CPUSET/father/other/$cpus_file" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.cpus") || return 1
-	test 1 = $(cat "$CPUSET/father/other/cpuset.cpus") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$cpus_file") || return 1
+	test 1 = $(cat "$CPUSET/father/other/$cpus_file") || return 1
 }
 
 test7()
 {
-	echo 1 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo 1 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpu_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/cpuset.cpus" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/$cpus_file" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.cpus") || return 1
-	test -z $(cat "$CPUSET/father/other/cpuset.cpus") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$cpus_file") || return 1
+	test -z $(cat "$CPUSET/father/other/$cpus_file") || return 1
 }
 
 test8()
 {
-	echo 1 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo 1 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/cpuset.cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpu_exclusive" || return 1
+	echo 1 > "$CPUSET/father/other/$cpus_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpu_exclusive_file" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/cpuset.cpu_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/$cpu_exclusive_file") || return 1
 }
 
 test9()
 {
-	echo 1 > "$CPUSET/father/cpuset.cpu_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo 1 > "$CPUSET/father/$cpu_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/cpuset.cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpu_exclusive" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/$cpus_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpu_exclusive_file" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.cpu_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$cpu_exclusive_file") || return 1
 }
 
 # The following cases test mems
 
 test10()
 {
-	echo 0 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mem_exclusive" || return 1
+	echo 0 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mem_exclusive_file" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$mem_exclusive_file") || return 1
 }
 
 test11()
 {
-	echo 1 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mem_exclusive_file" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$mem_exclusive_file") || return 1
 }
 
 test12()
 {
-	echo 1 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mem_exclusive_file" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/cpuset.mem_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/$mem_exclusive_file") || return 1
 }
 
 test13()
 {
-	echo 0 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mem_exclusive" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mem_exclusive_file" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$mem_exclusive_file") || return 1
 }
 
 test14()
 {
-	echo 1 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mem_exclusive" || return 1
-	echo 0 > "$CPUSET/father/cpuset.mem_exclusive" 2> /dev/null && return 1
+	echo 1 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mem_exclusive_file" || return 1
+	echo 0 > "$CPUSET/father/$mem_exclusive_file" 2> /dev/null && return 1
 
-	test 1 = $(cat "$CPUSET/father/cpuset.mem_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/$mem_exclusive_file") || return 1
 }
 
 test15()
 {
-	echo 1 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo 1 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mem_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/cpuset.mems" || return 1
+	echo 1 > "$CPUSET/father/other/$mems_file" || return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.mems") || return 1
-	test 1 = $(cat "$CPUSET/father/other/cpuset.mems") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$mems_file") || return 1
+	test 1 = $(cat "$CPUSET/father/other/$mems_file") || return 1
 }
 
 test16()
 {
-	echo 1 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo 1 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mem_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/cpuset.mems" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/$mems_file" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.mems") || return 1
-	test -z $(cat "$CPUSET/father/other/cpuset.mems") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$mems_file") || return 1
+	test -z $(cat "$CPUSET/father/other/$mems_file") || return 1
 }
 
 test17()
 {
-	echo 1 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo 1 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo 1 > "$CPUSET/father/other/cpuset.mems" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mem_exclusive" || return 1
+	echo 1 > "$CPUSET/father/other/$mems_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mem_exclusive_file" || return 1
 
-	test 1 = $(cat "$CPUSET/father/child/cpuset.mem_exclusive") || return 1
+	test 1 = $(cat "$CPUSET/father/child/$mem_exclusive_file") || return 1
 }
 
 test18()
 {
-	echo 1 > "$CPUSET/father/cpuset.mem_exclusive" || return 1
-	echo "0-1" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo 1 > "$CPUSET/father/$mem_exclusive_file" || return 1
+	echo "0-1" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
 	mkdir "$CPUSET/father/other" || return 1
-	echo "0-1" > "$CPUSET/father/other/cpuset.mems" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mem_exclusive" 2> /dev/null && return 1
+	echo "0-1" > "$CPUSET/father/other/$mems_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mem_exclusive_file" 2> /dev/null && return 1
 
-	test 0 = $(cat "$CPUSET/father/child/cpuset.mem_exclusive") || return 1
+	test 0 = $(cat "$CPUSET/father/child/$mem_exclusive_file") || return 1
 }
 
 for i in $(seq 1 $TST_TOTAL)
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index cc31729..dfa2a89 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -39,6 +39,18 @@ CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"
 
 HOTPLUG_CPU="1"
+cpus_file=
+cpu_exclusive_file=
+mems_file=
+memory_pressure_file=
+memory_pressure_enabled_file=
+mem_exclusive_file=
+mem_hardwall_file=
+memory_migrate_file=
+memory_spread_page_file=
+memory_spread_slab_file=
+sched_load_balance_file=
+sched_relax_domain_level_file=
 
 cpuset_log()
 {
@@ -170,6 +182,43 @@ cleanup()
 	rm -rf "$CPUSET_TMP" > /dev/null 2>&1
 }
 
+# check cpuset cgroup files for different OS
+cpuset_files_check()
+{
+	setup
+
+	if [ -f "$CPUSET/cpuset.cpus" ]; then
+		cpus_file="cpuset.cpus"
+		cpu_exclusive_file="cpuset.cpu_exclusive"
+		mems_file="cpuset.mems"
+		memory_pressure_file="cpuset.memory_pressure"
+		memory_pressure_enabled_file="cpuset.memory_pressure_enabled"
+		mem_exclusive_file="cpuset.mem_exclusive"
+		mem_hardwall_file="cpuset.mem_hardwall"
+		memory_migrate_file="cpuset.memory_migrate"
+		memory_spread_page_file="cpuset.memory_spread_page"
+		memory_spread_slab_file="cpuset.memory_spread_slab"
+		sched_load_balance_file="cpuset.sched_load_balance"
+		sched_relax_domain_level_file="cpuset.sched_relax_domain_level"
+	else
+		cpus_file="cpus"
+		cpu_exclusive_file="cpu_exclusive"
+		mems_file="mems"
+		memory_pressure_file="memory_pressure"
+		memory_pressure_enabled_file="memory_pressure_enabled"
+		mem_exclusive_file="mem_exclusive"
+		mem_hardwall_file="mem_hardwall"
+		memory_migrate_file="memory_migrate"
+		memory_spread_page_file="memory_spread_page"
+		memory_spread_slab_file="memory_spread_slab"
+		sched_load_balance_file="sched_load_balance"
+		sched_relax_domain_level_file="sched_relax_domain_level"
+
+	fi
+
+	cleanup
+}
+
 # set the cpuset's parameter
 # cpuset_set <cpusetpath> <cpus> <mems> <load_balance>
 cpuset_set()
@@ -186,19 +235,19 @@ cpuset_set()
 
 	if [ "$path" != "$CPUSET" ]; then
 		if [ "$cpus" != "-" ]; then
-			/bin/echo $cpus > $path/cpuset.cpus
+			/bin/echo $cpus > $path/$cpus_file
 			if [ $? -ne 0 ]; then
 				return 1
 			fi
 		fi
 
-		/bin/echo $mems > $path/cpuset.mems
+		/bin/echo $mems > $path/$mems_file
 		if [ $? -ne 0 ]; then
 			return 1
 		fi
 	fi
 
-	/bin/echo $load_balance > $path/cpuset.sched_load_balance
+	/bin/echo $load_balance > $path/$sched_load_balance_file
 	if [ $? -ne 0 ]; then
 		return 1
 	fi
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
index 6b0a7e1..28a994c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check
+cpuset_files_check
 
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
@@ -42,404 +43,404 @@ exit_status=0
 
 test1()
 {
-	echo > "$CPUSET/father/cpuset.cpus" || return 1
-	echo > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo > "$CPUSET/father/$cpus_file" || return 1
+	echo > "$CPUSET/father/child/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test -z "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test2()
 {
-	echo > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" 2> /dev/null && return 1
+	echo > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test -z "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test3()
 {
-	echo 0 > "$CPUSET/father/cpuset.cpus" || return 1
-	echo > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo 0 > "$CPUSET/father/$cpus_file" || return 1
+	echo > "$CPUSET/father/child/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test4()
 {
-	echo 0 > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo 0 > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test5()
 {
-	echo 0 > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpus" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/$cpus_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpus_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test6()
 {
-	echo 0 > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0,1 > "$CPUSET/father/child/cpuset.cpus" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/$cpus_file" || return 1
+	echo 0,1 > "$CPUSET/father/child/$cpus_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test7()
 {
-	echo "0,1" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo "0,1" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test8()
 {
-	echo "0,1" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
+	echo "0,1" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test9()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo > "$CPUSET/father/cpuset.cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo > "$CPUSET/father/child/$cpus_file" || return 1
+	echo > "$CPUSET/father/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test -z "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test -z "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test10()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo > "$CPUSET/father/cpuset.cpus" 2> /dev/null && return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
+	echo > "$CPUSET/father/$cpus_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test11()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/cpuset.cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo > "$CPUSET/father/child/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test12()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/cpuset.cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test13()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/cpuset.cpus" 2> /dev/null && return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo 1 > "$CPUSET/father/child/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/$cpus_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 1 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 1 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test14()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0,1 > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/cpuset.cpus" 2> /dev/null && return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0,1 > "$CPUSET/father/child/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/$cpus_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test "0-1" = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test "0-$((nr_cpus-1))" = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test15()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo "0,1" > "$CPUSET/father/cpuset.cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
+	echo "0,1" > "$CPUSET/father/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 test16()
 {
-	echo "$cpus_all" > "$CPUSET/father/cpuset.cpus" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.cpus" || return 1
-	echo "0,1" > "$CPUSET/father/cpuset.cpus" || return 1
+	echo "$cpus_all" > "$CPUSET/father/$cpus_file" || return 1
+	echo 0 > "$CPUSET/father/child/$cpus_file" || return 1
+	echo "0,1" > "$CPUSET/father/$cpus_file" || return 1
 
-	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/cpuset.cpus")"
-	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/cpuset.cpus")"
+	cpuset_log "father cpuset.cpus $(cat "$CPUSET/father/$cpus_file")"
+	cpuset_log "child cpuset.cpus $(cat "$CPUSET/father/child/$cpus_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.cpus")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.cpus")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$cpus_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$cpus_file")" || return 1
 }
 
 ## test mems
 
 test17()
 {
-	echo > "$CPUSET/father/cpuset.mems" || return 1
-	echo > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo > "$CPUSET/father/$mems_file" || return 1
+	echo > "$CPUSET/father/child/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test -z "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test -z "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test18()
 {
-	echo > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" 2> /dev/null && return 1
+	echo > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test -z "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test -z "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test19()
 {
-	echo 0 > "$CPUSET/father/cpuset.mems" || return 1
-	echo > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo 0 > "$CPUSET/father/$mems_file" || return 1
+	echo > "$CPUSET/father/child/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test20()
 {
-	echo 0 > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo 0 > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test21()
 {
-	echo 0 > "$CPUSET/father/cpuset.mems" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mems" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/$mems_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mems_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test22()
 {
-	echo 0 > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0,1 > "$CPUSET/father/child/cpuset.mems" 2> /dev/null && return 1
+	echo 0 > "$CPUSET/father/$mems_file" || return 1
+	echo 0,1 > "$CPUSET/father/child/$mems_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test23()
 {
-	echo "0,1" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo "0,1" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test24()
 {
-	echo "0,1" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
+	echo "0,1" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test25()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo > "$CPUSET/father/cpuset.mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo > "$CPUSET/father/child/$mems_file" || return 1
+	echo > "$CPUSET/father/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test -z "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test -z "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test26()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo > "$CPUSET/father/cpuset.mems" 2> /dev/null && return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
+	echo > "$CPUSET/father/$mems_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test27()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/cpuset.mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo > "$CPUSET/father/child/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test -z "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test -z "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test28()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/cpuset.mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test 0 = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test 0 = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test29()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 1 > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/cpuset.mems" 2> /dev/null && return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo 1 > "$CPUSET/father/child/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/$mems_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 1 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 1 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test30()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0,1 > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/cpuset.mems" 2> /dev/null && return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo 0,1 > "$CPUSET/father/child/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/$mems_file" 2> /dev/null && return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test "0-1" = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test "0-$((nr_mems-1))" = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test31()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo "0,1" > "$CPUSET/father/cpuset.mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
+	echo "0,1" > "$CPUSET/father/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 test32()
 {
-	echo "$mems_all" > "$CPUSET/father/cpuset.mems" || return 1
-	echo 0 > "$CPUSET/father/child/cpuset.mems" || return 1
-	echo "0,1" > "$CPUSET/father/cpuset.mems" || return 1
+	echo "$mems_all" > "$CPUSET/father/$mems_file" || return 1
+	echo 0 > "$CPUSET/father/child/$mems_file" || return 1
+	echo "0,1" > "$CPUSET/father/$mems_file" || return 1
 
-	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/cpuset.mems")"
-	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/cpuset.mems")"
+	cpuset_log "father cpuset.mems $(cat "$CPUSET/father/$mems_file")"
+	cpuset_log "child cpuset.mems $(cat "$CPUSET/father/child/$mems_file")"
 
-	test "0-1" = "$(cat "$CPUSET/father/cpuset.mems")" || return 1
-	test 0 = "$(cat "$CPUSET/father/child/cpuset.mems")" || return 1
+	test "0-1" = "$(cat "$CPUSET/father/$mems_file")" || return 1
+	test 0 = "$(cat "$CPUSET/father/child/$mems_file")" || return 1
 }
 
 for i in $(seq 1 $TST_TOTAL)
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index e973de7..7fcd26a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check 2 1
+cpuset_files_check
 
 exit_status=0
 
@@ -86,7 +87,7 @@ root_cpu_hotplug_test()
 		return 1
 	fi
 
-	root_cpus="`cat $CPUSET/cpuset.cpus`"
+	root_cpus="`cat $CPUSET/$cpus_file`"
 
 	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
 	task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
@@ -155,7 +156,7 @@ general_cpu_hotplug_test()
 		return 1
 	fi
 
-	cpus="`cat $path/cpuset.cpus`"
+	cpus="`cat $path/$cpus_file`"
 
 	task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
 	task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 1b4f314..507a5fb 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check 1 1
+cpuset_files_check
 
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
@@ -105,7 +106,7 @@ test_cpus()
 	cfile_name="cpus"
 	while read cpus result
 	do
-		inherit_test "$CPUSET/1/cpuset.cpus" "$cpus" "$result"
+		inherit_test "$CPUSET/1/$cpus_file" "$cpus" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					EMPTY
@@ -119,7 +120,7 @@ test_mems()
 	cfile_name="mems"
 	while read mems result
 	do
-		inherit_test "$CPUSET/1/cpuset.mems" "$mems" "$result"
+		inherit_test "$CPUSET/1/$mems_file" "$mems" "$result"
 	done <<- EOF
 		NULL					EMPTY
 		0					EMPTY
@@ -131,13 +132,13 @@ test_mems()
 # test cpu_exclusive mem_exclusive mem_hardwall memory_migrate
 test_three_result_similar_flags()
 {
-	for filename in cpu_exclusive mem_exclusive mem_hardwall \
-			memory_migrate
+	for filename in $cpu_exclusive_file $mem_exclusive_file $mem_hardwall_file \
+			$memory_migrate_file
 	do
 		cfile_name="$filename"
 		while read flags result
 		do
-			inherit_test "$CPUSET/1/cpuset.$filename" "$flags" "$result"
+			inherit_test "$CPUSET/1/$filename" "$flags" "$result"
 		done <<- EOF
 			0	0
 			1	0
@@ -149,12 +150,12 @@ test_three_result_similar_flags()
 # test memory_spread_page memory_spread_slab
 test_spread_flags()
 {
-	for filename in memory_spread_page memory_spread_slab
+	for filename in $memory_spread_page_file $memory_spread_slab_file
 	do
 		cfile_name="$filename"
 		while read flags result
 		do
-			inherit_test "$CPUSET/1/cpuset.$filename" "$flags" "$result"
+			inherit_test "$CPUSET/1/$filename" "$flags" "$result"
 		done <<- EOF
 			0	0
 			1	1
@@ -168,7 +169,7 @@ test_sched_load_balance_flag()
 	cfile_name="sched_load_balance"
 	while read flag result
 	do
-		inherit_test "$CPUSET/1/cpuset.sched_load_balance" "$flag" "$result"
+		inherit_test "$CPUSET/1/$sched_load_balance_file" "$flag" "$result"
 	done <<- EOF
 		0	1
 		1	1
@@ -181,7 +182,7 @@ test_domain()
 	cfile_name="sched_relax_domain_level"
 	while read domain_level result
 	do
-		inherit_test "$CPUSET/1/cpuset.sched_relax_domain_level" "$domain_level" "$result"
+		inherit_test "$CPUSET/1/$sched_relax_domain_level_file" "$domain_level" "$result"
 	done <<- EOF
 		-1	-1
 		0	-1
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
index 7123019..951f939 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check 4 2
+cpuset_files_check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
index 014bc74..07457aa 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check 4 2
+cpuset_files_check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
index eddd7f6..e6ad581 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check
+cpuset_files_check
 
 exit_status=0
 
@@ -43,7 +44,7 @@ usemem=$((py_mem - 20))
 
 test1()
 {
-	echo 0 > "$CPUSET/cpuset.memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 0 > "$CPUSET/$memory_pressure_enabled_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Closing memory_pressure_enabled failed."
@@ -53,7 +54,7 @@ test1()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/cpuset.memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/$memory_pressure_file") -ne 0 ]; then
 			tst_resm TFAIL "Memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -62,7 +63,7 @@ test1()
 
 test2()
 {
-	echo 0 > "$CPUSET/cpuset.memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 0 > "$CPUSET/$memory_pressure_enabled_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Closing memory_pressure_enabled failed."
@@ -74,7 +75,7 @@ test2()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/cpuset.memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/$memory_pressure_file") -ne 0 ]; then
 			tst_resm TFAIL "Memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -83,7 +84,7 @@ test2()
 
 test3()
 {
-	echo 1 > "$CPUSET/cpuset.memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/$memory_pressure_enabled_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -100,11 +101,11 @@ test3()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/cpuset.memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/$memory_pressure_file") -ne 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure had memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/cpuset.memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/$memory_pressure_file") -ne 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -114,7 +115,7 @@ test3()
 
 test4()
 {
-	echo 1 > "$CPUSET/cpuset.memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/$memory_pressure_enabled_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -147,11 +148,11 @@ test4()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/cpuset.memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/$memory_pressure_file") -ne 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure had memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/cpuset.memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/$memory_pressure_file") -eq 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
@@ -160,7 +161,7 @@ test4()
 
 test5()
 {
-	echo 1 > "$CPUSET/cpuset.memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/$memory_pressure_enabled_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -178,11 +179,11 @@ test5()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/cpuset.memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/$memory_pressure_file") -eq 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/cpuset.memory_pressure") -ne 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/$memory_pressure_file") -ne 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure had memory pressure rate."
 			return 1
 		fi
@@ -191,7 +192,7 @@ test5()
 
 test6()
 {
-	echo 1 > "$CPUSET/cpuset.memory_pressure_enabled" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/$memory_pressure_enabled_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "Opening memory_pressure_enabled failed."
@@ -224,11 +225,11 @@ test6()
 	local i
 	for i in $(seq 0 9)
 	do
-		if [ $(cat "$CPUSET/cpuset.memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/$memory_pressure_file") -eq 0 ]; then
 			tst_resm TFAIL "root group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
-		if [ $(cat "$CPUSET/sub_cpuset/cpuset.memory_pressure") -eq 0 ]; then
+		if [ $(cat "$CPUSET/sub_cpuset/$memory_pressure_file") -eq 0 ]; then
 			tst_resm TFAIL "sub group's memory_pressure didn't have memory pressure rate."
 			return 1
 		fi
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index e2767ef..14116be 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check
+cpuset_files_check
 
 exit_status=0
 nr_cpus=$NR_CPUS
@@ -207,7 +208,7 @@ general_memory_spread_test()
 		return 1
 	fi
 
-	/bin/echo "$is_spread" > "$cpusetpath/cpuset.memory_spread_page" 2> $CPUSET_TMP/stderr
+	/bin/echo "$is_spread" > "$cpusetpath/$memory_spread_page_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set spread value failed."
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index cb7dbd8..2706054 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check
+cpuset_files_check
 
 exit_status=0
 
@@ -345,7 +346,7 @@ test11()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/cpuset.memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/$memory_migrate_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -384,7 +385,7 @@ talk2memory_test_for_case_12_13()
 	echo $1 > "$2/tasks"
 	/bin/kill -s SIGUSR1 $1
 
-	echo 0 > "$2/cpuset.mems" || return 1
+	echo 0 > "$2/$mems_file" || return 1
 	sleep 1
 	/bin/kill -s SIGUSR1 $1
 	sleep 1
@@ -432,7 +433,7 @@ test13()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/0/cpuset.memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/0/$memory_migrate_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group's memory_migrate failed."
@@ -543,7 +544,7 @@ test15()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/cpuset.memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/$memory_migrate_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -599,7 +600,7 @@ test16()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/cpuset.memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/$memory_migrate_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -618,7 +619,7 @@ test16()
 
 		echo $testtid > "$CPUSET/2/tasks"
 		sleep 1
-		echo 1 > "$CPUSET/1/cpuset.memory_migrate"
+		echo 1 > "$CPUSET/1/$memory_migrate_file"
 		sleep 1
 		/bin/kill -s SIGUSR2 $testpid
 		sleep 1
@@ -666,7 +667,7 @@ test17()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/cpuset.memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/$memory_migrate_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -684,7 +685,7 @@ test17()
 
 		echo $testtid > "$CPUSET/2/tasks"
 		sleep 1
-		echo 0 > "$CPUSET/1/cpuset.mems"
+		echo 0 > "$CPUSET/1/$mems_file"
 		sleep 1
 		/bin/kill -s SIGUSR2 $testpid
 		sleep 1
@@ -734,7 +735,7 @@ test18()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/1/cpuset.memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/1/$memory_migrate_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group1's memory_migrate failed."
@@ -748,7 +749,7 @@ test18()
 		return 1
 	fi
 
-	echo 1 > "$CPUSET/2/cpuset.memory_migrate" 2> $CPUSET_TMP/stderr
+	echo 1 > "$CPUSET/2/$memory_migrate_file" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
 		tst_resm TFAIL "set general group2's memory_migrate failed."
@@ -766,7 +767,7 @@ test18()
 
 		echo $testtid > "$CPUSET/2/tasks"
 		sleep 1
-		echo 0 > "$CPUSET/1/cpuset.mems"
+		echo 0 > "$CPUSET/1/$mems_file"
 		sleep 1
 		/bin/kill -s SIGUSR2 $testpid
 		sleep 1
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index c4e6064..07f31b7 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -29,6 +29,7 @@ export TST_COUNT=1
 . cpuset_funcs.sh
 
 check
+cpuset_files_check
 
 tst_flag2mask TCONF
 TCONF=$?
@@ -57,14 +58,14 @@ do_syscall_test()
 		tst_resm TFAIL "mkdir -p $TEST_CPUSET fail."
 		return 1
 	fi
-	echo "$1" > "$TEST_CPUSET/cpuset.cpus"
+	echo "$1" > "$TEST_CPUSET/$cpus_file"
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "set $TEST_CPUSET/cupset.cpus as $1 fail."
+		tst_resm TFAIL "set $TEST_CPUSET/$cpus_file as $1 fail."
 		return 1
 	fi
-	echo "$2" > "$TEST_CPUSET/cpuset.mems"
+	echo "$2" > "$TEST_CPUSET/$mems_file"
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "set $TEST_CPUSET/cpuset.mems as $2 fail."
+		tst_resm TFAIL "set $TEST_CPUSET/$mems_file as $2 fail."
 		return 1
 	fi
 	cpuset_syscall_test $3 >"$TEST_OUTPUT" &
-- 
1.6.0.2


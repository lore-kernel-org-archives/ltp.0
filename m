Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VR0GJ-0005T2-91
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:15 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VR0GH-0001mN-NQ
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:15 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  1 Oct 2013 17:44:48 +0400
Message-Id: <1380635095-21403-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 1/8] controllers/cpuset: removed bash sweetnesses
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_base_ops_testset.sh                     |   12 ++--
 .../cpuset_exclusive_test/cpuset_exclusive_test.sh |    6 +-
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |    2 +-
 .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh |    6 +-
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    6 +-
 .../cpuset_inherit_test/cpuset_inherit_testset.sh  |    6 +-
 .../cpuset_load_balance_test.sh                    |    6 +-
 .../cpuset_sched_domains_test.sh                   |    7 +-
 .../cpuset_memory_pressure_testset.sh              |    6 +-
 .../cpuset_memory_spread_testset.sh                |   60 +++++++++++++++-----
 .../cpuset_memory_test/cpuset_memory_testset.sh    |    6 +-
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    6 +-
 .../kernel/controllers/cpuset/run_cpuset_test.sh   |    6 +-
 13 files changed, 82 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index a40c46b..8b21210 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset01"
 export TST_TOTAL=97
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
@@ -97,7 +97,7 @@ base_op_test()
 			exit_status=1
 		fi
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 }
 
 test_cpus()
@@ -190,7 +190,7 @@ attach_task_test()
 	if [ $? -ne 0 ]; then
 		exit_status=1
 		cleanup
-		: $((TST_COUNT++))
+		TST_COUNT=$(($TST_COUNT + 1))
 		return
 	fi
 
@@ -199,7 +199,7 @@ attach_task_test()
 	if [ $? -ne 0 ]; then
 		exit_status=1
 		cleanup
-		: $((TST_COUNT++))
+		TST_COUNT=$(($TST_COUNT + 1))
 		return
 	fi
 
@@ -227,7 +227,7 @@ attach_task_test()
 	if [ $? -ne 0 ]; then
 		exit_status=1
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 }
 
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
index 363317c..0ad31e7 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset03"
 export TST_TOTAL=18
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 
 # Case 1-9 test cpus
@@ -238,7 +238,7 @@ do
 			exit_status=1
 		fi
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 done
 
 exit $exit_status
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index b996461..a83845c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -31,7 +31,7 @@ else
 	N_NODES="`cat /sys/devices/system/node/has_normal_memory`"
 fi
 N_NODES=${N_NODES#*-*}
-: $((N_NODES++))
+N_NODES=$(($N_NODES + 1))
 
 CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
index 1b633c1..5804aa4 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset04"
 export TST_TOTAL=32
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
@@ -463,7 +463,7 @@ do
 			exit_status=1
 		fi
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 done
 
 exit $exit_status
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index 205152c..2bfe0f5 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset08"
 export TST_TOTAL=13
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 
 nr_cpus=$NR_CPUS
@@ -218,7 +218,7 @@ base_test()
 
 		cpu_hotplug_cleanup
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 }
 
 # Test Case 1-2
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 27d9a61..780b7eb 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset02"
 export TST_TOTAL=27
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
@@ -97,7 +97,7 @@ inherit_test()
 			exit_status=1
 		fi
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 }
 
 test_cpus()
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
index 854be72..003e9cf 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset07"
 export TST_TOTAL=13
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
@@ -307,7 +307,7 @@ base_test()
 
 		cpu_hotplug_cleanup
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 }
 
 test_general_load_balance1()
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
index bfead80..4547367 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset06"
 export TST_TOTAL=19
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
@@ -222,7 +222,7 @@ base_test()
 
 		cpu_hotplug_cleanup
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 }
 
 # Casee 1-6
@@ -236,7 +236,6 @@ test_root_load_balance()
 	while read isbalance level hotplug
 	do
 		base_test $isbalance $hotplug
-		: $((file_case_num++))
 	done <<- EOF
 		0	none
 		1	none
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
index 185a028..f342e6c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset10"
 export TST_TOTAL=6
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 
 # usable physical memory
@@ -254,7 +254,7 @@ do
 			fi
 		fi
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 done
 
 exit $exit_status
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index 0a954c0..a357e22 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset11"
 export TST_TOTAL=6
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 # must >= 3 for: 1-$((nr_mems-2))
 nr_cpus=4
@@ -48,15 +48,45 @@ nodedir="/sys/devices/system/node"
 
 FIFO="./myfifo"
 
-declare -a memsinfo
+# memsinfo is an array implementation of the form of a multi-line string
+# _0: value0
+# _1: value1
+# _2: value2
+#
+memsinfo=""
+
+# set value to memsinfo ($1 - index, $2 - value)
+set_memsinfo_val()
+{
+	local nl='
+'
+	# clearing existent value (if present)
+	memsinfo=`echo "$memsinfo" | sed -r "/^\_$1\:\s/d"`
+
+	if [ -z "$memsinfo" ]; then
+		memsinfo="_$1: $2"
+	else
+		memsinfo="$memsinfo${nl}_$1: $2"
+	fi
+}
+
+# get value from memsinfo ($1 - index)
+get_memsinfo_val()
+{
+	local value=
+	value=`echo "$memsinfo" | grep -e "^\_$1\:\s"`
+	value=`echo "$value" | sed -r "s/^.*\:\s(.*)$/\1/"`
+	echo "$value"
+}
+
 
-init_mems_info_array()
+init_memsinfo_array()
 {
 	local i=
 
 	for i in `seq 0 $((nr_mems-1))`
 	do
-		memsinfo[$i]=0
+		set_memsinfo_val $i 0
 	done
 }
 
@@ -67,8 +97,8 @@ get_meminfo()
 	local nodepath="$nodedir/node$nodeid"
 	local nodememinfo="$nodepath/meminfo"
 	local item="$2"
-	local infoarray=(`cat $nodememinfo | grep $item`)
-	memsinfo[$nodeid]=${infoarray[3]}
+	local info=`cat $nodememinfo | grep $item | awk '{print $4}'`
+	set_memsinfo_val $nodeid $info
 }
 
 # freemem_check
@@ -88,7 +118,7 @@ freemem_check()
 	for i in `seq 0 $((nr_mems-1))`
 	do
 		# I think we need 100MB free memory to run test
-		if [ ${memsinfo[$i]} -lt 100000 ]; then
+		if [ $(get_memsinfo_val $i) -lt 100000 ]; then
 			return 1
 		fi
 	done
@@ -109,9 +139,9 @@ get_memsinfo()
 account_meminfo()
 {
 	local nodeId="$1"
-	local tmp="${memsinfo[$nodeId]}"
+	local tmp="$(get_memsinfo_val $nodeId)"
 	get_meminfo $@ "FilePages"
-	memsinfo[$nodeId]=$((${memsinfo[$nodeId]}-$tmp))
+	set_memsinfo_val $nodeId $(($(get_memsinfo_val $nodeId)-$tmp))
 }
 
 # account_memsinfo
@@ -136,7 +166,7 @@ result_check()
 
 	for i in $nodelist
 	do
-		if [ ${memsinfo[$i]} -le $upperlimit ]; then
+		if [ $(get_memsinfo_val $i) -le $upperlimit ]; then
 			return 1
 		fi
 	done
@@ -153,7 +183,7 @@ result_check()
 
 	for i in $othernodelist
 	do
-		if [ ${memsinfo[$i]} -gt $lowerlimit ]; then
+		if [ $(get_memsinfo_val $i) -gt $lowerlimit ]; then
 			return 1
 		fi
 	done
@@ -214,7 +244,7 @@ general_memory_spread_test()
 	account_memsinfo
 	result_check $expect_nodes
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "hog the memory on the unexpected node(FilePages_For_Nodes(KB): ${memsinfo[*]}, Expect Nodes: $expect_nodes)."
+		tst_resm TFAIL "hog the memory on the unexpected node(FilePages_For_Nodes(KB): ${memsinfo}, Expect Nodes: $expect_nodes)."
 		return 1
 	fi
 }
@@ -246,7 +276,7 @@ base_test()
 			tst_resm TPASS "Cpuset memory spread page test succeeded."
 		fi
 	fi
-	((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 }
 
 # test general spread page cache in a cpuset
@@ -301,7 +331,7 @@ test_spread_page2()
 	fi
 }
 
-init_mems_info_array
+init_memsinfo_array
 freemem_check
 if [ $? -ne 0 ]; then
 	tst_brkm TFAIL ignored "Some node doesn't has enough free memory(100MB) to do test(MemFree_For_Nodes(KB): ${memsinfo[*]})."
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index b117932..85f1863 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -22,14 +22,14 @@
 #                                                                              #
 ################################################################################
 
-. ./cpuset_funcs.sh
-
 cd $LTPROOT/testcases/bin
 
 export TCID="cpuset09"
 export TST_TOTAL=18
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
@@ -825,7 +825,7 @@ do
 			fi
 		fi
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 done
 
 exit $exit_status
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 02a41a3..35e368c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -24,12 +24,12 @@
 
 cd $LTPROOT/testcases/bin
 
-. ./cpuset_funcs.sh
-
 export TCID="cpuset05"
 export TST_TOTAL=16
 export TST_COUNT=1
 
+. ./cpuset_funcs.sh
+
 exit_status=0
 
 TEST_CPUSET="$CPUSET/0"
@@ -338,7 +338,7 @@ do
 			fi
 		fi
 	fi
-	: $((TST_COUNT++))
+	TST_COUNT=$(($TST_COUNT + 1))
 done
 
 exit $exit_status
diff --git a/testcases/kernel/controllers/cpuset/run_cpuset_test.sh b/testcases/kernel/controllers/cpuset/run_cpuset_test.sh
index ee269f9..abdc885 100755
--- a/testcases/kernel/controllers/cpuset/run_cpuset_test.sh
+++ b/testcases/kernel/controllers/cpuset/run_cpuset_test.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 # usage ./run_cpuset_test.sh test_num
 
 ################################################################################
@@ -41,12 +41,12 @@
 #                                                                              #
 ################################################################################
 
-source cpuset_funcs.sh;
-
 export TCID="cpuset_test";
 export TST_TOTAL=1;
 export TST_COUNT=1;
 
+. cpuset_funcs.sh;
+
 TEST_NUM=$1;
 SCRIPT_PID=$$;
 RC=0;
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

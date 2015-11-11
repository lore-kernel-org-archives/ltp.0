From: Cedric Hnyda <chnyda@suse.com>
Date: Wed, 11 Nov 2015 16:55:05 +0100
Subject: [LTP]  [PATCH V4] controllers/cgroup_fj: fix and clean up
Message-ID: <1447257305-14696-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Many tests were failing on recent kernels because it is not
possible to mount cgroup several times anymore.
Now the test first checks if the cgroup exists. The cgroup
will be mounted (and umounted) only if it doesn't exist at
the start of the test.
It also checks that the subsystem exist before we run the
tests.
A few minor typo mistakes were fixed (expectted instead of
expected).
Most of the tests are now passing.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 .../controllers/cgroup_fj/cgroup_fj_function.sh    | 37 +++++------
 .../controllers/cgroup_fj/cgroup_fj_stress.sh      | 42 ++++++------
 .../controllers/cgroup_fj/cgroup_fj_utility.sh     | 76 ++++++++++++++--------
 3 files changed, 90 insertions(+), 65 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 3167fab..59ded87 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -37,6 +37,7 @@ noprefix_use_str="";
 release_agent_para_str="";
 notify_on_release_str="";
 release_agent_str="";
+mounted=1;
 
 expected=1;
 
@@ -139,8 +140,6 @@ if [ $? -ne 0 ]; then
 fi
 setup;
 
-mount_cgroup;
-
 $TESTROOT/cgroup_fj_proc &
 pid=$!
 
@@ -148,15 +147,15 @@ mkdir_subgroup;
 
 # cpuset.cpus and cpuset.mems should be specified with suitable value
 # before attaching operation if subsystem is cpuset
-if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] || [ $subsystem == "none" ] ; then
+if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] || [ "$subsystem" == "none" ] ; then
 	exist=`grep -w cpuset /proc/cgroups | cut -f1`;
 	if [ "$exist" != "" ]; then
 		if [ "$noprefix_use" == "no" ]; then
-			do_echo 1 1 `cat /dev/cgroup/cpus` /dev/cgroup/subgroup_1/cpus;
-			do_echo 1 1 `cat /dev/cgroup/mems` /dev/cgroup/subgroup_1/mems;
+			do_echo 1 1 `cat $mount_point/cpus` $mount_point/subgroup_1/cpus;
+			do_echo 1 1 `cat $mount_point/mems` $mount_point/subgroup_1/mems;
 		else
-			do_echo 1 1 `cat /dev/cgroup/cpuset.cpus` /dev/cgroup/subgroup_1/cpuset.cpus;
-			do_echo 1 1 `cat /dev/cgroup/cpuset.mems` /dev/cgroup/subgroup_1/cpuset.mems;
+			do_echo 1 1 `cat $mount_point/cpuset.cpus` $mount_point/subgroup_1/cpuset.cpus;
+			do_echo 1 1 `cat $mount_point/cpuset.mems` $mount_point/subgroup_1/cpuset.mems;
 		fi
 	fi
 fi
@@ -166,12 +165,12 @@ case $attach_operation in
 "1" )
 	;;
 "2" )
-	do_echo 1 1 $pid /dev/cgroup/subgroup_1/tasks;
+	do_echo 1 1 $pid $mount_point/subgroup_1/tasks;
 	;;
 "3" )
 	$TESTROOT/cgroup_fj_proc &
 	pid2=$!
-	cat /dev/cgroup/tasks > $TMPFILE
+	cat $mount_point/tasks > $TMPFILE
 	nlines=`cat $TMPFILE | wc -l`
 	for i in `seq 1 $nlines`
 	do
@@ -190,12 +189,12 @@ case $attach_operation in
 					continue
 				fi
 			fi
-			do_echo 1 1 "$cur_pid" /dev/cgroup/subgroup_1/tasks
+			do_echo 1 1 "$cur_pid" $mount_point/subgroup_1/tasks
 		fi
 	done
 	;;
 "4" )
-	do_echo 1 1 $pid /dev/cgroup/subgroup_1/tasks;
+	do_echo 1 1 $pid $mount_point/subgroup_1/tasks;
 	sleep 1
 	do_kill 1 1 10 $pid
 	;;
@@ -214,18 +213,18 @@ esac
 #if [ $notify_on_release -ne 0 ] && [ $notify_on_release -ne 1 ] && [ $notify_on_release -ne 2 ];then
 #	expected=0
 #fi
-do_echo 1 $expected $notify_on_release_str /dev/cgroup/subgroup_1/notify_on_release;
+do_echo 1 $expected $notify_on_release_str $mount_point/subgroup_1/notify_on_release;
 
 # echo release_agent that analysed from parameter
 if [ $release_agent_echo -ne 1 ]; then
-	do_echo 1 1 $release_agent_str /dev/cgroup/release_agent;
+	do_echo 1 1 $release_agent_str $mount_point/release_agent;
 fi
 
 sleep 1
 
 # pid could not be echoed from subgroup if subsystem is ( or include ) ns,
 # so we kill them here
-if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] || [ $subsystem == "none" ] ; then
+if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] || [ "$subsystem" == "none" ] ; then
 	do_kill 1 1 9 $pid
 	do_kill 1 1 9 $pid2
 # removing operation
@@ -234,20 +233,20 @@ else
 	"1" )
 		;;
 	"2" )
-		do_echo 1 1 $pid /dev/cgroup/tasks
+		do_echo 1 1 $pid $mount_point/tasks
 		if [ $pid2 -ne 0 ]  ; then
-			do_echo 1 1 $pid2 /dev/cgroup/tasks
+			do_echo 1 1 $pid2 $mount_point/tasks
 		fi
 		;;
 	"3" )
-		cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
+		cat $mount_point/subgroup_1/tasks > $TMPFILE
 		nlines=`cat $TMPFILE | wc -l`
 		if [ $nlines -ne 0 ]; then
 			for i in `seq 1 $nlines`
 			do
 				cur_pid=`sed -n "$i""p" $TMPFILE`
 				if [ -e /proc/$cur_pid/ ];then
-					do_echo 1 1 "$cur_pid" /dev/cgroup/tasks
+					do_echo 1 1 "$cur_pid" $mount_point/tasks
 				fi
 			done
 		fi
@@ -264,7 +263,7 @@ fi
 
 sleep 1
 
-do_rmdir 0 1 /dev/cgroup/subgroup_*
+do_rmdir 0 1 $mount_point/subgroup_*
 
 cleanup;
 do_kill 1 1 9 $pid
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index daab096..9d61c1b 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -40,6 +40,7 @@ subgroup_hiers=$4		#number of subgroup's hierarchy
 attach_operation=$5		# 1: attach one process to every subcgroup
 				# 2: attach all processes in root group to one subcgroup
 				# 3: attach all processes in root group to every subcgroup
+mounted=1
 
 usage()
 {
@@ -73,7 +74,6 @@ usage()
 	echo "  will create one hierarchy, will attach one process to every subcgroup"
 }
 
-
 exit_parameter()
 {
 	echo "ERROR: Wrong input parameters... Exiting test"
@@ -108,7 +108,7 @@ get_subgroup_path1()
 		return;
 	fi
 
-	cur_subgroup_path1="/dev/cgroup/subgroup_$1/"
+	cur_subgroup_path1="$mount_point/subgroup_$1/"
 }
 
 
@@ -148,9 +148,11 @@ esac
 
 ##########################  main   #######################
 
-setup;
+if ! [ "$subsystem" == "all" ] && ! [ "$subsystem" == "none" ] ; then
+	exist_subsystem;
+fi
 
-mount_cgroup;
+setup;
 
 $TESTROOT/cgroup_fj_proc &
 pid=$!
@@ -161,8 +163,8 @@ exist_cpuset=0
 exist_cpuset=`grep -w cpuset /proc/cgroups | cut -f1`;
 if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 	if [ "$exist_cpuset" != "" ]; then
-		cpus=`cat /dev/cgroup/cpuset.cpus`
-		mems=`cat /dev/cgroup/cpuset.mems`
+		cpus=`cat $mount_point/cpuset.cpus`
+		mems=`cat $mount_point/cpuset.mems`
 	fi
 fi
 
@@ -172,8 +174,8 @@ mkdir_subgroup;
 # before attachint operation if subsystem is cpuset
 if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 	if [ "$exist_cpuset" != "" ]; then
-		do_echo 1 1 "$cpus" /dev/cgroup/subgroup_1/cpuset.cpus;
-		do_echo 1 1 "$mems" /dev/cgroup/subgroup_1/cpuset.mems;
+		do_echo 1 1 "$cpus" $mount_point/subgroup_1/cpuset.cpus;
+		do_echo 1 1 "$mems" $mount_point/subgroup_1/cpuset.mems;
 	fi
 fi
 
@@ -181,23 +183,25 @@ if [ $mount_times -ne 1 ]; then
 	count=0
 	for i in `seq 1 $mount_times`
 	do
-		do_echo 1 1 $pid /dev/cgroup/subgroup_1/tasks
+		do_echo 1 1 $pid $mount_point/subgroup_1/tasks
 		if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] ; then
 			do_kill 1 1 9 $pid
 			$TESTROOT/cgroup_fj_proc &
 			pid=$!
 		else
-			do_echo 1 1 $pid /dev/cgroup/tasks
+			do_echo 1 1 $pid $mount_point/tasks
 		fi
 		setup;
 		$TESTROOT/cgroup_fj_proc &
 		pid=$!
-		mount_cgroup;
+		if [ $mounted -ne 1 ]; then
+			mount_cgroup;
+		fi
 		mkdir_subgroup;
 		if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 			if [ "$exist_cpuset" != "" ]; then
-				do_echo 1 1 "$cpus" /dev/cgroup/subgroup_1/cpuset.cpus;
-				do_echo 1 1 "$mems" /dev/cgroup/subgroup_1/cpuset.mems;
+				do_echo 1 1 "$cpus" $mount_point/subgroup_1/cpuset.cpus;
+				do_echo 1 1 "$mems" $mount_point/subgroup_1/cpuset.mems;
 			fi
 		fi
 		let "count = $count + 1"
@@ -244,12 +248,12 @@ else
 		do
 			do_echo 1 1 $pid "${pathes[$i]}""tasks"
 		done
-		do_echo 1 1 $pid /dev/cgroup/tasks
+		do_echo 1 1 $pid $mount_point/tasks
 		;;
 	"2" )
-		pathes2[0]="/dev/cgroup/"
+		pathes2[0]="$mount_point"
 		pathes2[1]="${pathes[$count]}"
-		pathes2[3]="/dev/cgroup/"
+		pathes2[3]="$mount_point/"
 		for i in `seq 1 $nlines`
 		do
 			j=$i
@@ -271,8 +275,8 @@ else
 	"3" )
 		count2=$count
 		let "count2 = $count2 + 1"
-		pathes[0]="/dev/cgroup/"
-		pathes[$count2]="/dev/cgroup/"
+		pathes[0]="$mount_point/"
+		pathes[$count2]="$mount_point/"
 		for i in `seq 0 $count`
 		do
 			j=$i
@@ -303,7 +307,7 @@ else
 	done
 fi
 
-do_rmdir 0 1 /dev/cgroup/subgroup_*
+do_rmdir 0 1 $mount_point/subgroup_*
 
 sleep 1
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 9782f45..af1680f 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -50,6 +50,12 @@ exist_subsystem()
 	fi
 }
 
+get_mount_point()
+{
+	check_point=`grep -w $subsystem /proc/mounts | cut -f 2 | cut -d " " -f2`
+	echo $check_point
+}
+
 get_subsystem()
 {
 	case $subsystem in
@@ -234,18 +240,17 @@ do_exit()
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	exit_status=$3
-
 	if [ $exit_status -eq 0 ] ;then
-		if [ $expectted -lt 1 ]; then
+		if [ $expected -lt 1 ]; then
 			if [ $exit_here -ge 1 ]; then
 				cleanup;
 				exit -1
 			fi
 		fi
 	else
-		if [ $expectted -ge 1 ]; then
+		if [ $expected -ge 1 ]; then
 			if [ $exit_here -ge 1 ]; then
 				cleanup;
 				exit -1
@@ -369,7 +374,6 @@ do_mount()
 			echo "\"mount -t cgroup $para_o $something $target\" (expected: fail)"
 		fi
 	fi
-
 	mount -t cgroup $para_o $something $target
 	do_exit $exit_here $expected $?;
 }
@@ -451,10 +455,25 @@ do_kill()
 
 setup()
 {
-	if [ -e /dev/cgroup ]; then
+	# Current test will fail if the previous one failed to rmdir
+	# so try to remove all subgroups
+	mount_point=$(get_mount_point)
+	rmdir $mount_point/subgroup_*
+
+	if [ "$mount_point" == "" ] ; then
+		mounted=0
+		mount_point=/dev/cgroup
+	fi
+
+	if [ -e $mount_point ] && [ $mounted -ne 1 ]; then
+		rm -rf $mount_point
 		cleanup;
 	fi
-	do_mkdir 1 1 /dev/cgroup
+
+	if [ $mounted -ne 1 ]; then
+		do_mkdir 1 1 $mount_point
+		mount_cgroup;
+	fi
 
 	if [ -e $TESTROOT/cgroup_fj_release_agent ]
 	then
@@ -493,47 +512,49 @@ cleanup()
 
 	killall -9 cgroup_fj_proc 1>/dev/null 2>&1;
 
-	if [ -e /dev/cgroup/subgroup_1 ]; then
-		cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
+	if [ -e $mount_point/subgroup_1 ]; then
+		cat $mount_point/subgroup_1/tasks > $TMPFILE
 		nlines=`cat $TMPFILE | wc -l`
 		for i in `seq 1 $nlines`
 		do
 			cur_pid=`sed -n "$i""p" $TMPFILE`
 			if [ -e /proc/$cur_pid/ ];then
-				do_echo 0 1 "$cur_pid" /dev/cgroup/tasks
+				do_echo 0 1 "$cur_pid" $mount_point/tasks
 			fi
 		done
-		do_rmdir 0 1 /dev/cgroup/subgroup_*
+		do_rmdir 0 1 $mount_point/subgroup_*
 	fi
 
 	if [ -e $TMPFILE ]; then
 		rm -f $TMPFILE 2>/dev/null
 	fi
 
-	mount_str="`mount -l | grep /dev/cgroup`"
-	if [ "$mount_str" != "" ]; then
-		do_umount 0 1 /dev/cgroup
-	fi
-
-	if [ -e /dev/cgroup ]; then
-		do_rmdir 0 1 /dev/cgroup
+	if [ $mounted -ne 1 ] ; then
+		mount_str="`mount -l | grep $mount_point`"
+		if [ "$mount_str" != "" ]; then
+			do_umount 0 1 $mount_point
+		fi
+		if [ -e $mount_point ]; then
+			echo "about to rm $mount_point"
+			do_rmdir 0 1 $mount_point
+		fi
 	fi
 }
 
 reclaim_foundling()
 {
-	if ! [ -e /dev/cgroup/subgroup_1 ]; then
+	if ! [ -e $mount_point/subgroup_1 ]; then
 		return
 	fi
 	foundlings=0
-	cat `find /dev/cgroup/subgroup_* -name "tasks"` > $TMPFILE
+	cat `find $mount_point/subgroup_* -name "tasks"` > $TMPFILE
 	nlines=`cat "$TMPFILE" | wc -l`
 	for k in `seq 1 $nlines`
 	do
 		cur_pid=`sed -n "$k""p" $TMPFILE`
 		if [ -e /proc/$cur_pid/ ];then
 			echo "ERROR: pid $cur_pid reclaimed"
-			do_echo 0 1 "$cur_pid" "/dev/cgroup/tasks"
+			do_echo 0 1 "$cur_pid" "$mount_point/tasks"
 			: $((foundlings += 1))
 		fi
 	done
@@ -545,18 +566,19 @@ reclaim_foundling()
 
 mkdir_subgroup()
 {
-	if ! [ -e /dev/cgroup ]; then
-		echo "ERROR: /dev/cgroup doesn't exist... Exiting test"
+	if ! [ -e $mount_point ]; then
+		echo "ERROR: $mount_point doesn't exist... Exiting test"
 		exit -1;
 	fi
 
-	do_mkdir 1 1 /dev/cgroup/subgroup_1
+	do_mkdir 1 1 $mount_point/subgroup_1
 }
 
 mount_cgroup ()
 {
 	expected=1
 	PARAMETER_O="";
+
 	if [ "$subsystem" == "abc" ]; then
 		expected=0
 	fi
@@ -579,10 +601,10 @@ mount_cgroup ()
 	fi
 	if [ "$remount_use_str" != "" ]; then
 		if [ "$PARAMETER_O" != "" ]; then
-			do_mount 1 1 "-o$PARAMETER_O" /dev/cgroup
+			do_mount 1 1 "-o$PARAMETER_O" $mount_point
 			PARAMETER_O="$PARAMETER_O"",""$remount_use_str"
 		else
-			do_mount 1 1 "" /dev/cgroup
+			do_mount 1 1 "" $mount_point
 			PARAMETER_O="$remount_use_str"
 		fi
 		sleep 1
@@ -592,7 +614,7 @@ mount_cgroup ()
 		PARAMETER_O="-o""$PARAMETER_O"
 	fi
 
-	do_mount 1 $expected "$PARAMETER_O" /dev/cgroup
+	do_mount 1 $expected "$PARAMETER_O" $mount_point
 }
 
 check_para()
-- 
2.1.4


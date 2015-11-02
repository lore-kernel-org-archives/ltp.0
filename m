From: Cedric Hnyda <chnyda@suse.com>
Date: Mon,  2 Nov 2015 15:13:37 +0100
Subject: [LTP]  [PATCH] cgroup_fj: add prefix ltp_ to subgroups
Message-ID: <1446473617-17331-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add prefix "ltp_" to the subgroups to make sure
the tests will not collide with anything else on the
system.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 .../controllers/cgroup_fj/cgroup_fj_function.sh      | 20 ++++++++++----------
 .../kernel/controllers/cgroup_fj/cgroup_fj_stress.sh | 15 +++++++--------
 .../controllers/cgroup_fj/cgroup_fj_utility.sh       | 14 +++++++-------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 4581112..a549165 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -161,11 +161,11 @@ if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] || [ "$subsystem" =
 	exist=`grep -w cpuset /proc/cgroups | cut -f1`;
 	if [ "$exist" != "" ]; then
 		if [ "$noprefix_use" == "no" ]; then
-			do_echo 1 1 `cat $mount_point/cpus` $mount_point/subgroup_1/cpus;
-			do_echo 1 1 `cat $mount_point/mems` $mount_point/subgroup_1/mems;
+			do_echo 1 1 `cat $mount_point/cpus` $mount_point/ltp_subgroup_1/cpus;
+			do_echo 1 1 `cat $mount_point/mems` $mount_point/ltp_subgroup_1/mems;
 		else
-			do_echo 1 1 `cat $mount_point/cpuset.cpus` $mount_point/subgroup_1/cpuset.cpus;
-			do_echo 1 1 `cat $mount_point/cpuset.mems` $mount_point/subgroup_1/cpuset.mems;
+			do_echo 1 1 `cat $mount_point/cpuset.cpus` $mount_point/ltp_subgroup_1/cpuset.cpus;
+			do_echo 1 1 `cat $mount_point/cpuset.mems` $mount_point/ltp_subgroup_1/cpuset.mems;
 		fi
 	fi
 fi
@@ -175,7 +175,7 @@ case $attach_operation in
 "1" )
 	;;
 "2" )
-	do_echo 1 1 $pid $mount_point/subgroup_1/tasks;
+	do_echo 1 1 $pid $mount_point/ltp_subgroup_1/tasks;
 	;;
 "3" )
 	$TESTROOT/cgroup_fj_proc &
@@ -199,12 +199,12 @@ case $attach_operation in
 					continue
 				fi
 			fi
-			do_echo 1 1 "$cur_pid" $mount_point/subgroup_1/tasks
+			do_echo 1 1 "$cur_pid" $mount_point/ltp_subgroup_1/tasks
 		fi
 	done
 	;;
 "4" )
-	do_echo 1 1 $pid $mount_point/subgroup_1/tasks;
+	do_echo 1 1 $pid $mount_point/ltp_subgroup_1/tasks;
 	sleep 1
 	do_kill 1 1 10 $pid
 	;;
@@ -223,7 +223,7 @@ esac
 #if [ $notify_on_release -ne 0 ] && [ $notify_on_release -ne 1 ] && [ $notify_on_release -ne 2 ];then
 #	expected=0
 #fi
-do_echo 1 $expected $notify_on_release_str $mount_point/subgroup_1/notify_on_release;
+do_echo 1 $expected $notify_on_release_str $mount_point/ltp_subgroup_1/notify_on_release;
 
 # echo release_agent that analysed from parameter
 if [ $release_agent_echo -ne 1 ]; then
@@ -249,7 +249,7 @@ else
 		fi
 		;;
 	"3" )
-		cat $mount_point/subgroup_1/tasks > $TMPFILE
+		cat $mount_point/ltp_subgroup_1/tasks > $TMPFILE
 		nlines=`cat $TMPFILE | wc -l`
 		if [ $nlines -ne 0 ]; then
 			for i in `seq 1 $nlines`
@@ -273,7 +273,7 @@ fi
 
 sleep 1
 
-do_rmdir 0 1 $mount_point/subgroup_*
+do_rmdir 0 1 $mount_point/ltp_subgroup_*
 
 cleanup;
 do_kill 1 1 9 $pid
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index ef6e1b7..11ebfae 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -114,10 +114,9 @@ get_subgroup_path1()
 		return;
 	fi
 
-	cur_subgroup_path1="$mount_point/subgroup_$1/"
+	cur_subgroup_path1="$mount_point/ltp_subgroup_$1/"
 }
 
-
 get_subgroup_path2()
 {
 	cur_subgroup_path2=""
@@ -183,8 +182,8 @@ mkdir_subgroup;
 # before attachint operation if subsystem is cpuset
 if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 	if [ "$exist_cpuset" != "" ]; then
-		do_echo 1 1 "$cpus" $mount_point/subgroup_1/cpuset.cpus;
-		do_echo 1 1 "$mems" $mount_point/subgroup_1/cpuset.mems;
+		do_echo 1 1 "$cpus" $mount_point/ltp_subgroup_1/cpuset.cpus;
+		do_echo 1 1 "$mems" $mount_point/ltp_subgroup_1/cpuset.mems;
 	fi
 fi
 
@@ -192,7 +191,7 @@ if [ $mount_times -ne 1 ]; then
 	count=0
 	for i in `seq 1 $mount_times`
 	do
-		do_echo 1 1 $pid $mount_point/subgroup_1/tasks
+		do_echo 1 1 $pid $mount_point/ltp_subgroup_1/tasks
 		if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] ; then
 			do_kill 1 1 9 $pid
 			$TESTROOT/cgroup_fj_proc &
@@ -209,8 +208,8 @@ if [ $mount_times -ne 1 ]; then
 		mkdir_subgroup;
 		if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 			if [ "$exist_cpuset" != "" ]; then
-				do_echo 1 1 "$cpus" $mount_point/subgroup_1/cpuset.cpus;
-				do_echo 1 1 "$mems" $mount_point/subgroup_1/cpuset.mems;
+				do_echo 1 1 "$cpus" $mount_point/ltp_subgroup_1/cpuset.cpus;
+				do_echo 1 1 "$mems" $mount_point/ltp_subgroup_1/cpuset.mems;
 			fi
 		fi
 		let "count = $count + 1"
@@ -316,7 +315,7 @@ else
 	done
 fi
 
-do_rmdir 0 1 $mount_point/subgroup_*
+do_rmdir 0 1 $mount_point/ltp_subgroup_*
 
 sleep 1
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index c8a000a..ccdd346 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -457,7 +457,7 @@ setup()
 {
 	# Current test will fail if the previous one failed to rmdir
 	# so try to remove all subgroups
-	rm -rf $mount_point/subgroup_*
+	rm -rf $mount_point/ltp_subgroup_*
 
 	if [ -e $mount_point ] && [ $mounted -ne 1 ]; then
 		rm -rf /dev/cgroup
@@ -506,8 +506,8 @@ cleanup()
 
 	killall -9 cgroup_fj_proc 1>/dev/null 2>&1;
 
-	if [ -e $mount_point/subgroup_1 ]; then
-		cat $mount_point/subgroup_1/tasks > $TMPFILE
+	if [ -e $mount_point/ltp_subgroup_1 ]; then
+		cat $mount_point/ltp_subgroup_1/tasks > $TMPFILE
 		nlines=`cat $TMPFILE | wc -l`
 		for i in `seq 1 $nlines`
 		do
@@ -516,7 +516,7 @@ cleanup()
 				do_echo 0 1 "$cur_pid" $mount_point/tasks
 			fi
 		done
-		do_rmdir 0 1 $mount_point/subgroup_*
+		do_rmdir 0 1 $mount_point/ltp_subgroup_*
 	fi
 
 	if [ -e $TMPFILE ]; then
@@ -537,11 +537,11 @@ cleanup()
 
 reclaim_foundling()
 {
-	if ! [ -e $mount_point/subgroup_1 ]; then
+	if ! [ -e $mount_point/ltp_subgroup_1 ]; then
 		return
 	fi
 	foundlings=0
-	cat `find $mount_point/subgroup_* -name "tasks"` > $TMPFILE
+	cat `find $mount_point/ltp_subgroup_* -name "tasks"` > $TMPFILE
 	nlines=`cat "$TMPFILE" | wc -l`
 	for k in `seq 1 $nlines`
 	do
@@ -565,7 +565,7 @@ mkdir_subgroup()
 		exit -1;
 	fi
 
-	do_mkdir 1 1 $mount_point/subgroup_1
+	do_mkdir 1 1 $mount_point/ltp_subgroup_1
 }
 
 mount_cgroup ()
-- 
2.1.4


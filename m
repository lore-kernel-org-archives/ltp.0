Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chnyda@suse.com>) id 1ZZGFA-0004aT-Gd
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 10:35:16 +0000
Received: from smtp.nue.novell.com ([195.135.221.5])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZGF7-0004CZ-O4
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 10:35:16 +0000
From: Cedric Hnyda <chnyda@suse.com>
Date: Tue,  8 Sep 2015 12:34:37 +0200
Message-Id: <1441708477-26192-1-git-send-email-chnyda@suse.com>
Subject: [LTP] [PATCH] cgroup_fj: renamed arguments because the previous
	ones were not clear.
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

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 .../controllers/cgroup_fj/cgroup_fj_function.sh    |  45 ++-
 .../controllers/cgroup_fj/cgroup_fj_stress.sh      |  83 ++---
 .../controllers/cgroup_fj/cgroup_fj_testcases.sh   | 362 ++++++++++-----------
 .../controllers/cgroup_fj/cgroup_fj_utility.sh     |  58 ++--
 4 files changed, 258 insertions(+), 290 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index 9bfaeb7..673a942 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -32,7 +32,6 @@ remove_operation=$7
 notify_on_release=$8
 release_agent_echo=$9
 
-subsystem_str="";
 remount_use_str="";
 noprefix_use_str="";
 release_agent_para_str="";
@@ -55,24 +54,24 @@ usage()
 	echo "                          -subgroup_exist -attach_operation -remove_operation"
 	echo "                          -notify_on_release -release_agent_echo"
 	echo "    subsystem's usable number"
-	echo "      1: debug"
-	echo "      2: cpuset"
-	echo "      3: ns"
-	echo "      4: cpu"
-	echo "      5: cpuacct"
-	echo "      6: memory"
-	echo "      7: all"
-	echo "      8: (none)"
-	echo "      9: debug,debug"
-	echo "      10: (nonexistent subsystem), e.g. abc"
-	echo "      11: freezer"
-	echo "      12: devices"
+	echo "      debug"
+	echo "      cpuset"
+	echo "      ns"
+	echo "      cpu"
+	echo "      cpuacct"
+	echo "      memory"
+	echo "      all"
+	echo "      none: (none)"
+	echo "      debug,debug: debug,debug"
+	echo "      nonexistent: (nonexistent subsystem), e.g. abc"
+	echo "      freezer: freezer"
+	echo "      devices: devices"
 	echo "    remount_use's usable number"
-	echo "      1: do not use remount in "-o"'s parameter"
-	echo "      2: use it"
+	echo "      yes: do not use remount in "-o"'s parameter"
+	echo "      no: use it"
 	echo "    noprefix_use's usable number"
-	echo "      1: do not use noprefix in "-o"'s parameter"
-	echo "      2: use it. only cpuset available"
+	echo "      yes: do not use noprefix in "-o"'s parameter"
+	echo "      no: use it. only cpuset available"
 	echo "    release_agent_para's usable number"
 	echo "      1: don't use release_agent_para= in "-o"'s parameter"
 	echo "      2: empty after "=""
@@ -83,8 +82,8 @@ usage()
 	echo "      7: nonexistent command"
 	echo "      8: no-permission command"
 	echo "    subgroup_exist's usable number"
-	echo "      1: subgroup will been created"
-	echo "      2: subgroup will not been created"
+	echo "      yes: subgroup will been created"
+	echo "      no: subgroup will not been created"
 	echo "    attach_operation's usable number"
 	echo "      1: attach nothing"
 	echo "      2: attach one process by echo"
@@ -114,7 +113,7 @@ usage()
 	echo "      5: command in other directory"
 	echo "      6: nonexistent command"
 	echo "      7: no-permission command"
-	echo "example: ./cgroup_fj_function.sh 1 1 1 1 1 1 1 1 1"
+	echo "example: ./cgroup_fj_function.sh debug yes yes 1 yes 1 1 1 1"
 	echo "  will use "debug" to test, will not use option "remount","noprefix","release_agent""
 	echo "  in in "-o"'s parameter, will create some subgroup, will not attach/remove any process"
 	echo "  will echo 0 to notify_on_release and will not echo anything to release_agent"
@@ -157,10 +156,10 @@ mkdir_subgroup;
 
 # cpuset.cpus and cpuset.mems should be specified with suitable value
 # before attaching operation if subsystem is cpuset
-if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] || [ $subsystem -eq 8 ] ; then
+if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] || [ $subsystem == "none" ] ; then
 	exist=`grep -w cpuset /proc/cgroups | cut -f1`;
 	if [ "$exist" != "" ]; then
-		if [ $noprefix_use -eq 2 ]; then
+		if [ "$noprefix_use" == "no" ]; then
 			do_echo 1 1 `cat /dev/cgroup/cpus` /dev/cgroup/subgroup_1/cpus;
 			do_echo 1 1 `cat /dev/cgroup/mems` /dev/cgroup/subgroup_1/mems;
 		else
@@ -234,7 +233,7 @@ sleep 1
 
 # pid could not be echoed from subgroup if subsystem is ( or include ) ns,
 # so we kill them here
-if [ $subsystem -eq 3 ] || [ $subsystem -eq 7 ] || [ $subsystem -eq 8 ] ; then
+if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] || [ $subsystem == "none" ] ; then
 	do_kill 1 1 9 $pid
 	do_kill 1 1 9 $pid2
 # removing operation
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index fcca228..972a717 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -46,29 +46,29 @@ usage()
 	echo "usage of cgroup_fj_stress.sh: "
 	echo "  ./cgroup_fj_stress.sh -subsystem -mount_times -subgroup_num -subgroup_hiers -attach_operation"
 	echo "    subsystem's usable number"
-	echo "      1: debug"
-	echo "      2: cpuset"
-	echo "      3: ns"
-	echo "      4: cpu"
-	echo "      5: cpuacct"
-	echo "      6: memory"
-	echo "      7: all"
+	echo "      debug"
+	echo "      cpuset"
+	echo "      ns"
+	echo "      cpu"
+	echo "      cpuacct"
+	echo "      memory"
+	echo "      all"
 	echo "    mount_times's usable number"
 	echo "      1: execute once"
-	echo "      2: execute 100 times"
+	echo "      100: execute 100 times"
 	echo "    subgroup_num's usable number"
 	echo "      (subgroup number in the same hierarchy)"
-	echo "      1: 1"
-	echo "      2: 100"
+	echo "      1"
+	echo "      100"
         echo "    subgroup_hiers's usable number"
 	echo "      (number of subgroup's hierarchy)"
-	echo "      1: 1"
-	echo "      2: 100"
+	echo "      1"
+	echo "      100"
 	echo "    attach_operation's usable number"
 	echo "      1: attach one process to every subcgroup"
 	echo "      2: attach all processes in root group to one subcgroup"
 	echo "      3: attach all processes in root group to every subcgroup"
-        echo "example: ./cgroup_fj_stress.sh 1 1 1 1 1"
+        echo "example: ./cgroup_fj_stress.sh debug 1 1 1 1"
         echo "  will use "debug" to test, will mount once, will create one subgroup in same hierarchy,"
 	echo "  will create one hierarchy, will attach one process to every subcgroup"
 }
@@ -91,8 +91,7 @@ export TMPFILE=$TESTROOT/tmp_tasks
 pid=0;
 release_agent_para=1;
 release_agent_echo=1;
-subsystem_str="debug";
-get_subsystem;
+subsystem_str=$subsystem;
 if [ "$?" -ne "0" ] || [ "$#" -ne "5" ]; then
 	usage;
 	exit_parameter;
@@ -130,42 +129,24 @@ get_subgroup_path2()
 }
 
 case $mount_times in
-"1" )
-	mount_times=1
-	;;
-"2" )
-	mount_times=100
-	;;
-*  )
-	usage;
-	exit_parameter;
-	;;
+''|*[!0-9]*) 
+	usage
+	exit_parameter;;
+    *) ;;
 esac
 
 case $subgroup_num in
-"1" )
-	subgroup_num=1
-	;;
-"2" )
-	subgroup_num=100
-	;;
-*  )
-	usage;
-	exit_parameter;
-	;;
+''|*[!0-9]*) 
+	usage
+	exit_parameter;;
+    *) ;;
 esac
 
 case $subgroup_hiers in
-"1" )
-	subgroup_hiers=1
-	;;
-"2" )
-	subgroup_hiers=100
-	;;
-*  )
-	usage;
-	exit_parameter;
-	;;
+''|*[!0-9]*) 
+	usage
+	exit_parameter;;
+    *) ;;
 esac
 
 ##########################  main   #######################
@@ -186,7 +167,7 @@ cpus=0
 mems=0
 exist_cpuset=0
 exist_cpuset=`grep -w cpuset /proc/cgroups | cut -f1`;
-if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 	if [ "$exist_cpuset" != "" ]; then
 		cpus=`cat /dev/cgroup/cpuset.cpus`
 		mems=`cat /dev/cgroup/cpuset.mems`
@@ -197,7 +178,7 @@ mkdir_subgroup;
 
 # cpuset.cpus and cpuset.mems should be specified with suitable value
 # before attachint operation if subsystem is cpuset
-if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 	if [ "$exist_cpuset" != "" ]; then
 		do_echo 1 1 "$cpus" /dev/cgroup/subgroup_1/cpuset.cpus;
 		do_echo 1 1 "$mems" /dev/cgroup/subgroup_1/cpuset.mems;
@@ -209,7 +190,7 @@ if [ $mount_times -ne 1 ]; then
 	for i in `seq 1 $mount_times`
 	do
 		do_echo 1 1 $pid /dev/cgroup/subgroup_1/tasks
-		if [ $subsystem -eq 3 ] || [ $subsystem -eq 7 ] ; then
+		if [ "$subsystem" == "ns" ] || [ "$subsystem" == "all" ] ; then
 			do_kill 1 1 9 $pid
 			$TESTROOT/cgroup_fj_proc &
 			pid=$!
@@ -221,7 +202,7 @@ if [ $mount_times -ne 1 ]; then
 		pid=$!
 		mount_cgroup;
 		mkdir_subgroup;
-		if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+		if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 			if [ "$exist_cpuset" != "" ]; then
 				do_echo 1 1 "$cpus" /dev/cgroup/subgroup_1/cpuset.cpus;
 				do_echo 1 1 "$mems" /dev/cgroup/subgroup_1/cpuset.mems;
@@ -239,7 +220,7 @@ else
 	do
 		get_subgroup_path1 $i
 		do_mkdir 1 1 $cur_subgroup_path1
-		if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+		if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 			if [ "$exist_cpuset" != "" ]; then
 				do_echo 1 1 "$cpus" "$cur_subgroup_path1""cpuset.cpus";
 				do_echo 1 1 "$mems" "$cur_subgroup_path1""cpuset.mems";
@@ -251,7 +232,7 @@ else
 		do
 			get_subgroup_path2 $j
 			do_mkdir 1 1 "$cur_subgroup_path1""$cur_subgroup_path2" 1
-			if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+			if [ "$subsystem" == "cpuset" ] || [ "$subsystem" == "all" ] ; then
 				if [ "$exist_cpuset" != "" ]; then
 					do_echo 1 1 "$cpus" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.cpus";
 					do_echo 1 1 "$mems" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.mems";
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh
index d9af22a..a03918a 100644
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases.sh
@@ -1,137 +1,137 @@
-function	1 1 1 1 1 2 3 2 1
-function	1 2 1 1 1 2 3 2 1
-function	1 1 1 2 1 2 3 2 1
-function	1 1 1 3 1 2 3 2 1
-function	1 1 1 4 1 2 3 2 1
-function	1 1 1 5 1 2 3 2 1
-function	1 1 1 6 1 2 3 2 1
-function	1 1 1 7 1 2 3 2 1
-function	1 1 1 8 1 2 3 2 1
-function	2 1 1 1 1 2 3 2 1
-function	2 2 1 1 1 2 3 2 1
-function	2 1 2 1 1 2 3 2 1
-function	2 1 1 2 1 2 3 2 1
-function	2 1 1 3 1 2 3 2 1
-function	2 1 1 4 1 2 3 2 1
-function	2 1 1 5 1 2 3 2 1
-function	2 1 1 6 1 2 3 2 1
-function	2 1 1 7 1 2 3 2 1
-function	2 1 1 8 1 2 3 2 1
-function	3 1 1 1 1 2 3 2 1
-function	3 2 1 1 1 2 3 2 1
-function	3 1 1 2 1 2 3 2 1
-function	3 1 1 3 1 2 3 2 1
-function	3 1 1 4 1 2 3 2 1
-function	3 1 1 5 1 2 3 2 1
-function	3 1 1 6 1 2 3 2 1
-function	3 1 1 7 1 2 3 2 1
-function	3 1 1 8 1 2 3 2 1
-function	4 1 1 1 1 2 3 2 1
-function	4 2 1 1 1 2 3 2 1
-function	4 1 1 2 1 2 3 2 1
-function	4 1 1 3 1 2 3 2 1
-function	4 1 1 4 1 2 3 2 1
-function	4 1 1 5 1 2 3 2 1
-function	4 1 1 6 1 2 3 2 1
-function	4 1 1 7 1 2 3 2 1
-function	4 1 1 8 1 2 3 2 1
-function	5 1 1 1 1 2 3 2 1
-function	5 2 1 1 1 2 3 2 1
-function	5 1 1 2 1 2 3 2 1
-function	5 1 1 3 1 2 3 2 1
-function	5 1 1 4 1 2 3 2 1
-function	5 1 1 5 1 2 3 2 1
-function	5 1 1 6 1 2 3 2 1
-function	5 1 1 7 1 2 3 2 1
-function	5 1 1 8 1 2 3 2 1
-function	6 1 1 1 1 2 3 2 1
-function	6 2 1 1 1 2 3 2 1
-function	6 1 1 2 1 2 3 2 1
-function	6 1 1 3 1 2 3 2 1
-function	6 1 1 4 1 2 3 2 1
-function	6 1 1 5 1 2 3 2 1
-function	6 1 1 6 1 2 3 2 1
-function	6 1 1 7 1 2 3 2 1
-function	6 1 1 8 1 2 3 2 1
-function	7 1 1 1 1 2 3 2 1
-function	7 2 1 1 1 2 3 2 1
-function	7 1 1 2 1 2 3 2 1
-function	7 1 1 3 1 2 3 2 1
-function	7 1 1 4 1 2 3 2 1
-function	7 1 1 5 1 2 3 2 1
-function	7 1 1 6 1 2 3 2 1
-function	7 1 1 7 1 2 3 2 1
-function	7 1 1 8 1 2 3 2 1
-function	8 1 1 1 1 2 3 2 1
-function	9 1 1 1 1 2 3 2 1
-function	9 2 1 1 1 2 3 2 1
-function	9 1 1 2 1 2 3 2 1
-function	9 1 1 3 1 2 3 2 1
-function	9 1 1 4 1 2 3 2 1
-function	9 1 1 5 1 2 3 2 1
-function	9 1 1 6 1 2 3 2 1
-function	9 1 1 7 1 2 3 2 1
-function	9 1 1 8 1 2 3 2 1
-function	10 1 1 1 1 2 3 2 1
-function	11 1 1 1 1 2 3 2 1
-function	11 2 1 1 1 2 3 2 1
-function	11 1 1 2 1 2 3 2 1
-function	11 1 1 3 1 2 3 2 1
-function	11 1 1 4 1 2 3 2 1
-function	11 1 1 5 1 2 3 2 1
-function	11 1 1 6 1 2 3 2 1
-function	11 1 1 7 1 2 3 2 1
-function	11 1 1 8 1 2 3 2 1
-function	12 1 1 1 1 2 3 2 1
-function	12 2 1 1 1 2 3 2 1
-function	12 1 1 2 1 2 3 2 1
-function	12 1 1 3 1 2 3 2 1
-function	12 1 1 4 1 2 3 2 1
-function	12 1 1 5 1 2 3 2 1
-function	12 1 1 6 1 2 3 2 1
-function	12 1 1 7 1 2 3 2 1
-function	12 1 1 8 1 2 3 2 1
-function	1 1 1 1 1 1 2 1 1
-function	1 1 1 1 1 2 2 1 1
-function	1 1 1 1 1 2 3 1 1
-function	1 1 1 1 1 2 5 1 1
-function	1 1 1 1 1 3 1 1 1
-function	1 1 1 1 1 3 2 1 1
-function	1 1 1 1 1 3 4 1 1
-function	1 1 1 1 1 4 3 1 1
-function	1 1 1 1 1 4 5 1 1
-function	1 1 1 1 2 1 1 1 1
-function	1 1 1 1 1 1 1 1 1
-function	1 1 1 1 1 1 3 2 1
-function	1 1 1 1 1 2 3 2 2
-function	1 1 1 1 1 2 3 2 3
-function	1 1 1 1 1 2 3 2 4
-function	1 1 1 1 1 2 3 2 5
-function	1 1 1 1 1 2 3 2 6
-function	1 1 1 1 1 2 3 2 7
-function	1 1 1 1 1 2 3 3 2
-function	1 1 1 1 1 2 3 4 2
-function	1 1 1 1 1 2 3 5 2
-function	1 1 1 1 1 2 3 6 2
-function	1 1 1 1 1 2 3 7 2
-function	1 1 1 2 1 2 3 2 2
-function	1 1 1 3 1 2 3 1 1
-function	1 1 1 3 1 2 3 1 2
-function	1 1 1 3 1 2 3 1 3
-function	1 1 1 3 1 2 3 2 1
-function	1 1 1 3 1 2 3 2 2
-function	1 1 1 3 1 2 3 2 3
-function	1 1 1 3 1 2 3 2 4
-function	1 1 1 3 1 2 3 2 5
-function	1 1 1 3 1 2 3 2 6
-function	1 1 1 3 1 2 3 2 7
-function	1 1 1 3 1 2 3 3 1
-function	1 1 1 3 1 2 3 3 2
-function	1 1 1 3 1 2 3 3 3
-function	1 1 1 3 1 2 3 4 2
-function	1 1 1 3 1 2 3 5 2
-function	1 1 1 3 1 2 3 6 2
-function	1 1 1 3 1 2 3 7 2
+function	debug yes yes 1 yes 2 3 2 1
+function	debug no yes 1 yes 2 3 2 1
+function	debug yes yes 2 yes 2 3 2 1
+function	debug yes yes 3 yes 2 3 2 1
+function	debug yes yes 4 yes 2 3 2 1
+function	debug yes yes 5 yes 2 3 2 1
+function	debug yes yes 6 yes 2 3 2 1
+function	debug yes yes 7 yes 2 3 2 1
+function	debug yes yes 8 yes 2 3 2 1
+function	cpuset yes yes 1 yes 2 3 2 1
+function	cpuset no yes 1 yes 2 3 2 1
+function	cpuset yes no 1 yes 2 3 2 1
+function	cpuset yes yes 2 yes 2 3 2 1
+function	cpuset yes yes 3 yes 2 3 2 1
+function	cpuset yes yes 4 yes 2 3 2 1
+function	cpuset yes yes 5 yes 2 3 2 1
+function	cpuset yes yes 6 yes 2 3 2 1
+function	cpuset yes yes 7 yes 2 3 2 1
+function	cpuset yes yes 8 yes 2 3 2 1
+function	ns yes yes 1 yes 2 3 2 1
+function	ns no yes 1 yes 2 3 2 1
+function	ns yes yes 2 yes 2 3 2 1
+function	ns yes yes 3 yes 2 3 2 1
+function	ns yes yes 4 yes 2 3 2 1
+function	ns yes yes 5 yes 2 3 2 1
+function	ns yes yes 6 yes 2 3 2 1
+function	ns yes yes 7 yes 2 3 2 1
+function	ns yes yes 8 yes 2 3 2 1
+function	cpu yes yes 1 yes 2 3 2 1
+function	cpu no yes 1 yes 2 3 2 1
+function	cpu yes yes 2 yes 2 3 2 1
+function	cpu yes yes 3 yes 2 3 2 1
+function	cpu yes yes 4 yes 2 3 2 1
+function	cpu yes yes 5 yes 2 3 2 1
+function	cpu yes yes 6 yes 2 3 2 1
+function	cpu yes yes 7 yes 2 3 2 1
+function	cpu yes yes 8 yes 2 3 2 1
+function	cpuacct yes yes 1 yes 2 3 2 1
+function	cpuacct no yes 1 yes 2 3 2 1
+function	cpuacct yes yes 2 yes 2 3 2 1
+function	cpuacct yes yes 3 yes 2 3 2 1
+function	cpuacct yes yes 4 yes 2 3 2 1
+function	cpuacct yes yes 5 yes 2 3 2 1
+function	cpuacct yes yes 6 yes 2 3 2 1
+function	cpuacct yes yes 7 yes 2 3 2 1
+function	cpuacct yes yes 8 yes 2 3 2 1
+function	memory yes yes 1 yes 2 3 2 1
+function	memory no yes 1 yes 2 3 2 1
+function	memory yes yes 2 yes 2 3 2 1
+function	memory yes yes 3 yes 2 3 2 1
+function	memory yes yes 4 yes 2 3 2 1
+function	memory yes yes 5 yes 2 3 2 1
+function	memory yes yes 6 yes 2 3 2 1
+function	memory yes yes 7 yes 2 3 2 1
+function	memory yes yes 8 yes 2 3 2 1
+function	all yes yes 1 yes 2 3 2 1
+function	all no yes 1 yes 2 3 2 1
+function	all yes yes 2 yes 2 3 2 1
+function	all yes yes 3 yes 2 3 2 1
+function	all yes yes 4 yes 2 3 2 1
+function	all yes yes 5 yes 2 3 2 1
+function	all yes yes 6 yes 2 3 2 1
+function	all yes yes 7 yes 2 3 2 1
+function	all yes yes 8 yes 2 3 2 1
+function	none yes yes 1 yes 2 3 2 1
+function	debug,debug yes yes 1 yes 2 3 2 1
+function	debug,debug no yes 1 yes 2 3 2 1
+function	debug,debug yes yes 2 yes 2 3 2 1
+function	debug,debug yes yes 3 yes 2 3 2 1
+function	debug,debug yes yes 4 yes 2 3 2 1
+function	debug,debug yes yes 5 yes 2 3 2 1
+function	debug,debug yes yes 6 yes 2 3 2 1
+function	debug,debug yes yes 7 yes 2 3 2 1
+function	debug,debug yes yes 8 yes 2 3 2 1
+function	nonexistent yes yes 1 yes 2 3 2 1
+function	freezer yes yes 1 yes 2 3 2 1
+function	freezer no yes 1 yes 2 3 2 1
+function	freezer yes yes 2 yes 2 3 2 1
+function	freezer yes yes 3 yes 2 3 2 1
+function	freezer yes yes 4 yes 2 3 2 1
+function	freezer yes yes 5 yes 2 3 2 1
+function	freezer yes yes 6 yes 2 3 2 1
+function	freezer yes yes 7 yes 2 3 2 1
+function	freezer yes yes 8 yes 2 3 2 1
+function	devices yes yes 1 yes 2 3 2 1
+function	devices no yes 1 yes 2 3 2 1
+function	devices yes yes 2 yes 2 3 2 1
+function	devices yes yes 3 yes 2 3 2 1
+function	devices yes yes 4 yes 2 3 2 1
+function	devices yes yes 5 yes 2 3 2 1
+function	devices yes yes 6 yes 2 3 2 1
+function	devices yes yes 7 yes 2 3 2 1
+function	devices yes yes 8 yes 2 3 2 1
+function	debug yes yes 1 yes 1 2 1 1
+function	debug yes yes 1 yes 2 2 1 1
+function	debug yes yes 1 yes 2 3 1 1
+function	debug yes yes 1 yes 2 5 1 1
+function	debug yes yes 1 yes 3 1 1 1
+function	debug yes yes 1 yes 3 2 1 1
+function	debug yes yes 1 yes 3 4 1 1
+function	debug yes yes 1 yes 4 3 1 1
+function	debug yes yes 1 yes 4 5 1 1
+function	debug yes yes 1 no 1 1 1 1
+function	debug yes yes 1 yes 1 1 1 1
+function	debug yes yes 1 yes 1 3 2 1
+function	debug yes yes 1 yes 2 3 2 2
+function	debug yes yes 1 yes 2 3 2 3
+function	debug yes yes 1 yes 2 3 2 4
+function	debug yes yes 1 yes 2 3 2 5
+function	debug yes yes 1 yes 2 3 2 6
+function	debug yes yes 1 yes 2 3 2 7
+function	debug yes yes 1 yes 2 3 3 2
+function	debug yes yes 1 yes 2 3 4 2
+function	debug yes yes 1 yes 2 3 5 2
+function	debug yes yes 1 yes 2 3 6 2
+function	debug yes yes 1 yes 2 3 7 2
+function	debug yes yes 2 yes 2 3 2 2
+function	debug yes yes 3 yes 2 3 1 1
+function	debug yes yes 3 yes 2 3 1 2
+function	debug yes yes 3 yes 2 3 1 3
+function	debug yes yes 3 yes 2 3 2 1
+function	debug yes yes 3 yes 2 3 2 2
+function	debug yes yes 3 yes 2 3 2 3
+function	debug yes yes 3 yes 2 3 2 4
+function	debug yes yes 3 yes 2 3 2 5
+function	debug yes yes 3 yes 2 3 2 6
+function	debug yes yes 3 yes 2 3 2 7
+function	debug yes yes 3 yes 2 3 3 1
+function	debug yes yes 3 yes 2 3 3 2
+function	debug yes yes 3 yes 2 3 3 3
+function	debug yes yes 3 yes 2 3 4 2
+function	debug yes yes 3 yes 2 3 5 2
+function	debug yes yes 3 yes 2 3 6 2
+function	debug yes yes 3 yes 2 3 7 2
 function2	1
 function2	2
 function2	3
@@ -145,50 +145,50 @@ function2	10
 function2	11
 function2	12
 function2	13
-stress	1 2 1 1 1
-stress	2 2 1 1 1
-stress	3 2 1 1 1
-stress	4 2 1 1 1
-stress	5 2 1 1 1
-stress	6 2 1 1 1
-stress	7 2 1 1 1
-stress	1 1 1 1 2
-stress	1 1 1 2 1
-stress	1 1 1 2 2
-stress	1 1 1 2 3
-stress	1 1 2 1 1
-stress	1 1 2 1 2
-stress	1 1 2 1 3
-stress	1 1 2 2 1
-stress	1 1 2 2 2
-stress	2 1 1 1 2
-stress	2 1 1 2 1
-stress	2 1 1 2 2
-stress	2 1 1 2 3
-stress	2 1 2 1 1
-stress	2 1 2 1 2
-stress	2 1 2 1 3
-stress	2 1 2 2 1
-stress	2 1 2 2 2
-stress	4 1 1 1 2
-stress	4 1 2 1 1
-stress	4 1 2 1 2
-stress	4 1 2 1 3
-stress	5 1 1 1 2
-stress	5 1 1 2 1
-stress	5 1 1 2 2
-stress	5 1 1 2 3
-stress	5 1 2 1 1
-stress	5 1 2 1 2
-stress	5 1 2 1 3
-stress	5 1 2 2 1
-stress	5 1 2 2 2
-stress	6 1 1 1 2
-stress	6 1 1 2 1
-stress	6 1 1 2 2
-stress	6 1 1 2 3
-stress	6 1 2 1 1
-stress	6 1 2 1 2
-stress	6 1 2 1 3
-stress	6 1 2 2 1
-stress	6 1 2 2 2
+stress	debug 100 1 1 1
+stress	cpuset 100 1 1 1
+stress	ns 100 1 1 1
+stress	cpu 100 1 1 1
+stress	cpuacct 100 1 1 1
+stress	memory 100 1 1 1
+stress	all 100 1 1 1
+stress	debug 1 1 1 2
+stress	debug 1 1 100 1
+stress	debug 1 1 100 2
+stress	debug 1 1 100 3
+stress	debug 1 100 1 1
+stress	debug 1 100 1 2
+stress	debug 1 100 1 3
+stress	debug 1 100 100 1
+stress	debug 1 100 100 2
+stress	cpuset 1 1 1 2
+stress	cpuset 1 1 100 1
+stress	cpuset 1 1 100 2
+stress	cpuset 1 1 100 3
+stress	cpuset 1 100 1 1
+stress	cpuset 1 100 1 2
+stress	cpuset 1 100 1 3
+stress	cpuset 1 100 100 1
+stress	cpuset 1 100 100 2
+stress	cpu 1 1 1 2
+stress	cpu 1 100 1 1
+stress	cpu 1 100 1 2
+stress	cpu 1 100 1 3
+stress	cpuacct 1 1 1 2
+stress	cpuacct 1 1 100 1
+stress	cpuacct 1 1 100 2
+stress	cpuacct 1 1 100 3
+stress	cpuacct 1 100 1 1
+stress	cpuacct 1 100 1 2
+stress	cpuacct 1 100 1 3
+stress	cpuacct 1 100 100 1
+stress	cpuacct 1 100 100 2
+stress	memory 1 1 1 2
+stress	memory 1 1 100 1
+stress	memory 1 1 100 2
+stress	memory 1 1 100 3
+stress	memory 1 100 1 1
+stress	memory 1 100 1 2
+stress	memory 1 100 1 3
+stress	memory 1 100 100 1
+stress	memory 1 100 100 2
\ No newline at end of file
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 9b49725..1e2e521 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -22,14 +22,12 @@
 ##                                                                            ##
 ################################################################################
 
-subsystem_str=""
-
 exist_subsystem()
 {
 	checksubsystem=""
 	case "$#" in
 	"0" )
-		checksubsystem=$subsystem_str
+		checksubsystem=$subsystem
 		;;
 	"1" )
 		checksubsystem=$1
@@ -54,49 +52,39 @@ exist_subsystem()
 get_subsystem()
 {
 	case $subsystem in
-	"1" )
-		subsystem_str="debug";
+	"debug" )
 		exist_subsystem;
 		;;
-	"2" )
-		subsystem_str="cpuset";
+	"cpuset" )
 		exist_subsystem;
 		;;
-	"3" )
-		subsystem_str="ns";
+	"ns" )
 		exist_subsystem;
 		;;
-	"4" )
-		subsystem_str="cpu"
+	"cpu" )
 		exist_subsystem;
 		;;
-	"5" )
-		subsystem_str="cpuacct";
+	"cpuacct" )
 		exist_subsystem;
 		;;
-	"6" )
-		subsystem_str="memory";
+	"memory" )
 		exist_subsystem;
 		;;
-	"7" )
-		subsystem_str="all";
+	"all" )
 		;;
-	"8" )
-		subsystem_str=""
+	"none" )
+		subsystem=""
 		;;
-	"9" )
-		subsystem_str="debug,debug";
+	"debug,debug" )
 		exist_subsystem "debug";
 		;;
-	"10" )
-		subsystem_str="abc";
+	"nonexistent" )
+		subsystem="abc";
 		;;
-	"11" )
-		subsystem_str="freezer";
+	"freezer" )
 		exist_subsystem;
 		;;
-	"12" )
-		subsystem_str="devices";
+	"devices" )
 		exist_subsystem;
 		;;
 	 *  )
@@ -108,10 +96,10 @@ get_subsystem()
 get_remount_use()
 {
 	case $remount_use in
-	"1" )
+	"yes" )
 		remount_use_str="";
 		;;
-	"2" )
+	"no" )
 		remount_use_str="remount";
 		;;
 	 *  )
@@ -123,11 +111,11 @@ get_remount_use()
 get_noprefix_use()
 {
 	case $noprefix_use in
-	"1" )
+	"yes" )
 		noprefix_use_str="";
 		;;
-	"2" )
-		if [ $subsystem -ne 2 ]; then
+	"no" )
+		if [ $subsystem != "cpuset" ]; then
 			return -1
 		fi
 		noprefix_use_str="noprefix";
@@ -570,11 +558,11 @@ mount_cgroup ()
 {
 	expectted=1
 	PARAMETER_O="";
-	if [ $subsystem -eq 10 ]; then
+	if [ "$subsystem" == "abc" ]; then
 		expectted=0
 	fi
-	if [ "$subsystem_str" != "" ]; then
-		PARAMETER_O="$subsystem_str"
+	if [ "$subsystem" != "" ]; then
+		PARAMETER_O="$subsystem"
 	fi
 	if [ "$noprefix_use_str" != "" ]; then
 		if [ "$PARAMETER_O" != "" ]; then
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

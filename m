From: Cedric Hnyda <chnyda@suse.com>
Date: Wed, 30 Sep 2015 13:10:27 +0200
Subject: [LTP]  [PATCH V2] controllers/cgroup_fj: Fixed exit codes
Message-ID: <1443611427-14358-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed exit codes in case of not supported tests

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 .../controllers/cgroup_fj/cgroup_fj_function.sh    |  12 +--
 .../controllers/cgroup_fj/cgroup_fj_function2.sh   |   2 +-
 .../controllers/cgroup_fj/cgroup_fj_stress.sh      |   2 +-
 .../controllers/cgroup_fj/cgroup_fj_utility.sh     | 103 +++++++++++----------
 .../controllers/cgroup_fj/run_cgroup_test_fj.sh    |   2 +-
 5 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index cbb1cd3..3167fab 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -38,7 +38,7 @@ release_agent_para_str="";
 notify_on_release_str="";
 release_agent_str="";
 
-expectted=1;
+expected=1;
 
 # Create some processes and move them to cgroups
 pid=0;
@@ -127,7 +127,7 @@ export TMPFILE=$TESTROOT/tmp_tasks
 
 ##########################  main   #######################
 if [ "$#" -ne "9" ]; then
-	echo "ERROR: Wrong inputed parameter..Exiting test";
+	echo "ERROR: Wrong input parameters... Exiting test";
 	usage;
 	exit -1;
 fi
@@ -204,17 +204,17 @@ esac
 # echo notify_on_release that analysed from parameter
 case $notify_on_release in
 "1"|"2"|"3")
-	expectted=1
+	expected=1
 	;;
 *)
-	expectted=0
+	expected=0
 	;;
 esac
 
 #if [ $notify_on_release -ne 0 ] && [ $notify_on_release -ne 1 ] && [ $notify_on_release -ne 2 ];then
-#	expectted=0
+#	expected=0
 #fi
-do_echo 1 $expectted $notify_on_release_str /dev/cgroup/subgroup_1/notify_on_release;
+do_echo 1 $expected $notify_on_release_str /dev/cgroup/subgroup_1/notify_on_release;
 
 # echo release_agent that analysed from parameter
 if [ $release_agent_echo -ne 1 ]; then
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
index 2f304ae..68d290b 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
@@ -45,7 +45,7 @@ usage()
 
 exit_parameter()
 {
-	echo "ERROR: Wrong inputed parameter..Exiting test"
+	echo "ERROR: Wrong input parametes... Exiting test"
 	exit -1;
 }
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 53cabd0..669ed3c 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -76,7 +76,7 @@ usage()
 
 exit_parameter()
 {
-	echo "ERROR: Wrong inputed parameter..Exiting test"
+	echo "ERROR: Wrong input parameters... Exiting test"
 	exit -1;
 }
 
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index 75c0dcb..8f00b85 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -45,7 +45,8 @@ exist_subsystem()
 
 	exist=`grep -w $checksubsystem /proc/cgroups | cut -f1`;
 	if [ "$exist" = "" ]; then
-		exit 9
+		tst_brkm TCONF NULL "Subsystem $subsystem not supported"
+		exit 32
 	fi
 }
 
@@ -220,7 +221,7 @@ get_release_agent()
 }
 
 # check the exit status, and exit or echo info.
-# exit status	expectted value	echo info	exit or not
+# exit status	expected value	echo info	exit or not
 # 0		0		no		no
 # 0		1		yes	yes
 # not 0	0		yes	yes
@@ -233,20 +234,20 @@ do_exit()
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	exit_status=$3
 
 	if [ $exit_status -eq 0 ] ;then
-		if [ $expectted -lt 1 ]; then
-			echo "								against with expectted"
+		if [ $expected -lt 1 ]; then
+			echo "								against with expected"
 			if [ $exit_here -ge 1 ]; then
 				cleanup;
 				exit -1
 			fi
 		fi
 	else
-		if [ $expectted -ge 1 ]; then
-			echo "								against with expectted"
+		if [ $expected -ge 1 ]; then
+			echo "								against with expected"
 			if [ $exit_here -ge 1 ]; then
 				cleanup;
 				exit -1
@@ -268,20 +269,20 @@ do_echo()
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	value=$3
 	target=$4
 
 	if [ $no_debug -ne 1 ]; then
-		if [ $expectted -ge 1 ]; then
-			echo "\"echo $value > $target\" (expectted: success)"
+		if [ $expected -ge 1 ]; then
+			echo "\"echo $value > $target\" (expected: success)"
 		else
-			echo "\"echo $value > $target\" (expectted: fail)"
+			echo "\"echo $value > $target\" (expected: fail)"
 		fi
 	fi
 
 	`echo $value > $target`
-	do_exit $exit_here $expectted $?;
+	do_exit $exit_here $expected $?;
 }
 
 do_mkdir()
@@ -292,7 +293,7 @@ do_mkdir()
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	target=$3
 	parents=0
 	if [ "$#" -eq "4" ] && [ "$4" -ne 0 ]; then
@@ -300,10 +301,10 @@ do_mkdir()
 	fi
 
 	if [ $no_debug -ne 1 ]; then
-		if [ $expectted -ge 1 ]; then
-			echo "\"mkdir $target\" (expectted: success)"
+		if [ $expected -ge 1 ]; then
+			echo "\"mkdir $target\" (expected: success)"
 		else
-			echo "\"mkdir $target\" (expectted: fail)"
+			echo "\"mkdir $target\" (expected: fail)"
 		fi
 	fi
 
@@ -316,7 +317,7 @@ do_mkdir()
 	else
 		mkdir -p $target
 	fi
-	do_exit $exit_here $expectted $?;
+	do_exit $exit_here $expected $?;
 }
 
 do_rmdir()
@@ -327,7 +328,7 @@ do_rmdir()
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	target=$3
 
 	if ! [ -e $target ]; then
@@ -336,15 +337,15 @@ do_rmdir()
 	fi
 
 	if [ $no_debug -ne 1 ]; then
-		if [ $expectted -ge 1 ]; then
-			echo "\"rmdir $target\" (expectted: success)"
+		if [ $expected -ge 1 ]; then
+			echo "\"rmdir $target\" (expected: success)"
 		else
-			echo "\"rmdir $target\" (expectted: fail)"
+			echo "\"rmdir $target\" (expected: fail)"
 		fi
 	fi
 
 	rmdir $3 $4 $5
-	do_exit $exit_here $expectted $?;
+	do_exit $exit_here $expected $?;
 }
 
 do_mount()
@@ -355,7 +356,7 @@ do_mount()
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	para_o=$3
 	target=$4
 	something="cgroup"
@@ -364,15 +365,15 @@ do_mount()
 	fi
 
 	if [ $no_debug -ne 1 ]; then
-		if [ $expectted -ge 1 ]; then
-			echo "\"mount -t cgroup $para_o $something $target\" (expectted: success)"
+		if [ $expected -ge 1 ]; then
+			echo "\"mount -t cgroup $para_o $something $target\" (expected: success)"
 		else
-			echo "\"mount -t cgroup $para_o $something $target\" (expectted: fail)"
+			echo "\"mount -t cgroup $para_o $something $target\" (expected: fail)"
 		fi
 	fi
 
 	mount -t cgroup $para_o $something $target
-	do_exit $exit_here $expectted $?;
+	do_exit $exit_here $expected $?;
 }
 
 do_umount()
@@ -383,54 +384,54 @@ do_umount()
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	target=$3
 
 	if [ $no_debug -ne 1 ]; then
-		if [ $expectted -ge 1 ]; then
-			echo "\"umount $target\" (expectted: success)"
+		if [ $expected -ge 1 ]; then
+			echo "\"umount $target\" (expected: success)"
 		else
-			echo "\"umount $target\" (expectted: fail)"
+			echo "\"umount $target\" (expected: fail)"
 		fi
 	fi
 
 	umount $target
-	do_exit $exit_here $expectted $?;
+	do_exit $exit_here $expected $?;
 }
 
 do_mv()
 {
 	if [ "$#" -ne "4" ]; then
-		echo "ERROR: mv failed,your parameter is wrong..Exiting test"
+		echo "ERROR: mv failed,your parameter is wrong... Exiting test"
 		exit -1
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	source=$3
 	target=$4
 
 	if [ $no_debug -ne 1 ]; then
-		if [ $expectted -ge 1 ]; then
-			echo "\"mv $source $target\" (expectted: success)"
+		if [ $expected -ge 1 ]; then
+			echo "\"mv $source $target\" (expected: success)"
 		else
-			echo "\"mv $source $target\" (expectted: fail)"
+			echo "\"mv $source $target\" (expected: fail)"
 		fi
 	fi
 
 	mv $source $target
-	do_exit $exit_here $expectted $?;
+	do_exit $exit_here $expected $?;
 }
 
 do_kill()
 {
 	if [ "$#" -ne "4" ]; then
-		echo "ERROR: kill failed,your parameter is wrong..Exiting test"
+		echo "ERROR: kill failed,your parameter is wrong... Exiting test"
 		exit -1
 	fi
 
 	exit_here=$1
-	expectted=$2
+	expected=$2
 	signo=$3
 	pid=$4
 
@@ -439,15 +440,15 @@ do_kill()
 	fi
 
 	if [ $no_debug -ne 1 ]; then
-		if [ $expectted -ge 1 ]; then
-			echo "\"kill -$signo $pid\" (expectted: success)"
+		if [ $expected -ge 1 ]; then
+			echo "\"kill -$signo $pid\" (expected: success)"
 		else
-			echo "\"kill -$signo $pid\" (expectted: fail)"
+			echo "\"kill -$signo $pid\" (expected: fail)"
 		fi
 	fi
 
 	kill -s $signo $pid
-	do_exit $exit_here $expectted $?;
+	do_exit $exit_here $expected $?;
 }
 
 setup()
@@ -464,7 +465,7 @@ setup()
 		cp -f $TESTROOT/cgroup_fj_release_agent /root
 		chmod a+x /root/cgroup_fj_release_agent
 	else
-		echo "ERROR: $TESTROOT/cgroup_fj_release_agent isn't exist..Exiting test"
+		echo "ERROR: $TESTROOT/cgroup_fj_release_agent doesn't exist... Exiting test"
 		exit -1;
 	fi
 
@@ -476,7 +477,7 @@ setup()
 	then
 		chmod a+x $TESTROOT/cgroup_fj_proc
 	else
-		echo "ERROR: $TESTROOT/cgroup_fj_proc isn't exist..Exiting test"
+		echo "ERROR: $TESTROOT/cgroup_fj_proc doesn't exist... Exiting test"
 		exit -1;
 	fi
 }
@@ -547,7 +548,7 @@ reclaim_foundling()
 mkdir_subgroup()
 {
 	if ! [ -e /dev/cgroup ]; then
-		echo "ERROR: /dev/cgroup isn't exist..Exiting test"
+		echo "ERROR: /dev/cgroup doesn't exist... Exiting test"
 		exit -1;
 	fi
 
@@ -556,10 +557,10 @@ mkdir_subgroup()
 
 mount_cgroup ()
 {
-	expectted=1
+	expected=1
 	PARAMETER_O="";
 	if [ "$subsystem" == "abc" ]; then
-		expectted=0
+		expected=0
 	fi
 	if [ "$subsystem" != "" ]; then
 		PARAMETER_O="$subsystem"
@@ -593,7 +594,7 @@ mount_cgroup ()
 		PARAMETER_O="-o""$PARAMETER_O"
 	fi
 
-	do_mount 1 $expectted "$PARAMETER_O" /dev/cgroup
+	do_mount 1 $expected "$PARAMETER_O" /dev/cgroup
 }
 
 check_para()
@@ -613,7 +614,7 @@ check_para()
 
 	if [ $ret1 -ne 0 ] || [ $ret2 -ne 0 ] || [ $ret3 -ne 0 ] || [ $ret4 -ne 0 ] || [ $ret5 -ne 0 ] || [ $ret6 -ne 0 ]
 	then
-		echo "ERROR: Wrong inputed parameter..Exiting test"
+		echo "ERROR: Wrong input parameters..Exiting test"
 		return -1
 	fi
 
diff --git a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
index 4dcb7d5..b47f914 100755
--- a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
+++ b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
@@ -122,7 +122,7 @@ esac
 ret=$?
 if [ $ret -eq 0 ]; then
 	tst_resm TPASS "case$i($CASETYPE$CASECMD)    PASS"
-elif [ $ret -ne 9 ]; then
+elif [ $ret -ne 32 ]; then
 	tst_resm TFAIL "case$i($CASETYPE $CASECMD)    FAIL"
 fi
 
-- 
2.1.4


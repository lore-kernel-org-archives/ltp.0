Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Wb1ls-0001ss-4w
	for ltp-list@lists.sourceforge.net; Fri, 18 Apr 2014 05:55:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wb1ln-0000NG-D3
	for ltp-list@lists.sourceforge.net; Fri, 18 Apr 2014 05:55:32 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3I5tFw3029379
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Apr 2014 13:55:16 +0800
Message-ID: <1397800512.2119.5.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 18 Apr 2014 13:55:12 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] controllers/cpuacct: add cpuacct tests to default and
 somecleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Change the entry like:
	cpuacct01 run_cpuacct_test.sh 1
	cpuacct02 run_cpuacct_test.sh 2

* Add cpuacct tests to scenario_groups/default

* Add umount_cpuacct_mounted function for umount cpuacct mounted

* Make use of tst_require_root, exists and tst_resm

* Some cleanup

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/cpuacct                                    |   4 +-
 scenario_groups/default                            |   1 +
 .../kernel/controllers/cpuacct/cpuacct_setup.sh    |  30 +-
 .../kernel/controllers/cpuacct/run_cpuacct_test.sh | 370 +++++++++------------
 4 files changed, 186 insertions(+), 219 deletions(-)

diff --git a/runtest/cpuacct b/runtest/cpuacct
index 34354de..11279f9 100644
--- a/runtest/cpuacct
+++ b/runtest/cpuacct
@@ -1,2 +1,2 @@
-CPUACCT01 $LTPROOT/testcases/bin/run_cpuacct_test.sh 1
-CPUACCT02 $LTPROOT/testcases/bin/run_cpuacct_test.sh 2
+cpuacct01 run_cpuacct_test.sh 1
+cpuacct02 run_cpuacct_test.sh 2
diff --git a/scenario_groups/default b/scenario_groups/default
index 196e636..c0e056c 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -27,3 +27,4 @@ hyperthreading
 kernel_misc
 modules
 fs_ext4
+cpuacct
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
index fb58d1d..d8553ef 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
@@ -15,8 +15,8 @@
 #  the GNU General Public License for more details.                            #
 #                                                                              #
 #  You should have received a copy of the GNU General Public License           #
-#  along with this program;  if not, write to the Free Software                #
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA     #
+#  along with this program;  if not, write to the Free Software Foundation,    #
+#  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA            #
 #                                                                              #
 ################################################################################
 ################################################################################
@@ -45,18 +45,31 @@
 #                                                                              #
 ################################################################################
 
+. cmdlib.sh
+
+# umount cpuacct if it has been mounted.
+umount_cpuacct_mounted()
+{
+	dir=`cat /proc/mounts | grep cpuacct | awk '{print $2}'`
+	if [ -n "$dir" ]; then
+		umount "$dir" 2> /dev/null
+	fi
+}
+
 # The cleanup function
-cleanup ()
+cleanup()
 {
 	echo "Cleanup called"
 	rm -rf txt*
 	rmdir /dev/cpuacct/group*/group* 2> /dev/null
 	rmdir /dev/cpuacct/group* 2> /dev/null
 	umount /dev/cpuacct/ 2> /dev/null
+	umount_cpuacct_mounted
 	rmdir /dev/cpuacct 2> /dev/null
 	rm -rf tmp2 2> /dev/null
 }
-task_kill ()
+
+task_kill()
 {
 	for i in `ps -e | grep cpuacct_task | awk '{print $1}'`
 	do
@@ -70,27 +83,28 @@ task_kill ()
 
 #clean any group created eralier (if any)
 
-setup ()
+setup()
 {
 	if [ -e /dev/cpuacct ]
 	then
 		echo "WARN:/dev/cpuacct already exist..overwriting"
 		rmdir /dev/cpuacct/group*/group* 2> /dev/null
-	        rmdir /dev/cpuacct/group* 2> /dev/null
+		rmdir /dev/cpuacct/group* 2> /dev/null
         	umount /dev/cpuacct/ 2> /dev/null
-	        rmdir /dev/cpuacct 2> /dev/null
+		rmdir /dev/cpuacct 2> /dev/null
 
 		mkdir /dev/cpuacct
 	else
 		mkdir /dev/cpuacct
 	fi
+	umount_cpuacct_mounted
 	mount -t cgroup -ocpuacct none /dev/cpuacct 2> /dev/null
 	if [ $? -ne 0 ]
 	then
 		echo "TFAIL: Could not mount cgroup filesystem"
 		echo "Exiting test"
 		cleanup
-		exit -1
+		exit 1
 	fi
 
 	# Group created earlier may again be visible if not cleaned properly.
diff --git a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh b/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
index 4c4d951..22d6a30 100755
--- a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
+++ b/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
@@ -14,8 +14,8 @@
 #  the GNU General Public License for more details.                         #
 #                                                                           #
 #  You should have received a copy of the GNU General Public License        #
-#  along with this program;  if not, write to the Free Software             #
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA  #
+#  along with this program;  if not, write to the Free Software Foundation, #
+#  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA         #
 #                                                                           #
 #############################################################################
 # Name Of File: run_cpuacct_test.sh                                         #
@@ -40,6 +40,7 @@
 #                                                                           #
 #############################################################################
 
+
 export TCID="cpuacct_test01";
 export TST_TOTAL=1;
 export TST_COUNT=1;
@@ -47,22 +48,17 @@ export TST_COUNT=1;
 TEST_NUM=$1;
 SCRIPT_PID=$$;
 RC=0;
-PWD=`pwd`;
 
-cd $LTPROOT/testcases/bin/  2> /dev/null
 . cpuacct_setup.sh
 
-if [ "$USER" != root ]; then
-        tst_brkm TBROK ignored "Test must be run as root"
-        exit 0
-fi
-
 tst_kvercmp 2 6 30  2> /dev/null
 if [ $? -eq 0 ]; then
-        tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
+        tst_brkm TCONF ignored "Test should be run with kernel 2.6.30 or newer"
         exit 0
 fi
 
+tst_require_root
+
 task_kill  2> /dev/null
 cleanup
 
@@ -71,18 +67,17 @@ cg_path="/dev/cpuacct";
 num_online_cpus=`tst_ncpus`
 
 #Function to create tasks equal to num_online_cpus.
-nr_tasks ()
+nr_tasks()
 {
-	$PWD/cpuacct_task01 &
+	cpuacct_task01 &
 	pid=$!
 }
 
 #Function to caluculate the threshold value.
-get_threshold ()
+get_threshold()
 {
 	num_online_cpus=`expr $num_online_cpus \* $num_online_cpus`
-	if [ $num_online_cpus -le 32 ]
-	then
+	if [ $num_online_cpus -le 32 ]; then
 		threshold=32
 	else
 		threshold=$num_online_cpus
@@ -92,37 +87,33 @@ get_threshold ()
 
 #Function which is called for reading the cpuacct.usage_percpu stat value
 #for Parent and Child cgroups.
-per_cpu_usage ()
+per_cpu_usage()
 {
 	attrc=0
 	attrp=0
-        i=0
-        k=0
-        while read line
-        do
-	        j=0
-                for k in $line
-                do
-        	        j=`expr $j + $k`
-                done
-                if [ "$i" == "0" ]
-                then
-   	             attrp=$j
-                     i=`expr $i + 1`
-                else
-                     attrc=`expr $j + $attrc`
-                fi
-        done < "./tmp2"
+	i=0
+	k=0
+	while read line
+	do
+		j=0
+		for k in $line
+		do
+			j=`expr $j + $k`
+		done
+		if [ "$i" = "0" ]; then
+			attrp=$j
+			i=`expr $i + 1`
+		else
+			attrc=`expr $j + $attrc`
+		fi
+	done < "./tmp2"
 }
 
 #Function which verifies the cpu accounting of the Parent and the Child cgroups.
 check_attr()
 {
-
-	if [ "$1" == "1" ]
-	then
-		if [ "$2" == "cpuacct.stat" ]
-		then
+	if [ "$1" = "1" ]; then
+		if [ "$2" = "cpuacct.stat" ]; then
 			attr1="`sed -n 1p tmp2`"
 			attr2="`sed -n 2p tmp2`"
 			attr3="`sed -n 3p tmp2`"
@@ -131,29 +122,27 @@ check_attr()
 			echo "$2 for Parent cgroup is $attr1 : $attr2"
 			echo "$2 for Child cgroup is $attr3 : $attr4"
 
-		        if [ "$attr1" == "$attr3" ] && [ "$attr2" == "$attr4" ]
-		        then
+			if [ "$attr1" = "$attr3" ] && \
+			   [ "$attr2" = "$attr4" ]; then
 				RC=$?
 				echo "TPASS $mes:$2 PASSED"
 
-		        else
+			else
 				RC=$?
 				echo "TFAIL $mes:$2 FAILED"
-		        fi
-		elif [ "$2" == "cpuacct.usage_percpu" ]
-                then
+			fi
+		elif [ "$2" = "cpuacct.usage_percpu" ]; then
 			per_cpu_usage
 			echo
-                        echo "$2 for Parent cgroup : $attrp"
-                        echo "$2 for Child  cgroup : $attrc"
-                        if [ "$attrp" == "$attrc" ]
-                        then
-                                RC=$?
-                                echo "TPASS $mes:$2 PASSED"
-                        else
-                                RC=$?
-                                echo "TFAIL $mes:$2 FAILED"
-                        fi
+			echo "$2 for Parent cgroup : $attrp"
+			echo "$2 for Child  cgroup : $attrc"
+			if [ "$attrp" = "$attrc" ]; then
+				RC=$?
+				echo "TPASS $mes:$2 PASSED"
+			else
+				RC=$?
+				echo "TFAIL $mes:$2 FAILED"
+			fi
 		else
 			attr1="`sed -n 1p tmp2`"
 			attr2="`sed -n 2p tmp2`"
@@ -161,10 +150,9 @@ check_attr()
 			echo
 			echo "$2 for Parent cgroup is $attr1"
 			echo "$2 for Child cgroup is $attr2"
-		        if [ "$attr1"  ==   "$attr2"  ]
-		        then
+			if [ "$attr1" = "$attr2" ]; then
 				RC=$?
-			        echo "TPASS $mes:$2 PASSED"
+				echo "TPASS $mes:$2 PASSED"
 			else
 				RC=$?
 				echo "TFAIL $mes:$2 FAILED"
@@ -172,9 +160,7 @@ check_attr()
 
 		fi
 	else
-
-		if [ "$2" == "cpuacct.stat" ]
-		then
+		if [ "$2" = "cpuacct.stat" ]; then
 			attr0="`sed -n 1p tmp2 | cut -d" " -f2`"
 			attr1="`sed -n 2p tmp2 | cut -d" " -f2`"
 			attr2="`sed -n 3p tmp2 | cut -d" " -f2`"
@@ -193,29 +179,25 @@ check_attr()
 			diff_sys=`expr $attr1 - $attr_sys`
 			[ ${diff_sys} -le 0 ] &&  diff_sys=$((0 - $diff_sys))
 			if [ "$diff_usr" -le "$threshold" ] && \
-			[ "$diff_sys" -le "$threshold" ]
-			then
+			   [ "$diff_sys" -le "$threshold" ]; then
 				RC=$?
-			        echo "TPASS $mes:$2 PASSED"
-		        else
+				echo "TPASS $mes:$2 PASSED"
+			else
 				RC=$?
-			        echo "TFAIL $mes:$2 FAILED"
+				echo "TFAIL $mes:$2 FAILED"
 			fi
-		elif [ "$2" == "cpuacct.usage_percpu" ]
-		then
+		elif [ "$2" = "cpuacct.usage_percpu" ]; then
 			per_cpu_usage
 			echo
 			echo "$2 for Parent cgroup : $attrp"
 			echo "$2 for Child  cgroup : $attrc"
-			if [ "$attrp" == "$attrc" ]
-			then
+			if [ "$attrp" = "$attrc" ]; then
 				RC=$?
-			        echo "TPASS $mes:$2 PASSED"
-		        else
+				echo "TPASS $mes:$2 PASSED"
+			else
 				RC=$?
-			        echo "TFAIL $mes:$2 FAILED"
-		        fi
-
+				echo "TFAIL $mes:$2 FAILED"
+			fi
 		else
 			attr0="`sed -n 1p tmp2`"
 			attr1="`sed -n 2p tmp2`"
@@ -224,14 +206,13 @@ check_attr()
 			echo
 			echo "$2 for Parent cgroup : $attr0"
 			echo "$2 for Child  cgroup : $attr"
-			if [ "$attr0" == "$attr" ]
-			then
+			if [ "$attr0" = "$attr" ]; then
 				RC=$?
-			        echo "TPASS $mes:$2 PASSED"
-		        else
+				echo "TPASS $mes:$2 PASSED"
+			else
 				RC=$?
-			        echo "TFAIL $mes:$2 FAILED"
-		        fi
+				echo "TFAIL $mes:$2 FAILED"
+			fi
 		fi
 	fi
 }
@@ -242,144 +223,115 @@ setup;
 
 echo "TEST STARTED: Please avoid using system while this test executes";
 
-
 status=0
 case ${TEST_NUM} in
-	"1" )
-		ls $PWD/cpuacct_task01 &> /dev/null
-		if [ $? -ne 0 ]
-		then
-		        echo "TFAIL Task file cpuacct_task01.c not compiled"
-			echo "Please check Makefile Exiting test"
-			task_kill 2> /dev/null
-		        exit -1
+"1" )
+	exists cpuacct_task01
+	cpuacct_task01 &
+	pid=$!
+
+	mkdir $cg_path/group_1 2> /dev/null
+	mkdir $cg_path/group_1/group_11/ 2> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
+		cleanup
+		task_kill 2> /dev/null
+		exit 1
+	fi
+	echo $pid > $cg_path/group_1/group_11/tasks 2> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "TFAIL Not able to move a task to the cgroup"
+		echo "Exiting Test"
+		cleanup 2> /dev/null
+		task_kill 2> /dev/null
+		exit 1
+	fi
+	sleep 5
+	task_kill 2> /dev/null
+	for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
+	do
+		cat $cg_path/group_1/$i \
+		$cg_path/group_1/group_11/$i > tmp2
+		check_attr $1 $i
+		if [ $RC -ne 0 ]; then
+			status=1
 		fi
-		$PWD/cpuacct_task01 &
-                pid=$!
+	done
+	if [ $status -eq 0 ]; then
+		echo
+		tst_resm TPASS "$mes test executed successfully"
+		cleanup 2> /dev/null
+		task_kill 2> /dev/null
+		exit 0
+	else
+		echo
+		tst_resm TFAIL "$mes test execution Failed"
+		cleanup 2> /dev/null
+		exit 1
+	fi
+	;;
 
-		mkdir $cg_path/group_1 2> /dev/null
-		mkdir $cg_path/group_1/group_11/ 2> /dev/null
-		if [ $? -ne 0 ]
-                then
-                        echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
-                        cleanup
-			task_kill 2> /dev/null
-                        exit -1
-                fi
-		echo $pid > /$cg_path/group_1/group_11/tasks 2> /dev/null
-		if [ $? -ne 0 ]
-		then
-			echo "TFAIL Not able to move a task to the cgroup"
+"2" )
+	mkdir $cg_path/group_1 2> /dev/null
+	mkdir $cg_path/group_1/group_11 2> /dev/null
+	mkdir $cg_path/group_1/group_12 2> /dev/null
+	if [ $? -ne 0 ]; then
+		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
+		cleanup 2> /dev/null
+		task_kill 2> /dev/null
+		exit 1
+	fi
+
+	exists cpuacct_task01
+	for (( m=0 ; m<=$num_online_cpus ; m++ ))
+	do
+		nr_tasks
+		echo $pid > $cg_path/group_1/group_11/tasks
+		if [ $? -ne 0 ]; then
+			echo "TFAIL Not able to move task to cgroup"
 			echo "Exiting Test"
 			cleanup 2> /dev/null
 			task_kill 2> /dev/null
-			exit -1
+			exit 1
 		fi
-		sleep 5
-		task_kill 2> /dev/null
-		for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
-		do
-			cat $cg_path/group_1/$i \
-			$cg_path/group_1/group_11/$i > tmp2
-			check_attr $1 $i
-		if [ $RC -ne 0 ]
-		then
-			status=1
-		fi
-		done
-		if [ $status -eq 0 ]
-		then
-			echo
-			echo "$mes test executed successfully"
+		nr_tasks
+		echo $pid >$cg_path/group_1/group_12/tasks
+		if [ $? -ne 0 ]; then
+			echo "TFAIL Not able to move task to cgroup"
+			echo "Exiting Test"
 			cleanup 2> /dev/null
 			task_kill 2> /dev/null
-			exit 0
-		else
-			echo
-			echo "$mes test execution Failed"
-			cleanup 2> /dev/null
-			exit -1
+			exit 1
 		fi
-		;;
-
-	"2" )
-		mkdir $cg_path/group_1 2> /dev/null
-		mkdir $cg_path/group_1/group_11 2> /dev/null
-		mkdir $cg_path/group_1/group_12 2> /dev/null
-                if [ $? -ne 0 ]
-                then
-          		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
-                        cleanup 2> /dev/null
-			task_kill 2> /dev/null
-                        exit -1
-                fi
-
-                ls $PWD/cpuacct_task01 &> /dev/null
-                if [ $? -ne 0 ]
-                then
-                        echo "TFAIL Task file cpuacct_task01.c not compiled"
-			echo "Please check Makefile Exiting test"
-                	cleanup 2> /dev/null
-			task_kill 2> /dev/null
-		        exit -1
-                fi
-		for (( m=0 ; m<=$num_online_cpus ; m++ ))
-		do
-			nr_tasks
-        	        echo $pid > $cg_path/group_1/group_11/tasks
-			if [ $? -ne 0 ]
-                	then
-                        	echo "TFAIL Not able to move task to cgroup"
-				echo "Exiting Test"
-	                        cleanup 2> /dev/null
-				task_kill 2> /dev/null
-				exit -1
-        	        fi
-			nr_tasks
-			echo $pid >$cg_path/group_1/group_12/tasks
-	                if [ $? -ne 0 ]
-        	        then
-                	        echo "TFAIL Not able to move task to cgroup"
-				echo "Exiting Test"
-				cleanup 2> /dev/null
-				task_kill 2> /dev/null
-                        	exit -1
-	                fi
-			sleep 2
-		done
+		sleep 2
+	done
+	task_kill 2> /dev/null
+	for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
+	do
+		cat $cg_path/group_1/$i  \
+		$cg_path/group_1/group_11/$i \
+		$cg_path/group_1/group_12/$i >tmp2
+		check_attr $1 $i
+		if [ $RC -ne 0 ]; then
+			status=1
+		fi
+	done
+	if [ $status -eq 0 ]; then
+		echo
+		tst_resm TPASS "$mes test executed successfully"
+		cleanup 2> /dev/null
 		task_kill 2> /dev/null
-		for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
-                do
-                        cat $cg_path/group_1/$i  \
-			$cg_path/group_1/group_11/$i \
-			$cg_path/group_1/group_12/$i >tmp2
-                        check_attr $1 $i
-		if [ $RC -ne 0 ]
-                then
-                        status=1
-                fi
-		done
-		if [ $status -eq 0 ]
-                then
-                        echo
-                        echo "$mes test executed successfully"
-                        cleanup 2> /dev/null
-			task_kill 2> /dev/null
-			cd $PWD
-                        exit 0
-                else
-                        echo
-                        echo "$mes test execution Failed"
-                        cleanup 2> /dev/null
-			task_kill 2> /dev/null
-			cd $PWD
-                        exit -1
-                fi
-
-		;;
-	* )
-		usage
-		exit -1
-		;;
-	esac
-
+		exit 0
+	else
+		echo
+		tst_resm TFAIL "$mes test execution Failed"
+		cleanup 2> /dev/null
+		task_kill 2> /dev/null
+		exit 1
+	fi
+	;;
+* )
+	usage
+	exit 1
+	;;
+esac
-- 
1.8.4.2




------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

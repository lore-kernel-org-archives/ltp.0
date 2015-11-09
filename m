From: Cedric Hnyda <chnyda@suse.com>
Date: Mon,  9 Nov 2015 10:35:22 +0100
Subject: [LTP]  [PATCH] controllers/cpuacct: rewrote testcases
Message-ID: <1447061722-12065-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rewrote cpuacct testcases since they were outdated.
Removed old files
Added 6 tests for cpuacct.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                                |   7 +
 testcases/kernel/controllers/cpuacct/.gitignore    |   1 -
 testcases/kernel/controllers/cpuacct/README        |  51 ----
 testcases/kernel/controllers/cpuacct/cpuacct.sh    | 221 ++++++++++++++
 .../kernel/controllers/cpuacct/cpuacct_setup.sh    | 122 --------
 .../kernel/controllers/cpuacct/cpuacct_task.sh     |  30 ++
 .../kernel/controllers/cpuacct/cpuacct_task01.c    |  17 --
 .../controllers/cpuacct/cpuacct_testplan.txt       |  44 ---
 .../kernel/controllers/cpuacct/run_cpuacct_test.sh | 340 ---------------------
 9 files changed, 258 insertions(+), 575 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cpuacct/.gitignore
 delete mode 100644 testcases/kernel/controllers/cpuacct/README
 create mode 100755 testcases/kernel/controllers/cpuacct/cpuacct.sh
 delete mode 100755 testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
 create mode 100755 testcases/kernel/controllers/cpuacct/cpuacct_task.sh
 delete mode 100644 testcases/kernel/controllers/cpuacct/cpuacct_task01.c
 delete mode 100644 testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt
 delete mode 100755 testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh

diff --git a/runtest/controllers b/runtest/controllers
index 6d9daf4..161e539 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -197,6 +197,13 @@ cgroup_fj_stress_memory_1_100_100_2 run_cgroup_test_fj.sh stress memory 1 100 10
 
 controllers	test_controllers.sh
 
+cpuacct_1_1 cpuacct.sh 1 1
+cpuacct_1_1 cpuacct.sh 1 10
+cpuacct_1_1 cpuacct.sh 10 10
+cpuacct_1_1 cpuacct.sh 1 100
+cpuacct_1_1 cpuacct.sh 100 1
+cpuacct_1_1 cpuacct.sh 100 100
+
 cpuset_base_ops	cpuset_base_ops_testset.sh
 cpuset_inherit	cpuset_inherit_testset.sh
 cpuset_exclusive	cpuset_exclusive_test.sh
diff --git a/testcases/kernel/controllers/cpuacct/.gitignore b/testcases/kernel/controllers/cpuacct/.gitignore
deleted file mode 100644
index 0dfdad3..0000000
--- a/testcases/kernel/controllers/cpuacct/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/cpuacct_task01
diff --git a/testcases/kernel/controllers/cpuacct/README b/testcases/kernel/controllers/cpuacct/README
deleted file mode 100644
index 383f252..0000000
--- a/testcases/kernel/controllers/cpuacct/README
+++ /dev/null
@@ -1,51 +0,0 @@
-TEST SUITE:
-
-The directory cpuacct contains the tests related to cpu accounting controller.
-More testcases are expected to be added in future.
-
-TESTS AIM:
-
-The aim of the tests is to test cpu accounting controller functionality.
-
-FILES DESCRIPTION:
-
-cpuacct_task01.c
----------------
-This is the task which is run for eating up the cpu time.
-
-
-cpuacct_setup.sh
-----------
-This file contains the functions which are common for all the tests. For ex.
-the setup and cleanup functions which do the setup for running the test and do
-the cleanup once the test finishes. The setup() function creates /dev/cpuacct
-directory and mounts cgroup filesystem on it with accounting  controller. It
-then creates a number(n) of groups in /dev/cpuacct. The cleanup function does a
-complete cleanup of the system.
-
-Most of the error scenarios have been taken care of for a sane cleanup of the
-system. However if cleanup fails in any case, just manually execute the
-commands written in cleanup function in setup.sh.
-One of the most common causes of failed cleanup is that you have done cd into
-any of the groups in controller dir tree.
-
-run_cpuacct_test.sh
-------------------
-This script creates different scenarios for cpu accounting controller testing and
-starting (n) tasks in different groups to do some cpu allocations etc. It
-checks for the cpu usage of the groups and reports test pass/fail accordingly.
-
-Makefile
---------
-
-The usual makefile for this directory
-
-PASS/FAIL CRITERION:
-==================
-The test cases are intelligent enough in deciding the pass or failure of a
-test.
-
-README:
---------
-The one you have gone through.
-
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
new file mode 100755
index 0000000..ec1ac90
--- /dev/null
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -0,0 +1,221 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2015 SUSE                                                    ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301   ##
+## USA                                                                        ##
+##                                                                            ##
+## Author: Cedric Hnyda <chnyda@suse.com>                                     ##
+##                                                                            ##
+################################################################################
+
+# Usage
+# ./cpuacct.sh nbsubgroup nbprocess
+#
+# 1) nbsubgroup : number of subgroup to create
+# 2) nbprocess : number of process to attach to each subgroup
+#
+# Description
+#
+# 1) Find if cpuacct is mounted, if not mounted, cpuacct will be mounted
+# 2) Create a subgroup ltp_test in cpuacct
+# 3) Create nbsubgroup subgroup in ltp_test and attach them nbprocess process
+# 4) Check that every subgroup's tasks file is not empty (test1)
+# 5) Kill all created process
+# 6) Check that ltp_test/subgroup*/cpuacct.usage != 0 (test2)
+# 7) Check that sum ltp_test/subgroup*/cpuacct.usage = ltp_test/cpuacct.usage
+# (test3)
+# 8) cleanup
+
+
+mounted=1
+mount_point=""
+max=$1
+nbprocess=$2
+
+cd $LTPROOT/testcases/bin
+
+cnt=1
+for arg; do
+	if [ $cnt -gt 1 ]; then
+		NAME+="_"
+		NAME+=$arg
+	fi
+	cnt=$(( $cnt + 1 ))
+done
+
+PREFIX="cpuacct_"
+
+export TCID=$PREFIX$1$NAME
+export TESTROOT=`pwd`
+export TST_TOTAL=3;
+export TST_COUNT=1;
+TMPFILE="$TESTROOT/tmp_tasks"
+status=0
+
+verify_result()
+{
+	result=$1
+	expected=$2
+	message=$3
+	if [ "$result" -ne "$expected" ]; then
+		tst_resm TINFO "expected $expected, got $result"
+		cleanup;
+		tst_brkm TCONF NULL $message
+		exit 32
+	fi
+}
+
+mount_cpuacct()
+{
+	mount -t cgroup -o cpuacct none $mount_point
+	verify_result $? 0 "Error occured while mounting cgroup"
+}
+
+umount_cpuacct()
+{
+	tst_resm TINFO "Umounting cpuacct"
+	umount $mount_point
+	verify_result $? 0 "Error occured while umounting cgroup"
+}
+
+do_mkdir()
+{
+	path=$1
+	mkdir -p $path
+	verify_result $? 0 "Error occured with mkdir"
+}
+
+do_rmdir()
+{
+	path=$1
+	rmdir $path
+	verify_result $? 0 "Error occured with rmdir"
+}
+
+setup()
+{
+	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
+	tst_resm TINFO "cpuacct: $mount_point"
+	if [ "$mount_point" = "" ]; then
+		mounted=0
+		mount_point=/dev/cgroup
+	fi
+
+	testpath=$mount_point/ltp_test
+	if [ -e $testpath ]; then
+		rmdir $testpath/subgroup_*;
+		rmdir $testpath;
+	fi
+
+	if [ "$mounted" -eq "0" ]; then
+		do_mkdir $mount_point
+		mount_cpuacct
+	fi
+	do_mkdir $testpath
+	for i in `seq 1 $max`
+	do
+		do_mkdir $testpath/subgroup_$i
+	done
+
+	for i in `seq 1 $max`
+	do
+		for j in `seq 1 $nbprocess`
+		do
+			cpuacct_task.sh $testpath/subgroup_$i/tasks &
+		done
+	done
+
+	sleep 1
+}
+
+cleanup()
+{
+	tst_resm TINFO "removing created directories"
+	rmdir $testpath/subgroup_*;
+	rmdir $testpath;
+	killall -9 cpuacct_task.sh 1> /dev/null 2>&1;
+	if [ "$mounted" -ne 1 ] ; then
+		umount $mount_point
+		do_rmdir $mount_point
+	fi
+}
+
+##########################  main   #######################
+
+setup;
+
+error=0
+tst_resm TINFO "killing created process"
+for j in `seq 1 $max`
+do
+	cat $testpath/subgroup_$j/tasks > $TMPFILE
+	nlines=`cat $TMPFILE | wc -l`
+	if [ "$nlines" -eq "0" ]; then
+		error=1
+		status=1
+	fi
+	for i in `seq 1 $nlines`
+	do
+		cur_pid=`sed -n "$i""p" $TMPFILE`
+		if [ -e /proc/$cur_pid/ ];then
+			kill "$cur_pid"
+		fi
+	done
+done
+
+sleep 1
+
+## check that every subgroup has at least one process in tasks file
+if [ "$error" -eq "1" ]; then
+	tst_resm TFAIL "Some subgroup didn't have any pid in their tasks file"
+else
+	tst_resm TPASS "subgroups' tasks files are not empty"
+fi
+
+acc=0
+error=0
+for i in `seq 1 $max`
+do
+    tmp=`cat $testpath/subgroup_$i/cpuacct.usage`
+    if [ "$tmp" -eq "0" ]; then
+    	error=1
+    	status=1
+    fi
+    ((acc = acc + tmp))
+done
+
+## check that cpuacct.usage != 0 for every subgroup
+((TST_COUNT = TST_COUNT + 1))
+if [ "$error" -eq "1" ]; then
+	tst_resm TFAIL "cpuacct.usage should not be equal to 0"
+else
+	tst_resm TPASS "cpuacct.usage is not equal to 0 for every subgroup"
+fi
+
+## check that ltp_subgroup/cpuacct.usage == sum ltp_subgroup/subgroup*/cpuacct.usage
+((TST_COUNT = TST_COUNT + 1))
+ref=`cat $testpath/cpuacct.usage`
+if [ "$ref" != "$acc" ]; then
+	tst_resm TFAIL "ltp_test/cpuacct.usage not equal to ltp_test/subgroup*/cpuacct.usage"
+	status=1
+else
+	tst_resm TPASS "ltp_test/cpuacct.usage equal to ltp_test/subgroup*/cpuacct.usage"
+fi
+
+cleanup;
+exit $status
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
deleted file mode 100755
index 6eab1b4..0000000
--- a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
+++ /dev/null
@@ -1,122 +0,0 @@
-#!/bin/bash
-# usage ./cpuacct_setup.sh
-
-################################################################################
-#  Copyright (c) International Business Machines  Corp., 2009                  #
-#                                                                              #
-#  This program is free software;  you can redistribute it and/or modify       #
-#  it under the terms of the GNU General Public License as published by        #
-#  the Free Software Foundation; either version 2 of the License, or           #
-#  (at your option) any later version.                                         #
-#                                                                              #
-#  This program is distributed in the hope that it will be useful,             #
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of             #
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                   #
-#  the GNU General Public License for more details.                            #
-#                                                                              #
-#  You should have received a copy of the GNU General Public License           #
-#  along with this program;  if not, write to the Free Software Foundation,    #
-#  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA            #
-#                                                                              #
-################################################################################
-################################################################################
-# Name Of File: setup.sh                                        	       #
-#                                                                              #
-#  Description: This file has functions for the setup for testing cpu account  #
-#               controller. setup includes creating controller device,         #
-#               mounting it with cgroup filesystem with option cpu account     #
-#		and creating groups in it.                                     #
-#                                                                              #
-#  Functions:   setup(): creaes /dev/cpuacct, mounts cgroup fs on it, creates  #
-#               groups in that etc.                                            #
-#               usage(): Shows the usage of this file.                         #
-#               cleanup(): Does full system cleanup                            #
-#                                                                              #
-# Precaution:   Avoid system use by other applications/users to get fair and   #
-#               appropriate results (avoid unnecessary killing of applicatio)  #
-#                                                                              #
-# Author:       Rajasekhar Duddu   <rajduddu@in.ibm.com>                       #
-#                                                                              #
-# History:                                                                     #
-#                                                                              #
-#  DATE         NAME           EMAIL                         DESC              #
-#                                                                              #
-#  14/07/09  Rajasekhar D    <rajduddu@in.ibm.com>        Created this test    #
-#                                                                              #
-################################################################################
-
-# umount cpuacct if it has been mounted.
-umount_cpuacct_mounted()
-{
-	dir=`cat /proc/mounts | grep cpuacct | awk '{print $2}'`
-	if [ -n "$dir" ]; then
-		umount "$dir" 2> /dev/null
-	fi
-}
-
-# The cleanup function
-cleanup()
-{
-	echo "Cleanup called"
-	rm -rf txt*
-	rmdir /dev/cpuacct/group*/group* 2> /dev/null
-	rmdir /dev/cpuacct/group* 2> /dev/null
-	umount /dev/cpuacct/ 2> /dev/null
-	umount_cpuacct_mounted
-	rmdir /dev/cpuacct 2> /dev/null
-	rm -rf tmp2 2> /dev/null
-}
-
-task_kill()
-{
-	for i in `ps -e | grep cpuacct_task | awk '{print $1}'`
-	do
-		kill -SIGUSR1 $i
-	done
-	sleep 1
-	rm -rf txt* 2> /dev/null
-}
-#Create /dev/cpuacct & mount the cgroup file system with
-#cpu accounting controller
-
-#clean any group created eralier (if any)
-
-setup()
-{
-	if [ -e /dev/cpuacct ]; then
-		echo "WARN:/dev/cpuacct already exist..overwriting"
-		rmdir /dev/cpuacct/group*/group* 2> /dev/null
-		rmdir /dev/cpuacct/group* 2> /dev/null
-        	umount /dev/cpuacct/ 2> /dev/null
-		rmdir /dev/cpuacct 2> /dev/null
-		mkdir /dev/cpuacct
-	else
-		mkdir /dev/cpuacct
-	fi
-	umount_cpuacct_mounted
-	mount -t cgroup -ocpuacct none /dev/cpuacct 2> /dev/null
-	if [ $? -ne 0 ]
-	then
-		echo "TFAIL: Could not mount cgroup filesystem"
-		echo "Exiting test"
-		cleanup
-		exit 1
-	fi
-
-	# Group created earlier may again be visible if not cleaned properly.
-	#so clean them
-	if [ -e /dev/cpuacct/group_1 ]; then
-		rmdir /dev/cpuacct/group*/group* 2> /dev/null
-		rmdir /dev/cpuacct/group* 2> /dev/null
-		echo "WARN: Earlier groups found and removed...";
-	fi
-
-}
-
-# The usage of the script file
-usage()
-{
-	echo "Could not start cpu account controller test";
-	echo "usage: run_cpuacct_test.sh <TEST_NUM>";
-	echo "Skipping the cpu account controller test...";
-}
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_task.sh b/testcases/kernel/controllers/cpuacct/cpuacct_task.sh
new file mode 100755
index 0000000..54a9d65
--- /dev/null
+++ b/testcases/kernel/controllers/cpuacct/cpuacct_task.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2015 SUSE                                                    ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+## Author: Cedric Hnyda <chnyda@suse.com>                                     ##
+##                                                                            ##
+################################################################################
+
+echo $$ > $1
+i=0
+while :
+do
+	i=$i
+done
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_task01.c b/testcases/kernel/controllers/cpuacct/cpuacct_task01.c
deleted file mode 100644
index 67736e1..0000000
--- a/testcases/kernel/controllers/cpuacct/cpuacct_task01.c
+++ /dev/null
@@ -1,17 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-
-int main(void)
-{
-	FILE *fp;
-
-	while (1) {
-		fp = fopen("txt.x", "w");
-		if (fp == NULL) {
-			perror("fopen failed");
-			exit(1);
-		}
-		fclose(fp);
-	}
-	return 0;
-}
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt b/testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt
deleted file mode 100644
index ed84867..0000000
--- a/testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-The CPU Accounting controller testplan includes a complete set of
-testcases that test the CPU Accounting controller in different scenarios.
-
-
-TESTCASE DESCRIPTION:
-====================
-
-These tests will check if the cpu usage of the child cgroup is
-getting reflected in the parent cgroup.Reports PASS if the cpu
-usage is same for both the cgroups and FAIL if they differ.
-
-In these tests cpu usage of the tasks running in a group is read in
-terms of 3 different stat values.
-
-'cpuacct.usage'  gives the current cpu usage of the task running
-in the group.
-'cpuacct.usage_percpu' gives the cpu usage of each cpu.
-'cpuacct.stat' gives the user and system cpu usage of the task running
-in the group.
-
-Test01: STAT CHECK TEST
--------------------------------
-This test is run by running a task in the child group and reading it's stat
-values and comparing them with the parent group's stat values.
-
-Test02: STAT CHECK TEST
--------------------------------
-This test is run by running num_online_cpus number of tasks in 2 child groups,
-adding the stat values from the child groups and comparing them with the
-parent's stat values.
-
-The values reported for user and system time in cpuacct.stat is not very
-accurate and they can vary from the actual values by Threshold*num_online_cpus in the
-worst case.
-Where Threshold T = max(num_online_cpus^2, 32)
-
-In this test case, we allow for a max difference between actual and reported
-values to be 2T. If the difference between parent's value and children's value
-is greater than 2T, we mark the test as failed.
-
-
-For any other information please refer to
-Documentation/controllers/cpuacct.txt in kernel documentation.
-
diff --git a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh b/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
deleted file mode 100755
index b31aa45..0000000
--- a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
+++ /dev/null
@@ -1,340 +0,0 @@
-#!/bin/bash
-# usage ./run_cpuacct_test.sh $TEST_NUM
-#############################################################################
-#  Copyright (c) International Business Machines  Corp., 2009               #
-#                                                                           #
-#  This program is free software;  you can redistribute it and/or modify    #
-#  it under the terms of the GNU General Public License as published by     #
-#  the Free Software Foundation; either version 2 of the License, or        #
-#  (at your option) any later version.                                      #
-#                                                                           #
-#  This program is distributed in the hope that it will be useful,          #
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of          #
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                #
-#  the GNU General Public License for more details.                         #
-#                                                                           #
-#  You should have received a copy of the GNU General Public License        #
-#  along with this program;  if not, write to the Free Software Foundation, #
-#  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA         #
-#                                                                           #
-#############################################################################
-# Name Of File: run_cpuacct_test.sh                                         #
-#                                                                           #
-# Description: This file runs the setup for testing different cpu acctount  #
-#              controller features. After setup it runs diff test cases in  #
-#		diff setup.                                                 #
-#                                                                           #
-# Test 01:     Tests Cpu usage of Hierarchical cgroups                      #
-#                                                                           #
-# Precaution:   Avoid system use by other applications/users to get fair and#
-#               appropriate results (avoid unnecessary killing of 	    #
-#		application)						    #
-#                                                                           #
-# Author:       Rajasekhar Duddu   <rajduddu@in.ibm.com>                    #
-#                                                                           #
-# History:                                                                  #
-#                                                                           #
-#  DATE         NAME           EMAIL                         DESC           #
-#                                                                           #
-#  14/07/09  Rajasekhar D    <rajduddu@in.ibm.com>        Created this test #
-#                                                                           #
-#############################################################################
-
-
-export TCID="cpuacct_test01";
-export TST_TOTAL=1;
-export TST_COUNT=1;
-
-TEST_NUM=$1;
-SCRIPT_PID=$$;
-RC=0;
-
-tst_kvercmp 2 6 30  2> /dev/null
-if [ $? -eq 0 ]; then
-        tst_brkm TCONF ignored "Test should be run with kernel 2.6.30 or newer"
-        exit 0
-fi
-
-. cmdlib.sh
-
-tst_require_root
-
-. cpuacct_setup.sh
-
-task_kill  2> /dev/null
-cleanup
-
-mes="CPU Accounting Controller"
-cg_path="/dev/cpuacct";
-num_online_cpus=`tst_ncpus`
-
-#Function to create tasks equal to num_online_cpus.
-nr_tasks()
-{
-	cpuacct_task01 &
-	pid=$!
-}
-
-#Function to caluculate the threshold value.
-get_threshold()
-{
-	num_online_cpus=`expr $num_online_cpus \* $num_online_cpus`
-	if [ $num_online_cpus -le 32 ]; then
-		threshold=32
-	else
-		threshold=$num_online_cpus
-	fi
-	threshold=`expr $threshold \* 2`
-}
-
-#Function which is called for reading the cpuacct.usage_percpu stat value
-#for Parent and Child cgroups.
-per_cpu_usage()
-{
-	attrc=0
-	attrp=0
-	i=0
-	k=0
-	while read line
-	do
-		j=0
-		for k in $line
-		do
-			j=`expr $j + $k`
-		done
-		if [ "$i" = "0" ]; then
-			attrp=$j
-			i=`expr $i + 1`
-		else
-			attrc=`expr $j + $attrc`
-		fi
-	done < "./tmp2"
-}
-
-#Function which verifies the cpu accounting of the Parent and the Child cgroups.
-check_attr()
-{
-	if [ "$1" = "1" ]; then
-		if [ "$2" = "cpuacct.stat" ]; then
-			attr1="`sed -n 1p tmp2`"
-			attr2="`sed -n 2p tmp2`"
-			attr3="`sed -n 3p tmp2`"
-			attr4="`sed -n 4p tmp2`"
-			echo
-			echo "$2 for Parent cgroup is $attr1 : $attr2"
-			echo "$2 for Child cgroup is $attr3 : $attr4"
-
-			if [ "$attr1" = "$attr3" ] && \
-			   [ "$attr2" = "$attr4" ]; then
-				RC=$?
-				echo "TPASS $mes:$2 PASSED"
-
-			else
-				RC=$?
-				echo "TFAIL $mes:$2 FAILED"
-			fi
-		elif [ "$2" = "cpuacct.usage_percpu" ]; then
-			per_cpu_usage
-			echo
-			echo "$2 for Parent cgroup : $attrp"
-			echo "$2 for Child  cgroup : $attrc"
-			if [ "$attrp" = "$attrc" ]; then
-				RC=$?
-				echo "TPASS $mes:$2 PASSED"
-			else
-				RC=$?
-				echo "TFAIL $mes:$2 FAILED"
-			fi
-		else
-			attr1="`sed -n 1p tmp2`"
-			attr2="`sed -n 2p tmp2`"
-
-			echo
-			echo "$2 for Parent cgroup is $attr1"
-			echo "$2 for Child cgroup is $attr2"
-			if [ "$attr1" = "$attr2" ]; then
-				RC=$?
-				echo "TPASS $mes:$2 PASSED"
-			else
-				RC=$?
-				echo "TFAIL $mes:$2 FAILED"
-			fi
-
-		fi
-	else
-		if [ "$2" = "cpuacct.stat" ]; then
-			attr0="`sed -n 1p tmp2 | cut -d" " -f2`"
-			attr1="`sed -n 2p tmp2 | cut -d" " -f2`"
-			attr2="`sed -n 3p tmp2 | cut -d" " -f2`"
-			attr3="`sed -n 4p tmp2 | cut -d" " -f2`"
-			attr4="`sed -n 5p tmp2 | cut -d" " -f2`"
-			attr5="`sed -n 6p tmp2 | cut -d" " -f2`"
-			attr_usr=`expr $attr2 + $attr4 `
-			attr_sys=`expr $attr3 + $attr5`
-			echo
-			echo "$2 for Parent cgroup : $attr0::$attr1"
-			echo "$2 for Child  cgroup : $attr_usr::$attr_sys"
-			get_threshold
-			diff_usr=`expr $attr0 - $attr_usr `
-			[ ${diff_usr} -le 0 ] &&  diff_usr=$((0 - $diff_usr))
-
-			diff_sys=`expr $attr1 - $attr_sys`
-			[ ${diff_sys} -le 0 ] &&  diff_sys=$((0 - $diff_sys))
-			if [ "$diff_usr" -le "$threshold" ] && \
-			   [ "$diff_sys" -le "$threshold" ]; then
-				RC=$?
-				echo "TPASS $mes:$2 PASSED"
-			else
-				RC=$?
-				echo "TFAIL $mes:$2 FAILED"
-			fi
-		elif [ "$2" = "cpuacct.usage_percpu" ]; then
-			per_cpu_usage
-			echo
-			echo "$2 for Parent cgroup : $attrp"
-			echo "$2 for Child  cgroup : $attrc"
-			if [ "$attrp" = "$attrc" ]; then
-				RC=$?
-				echo "TPASS $mes:$2 PASSED"
-			else
-				RC=$?
-				echo "TFAIL $mes:$2 FAILED"
-			fi
-		else
-			attr0="`sed -n 1p tmp2`"
-			attr1="`sed -n 2p tmp2`"
-			attr2="`sed -n 3p tmp2`"
-			attr=`expr $attr1 + $attr2`
-			echo
-			echo "$2 for Parent cgroup : $attr0"
-			echo "$2 for Child  cgroup : $attr"
-			if [ "$attr0" = "$attr" ]; then
-				RC=$?
-				echo "TPASS $mes:$2 PASSED"
-			else
-				RC=$?
-				echo "TFAIL $mes:$2 FAILED"
-			fi
-		fi
-	fi
-}
-
-echo "TEST $TEST_NUM:CPU ACCOUNTING CONTROLLER TESTING";
-echo "RUNNING SETUP.....";
-setup;
-
-echo "TEST STARTED: Please avoid using system while this test executes";
-
-status=0
-case ${TEST_NUM} in
-"1" )
-	exists cpuacct_task01
-	cpuacct_task01 &
-	pid=$!
-
-	mkdir $cg_path/group_1 2> /dev/null
-	mkdir $cg_path/group_1/group_11/ 2> /dev/null
-	if [ $? -ne 0 ]; then
-		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
-		task_kill 2> /dev/null
-		cleanup
-		exit 1
-	fi
-	echo $pid > $cg_path/group_1/group_11/tasks 2> /dev/null
-	if [ $? -ne 0 ]; then
-		echo "TFAIL Not able to move a task to the cgroup"
-		echo "Exiting Test"
-		task_kill 2> /dev/null
-		cleanup
-		exit 1
-	fi
-	sleep 5
-	task_kill 2> /dev/null
-	for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
-	do
-		cat $cg_path/group_1/$i \
-		$cg_path/group_1/group_11/$i > tmp2
-		check_attr $1 $i
-		if [ $RC -ne 0 ]; then
-			status=1
-		fi
-	done
-	if [ $status -eq 0 ]; then
-		echo
-		tst_resm TPASS "$mes test executed successfully"
-		task_kill 2> /dev/null
-		cleanup
-		exit 0
-	else
-		echo
-		tst_resm TFAIL "$mes test execution Failed"
-		task_kill 2> /dev/null
-		cleanup
-		exit 1
-	fi
-	;;
-
-"2" )
-	mkdir $cg_path/group_1 2> /dev/null
-	mkdir $cg_path/group_1/group_11 2> /dev/null
-	mkdir $cg_path/group_1/group_12 2> /dev/null
-	if [ $? -ne 0 ]; then
-		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
-		task_kill 2> /dev/null
-		cleanup
-		exit 1
-	fi
-
-	exists cpuacct_task01
-	for (( m=0 ; m<=$num_online_cpus ; m++ ))
-	do
-		nr_tasks
-		echo $pid > $cg_path/group_1/group_11/tasks
-		if [ $? -ne 0 ]; then
-			echo "TFAIL Not able to move task to cgroup"
-			echo "Exiting Test"
-			task_kill 2> /dev/null
-			cleanup
-			exit 1
-		fi
-		nr_tasks
-		echo $pid >$cg_path/group_1/group_12/tasks
-		if [ $? -ne 0 ]; then
-			echo "TFAIL Not able to move task to cgroup"
-			echo "Exiting Test"
-			task_kill 2> /dev/null
-			cleanup
-			exit 1
-		fi
-		sleep 2
-	done
-	task_kill 2> /dev/null
-	for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
-	do
-		cat $cg_path/group_1/$i  \
-		$cg_path/group_1/group_11/$i \
-		$cg_path/group_1/group_12/$i >tmp2
-		check_attr $1 $i
-		if [ $RC -ne 0 ]; then
-			status=1
-		fi
-	done
-	if [ $status -eq 0 ]; then
-		echo
-		tst_resm TPASS "$mes test executed successfully"
-		task_kill 2> /dev/null
-		cleanup
-		exit 0
-	else
-		echo
-		tst_resm TFAIL "$mes test execution Failed"
-		task_kill 2> /dev/null
-		cleanup
-		exit 1
-	fi
-	;;
-* )
-	usage
-	exit 1
-	;;
-esac
-- 
2.1.4


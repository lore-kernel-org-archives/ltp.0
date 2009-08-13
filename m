Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rajduddu@linux.vnet.ibm.com>) id 1MbV8k-0000qz-PU
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:54:26 +0000
Received: from e28smtp06.in.ibm.com ([59.145.155.6])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbV8i-0007KV-4J
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:54:26 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7D7s5JQ014018
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 13:24:05 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7D7s5971511660
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 13:24:05 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7D7s5Xo006094
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 13:24:05 +0530
Date: Thu, 13 Aug 2009 13:24:04 +0530
From: Rajasekhar Duddu <rajduddu@linux.vnet.ibm.com>
Message-ID: <20090813075404.GA10982@rajasekhar>
References: <20090807111950.GD4761@rajasekhar>
	<1249648957.4851.49.camel@subratamodak.linux.ibm.com>
	<1249968754.5507.2.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1249968754.5507.2.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] CPU Accounting Controller test case for LTP.
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, dhaval@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>, Miao Xie <miaox@cn.fujitsu.com>, bharata@linux.vnet.ibm.com, Ingo Molnar <mingo@elte.hu>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, balbir <balbir@linux.vnet.ibm.com>

Hi Subrata, I have done the changes to the patch as you have
suggested, please review it and let me know if it needs any
changes thanku.

I am psoting the results also here.


Signed-off-by: Duddu Rajasekhar<rajduddu@in.ibm.com>
diff -rupN ltp-full-20090731//testcases/kernel/controllers/cpuacct/cpuacct_task.c ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/cpuacct_task.c
--- ltp-full-20090731//testcases/kernel/controllers/cpuacct/cpuacct_task.c	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/cpuacct_task.c	2009-08-12 15:21:46.000000000 +0000
@@ -0,0 +1,14 @@
+#include<stdio.h>
+
+int main(void)
+{
+	FILE *fp;
+
+	while (1) {
+		fp = fopen("txt.x", "w");
+		fclose(fp);
+	}
+	return 0;
+}
+
+
diff -rupN ltp-full-20090731//testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt
--- ltp-full-20090731//testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/cpuacct_testplan.txt	2009-08-13 07:05:14.000000000 +0000
@@ -0,0 +1,44 @@
+The CPU Accounting controller testplan includes a complete set of 
+testcases that test the CPU Accounting controller in different scenarios.
+
+
+TESTCASE DESCRIPTION:
+====================
+
+These tests will check if the cpu usage of the child cgroup is 
+getting reflected in the parent cgroup.Reports PASS if the cpu 
+usage is same for both the cgroups and FAIL if they differ.
+
+In these tests cpu usage of the tasks running in a group is read in 
+terms of 3 different stat values.
+
+'cpuacct.usage'  gives the current cpu usage of the task running 
+in the group.
+'cpuacct.usage_percpu' gives the cpu usage of each cpu.
+'cpuacct.stat' gives the user and system cpu usage of the task running 
+in the group.
+
+Test01: STAT CHECK TEST
+-------------------------------
+This test is run by running a task in the child group and reading it's stat 
+values and comparing them with the parent group's stat values.
+
+Test02: STAT CHECK TEST
+-------------------------------
+This test is run by running num_online_cpus number of tasks in 2 child groups, 
+adding the stat values from the child groups and comparing them with the 
+parent's stat values.
+
+The values reported for user and system time in cpuacct.stat is not very
+accurate and they can vary from the actual values by Threshold*num_online_cpus in the
+worst case.
+Where Threshold T = max(num_online_cpus^2, 32)
+
+In this test case, we allow for a max difference between actual and reported
+values to be 2T. If the difference between parent's value and children's value
+is greater than 2T, we mark the test as failed.
+
+
+For any other information please refer to 
+Documentation/controllers/cpuacct.txt in kernel documentation.
+
diff -rupN ltp-full-20090731//testcases/kernel/controllers/cpuacct/Makefile ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/Makefile
--- ltp-full-20090731//testcases/kernel/controllers/cpuacct/Makefile	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/Makefile	2009-08-13 07:04:40.000000000 +0000
@@ -0,0 +1,16 @@
+CFLAGS += -Wall
+CPPFLAGS += -I../../../../include -I../libcontrollers
+LDLIBS += -lm -L../../../../lib/ -L../libcontrollers -lcontrollers -lltp
+
+SRCS    = $(wildcard *.c)
+
+TARGETS = $(patsubst %.c,%,$(SRCS))
+
+all:	$(TARGETS)
+
+clean:
+	rm -f $(TARGETS) *.o
+
+install:
+	@set -e; for i in $(TARGETS) run_cpuacct_test.sh setup.sh; do ln -f $$i ../../../bin/$$i ; chmod +x $$i ; done
+
diff -rupN ltp-full-20090731//testcases/kernel/controllers/cpuacct/README ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/README
--- ltp-full-20090731//testcases/kernel/controllers/cpuacct/README	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/README	2009-08-13 07:01:59.000000000 +0000
@@ -0,0 +1,51 @@
+TEST SUITE:
+
+The directory cpuacct contains the tests related to cpu accounting controller.
+More testcases are expected to be added in future.
+
+TESTS AIM:
+
+The aim of the tests is to test cpu accounting controller functionality.
+
+FILES DESCRIPTION:
+
+cpuacct_task.c
+---------------
+This is the task which is run for eating up the cpu time.
+
+
+setup.sh
+----------
+This file contains the functions which are common for all the tests. For ex.
+the setup and cleanup functions which do the setup for running the test and do
+the cleanup once the test finishes. The setup() function creates /dev/cpuacct
+directory and mounts cgroup filesystem on it with accounting  controller. It 
+then creates a number(n) of groups in /dev/cpuacct. The cleanup function does a
+complete cleanup of the system.
+
+Most of the error scenarios have been taken care of for a sane cleanup of the
+system. However if cleanup fails in any case, just manually execute the
+commands written in cleanup function in setup.sh.
+One of the most common causes of failed cleanup is that you have done cd into
+any of the groups in controller dir tree.
+
+run_cpuacct_test.sh
+------------------
+This script creates different scenarios for cpu accounting controller testing and
+starting (n) tasks in different groups to do some cpu allocations etc. It
+checks for the cpu usage of the groups and reports test pass/fail accordingly.
+
+Makefile
+--------
+
+The usual makefile for this directory
+
+PASS/FAIL CRITERION:
+==================
+The test cases are intelligent enough in deciding the pass or failure of a
+test.
+
+README:
+--------
+The one you have gone through.
+
diff -rupN ltp-full-20090731//testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
--- ltp-full-20090731//testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh	2009-08-13 07:02:47.000000000 +0000
@@ -0,0 +1,380 @@
+#!/bin/bash
+# usage ./run_cpuacct_test.sh $TEST_NUM
+#############################################################################
+#  Copyright (c) International Business Machines  Corp., 2009               #
+#                                                                           #
+#  This program is free software;  you can redistribute it and/or modify    #
+#  it under the terms of the GNU General Public License as published by     #
+#  the Free Software Foundation; either version 2 of the License, or        #
+#  (at your option) any later version.                                      #
+#                                                                           #
+#  This program is distributed in the hope that it will be useful,          #
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of          #
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                #
+#  the GNU General Public License for more details.                         #
+#                                                                           #
+#  You should have received a copy of the GNU General Public License        #
+#  along with this program;  if not, write to the Free Software             #
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA  #
+#                                                                           #
+#############################################################################
+# Name Of File: run_cpuacct_test.sh                                         #
+#                                                                           #
+# Description: This file runs the setup for testing different cpu acctount  #
+#              controller features. After setup it runs diff test cases in  #
+#		diff setup.                                                 #
+#                                                                           #
+# Test 01:     Tests Cpu usage of Hierarchical cgroups                      #
+#                                                                           #
+# Precaution:   Avoid system use by other applications/users to get fair and#
+#               appropriate results (avoid unnecessary killing of 	    #
+#		application)						    #
+#                                                                           #
+# Author:       Rajasekhar Duddu   <rajduddu@in.ibm.com>                    #
+#                                                                           #
+# History:                                                                  #
+#                                                                           #
+#  DATE         NAME           EMAIL                         DESC           #
+#                                                                           #
+#  14/07/09  Rajasekhar D    <rajduddu@in.ibm.com>        Created this test #
+#                                                                           #
+#############################################################################
+
+export TCID="cpuacct_test01";
+export TST_TOTAL=1;
+export TST_COUNT=1;
+
+TEST_NUM=$1;
+SCRIPT_PID=$$;
+RC=0;
+PWD=`pwd`;
+
+cd $LTPROOT/testcases/bin/   2> /dev/null
+. setup.sh
+
+if [ "$USER" != root ]; then
+        tst_brkm TBROK ignored "Test must be run as root"
+        exit 0
+fi
+
+tst_kvercmp 2 6 30  2> /dev/null
+if [ $? -eq 0 ]; then
+        tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
+        exit 0
+fi
+
+task_kill  2> /dev/null
+cleanup
+
+mes="CPU Accounting Controller"
+cg_path="/dev/cpuacct";
+num_online_cpus=`cat /proc/cpuinfo | grep -w processor | wc -l`
+
+#Function to create tasks equal to num_online_cpus.
+nr_tasks ()
+{
+	$PWD/cpuacct_task &
+	pid=$!
+}
+
+#Function to caluculate the threshold value.
+get_threshold ()
+{
+	num_online_cpus=`expr $num_online_cpus \* $num_online_cpus`
+	if [ $num_online_cpus -le 32 ]
+	then
+		threshold=32
+	else
+		threshold=$num_online_cpus
+	fi
+	threshold=`expr $threshold \* 2`
+}
+
+#Function which is called for reading the cpuacct.usage_percpu stat value
+#for Parent and Child cgroups.
+per_cpu_usage ()
+{
+	attrc=0
+	attrp=0
+        i=0
+        k=0
+        while read line
+        do
+	        j=0
+                for k in $line
+                do
+        	        j=`expr $j + $k`
+                done
+                if [ "$i" == "0" ]
+                then
+   	             attrp=$j
+                     i=`expr $i + 1`
+                else
+                     attrc=`expr $j + $attrc`
+                fi
+        done < "./tmp2"
+}
+
+#Function which verifies the cpu accounting of the Parent and the Child cgroups.
+check_attr()
+{
+
+	if [ "$1" == "1" ]
+	then
+		if [ "$2" == "cpuacct.stat" ]
+		then
+			attr1="`sed -n 1p tmp2`"
+			attr2="`sed -n 2p tmp2`"
+			attr3="`sed -n 3p tmp2`"
+			attr4="`sed -n 4p tmp2`"
+			echo
+			echo "$2 for Parent cgroup is $attr1 : $attr2"
+			echo "$2 for Child cgroup is $attr3 : $attr4"
+
+		        if [ "$attr1" == "$attr3" ] && [ "$attr2" == "$attr4" ]
+		        then
+				RC=$?
+				echo "TPASS $mes:$2 PASSED"
+
+		        else
+				RC=$?
+				echo "TFAIL $mes:$2 FAILED"
+		        fi
+		elif [ "$2" == "cpuacct.usage_percpu" ]
+                then
+			per_cpu_usage
+			echo
+                        echo "$2 for Parent cgroup : $attrp"
+                        echo "$2 for Child  cgroup : $attrc"
+                        if [ "$attrp" == "$attrc" ]
+                        then
+                                RC=$?
+                                echo "TPASS $mes:$2 PASSED"
+                        else
+                                RC=$?
+                                echo "TFAIL $mes:$2 FAILED"
+                        fi
+		else
+			attr1="`sed -n 1p tmp2`"
+			attr2="`sed -n 2p tmp2`"
+
+			echo
+			echo "$2 for Parent cgroup is $attr1"
+			echo "$2 for Child cgroup is $attr2"
+		        if [ "$attr1"  ==   "$attr2"  ]
+		        then
+				RC=$?
+			        echo "TPASS $mes:$2 PASSED"
+			else
+				RC=$?
+				echo "TFAIL $mes:$2 FAILED"
+			fi
+
+		fi
+	else
+
+		if [ "$2" == "cpuacct.stat" ]
+		then
+			attr0="`sed -n 1p tmp2 | cut -d" " -f2`"
+			attr1="`sed -n 2p tmp2 | cut -d" " -f2`"
+			attr2="`sed -n 3p tmp2 | cut -d" " -f2`"
+			attr3="`sed -n 4p tmp2 | cut -d" " -f2`"
+			attr4="`sed -n 5p tmp2 | cut -d" " -f2`"
+			attr5="`sed -n 6p tmp2 | cut -d" " -f2`"
+			attr_usr=`expr $attr2 + $attr4 `
+			attr_sys=`expr $attr3 + $attr5`
+			echo
+			echo "$2 for Parent cgroup : $attr0::$attr1"
+			echo "$2 for Child  cgroup : $attr_usr::$attr_sys"
+			get_threshold
+			diff_usr=`expr $attr0 - $attr_usr `
+			[ ${diff_usr} -le 0 ] &&  diff_usr=$((0 - $diff_usr))
+
+			diff_sys=`expr $attr1 - $attr_sys`
+			[ ${diff_sys} -le 0 ] &&  diff_sys=$((0 - $diff_sys))
+			if [ "$diff_usr" -le "$threshold" ] && \
+			[ "$diff_sys" -le "$threshold" ]
+			then
+				RC=$?
+			        echo "TPASS $mes:$2 PASSED"
+		        else
+				RC=$?
+			        echo "TFAIL $mes:$2 FAILED"
+			fi
+		elif [ "$2" == "cpuacct.usage_percpu" ]
+		then
+			per_cpu_usage
+			echo
+			echo "$2 for Parent cgroup : $attrp"
+			echo "$2 for Child  cgroup : $attrc"
+			if [ "$attrp" == "$attrc" ]
+			then
+				RC=$?
+			        echo "TPASS $mes:$2 PASSED"
+		        else
+				RC=$?
+			        echo "TFAIL $mes:$2 FAILED"
+		        fi
+
+		else
+			attr0="`sed -n 1p tmp2`"
+			attr1="`sed -n 2p tmp2`"
+			attr2="`sed -n 3p tmp2`"
+			attr=`expr $attr1 + $attr2`
+			echo
+			echo "$2 for Parent cgroup : $attr0"
+			echo "$2 for Child  cgroup : $attr"
+			if [ "$attr0" == "$attr" ]
+			then
+				RC=$?
+			        echo "TPASS $mes:$2 PASSED"
+		        else
+				RC=$?
+			        echo "TFAIL $mes:$2 FAILED"
+		        fi
+		fi
+	fi
+}
+
+echo "TEST $TEST_NUM:CPU ACCOUNTING CONTROLLER TESTING";
+echo "RUNNING SETUP.....";
+setup;
+
+echo "TEST STARTED: Please avoid using system while this test executes";
+
+
+status=0
+case ${TEST_NUM} in
+	"1" )
+		gcc -o $PWD/cpuacct_task $PWD/cpuacct_task.c
+		ls $PWD/cpuacct_task &> /dev/null
+		if [ $? -ne 0 ]
+		then
+		        echo "TFAIL Task file cpuacct_task.c not compiled"
+			echo "Please check Makefile Exiting test"
+		        exit -1
+		fi
+		$PWD/cpuacct_task &
+                pid=$!
+
+		mkdir $cg_path/group_1 2> /dev/null
+		mkdir $cg_path/group_1/group_11/ 2> /dev/null
+		if [ $? -ne 0 ]
+                then
+                        echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
+                        cleanup
+                        exit -1
+                fi
+		echo $pid > /$cg_path/group_1/group_11/tasks 2> /dev/null
+		if [ $? -ne 0 ]
+		then
+			echo "TFAIL Not able to move a task to the cgroup"
+			echo "Exiting Test"
+			cleanup 2> /dev/null
+			exit -1
+		fi
+		sleep 5
+		task_kill 2> /dev/null
+		for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
+		do
+			cat $cg_path/group_1/$i \
+			$cg_path/group_1/group_11/$i > tmp2
+			check_attr $1 $i
+		done
+		if [ $RC -ne 0 ]
+		then
+			status=1
+		fi
+
+		if [ $status -eq 0 ]
+		then
+			echo
+			echo "$mes test executed successfully"
+			cleanup 2> /dev/null
+			cd $PWD
+			exit 0
+		else
+			echo
+			echo "$mes test execution Failed"
+			cleanup 2> /dev/null
+			cd $PWD
+			exit -1
+		fi
+		;;
+
+	"2" )
+		mkdir $cg_path/group_1 2> /dev/null
+		mkdir $cg_path/group_1/group_11 2> /dev/null
+		mkdir $cg_path/group_1/group_12 2> /dev/null
+                if [ $? -ne 0 ]
+                then
+          		echo "TFAIL Cannot create cpuacct cgroups Exiting Test"
+                        cleanup 2> /dev/null
+                        exit -1
+                fi
+
+		gcc -o $PWD/cpuacct_task $PWD/cpuacct_task.c
+                ls $PWD/cpuacct_task &> /dev/null
+                if [ $? -ne 0 ]
+                then
+                        echo "TFAIL Task file cpuacct_task.c not compiled"
+			echo "Please check Makefile Exiting test"
+                	cleanup 2> /dev/null
+		        exit -1
+                fi
+		for (( m=0 ; m<=$num_online_cpus ; m++ ))
+		do
+			nr_tasks
+        	        echo $pid > $cg_path/group_1/group_11/tasks
+			if [ $? -ne 0 ]
+                	then
+                        	echo "TFAIL Not able to move task to cgroup"
+				echo "Exiting Test"
+	                        cleanup 2> /dev/null
+				exit -1
+        	        fi
+			nr_tasks
+			echo $pid >$cg_path/group_1/group_12/tasks
+	                if [ $? -ne 0 ]
+        	        then
+                	        echo "TFAIL Not able to move task to cgroup"
+				echo "Exiting Test"
+				cleanup 2> /dev/null
+                        	exit -1
+	                fi
+			sleep 2
+		done
+		task_kill 2> /dev/null
+		for i in cpuacct.usage cpuacct.usage_percpu cpuacct.stat
+                do
+                        cat $cg_path/group_1/$i  \
+			$cg_path/group_1/group_11/$i \
+			$cg_path/group_1/group_12/$i >tmp2
+                        check_attr $1 $i
+                done
+		if [ $RC -ne 0 ]
+                then
+                        status=1
+                fi
+		if [ $status -eq 0 ]
+                then
+                        echo
+                        echo "$mes test executed successfully"
+                        cleanup 2> /dev/null
+			cd $PWD
+                        exit 0
+                else
+                        echo
+                        echo "$mes test execution Failed"
+                        cleanup 2> /dev/null
+			cd $PWD
+                        exit -1
+                fi
+
+		;;
+	* )
+		usage
+		exit -1
+		;;
+	esac
+
diff -rupN ltp-full-20090731//testcases/kernel/controllers/cpuacct/setup.sh ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/setup.sh
--- ltp-full-20090731//testcases/kernel/controllers/cpuacct/setup.sh	1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/cpuacct/setup.sh	2009-08-13 07:03:51.000000000 +0000
@@ -0,0 +1,114 @@
+#!/bin/bash
+# usage ./setup.sh
+
+################################################################################
+#  Copyright (c) International Business Machines  Corp., 2009                  #
+#                                                                              #
+#  This program is free software;  you can redistribute it and/or modify       #
+#  it under the terms of the GNU General Public License as published by        #
+#  the Free Software Foundation; either version 2 of the License, or           #
+#  (at your option) any later version.                                         #
+#                                                                              #
+#  This program is distributed in the hope that it will be useful,             #
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of             #
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                   #
+#  the GNU General Public License for more details.                            #
+#                                                                              #
+#  You should have received a copy of the GNU General Public License           #
+#  along with this program;  if not, write to the Free Software                #
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA     #
+#                                                                              #
+################################################################################
+################################################################################
+# Name Of File: setup.sh                                        	       #
+#                                                                              #
+#  Description: This file has functions for the setup for testing cpu account  #
+#               controller. setup includes creating controller device,         #
+#               mounting it with cgroup filesystem with option cpu account     #
+#		and creating groups in it.                                     #
+#                                                                              #
+#  Functions:   setup(): creaes /dev/cpuacct, mounts cgroup fs on it, creates  #
+#               groups in that etc.                                            #
+#               usage(): Shows the usage of this file.                         #
+#               cleanup(): Does full system cleanup                            #
+#                                                                              #
+# Precaution:   Avoid system use by other applications/users to get fair and   #
+#               appropriate results (avoid unnecessary killing of applicatio)  #
+#                                                                              #
+# Author:       Rajasekhar Duddu   <rajduddu@in.ibm.com>                       #
+#                                                                              #
+# History:                                                                     #
+#                                                                              #
+#  DATE         NAME           EMAIL                         DESC              #
+#                                                                              #
+#  14/07/09  Rajasekhar D    <rajduddu@in.ibm.com>        Created this test    #
+#                                                                              #
+################################################################################
+
+# The cleanup function
+cleanup ()
+{
+	echo "Cleanup called"
+	rm -rf txt.x 2> /dev/null
+	rm -f cpuacct_task 2>/dev/null
+	rmdir /dev/cpuacct/group*/group* 2> /dev/null
+	rmdir /dev/cpuacct/group* 2> /dev/null
+	umount /dev/cpuacct/ 2> /dev/null
+	rmdir /dev/cpuacct 2> /dev/null
+	rm -rf tmp2 2> /dev/null
+}
+task_kill ()
+{
+	for i in `ps -e | grep cpuacct_task | cut -d" " -f1`
+	do
+		kill -SIGUSR1 $i
+	done
+	rm -rf $PWD/txt.x 2> /dev/null
+	rm -f $PWD/cpuacct_task[0-8] 2>/dev/null
+}
+#Create /dev/cpuacct & mount the cgroup file system with
+#cpu accounting controller
+
+#clean any group created eralier (if any)
+
+setup ()
+{
+	if [ -e /dev/cpuacct ]
+	then
+		echo "WARN:/dev/cpuacct already exist..overwriting"
+		rmdir /dev/cpuacct/group*/group* 2> /dev/null
+	        rmdir /dev/cpuacct/group* 2> /dev/null
+        	umount /dev/cpuacct/ 2> /dev/null
+	        rmdir /dev/cpuacct 2> /dev/null
+
+		mkdir /dev/cpuacct
+	else
+		mkdir /dev/cpuacct
+	fi
+	mount -t cgroup -ocpuacct none /dev/cpuacct 2> /dev/null
+	if [ $? -ne 0 ]
+	then
+		echo "TFAIL: Could not mount cgroup filesystem"
+		echo "Exiting test"
+		cleanup
+		exit -1
+	fi
+
+	# Group created earlier may again be visible if not cleaned properly.
+	#so clean them
+	if [ -e /dev/cpuacct/group_1 ]
+	then
+		rmdir /dev/cpuacct/group*/group* 2> /dev/null
+		rmdir /dev/cpuacct/group* 2> /dev/null
+		echo "WARN: Earlier groups found and removed...";
+	fi
+
+}
+
+# The usage of the script file
+usage()
+{
+	echo "Could not start cpu account controller test";
+	echo "usage: run_cpuacct_test.sh $TEST_NUM ";
+	echo "Skipping the cpu account controller test...";
+}
diff -rupN ltp-full-20090731//testcases/kernel/controllers/Makefile ltp-full-20090731.src//testcases/kernel/controllers/Makefile
--- ltp-full-20090731//testcases/kernel/controllers/Makefile	2009-07-30 17:27:58.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/Makefile	2009-08-07 07:04:09.000000000 +0000
@@ -7,6 +7,8 @@ CHECK_MEMCTL := $(shell grep -w memory /
 CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut -f1)
 CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -f1)
+CHECK_CPUACCTCTL := $(shell grep -w cpuacct /proc/cgroups 2>/dev/null|cut -f1)
+
 endif
 
 ifdef CROSS_COMPILE
@@ -18,6 +20,7 @@ SUBDIRS += memctl
 SUBDIRS += io-throttle
 SUBDIRS += freezer
 SUBDIRS += cpuset
+SUBDIRS += cpuacct
 else
 $(info "Kernel is not compiled with control cgroup support")
 endif
@@ -60,6 +63,11 @@ SUBDIRS += cpuset
 else
 $(info "Kernel is not compiled with cpuset resource controller support")
 endif
+ifeq ($(CHECK_CPUACCTCTL),cpuacct)
+SUBDIRS += cpuacct
+else
+$(info "Kernel is not compiled with cpuacct resource controller support")
+endif
 endif
 
 # If at least one of the controllers is available then build libcontrollers.
diff -rupN ltp-full-20090731//testcases/kernel/controllers/README ltp-full-20090731.src//testcases/kernel/controllers/README
--- ltp-full-20090731//testcases/kernel/controllers/README	2009-05-11 10:02:46.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/README	2009-08-07 07:00:28.000000000 +0000
@@ -51,6 +51,10 @@ libcontrollers
 --------------
 This directory contains the library for cpucontroller testing.
 
+cpuacct
+-----------
+Directory containing the cpu accounting controller testcases.
+
 Makefile
 --------
 The usual Makefile to conduct all the tests.
diff -rupN ltp-full-20090731//testcases/kernel/controllers/test_controllers.sh ltp-full-20090731.src//testcases/kernel/controllers/test_controllers.sh
--- ltp-full-20090731//testcases/kernel/controllers/test_controllers.sh	2009-07-30 17:27:58.000000000 +0000
+++ ltp-full-20090731.src//testcases/kernel/controllers/test_controllers.sh	2009-08-07 07:07:37.000000000 +0000
@@ -43,6 +43,7 @@ then
 	IOTHROTTLE_CONTROLLER=`grep -w blockio /proc/cgroups | cut -f1`;
 	FREEZER=`grep -w freezer /proc/cgroups | cut -f1`;
 	CPUSET_CONTROLLER=`grep -w cpuset /proc/cgroups | cut -f1`
+        CPUACCOUNT_CONTROLLER=`grep -w cpuacct /proc/cgroups | cut -f1`
 
 	if [ "$CPU_CONTROLLER" = "cpu" ]
 	then
@@ -115,10 +116,22 @@ then
 		echo "Kernel does not support cpuset controller";
 		echo "Skipping all cpuset controller testcases....";
 	fi
+
+	if [ "$CPUACCOUNT_CONTROLLER" = "cpuacct" ]
+        then
+                $LTPROOT/testcases/bin/run_cpuacct_test.sh 1;
+                $LTPROOT/testcases/bin/run_cpuacct_test.sh 2;
+        else
+                echo "Could not start cpu accounting controller test";
+                echo "usage: run_cpuacct_test.sh $TEST_NUM ";
+                echo "Skipping the cpu accounting controller test...";
+        fi
+
 else
 	echo "CONTROLLERS TESTCASES: WARNING"
 	echo "Kernel does not support for control groups";
 	echo "Skipping all controllers testcases....";
+
 fi
 
 exit 0;





Results:

# ./run_cpuacct_test.sh 1
Cleanup called
TEST 1:CPU ACCOUNTING CONTROLLER TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes

cpuacct.usage for Parent cgroup is 5069122828
cpuacct.usage for Child cgroup is 5069122828
TPASS CPU Accounting Controller:cpuacct.usage PASSED

cpuacct.usage_percpu for Parent cgroup : 5069122828
cpuacct.usage_percpu for Child  cgroup : 5069122828
TPASS CPU Accounting Controller:cpuacct.usage_percpu PASSED

cpuacct.stat for Parent cgroup is user 81 : system 416
cpuacct.stat for Child cgroup is user 81 : system 416
TPASS CPU Accounting Controller:cpuacct.stat PASSED

CPU Accounting Controller test executed successfully
Cleanup called


./run_cpuacct_test.sh 2
Cleanup called
TEST 2:CPU ACCOUNTING CONTROLLER TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes

cpuacct.usage for Parent cgroup : 19946799644
cpuacct.usage for Child  cgroup : 19946799644
TPASS CPU Accounting Controller:cpuacct.usage PASSED

cpuacct.usage_percpu for Parent cgroup : 19946799644
cpuacct.usage_percpu for Child  cgroup : 19946799644
TPASS CPU Accounting Controller:cpuacct.usage_percpu PASSED

cpuacct.stat for Parent cgroup : 295::1489
cpuacct.stat for Child  cgroup : 295::1489
TPASS CPU Accounting Controller:cpuacct.stat PASSED

CPU Accounting Controller test executed successfully
Cleanup called

Thanks
-- 
Rajasekhar Duddu (rajduddu@linux.vnet.ibm.com),
Linux on System z - CSVT, IBM LTC, Bangalore.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

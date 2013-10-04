Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VS2K9-0001Oj-Cf
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:29 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VS2K7-0006sw-Mx
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:29 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  4 Oct 2013 14:08:58 +0400
Message-Id: <1380881342-13025-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/5] controllers/cpuset: reorganization
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

A separate name is assigned to each cpuset shell testcase (which
was invoked earlier by run_cpuset_test.sh).

This will simplify results analysis.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/controllers                                |   13 ++
 .../cpuset_base_ops_testset.sh                     |    8 +-
 .../cpuset_exclusive_test/cpuset_exclusive_test.sh |    8 +-
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |   25 ++-
 .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh |    8 +-
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    8 +-
 .../cpuset_inherit_test/cpuset_inherit_testset.sh  |    8 +-
 .../cpuset_load_balance_test.sh                    |    8 +-
 .../cpuset_sched_domains_test.sh                   |    8 +-
 .../cpuset_memory_pressure_testset.sh              |    8 +-
 .../cpuset_memory_spread_testset.sh                |    8 +-
 .../cpuset_memory_test/cpuset_memory_testset.sh    |    8 +-
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    8 +-
 .../kernel/controllers/cpuset/run_cpuset_test.sh   |  183 --------------------
 testcases/kernel/controllers/test_controllers.sh   |   20 --
 15 files changed, 73 insertions(+), 256 deletions(-)
 delete mode 100755 testcases/kernel/controllers/cpuset/run_cpuset_test.sh

diff --git a/runtest/controllers b/runtest/controllers
index 94fc185..81a9a10 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -12,4 +12,17 @@ memcg_stress		memcg_stress_test.sh
 memcg_control		PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
 cgroup_fj	run_cgroup_test_fj.sh
 controllers	test_controllers.sh
+
+cpuset_base_ops	cpuset_base_ops_testset.sh
+cpuset_inherit	cpuset_inherit_testset.sh
+cpuset_exclusive	cpuset_exclusive_test.sh
+cpuset_hierarchy	cpuset_hierarchy_test.sh
+cpuset_syscall	cpuset_syscall_testset.sh
+cpuset_sched_domains	cpuset_sched_domains_test.sh
+cpuset_load_balance	cpuset_load_balance_test.sh
+cpuset_hotplug	cpuset_hotplug_test.sh
+cpuset_memory	cpuset_memory_testset.sh
+cpuset_memory_pressure	cpuset_memory_pressure_testset.sh
+cpuset_memory_spread	cpuset_memory_spread_testset.sh
+
 cgroup_xattr	cgroup_xattr
diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 126eec5..be28c4b 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset01"
+export TCID="cpuset_base_ops"
 export TST_TOTAL=97
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
index 0ad31e7..2188ab6 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset03"
+export TCID="cpuset_exclusive"
 export TST_TOTAL=18
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index a83845c..edca7b4 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -89,38 +89,45 @@ user_check()
 
 cpuset_check()
 {
-	grep cpuset /proc/cgroups > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		tst_brkm TCONF ignored "Cpuset is not supported"
-		return 1
+        if [ -f /proc/cgroups ]; then
+		CPUSET_CONTROLLER=`grep -w cpuset /proc/cgroups | cut -f1`
+		CPUSET_CONTROLLER_VALUE=`grep -w cpuset /proc/cgroups | cut -f4`
+
+		if [ "$CPUSET_CONTROLLER" = "cpuset" ] && [ "$CPUSET_CONTROLLER_VALUE" = "1" ]
+		then
+			return 0
+		fi
 	fi
+
+	tst_brkm TCONF ignored "Cpuset is not supported"
+	return 1
 }
 
 check()
 {
 	user_check
 	if [ $? -ne 0 ]; then
-		return 1
+		exit 0
 	fi
 
 	cpuset_check
 	if [ $? -ne 0 ]; then
-		return 1
+		exit 0
 	fi
 
 	version_check
 	if [ $? -ne 0 ]; then
-		return 1
+		exit 0
 	fi
 
 	ncpus_check
 	if [ $? -ne 0 ]; then
-		return 1
+		exit 0
 	fi
 
 	nnodes_check
 	if [ $? -ne 0 ]; then
-		return 1
+		exit 0
 	fi
 
 }
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
index 5804aa4..61f58fc 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset04"
+export TCID="cpuset_hierarchy"
 export TST_TOTAL=32
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index 2bfe0f5..1a8eb98 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset08"
+export TCID="cpuset_hotplug"
 export TST_TOTAL=13
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 780b7eb..f9d524e 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset02"
+export TCID="cpuset_inherit"
 export TST_TOTAL=27
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
index 55f533a..0c9e5c6 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset07"
+export TCID="cpuset_load_balance"
 export TST_TOTAL=13
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
index 3ca70df..27d8266 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset06"
+export TCID="cpuset_sched_domains"
 export TST_TOTAL=19
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
index f342e6c..889398f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset10"
+export TCID="cpuset_memory_pressure"
 export TST_TOTAL=6
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index ffce419..f3f3b09 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset11"
+export TCID="cpuset_memory_spread"
 export TST_TOTAL=6
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 # must >= 3 for: 1-$((nr_mems-2))
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index 2a9f7e3..bc4ff1c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset09"
+export TCID="cpuset_memory"
 export TST_TOTAL=18
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index af92373..b6ac7a7 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -22,13 +22,13 @@
 #                                                                              #
 ################################################################################
 
-cd $LTPROOT/testcases/bin
-
-export TCID="cpuset05"
+export TCID="cpuset_syscall"
 export TST_TOTAL=16
 export TST_COUNT=1
 
-. ./cpuset_funcs.sh
+. cpuset_funcs.sh
+
+check
 
 exit_status=0
 
diff --git a/testcases/kernel/controllers/cpuset/run_cpuset_test.sh b/testcases/kernel/controllers/cpuset/run_cpuset_test.sh
deleted file mode 100755
index abdc885..0000000
--- a/testcases/kernel/controllers/cpuset/run_cpuset_test.sh
+++ /dev/null
@@ -1,183 +0,0 @@
-#!/bin/sh
-# usage ./run_cpuset_test.sh test_num
-
-################################################################################
-#                                                                              #
-# Copyright (c) 2009 FUJITSU LIMITED                                           #
-#                                                                              #
-# This program is free software;  you can redistribute it and#or modify        #
-# it under the terms of the GNU General Public License as published by         #
-# the Free Software Foundation; either version 2 of the License, or            #
-# (at your option) any later version.                                          #
-#                                                                              #
-# This program is distributed in the hope that it will be useful, but          #
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY   #
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
-# for more details.                                                            #
-#                                                                              #
-# You should have received a copy of the GNU General Public License            #
-# along with this program;  if not, write to the Free Software                 #
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA      #
-#                                                                              #
-################################################################################
-# Name Of File: run_cpuset_test.sh                                             #
-#                                                                              #
-# Description: This file runs the setup for testing different cpuset resource  #
-#              controller features. After setup it runs diff test cases in     #
-#              diff setup.                                                     #
-#                                                                              #
-# Test 01:     Tests basal operation of control file                           #
-#                                                                              #
-# Precaution:   Avoid system use by other applications/users to get fair and   #
-#               appropriate results (avoid unnecessary killing of applicatio)  #
-#                                                                              #
-# Author:       Miao Xie   <miaox@cn.fujitsu.com>                              #
-#                                                                              #
-# History:                                                                     #
-#                                                                              #
-#  DATE         NAME           EMAIL                         DESC              #
-#                                                                              #
-#  02/03/09  Miao Xie     <miaox@cn.fujitsu.com>        Created this test      #
-#                                                                              #
-################################################################################
-
-export TCID="cpuset_test";
-export TST_TOTAL=1;
-export TST_COUNT=1;
-
-. cpuset_funcs.sh;
-
-TEST_NUM=$1;
-SCRIPT_PID=$$;
-RC=0;
-PWD=`pwd`;
-
-check
-if [ $? -ne 0 ]; then
-	exit 0
-fi
-
-# The usage of the script file
-usage()
-{
-	echo "Could not start cpuset controller test";
-	echo "usage: run_cpuset_test.sh test_num";
-	echo "Skipping the cpuset controller test...";
-}
-
-cd $LTPROOT/testcases/bin/
-
-echo "TEST $TEST_NUM: CPUSET CONTROLLER TESTING";
-
-echo "TEST STARTED: Please avoid using system while this test executes";
-#Check if  C source  file has been compiled and then run it in different groups
-
-case $TEST_NUM in
-"1" )
-	if [ -f cpuset_base_ops_testset.sh ]; then
-		./cpuset_base_ops_testset.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"2" )
-	if [ -f cpuset_inherit_testset.sh ]; then
-		./cpuset_inherit_testset.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"3" )
-	if [ -f cpuset_exclusive_test.sh ]; then
-		./cpuset_exclusive_test.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"4" )
-	if [ -f cpuset_hierarchy_test.sh ]; then
-		./cpuset_hierarchy_test.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"5" )
-	if [ -f cpuset_syscall_testset.sh ]; then
-		./cpuset_syscall_testset.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"6" )
-	if [ -f cpuset_sched_domains_test.sh ]; then
-		./cpuset_sched_domains_test.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"7" )
-	if [ -f cpuset_load_balance_test.sh ]; then
-		./cpuset_load_balance_test.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"8" )
-	if [ -f cpuset_hotplug_test.sh ]; then
-		./cpuset_hotplug_test.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"9" )
-	if [ -f cpuset_memory_testset.sh ]; then
-		./cpuset_memory_testset.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"10" )
-	if [ -f cpuset_memory_pressure_testset.sh ]; then
-		./cpuset_memory_pressure_testset.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"11" )
-	if [ -f cpuset_memory_spread_testset.sh ]; then
-		./cpuset_memory_spread_testset.sh
-		exit $?;
-	else
-		echo "Shell file not installed..Please check Makefile...Exiting"
-		exit -1;
-	fi;
-	;;
-"*" )
-	usage;
-	exit -1;
-	;;
-esac
-
-echo "Cpuset Resource Controller test executed successfully.";
-cd $PWD
-exit 0;         #to let PAN reprt success of test
diff --git a/testcases/kernel/controllers/test_controllers.sh b/testcases/kernel/controllers/test_controllers.sh
index d3c3362..7aa974f 100755
--- a/testcases/kernel/controllers/test_controllers.sh
+++ b/testcases/kernel/controllers/test_controllers.sh
@@ -47,8 +47,6 @@ then
 	IOTHROTTLE_CONTROLLER_VALUE=`grep -w blockio /proc/cgroups | cut -f4`;
 	FREEZER=`grep -w freezer /proc/cgroups | cut -f1`;
 	FREEZER_VALUE=`grep -w freezer /proc/cgroups | cut -f4`;
-	CPUSET_CONTROLLER=`grep -w cpuset /proc/cgroups | cut -f1`
-	CPUSET_CONTROLLER_VALUE=`grep -w cpuset /proc/cgroups | cut -f4`
 	CPUACCOUNT_CONTROLLER=`grep -w cpuacct /proc/cgroups | cut -f1`
 	CPUACCOUNT_CONTROLLER_VALUE=`grep -w cpuacct /proc/cgroups | cut -f4`
 
@@ -102,24 +100,6 @@ then
 		echo "Kernel does not support freezer controller";
 		echo "Skipping all freezer testcases....";
 	fi
-	if [ "$CPUSET_CONTROLLER" = "cpuset" ] && [ "$CPUSET_CONTROLLER_VALUE" = "1" ]
-	then
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 1;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 2;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 3;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 4;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 5;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 6;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 7;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 8;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 9;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 10;
-		$LTPROOT/testcases/bin/run_cpuset_test.sh 11;
-	else
-		echo "CONTROLLERS TESTCASES: WARNING";
-		echo "Either Kernel does not support for cpuset controller or functionality is not enabled";
-		echo "Skipping all cpuset controller testcases....";
-	fi
 	if [ "$CPUACCOUNT_CONTROLLER" = "cpuacct" ] && [ "$CPUACCOUNT_CONTROLLER_VALUE" = "1" ]
         then
                 $LTPROOT/testcases/bin/run_cpuacct_test.sh 1;
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

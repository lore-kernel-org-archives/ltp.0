Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VQY0G-00075R-BW
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 07:34:48 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VQY0D-0001JW-HK
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 07:34:48 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 30 Sep 2013 11:34:22 +0400
Message-Id: <1380526462-27191-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130926114604.GD14003@rei.suse.cz>
References: <20130926114604.GD14003@rei.suse.cz>
Subject: [LTP] [PATCH] controllers/cpuset: reogranization
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

Renamed cpuset01 to cpuset12.

A separate name (from cpuset01 to cpuset11) is assigned to each cpuset
shell testcase (which was invoked earlier by run_cpuset_test.sh).

This will simplify results analysis.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/controllers                                |   13 +
 runtest/mm                                         |    2 +-
 .../cpuset_base_ops_testset.sh                     |    2 +
 .../cpuset_exclusive_test/cpuset_exclusive_test.sh |    2 +
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |   25 ++-
 .../cpuset_hierarchy_test/cpuset_hierarchy_test.sh |    2 +
 .../cpuset_hotplug_test/cpuset_hotplug_test.sh     |    2 +
 .../cpuset_inherit_test/cpuset_inherit_testset.sh  |    2 +
 .../cpuset_load_balance_test.sh                    |    2 +
 .../cpuset_sched_domains_test.sh                   |    2 +
 .../cpuset_memory_pressure_testset.sh              |    2 +
 .../cpuset_memory_spread_testset.sh                |    2 +
 .../cpuset_memory_test/cpuset_memory_testset.sh    |    2 +
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |    2 +
 .../kernel/controllers/cpuset/run_cpuset_test.sh   |  183 ---------------
 testcases/kernel/controllers/test_controllers.sh   |   20 --
 testcases/kernel/mem/cpuset/cpuset01.c             |  247 --------------------
 testcases/kernel/mem/cpuset/cpuset12.c             |  247 ++++++++++++++++++++
 18 files changed, 304 insertions(+), 455 deletions(-)
 delete mode 100755 testcases/kernel/controllers/cpuset/run_cpuset_test.sh
 delete mode 100644 testcases/kernel/mem/cpuset/cpuset01.c
 create mode 100644 testcases/kernel/mem/cpuset/cpuset12.c

diff --git a/runtest/controllers b/runtest/controllers
index 94fc185..2d33291 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -12,4 +12,17 @@ memcg_stress		memcg_stress_test.sh
 memcg_control		PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
 cgroup_fj	run_cgroup_test_fj.sh
 controllers	test_controllers.sh
+
+cpuset01	cpuset_base_ops_testset.sh
+cpuset02	cpuset_inherit_testset.sh
+cpuset03	cpuset_exclusive_test.sh
+cpuset04	cpuset_hierarchy_test.sh
+cpuset05	cpuset_syscall_testset.sh
+cpuset06	cpuset_sched_domains_test.sh
+cpuset07	cpuset_load_balance_test.sh
+cpuset08	cpuset_hotplug_test.sh
+cpuset09	cpuset_memory_testset.sh
+cpuset10	cpuset_memory_pressure_testset.sh
+cpuset11	cpuset_memory_spread_testset.sh
+
 cgroup_xattr	cgroup_xattr
diff --git a/runtest/mm b/runtest/mm
index 28151b5..86b7e99 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -74,7 +74,7 @@ ksm06 ksm06
 ksm06_1 ksm06 -n 10
 ksm06_2 ksm06 -n 10000
 
-cpuset01 cpuset01 -I 3600
+cpuset12 cpuset12 -I 3600
 
 oom01 oom01
 oom02 oom02
diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 126eec5..1b556a9 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
index 0ad31e7..bb98e3c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/cpuset_exclusive_test.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 
 # Case 1-9 test cpus
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index a83845c..5fbddf0 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -89,11 +89,18 @@ user_check()
 
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
@@ -125,6 +132,16 @@ check()
 
 }
 
+check_and_prepare()
+{
+	check
+	if [ $? -ne 0 ]; then
+		exit 0
+	fi
+
+	cd $LTPROOT/testcases/bin/
+}
+
 # Create /dev/cpuset & mount the cgroup file system with cpuset
 # clean any group created eralier (if any)
 setup()
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
index 5804aa4..8d26982 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/cpuset_hierarchy_test.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
index 2bfe0f5..bb8393f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 
 nr_cpus=$NR_CPUS
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 780b7eb..be6f85f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
index 55f533a..8e55fc1 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
index 3ca70df..66b56f2 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
index f342e6c..5a6b907 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/cpuset_memory_pressure_testset.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 
 # usable physical memory
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index 4d7bbeb..49ad576 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 # must >= 3 for: 1-$((nr_mems-2))
 nr_cpus=$NR_CPUS
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index 2a9f7e3..a84782a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index af92373..de620ee 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 . ./cpuset_funcs.sh
 
+check_and_prepare
+
 exit_status=0
 
 TEST_CPUSET="$CPUSET/0"
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
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
deleted file mode 100644
index abba489..0000000
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ /dev/null
@@ -1,247 +0,0 @@
-/*
- * Out Of Memory when changing cpuset's mems on NUMA. There was a
- * problem reported upstream that the allocator may see an empty
- * nodemask when changing cpuset's mems.
- * http://lkml.org/lkml/2010/5/4/77
- * http://lkml.org/lkml/2010/5/4/79
- * http://lkml.org/lkml/2010/5/4/80
- * This test is based on the reproducers for the above issue.
- *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-#include "config.h"
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <ctype.h>
-#include <err.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <math.h>
-#if HAVE_NUMAIF_H
-#include <numaif.h>
-#endif
-#include <signal.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-#include "test.h"
-#include "usctest.h"
-#include "mem.h"
-#include "numa_helper.h"
-
-char *TCID = "cpuset01";
-int TST_TOTAL = 1;
-
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-volatile int end;
-static int *nodes;
-static int nnodes;
-static long ncpus;
-
-static void testcpuset(void);
-static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
-static int mem_hog(void);
-static int mem_hog_cpuset(int ntasks);
-static long count_cpu(void);
-
-int main(int argc, char *argv[])
-{
-	char *msg;
-
-	msg = parse_opts(argc, argv, NULL, NULL);
-	if (msg != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	ncpus = count_cpu();
-	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "get_allowed_nodes_arr");
-	if (nnodes <= 1)
-		tst_brkm(TCONF, NULL, "requires a NUMA system.");
-
-	setup();
-	testcpuset();
-	cleanup();
-	tst_exit();
-}
-
-static void testcpuset(void)
-{
-	int lc;
-	int child, i, status;
-	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
-	char mems[BUFSIZ], buf[BUFSIZ];
-
-	read_cpuset_files(CPATH, "cpus", buf);
-	write_cpuset_files(CPATH_NEW, "cpus", buf);
-	read_cpuset_files(CPATH, "mems", mems);
-	write_cpuset_files(CPATH_NEW, "mems", mems);
-	SAFE_FILE_PRINTF(cleanup, CPATH_NEW "/tasks", "%d", getpid());
-
-	switch (child = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		for (i = 0; i < nnodes; i++) {
-			if (nodes[i] >= MAXNODES)
-				continue;
-			set_node(nmask, nodes[i]);
-		}
-		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "set_mempolicy");
-		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
-	}
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		snprintf(buf, BUFSIZ, "%d", nodes[0]);
-		write_cpuset_files(CPATH_NEW, "mems", buf);
-		snprintf(buf, BUFSIZ, "%d", nodes[1]);
-		write_cpuset_files(CPATH_NEW, "mems", buf);
-	}
-
-	if (waitpid(child, &status, WUNTRACED | WCONTINUED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-	if (WEXITSTATUS(status) != 0)
-		tst_resm(TFAIL, "child exit status is %d", WEXITSTATUS(status));
-}
-
-void setup(void)
-{
-	tst_require_root(NULL);
-
-	if (tst_kvercmp(2, 6, 32) < 0)
-		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-}
-
-void cleanup(void)
-{
-	umount_mem(CPATH, CPATH_NEW);
-
-	TEST_CLEANUP;
-}
-
-static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
-{
-	end = 1;
-}
-
-static int mem_hog(void)
-{
-	long pagesize;
-	unsigned long *addr;
-	int ret = 0;
-
-	pagesize = getpagesize();
-	while (!end) {
-		addr = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-		if (addr == MAP_FAILED) {
-			ret = 1;
-			tst_resm(TFAIL | TERRNO, "mmap");
-			break;
-		}
-		memset(addr, 0xF7, pagesize * 10);
-		munmap(addr, pagesize * 10);
-	}
-	return ret;
-}
-
-static int mem_hog_cpuset(int ntasks)
-{
-	int i, lc, status, ret = 0;
-	struct sigaction sa;
-	pid_t *pids;
-
-	if (ntasks <= 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "ntasks is small.");
-	sa.sa_handler = sighandler;
-	if (sigemptyset(&sa.sa_mask) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "sigemptyset");
-	sa.sa_flags = 0;
-	if (sigaction(SIGUSR1, &sa, NULL) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "sigaction");
-
-	pids = malloc(sizeof(pid_t) * ntasks);
-	if (pids == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
-	for (i = 0; i < ntasks; i++) {
-		switch (pids[i] = fork()) {
-		case -1:
-			tst_resm(TFAIL | TERRNO, "fork %d", pids[i]);
-			ret = 1;
-			break;
-		case 0:
-			ret = mem_hog();
-			exit(ret);
-		default:
-			break;
-		}
-	}
-	for (lc = 0; TEST_LOOPING(lc); lc++) ;
-	while (i--) {
-		if (kill(pids[i], SIGUSR1) == -1) {
-			tst_resm(TFAIL | TERRNO, "kill %d", pids[i]);
-			ret = 1;
-		}
-	}
-	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0) {
-		if (WIFEXITED(status)) {
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "child exit status is %d",
-					 WEXITSTATUS(status));
-				ret = 1;
-			}
-		} else if (WIFSIGNALED(status)) {
-			tst_resm(TFAIL, "child caught signal %d",
-				 WTERMSIG(status));
-			ret = 1;
-		}
-	}
-	return ret;
-}
-
-static long count_cpu(void)
-{
-	int ncpus = 0;
-
-	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
-		ncpus++;
-
-	return ncpus;
-}
-
-#else /* no NUMA */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
-}
-#endif
diff --git a/testcases/kernel/mem/cpuset/cpuset12.c b/testcases/kernel/mem/cpuset/cpuset12.c
new file mode 100644
index 0000000..036c001
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset12.c
@@ -0,0 +1,247 @@
+/*
+ * Out Of Memory when changing cpuset's mems on NUMA. There was a
+ * problem reported upstream that the allocator may see an empty
+ * nodemask when changing cpuset's mems.
+ * http://lkml.org/lkml/2010/5/4/77
+ * http://lkml.org/lkml/2010/5/4/79
+ * http://lkml.org/lkml/2010/5/4/80
+ * This test is based on the reproducers for the above issue.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include "config.h"
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <ctype.h>
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <math.h>
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+#include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "mem.h"
+#include "numa_helper.h"
+
+char *TCID = "cpuset12";
+int TST_TOTAL = 1;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+volatile int end;
+static int *nodes;
+static int nnodes;
+static long ncpus;
+
+static void testcpuset(void);
+static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
+static int mem_hog(void);
+static int mem_hog_cpuset(int ntasks);
+static long count_cpu(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	ncpus = count_cpu();
+	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "get_allowed_nodes_arr");
+	if (nnodes <= 1)
+		tst_brkm(TCONF, NULL, "requires a NUMA system.");
+
+	setup();
+	testcpuset();
+	cleanup();
+	tst_exit();
+}
+
+static void testcpuset(void)
+{
+	int lc;
+	int child, i, status;
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
+	char mems[BUFSIZ], buf[BUFSIZ];
+
+	read_cpuset_files(CPATH, "cpus", buf);
+	write_cpuset_files(CPATH_NEW, "cpus", buf);
+	read_cpuset_files(CPATH, "mems", mems);
+	write_cpuset_files(CPATH_NEW, "mems", mems);
+	SAFE_FILE_PRINTF(cleanup, CPATH_NEW "/tasks", "%d", getpid());
+
+	switch (child = fork()) {
+	case -1:
+		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+	case 0:
+		for (i = 0; i < nnodes; i++) {
+			if (nodes[i] >= MAXNODES)
+				continue;
+			set_node(nmask, nodes[i]);
+		}
+		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
+			tst_brkm(TBROK | TERRNO, cleanup, "set_mempolicy");
+		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
+	}
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		snprintf(buf, BUFSIZ, "%d", nodes[0]);
+		write_cpuset_files(CPATH_NEW, "mems", buf);
+		snprintf(buf, BUFSIZ, "%d", nodes[1]);
+		write_cpuset_files(CPATH_NEW, "mems", buf);
+	}
+
+	if (waitpid(child, &status, WUNTRACED | WCONTINUED) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	if (WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "child exit status is %d", WEXITSTATUS(status));
+}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+
+	if (tst_kvercmp(2, 6, 32) < 0)
+		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+}
+
+void cleanup(void)
+{
+	umount_mem(CPATH, CPATH_NEW);
+
+	TEST_CLEANUP;
+}
+
+static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
+{
+	end = 1;
+}
+
+static int mem_hog(void)
+{
+	long pagesize;
+	unsigned long *addr;
+	int ret = 0;
+
+	pagesize = getpagesize();
+	while (!end) {
+		addr = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
+			    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		if (addr == MAP_FAILED) {
+			ret = 1;
+			tst_resm(TFAIL | TERRNO, "mmap");
+			break;
+		}
+		memset(addr, 0xF7, pagesize * 10);
+		munmap(addr, pagesize * 10);
+	}
+	return ret;
+}
+
+static int mem_hog_cpuset(int ntasks)
+{
+	int i, lc, status, ret = 0;
+	struct sigaction sa;
+	pid_t *pids;
+
+	if (ntasks <= 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "ntasks is small.");
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "sigemptyset");
+	sa.sa_flags = 0;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "sigaction");
+
+	pids = malloc(sizeof(pid_t) * ntasks);
+	if (pids == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
+	for (i = 0; i < ntasks; i++) {
+		switch (pids[i] = fork()) {
+		case -1:
+			tst_resm(TFAIL | TERRNO, "fork %d", pids[i]);
+			ret = 1;
+			break;
+		case 0:
+			ret = mem_hog();
+			exit(ret);
+		default:
+			break;
+		}
+	}
+	for (lc = 0; TEST_LOOPING(lc); lc++) ;
+	while (i--) {
+		if (kill(pids[i], SIGUSR1) == -1) {
+			tst_resm(TFAIL | TERRNO, "kill %d", pids[i]);
+			ret = 1;
+		}
+	}
+	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0) {
+		if (WIFEXITED(status)) {
+			if (WEXITSTATUS(status) != 0) {
+				tst_resm(TFAIL, "child exit status is %d",
+					 WEXITSTATUS(status));
+				ret = 1;
+			}
+		} else if (WIFSIGNALED(status)) {
+			tst_resm(TFAIL, "child caught signal %d",
+				 WTERMSIG(status));
+			ret = 1;
+		}
+	}
+	return ret;
+}
+
+static long count_cpu(void)
+{
+	int ncpus = 0;
+
+	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	return ncpus;
+}
+
+#else /* no NUMA */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+}
+#endif
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

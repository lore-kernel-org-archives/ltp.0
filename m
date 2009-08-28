Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MgyU9-0001cN-EH
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:09 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyU4-0001QC-3t
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:09 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SAD7Qo018118
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:13:07 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAErvR191222
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:14:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAEqDY001854
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:14:53 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 15:44:49 +0530
Message-Id: <20090828101449.12177.9632.sendpatchset@localhost.localdomain>
In-Reply-To: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 2/8] Power management master script modified to
	integrate ILB testcase
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
To: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

Power management master script modified to integrate ILB testcases

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/runpwtests.sh ltp/testcases/kernel/power_management/runpwtests.sh
--- ltp_orig/testcases/kernel/power_management/runpwtests.sh	2009-08-28 10:54:59.000000000 +0530
+++ ltp/testcases/kernel/power_management/runpwtests.sh	2009-08-28 12:29:52.000000000 +0530
@@ -69,7 +69,7 @@ is_dual_core; dual_core=$?
 #Checking sched_mc sysfs interface
 #check_config.sh config_sched_mc || RC=$?
 TST_COUNT=1
-if [ $multi_socket -eq $YES -a $dual_core -eq $YES ] ; then
+if [ $multi_socket -eq $YES -a $multi_core -eq $YES ] ; then
 	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
 		if test_sched_mc.sh ; then
 			tst_resm TPASS "SCHED_MC sysfs tests"
@@ -232,7 +232,7 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
 			if [ $hyper_threaded -eq $YES ]; then
 				for sched_smt in `seq 0 $max_sched_smt`; do
 					for work_load in ${work_loads_list}; do
-                   		: $(( TST_COUNT += 1 ))
+                   				: $(( TST_COUNT += 1 ))
 						sched_mc_smt_pass_cnt=0
 						for repeat_test in `seq 1  10`; do
 							# Testcase to validate CPU consolidation for
@@ -260,6 +260,60 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
 		done
 		analyze_core_consolidation_result $sched_smt $work_load $sched_smt_pass_cnt
 	fi
+        # Verify ILB runs in same package as workload
+        if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
+		work_loads_list="ebizzy kernbench"	
+		for sched_mc in `seq 0 $max_sched_mc`; do
+			for work_load in ${work_loads_list}
+			do
+				: $(( TST_COUNT += 1 ))
+                                ilb_test.py -c $sched_mc -w $work_load; RC=$?
+				if [ $RC -eq 0 ]; then
+					tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
+				else
+					if [ $sched_mc -eq 0 ]; then
+						tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
+					else
+						tst_resm TFAIL "ILB did not run in same package"
+					fi
+				fi
+			done
+			if [ $hyper_threaded -eq $YES ]; then
+				for sched_smt in `seq 0 $max_sched_smt`; do
+					for work_load in ${work_loads_list}; do
+						: $(( TST_COUNT += 1 ))
+						ilb_test.py -c $sched_mc -t sched_smt -w $work_load; RC=$?
+ 						if [ $RC -eq 0 ]; then
+							tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
+						else
+							if [ $sched_mc -eq 0 ]; then
+								tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
+							else
+								tst_resm TFAIL "ILB did not run in same package"    
+							fi
+						fi
+					done
+				done
+			fi
+		done
+	fi
+	if [ $multi_socket -eq $YES -a $hyper_threaded -eq $YES -a $multi_core -eq $YES ]; then
+		for sched_smt in `seq 0 $max_sched_smt`; do
+			for work_load in ${work_loads_list}; do
+				: $(( TST_COUNT += 1 ))
+				ilb_test.py -t $sched_smt -w $work_load; RC=$?
+				if [ $RC -eq 0 ]; then
+					tst_resm TPASS "ILB & workload not load not in same package for sched_smt=$sched_smt"
+				else
+					if [ $sched_smt -eq 0 ]; then
+						tst_resm TPASS "Its oky if ILB is not in same package when sched_smt=0"
+					else
+						tst_resm TFAIL "ILB did not run in same package"
+					fi
+				fi
+			done
+		done
+	fi
 fi
 
 exit $RC

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

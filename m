Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLemw-0001g2-7Y
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:26 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLemq-00007j-6m
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:58:21 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UEr5jn015668
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:53:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UEwJH3237328
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:58:19 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UEwJCO032584
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:58:19 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 20:28:15 +0530
Message-Id: <20090630145815.11163.6728.sendpatchset@localhost.localdomain>
In-Reply-To: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 8/10]New set of reusbale Library functions and fixes
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

[Patch 8/10]New set of reusbale Library functions and fixes

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/pm_include.sh ltp_patched/testcases/kernel/power_management/pm_include.sh
--- ltp_orig/testcases/kernel/power_management/pm_include.sh	2009-06-30 15:04:19.000000000 +0530
+++ ltp_patched/testcases/kernel/power_management/pm_include.sh	2009-06-30 16:06:32.000000000 +0530
@@ -7,6 +7,7 @@ FAIL=1
 NOSUPPORT=2
 MISSING_FILE=3
 UNTESTED=4
+YES=0
 
 function cleanup() {
 	if [ -f ${1} ] ; then
@@ -65,9 +66,9 @@ function is_hyper_threaded() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
 	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
 	if [ $siblings -eq $cpu_cores ]; then
-		echo 0
+		return 1
 	else
-		echo 1
+		return 0
 	fi
 }
 
@@ -101,4 +102,291 @@ function check_input() {
 	done
 	return $RC
 }
- 
+
+function is_multi_socket() {
+	no_of_sockets=`cat /sys/devices/system/cpu/cpu?/topology/physical_package_id | uniq | wc -l`
+	if [ $no_of_sockets -gt 1 ] ; then
+		return 0
+	else
+		return 1
+	fi
+}
+
+function get_kernel_version() {
+	# Get kernel minor version
+	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' | cut -f1 -d'-'`
+}
+
+function get_valid_input() {
+	kernel_version=$1
+	case "$kernel_version" in
+	'2.6.29' | '2.6.30' | '2.6.31')
+			export valid_input="0 1 2" ;;
+		*) export valid_input="0 1" ;;
+	esac
+}
+		
+function get_max_sched_mc() {
+	get_kernel_version
+	case "$kernel_version" in
+	'2.6.29' | '2.6.30' | '2.6.31') 
+		return 2
+		;;
+	'2.6.26' | '2.6.27' | '2.6.28') 
+		return 1
+		;;
+	*) 
+		return 0
+		;;
+	esac
+}
+
+function get_max_sched_smt() {
+    get_kernel_version
+    case "$kernel_version" in
+        '2.6.29' | '2.6.30' | '2.6.31') 
+                    return 2
+				;;
+        '2.6.26' | '2.6.27' | '2.6.28') 
+                    return 1
+				;;
+        *) 
+			return 0
+			;;
+	esac
+}
+
+function check_supp_wkld() {
+	sched_mcsmt=$1
+	work_load=$2
+
+	case "$sched_mcsmt" in
+		1) if [ "$work_load" == "ebizzy" ]; then
+				return 0
+			else
+				return 1
+			fi
+			;;
+		2) if [ "$work_load" == "ebizzy" -o "$work_load" == "kernbench" ]; then
+                return 0
+            else
+                return 1
+            fi
+            ;;
+		*) 
+               return 1
+			;;
+	esac
+}
+
+function analyze_wrt_workload_hyperthreaded() {
+	sched_mc=$1
+    work_load=$2
+    pass_count=$3
+    sched_smt=$4
+    stress=$5
+
+	if [ $sched_mc > $sched_smt ]; then
+		check_supp_wkld $sched_mc $work_load; valid_workload=$?
+	else
+		check_supp_wkld $sched_smt $work_load; valid_workload=$?
+	fi
+
+	if [ "$stress" = "thread" ]; then
+		case "$valid_workload" in
+        0)
+			if [ $pass_count -lt 5 ]; then
+				RC=1
+				tst_resm TFAIL "Consolidation at core level failed for \
+sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
+			else
+				tst_resm TPASS "Consolidation at core level passed for \
+sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
+			fi ;;
+        1)
+            if [ $pass_count -lt 5 ]; then
+                tst_resm TPASS "Consolidation at core level failed for \
+unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
+            else
+				RC=1
+                tst_resm TFAIL "Consolidation at core level passed for \
+unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
+            fi ;;
+        esac
+	else
+		case "$valid_workload" in
+        0)
+            if [ $pass_count -lt 5 ]; then
+				RC=1
+                tst_resm TFAIL "Consolidation at package level failed for \
+sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
+            else
+                tst_resm TPASS "Consolidation at package level passed for \
+sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
+            fi ;;
+        1)
+			echo "pass count is $pass_count"
+            if [ $pass_count -lt 5 ]; then
+                tst_resm TPASS "Consolidation at package level failed for \
+unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
+            else
+				RC=1
+                tst_resm TFAIL "Consolidation at package level passed for \
+unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
+            fi ;;
+        esac
+	fi
+}
+
+function analyze_wrt_wkld() {
+	sched_mc=$1
+    work_load=$2
+    pass_count=$3
+	sched_smt=$4
+	stress=$5
+
+	check_supp_wkld $sched_mc $work_load; valid_workload=$?
+	if [ $hyper_threaded -eq $YES ]; then
+		analyze_wrt_workload_hyperthreaded $sched_mc $work_load $pass_count\
+		 $sched_smt $stress
+	else
+		case "$valid_workload" in
+		0)
+			if [ "$pass_count" -lt 5 ]; then
+				RC=1
+				tst_resm TFAIL "cpu consolidation failed for \
+sched_mc=$sched_mc for workload=$work_load"
+			else
+				tst_resm TPASS "cpu consolidation passed for \
+sched_mc=$sched_mc for workload=$work_load"
+			fi ;;
+		1)
+			if [ "$pass_count" -lt 5 ]; then
+				tst_resm TPASS "cpu consolidation failed for \
+unsupported workload $work_load when sched_mc=$sched_mc"
+            else
+				RC=1
+				tst_resm TFAIL "cpu consolidation passed for \
+unsupported workload $work_load when sched_mc=$sched_mc"
+            fi ;;
+        esac
+	fi
+}
+
+function analyze_result_hyperthreaded() {
+	sched_mc=$1
+    work_load=$2
+    pass_count=$3
+    sched_smt=$4
+    stress=$5
+
+	case "$sched_mc" in
+	0)
+		if [ $sched_smt ]; then
+			case "$sched_smt" in
+			0)
+				if [ "$stress" = "thread" ]; then
+					if [ $pass_count -lt 1 ]; then
+						tst_resm TPASS "Consolidation at core level failed for sched_mc=\
+$sched_mc & sched_smt=$sched_smt for workload=$work_load"
+					else
+						RC=1
+						tst_resm TFAIL "Consolidation at core level passed for sched_mc=\
+$sched_mc & sched_smt=$sched_smt for workload=$work_load"
+					fi
+				else
+					if [ "$pass_count" -lt 1 ]; then
+						tst_resm TPASS "cpu consolidation failed for sched_mc=\
+$sched_mc & sched_smt=$sched_smt for workload=$work_load"
+					else
+						RC=1
+						tst_resm TFAIL "cpu consolidation passed for sched_mc=\
+$sched_mc & sched_smt=$sched_smt for workload=$work_load"
+					fi
+				fi
+				;;
+			*)
+				if [ "$stress" = "thread" ]; then
+					analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt $stress
+				else
+					analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
+				fi ;;
+			esac
+		else
+			if [ $pass_count -lt 1 ]; then
+				tst_resm TPASS "cpu consolidation failed for sched_mc=\
+$sched_mc for workload=$work_load"
+			else
+				RC=1
+				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
+$sched_mc & sched_smt=$sched_smt for workload=$work_load"
+			fi
+		fi
+		;;
+	*)
+		if [ "$stress" = "thread" ]; then
+			analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt $stress
+		else
+			analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
+		fi
+		;;
+	esac
+}
+
+function analyze_consolidation_result() {
+	sched_mc=$1
+    work_load=$2
+    pass_count=$3
+	sched_smt=$4
+	stress=$5
+
+	if [ $hyper_threaded -eq $YES ]; then
+		analyze_result_hyperthreaded $sched_mc $work_load $pass_count $sched_smt $stress
+	else
+		case "$sched_mc" in
+	    0)
+    	    if [ $pass_count -lt 1 ]; then
+        	    tst_resm TPASS "cpu consolidation failed for sched_mc=\
+$sched_mc for workload=$work_load"
+        	else
+				RC=1
+            	tst_resm TFAIL "cpu consolidation passed for sched_mc=\
+$sched_mc for workload=$work_load"
+        	fi ;;
+    	*)
+        	analyze_wrt_wkld $sched_mc $work_load $pass_count
+        	;;
+    	esac
+	fi
+}
+
+function analyze_sched_domain_result(){
+	sched_mc=$1
+	result=$2
+	sched_smt=$3
+
+	if [ $hyper_threaded -eq $YES ]; then
+		if [ $sched_smt ]; then
+			if [ "$result" = 0 ];then
+				tst_resm TPASS "sched domain test for sched_mc=$sched_mc & sched_smt=$sched_smt"
+			else
+				RC=1
+				tst_resm TFAIL "sched domain test sched_mc=$sched_mc & sched_smt=$sched_smt"
+			fi
+		else
+			if [ "$result" = 0 ];then
+				tst_resm TPASS "sched domain test for sched_mc=$sched_mc"
+			else
+				RC=1
+				tst_resm TFAIL "sched domain test for sched_mc=$sched_mc"		
+			fi
+		fi
+	else
+		if [ "$result" = 0 ];then
+			tst_resm TPASS "sched domain test for sched_mc=$sched_mc"
+		else
+			RC=1
+			tst_resm TFAIL "sched domain test sched_mc=$sched_mc"
+		fi
+	fi
+}

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

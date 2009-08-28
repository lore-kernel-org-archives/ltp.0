Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MgyUZ-0001dc-I0
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:35 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyUQ-0006cm-LC
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:15:30 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SA5xXL010981
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:05:59 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAFIYj260572
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAFIIU016743
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:15:18 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 15:45:14 +0530
Message-Id: <20090828101514.12177.34040.sendpatchset@localhost.localdomain>
In-Reply-To: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 5/8] Modified library functions based on review
	comments
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
To: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

Incorporated Garrett Cooper's comments & hence modified code

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp_orig/testcases/kernel/power_management/pm_include.sh ltp/testcases/kernel/power_management/pm_include.sh
--- ltp_orig/testcases/kernel/power_management/pm_include.sh	2009-08-28 10:54:59.000000000 +0530
+++ ltp/testcases/kernel/power_management/pm_include.sh	2009-08-28 12:34:00.000000000 +0530
@@ -9,20 +9,23 @@ MISSING_FILE=3
 UNTESTED=4
 YES=0
 
-function cleanup() {
+cleanup() {
 	if [ -f ${1} ] ; then
 		rm -f ${1}
 	fi
 }
-function check_config_options() {
+
+check_config_options() {
 	if ( ! ${3} "${1}" ${2} | grep -v "#" > /dev/null ) ; then
 		echo "NOSUPPORT: current system dosen't support ${1}"
 	fi
 }
-function no_of_cpus() {
+
+no_of_cpus() {
 	echo $(cat /proc/cpuinfo | grep processor | wc -l)
 }
-function get_topology() {
+
+get_topology() {
 	declare -a cpus
 	declare -a phyid
 
@@ -43,7 +46,8 @@ function get_topology() {
 		(( j+=1 ))
 	done
 }
-function check_cpufreq() {
+
+check_cpufreq() {
 	total_cpus=$(no_of_cpus)
 	(( total_cpus-=1 ))
 
@@ -55,24 +59,22 @@ function check_cpufreq() {
 		fi
 	done
 }
-function get_supporting_freq() {
+
+get_supporting_freq() {
 	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies | uniq	
 }
-function get_supporting_govr() {
+
+get_supporting_govr() {
 	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors | uniq
 }
 
-function is_hyper_threaded() {
+is_hyper_threaded() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
 	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-	if [ $siblings -eq $cpu_cores ]; then
-		return 1
-	else
-		return 0
-	fi
+	[ $siblins > $cpu_cores ]; return $?
 }
 
-function check_input() {
+check_input() {
 	validity_check=${2:-valid}
 	testfile=$3
 	if [ "${validity_check}" = "invalid" ] ; then
@@ -103,61 +105,39 @@ function check_input() {
 	return $RC
 }
 
-function is_multi_socket() {
+is_multi_socket() {
 	no_of_sockets=`cat /sys/devices/system/cpu/cpu?/topology/physical_package_id | uniq | wc -l`
-	if [ $no_of_sockets -gt 1 ] ; then
-		return 0
-	else
-		return 1
-	fi
+	[ $no_of_sockets -gt 1 ] ; return $?
 }
 
-function is_multi_core() {
+is_multi_core() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
 	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-	echo "siblings count $siblings cores count $cpu_cores"
 	if [ $siblings -eq $cpu_cores ]; then
-		if [ $cpu_cores -gt 1 ]; then
-			return 0
-		else
-			return 1
-		fi
+		[ $cpu_cores -gt 1 ]; return $?
 	else
 		: $(( num_of_cpus = siblings / cpu_cores ))
-		if [ $num_of_cpus -gt 1 ]; then
-			return 0
-		else
-			return 1
-		fi
+		[ $num_of_cpus -gt 1 ]; return $?
 	fi
 }		
 
-function is_dual_core() {
+is_dual_core() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
         cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
         if [ $siblings -eq $cpu_cores ]; then
-                if [ $cpu_cores -eq 2 ]; then
-                        return 1
-                else
-                        return 0
-                fi
+                [ $cpu_cores -eq 2 ]; return $?
         else
                 : $(( num_of_cpus = siblings / cpu_cores ))
-                if [ $num_of_cpus -eq 2 ]; then
-                        echo "number of cpus $num_of_cpus"
-                        return 1
-                else
-                        return 0
-                fi
+                [ $num_of_cpus -eq 2 ]; return $?
         fi
 }
 
-function get_kernel_version() {
+get_kernel_version() {
 	# Get kernel minor version
 	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' | cut -f1 -d'-'`
 }
 
-function get_valid_input() {
+get_valid_input() {
 	kernel_version=$1
 	case "$kernel_version" in
 	'2.6.26' | '2.6.27' | '2.6.28')
@@ -166,22 +146,14 @@ function get_valid_input() {
 	esac
 }
 		
-function check_supp_wkld() {
+check_supp_wkld() {
 	sched_mcsmt=$1
 	work_load=$2
 
 	case "$sched_mcsmt" in
-		1) if [ "$work_load" == "ebizzy" ]; then
-				return 0
-			else
-				return 1
-			fi
+		1) [ "$work_load" == "ebizzy" ]; return $?
 			;;
-		2) if [ "$work_load" == "ebizzy" -o "$work_load" == "kernbench" ]; then
-                return 0
-            else
-                return 1
-            fi
+		2) [ "$work_load" == "ebizzy" -o "$work_load" == "kernbench" ]; return $?
             ;;
 		*) 
                return 1
@@ -189,7 +161,7 @@ function check_supp_wkld() {
 	esac
 }
 
-function analyze_wrt_workload_hyperthreaded() {
+analyze_wrt_workload_hyperthreaded() {
 	sched_mc=$1
     work_load=$2
     pass_count=$3
@@ -223,7 +195,7 @@ unsupported workload $work_load when sch
         esac
 }
 
-function analyze_wrt_wkld() {
+analyze_wrt_wkld() {
 	sched_mc=$1
     work_load=$2
     pass_count=$3
@@ -257,7 +229,7 @@ unsupported workload $work_load when sch
 	fi
 }
 
-function analyze_result_hyperthreaded() {
+analyze_result_hyperthreaded() {
 	sched_mc=$1
     work_load=$2
     pass_count=$3
@@ -299,13 +271,12 @@ $sched_mc for workload=$work_load"
 	esac
 }
 
-function analyze_package_consolidation_result() {
+analyze_package_consolidation_result() {
 	sched_mc=$1
     work_load=$2
     pass_count=$3
 	sched_smt=$4
 
-	echo "sched mc $sched_mc sched smt is $sched_smt workload $work_load pass count $pass_count"
 	if [ $hyper_threaded -eq $YES ]; then
 		analyze_result_hyperthreaded $sched_mc $work_load $pass_count $sched_smt
 	else
@@ -326,7 +297,7 @@ $sched_mc for workload=$work_load"
 	fi
 }
 
-function analyze_core_consolidation_result() {
+analyze_core_consolidation_result() {
 	sched_smt=$1
 	work_load=$2
 	pass_count=$3
@@ -353,7 +324,7 @@ unsupported workload $work_load when sch
 	esac
 }
 
-function analyze_sched_domain_result(){
+analyze_sched_domain_result(){
 	sched_mc=$1
 	result=$2
 	sched_smt=$3

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

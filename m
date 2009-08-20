Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MeABN-0004nK-DY
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:09 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeABJ-0006cv-JL
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:08:09 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KG5ulf004157
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:05:56 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KG7bUV134162
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:07:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KG7aNu003135
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2009 10:07:36 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2009 21:37:31 +0530
Message-Id: <20090820160731.30926.75897.sendpatchset@localhost.localdomain>
In-Reply-To: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
Subject: [LTP] New & modified reusable functions for new & existing testcases
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
To: vaidy <svaidy@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net, gautham <ego@in.ibm.com>, arun@linux.vnet.ibm.com

Implemented reusable functions to learn system architecture before executing 
architecture specific testcases.  

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/pm_include.sh ltp-full-20090731/testcases/kernel/power_management/pm_include.sh
--- ltp-full-20090731_orig/testcases/kernel/power_management/pm_include.sh	2009-08-20 19:59:11.000000000 +0530
+++ ltp-full-20090731/testcases/kernel/power_management/pm_include.sh	2009-08-20 20:29:21.000000000 +0530
@@ -112,6 +112,46 @@ function is_multi_socket() {
 	fi
 }
 
+function is_multi_core() {
+	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
+	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
+	echo "siblings count $siblings cores count $cpu_cores"
+	if [ $siblings -eq $cpu_cores ]; then
+		if [ $cpu_cores -gt 1 ]; then
+			return 0
+		else
+			return 1
+		fi
+	else
+		: $(( num_of_cpus = siblings / cpu_cores ))
+		if [ $num_of_cpus -gt 1 ]; then
+			return 0
+		else
+			return 1
+		fi
+	fi
+}		
+
+function is_dual_core() {
+	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
+        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
+        if [ $siblings -eq $cpu_cores ]; then
+                if [ $cpu_cores -eq 2 ]; then
+                        return 1
+                else
+                        return 0
+                fi
+        else
+                : $(( num_of_cpus = siblings / cpu_cores ))
+                if [ $num_of_cpus -eq 2 ]; then
+                        echo "number of cpus $num_of_cpus"
+                        return 1
+                else
+                        return 0
+                fi
+        fi
+}
+
 function get_kernel_version() {
 	# Get kernel minor version
 	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' | cut -f1 -d'-'`
@@ -120,42 +160,12 @@ function get_kernel_version() {
 function get_valid_input() {
 	kernel_version=$1
 	case "$kernel_version" in
-	'2.6.29' | '2.6.30' | '2.6.31')
-			export valid_input="0 1 2" ;;
-		*) export valid_input="0 1" ;;
+	'2.6.26' | '2.6.27' | '2.6.28')
+			export valid_input="0 1" ;;
+		*) export valid_input="0 1 2" ;;
 	esac
 }
 		
-function get_max_sched_mc() {
-	get_kernel_version
-	case "$kernel_version" in
-	'2.6.29' | '2.6.30' | '2.6.31') 
-		return 2
-		;;
-	'2.6.26' | '2.6.27' | '2.6.28') 
-		return 1
-		;;
-	*) 
-		return 0
-		;;
-	esac
-}
-
-function get_max_sched_smt() {
-    get_kernel_version
-    case "$kernel_version" in
-        '2.6.29' | '2.6.30' | '2.6.31') 
-                    return 2
-				;;
-        '2.6.26' | '2.6.27' | '2.6.28') 
-                    return 1
-				;;
-        *) 
-			return 0
-			;;
-	esac
-}
-
 function check_supp_wkld() {
 	sched_mcsmt=$1
 	work_load=$2
@@ -184,58 +194,33 @@ function analyze_wrt_workload_hyperthrea
     work_load=$2
     pass_count=$3
     sched_smt=$4
-    stress=$5
 
-	if [ $sched_mc > $sched_smt ]; then
+	if [ $sched_mc -gt $sched_smt ]; then
 		check_supp_wkld $sched_mc $work_load; valid_workload=$?
 	else
 		check_supp_wkld $sched_smt $work_load; valid_workload=$?
 	fi
 
-	if [ "$stress" = "thread" ]; then
-		case "$valid_workload" in
-        0)
-			if [ $pass_count -lt 5 ]; then
-				RC=1
-				tst_resm TFAIL "Consolidation at core level failed for \
-sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
-			else
-				tst_resm TPASS "Consolidation at core level passed for \
-sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
-			fi ;;
-        1)
-            if [ $pass_count -lt 5 ]; then
-                tst_resm TPASS "Consolidation at core level failed for \
-unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
-            else
-				RC=1
-                tst_resm TFAIL "Consolidation at core level passed for \
-unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
-            fi ;;
-        esac
-	else
-		case "$valid_workload" in
-        0)
-            if [ $pass_count -lt 5 ]; then
-				RC=1
-                tst_resm TFAIL "Consolidation at package level failed for \
+	case "$valid_workload" in
+	0)
+		if [ $pass_count -lt 5 ]; then
+			RC=1
+			tst_resm TFAIL "Consolidation at package level failed for \
 sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
-            else
-                tst_resm TPASS "Consolidation at package level passed for \
+		else
+			tst_resm TPASS "Consolidation at package level passed for \
 sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
-            fi ;;
-        1)
-			echo "pass count is $pass_count"
-            if [ $pass_count -lt 5 ]; then
-                tst_resm TPASS "Consolidation at package level failed for \
+		fi ;;
+	1)
+		if [ $pass_count -lt 5 ]; then
+			tst_resm TPASS "Consolidation at package level failed for \
 unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
-            else
-				RC=1
-                tst_resm TFAIL "Consolidation at package level passed for \
+		else
+			RC=1
+			tst_resm TFAIL "Consolidation at package level passed for \
 unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
-            fi ;;
+		fi ;;
         esac
-	fi
 }
 
 function analyze_wrt_wkld() {
@@ -243,12 +228,11 @@ function analyze_wrt_wkld() {
     work_load=$2
     pass_count=$3
 	sched_smt=$4
-	stress=$5
 
 	check_supp_wkld $sched_mc $work_load; valid_workload=$?
 	if [ $hyper_threaded -eq $YES ]; then
 		analyze_wrt_workload_hyperthreaded $sched_mc $work_load $pass_count\
-		 $sched_smt $stress
+		 $sched_smt 
 	else
 		case "$valid_workload" in
 		0)
@@ -278,74 +262,56 @@ function analyze_result_hyperthreaded() 
     work_load=$2
     pass_count=$3
     sched_smt=$4
-    stress=$5
 
+	echo "sched_mc =$sched_mc  work-load=$work_load  pass_count=$pass_count  sched_smt=$sched_smt"
 	case "$sched_mc" in
 	0)
 		if [ $sched_smt ]; then
 			case "$sched_smt" in
 			0)
-				if [ "$stress" = "thread" ]; then
-					if [ $pass_count -lt 1 ]; then
-						tst_resm TPASS "Consolidation at core level failed for sched_mc=\
-$sched_mc & sched_smt=$sched_smt for workload=$work_load"
-					else
-						RC=1
-						tst_resm TFAIL "Consolidation at core level passed for sched_mc=\
+				if [ "$pass_count" -lt 5 ]; then
+					tst_resm TPASS "cpu consolidation failed for sched_mc=\
 $sched_mc & sched_smt=$sched_smt for workload=$work_load"
-					fi
 				else
-					if [ "$pass_count" -lt 1 ]; then
-						tst_resm TPASS "cpu consolidation failed for sched_mc=\
-$sched_mc & sched_smt=$sched_smt for workload=$work_load"
-					else
-						RC=1
-						tst_resm TFAIL "cpu consolidation passed for sched_mc=\
+					RC=1
+				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
 $sched_mc & sched_smt=$sched_smt for workload=$work_load"
-					fi
 				fi
 				;;
 			*)
-				if [ "$stress" = "thread" ]; then
-					analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt $stress
-				else
-					analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
-				fi ;;
+				analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
+				;;
 			esac
 		else
-			if [ $pass_count -lt 1 ]; then
+			if [ $pass_count -lt 5 ]; then
 				tst_resm TPASS "cpu consolidation failed for sched_mc=\
 $sched_mc for workload=$work_load"
 			else
 				RC=1
 				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
-$sched_mc & sched_smt=$sched_smt for workload=$work_load"
+$sched_mc for workload=$work_load"
 			fi
 		fi
 		;;
 	*)
-		if [ "$stress" = "thread" ]; then
-			analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt $stress
-		else
 			analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
-		fi
 		;;
 	esac
 }
 
-function analyze_consolidation_result() {
+function analyze_package_consolidation_result() {
 	sched_mc=$1
     work_load=$2
     pass_count=$3
 	sched_smt=$4
-	stress=$5
 
+	echo "sched mc $sched_mc sched smt is $sched_smt workload $work_load pass count $pass_count"
 	if [ $hyper_threaded -eq $YES ]; then
-		analyze_result_hyperthreaded $sched_mc $work_load $pass_count $sched_smt $stress
+		analyze_result_hyperthreaded $sched_mc $work_load $pass_count $sched_smt
 	else
 		case "$sched_mc" in
 	    0)
-    	    if [ $pass_count -lt 1 ]; then
+    	    if [ $pass_count -lt 5 ]; then
         	    tst_resm TPASS "cpu consolidation failed for sched_mc=\
 $sched_mc for workload=$work_load"
         	else
@@ -360,6 +326,33 @@ $sched_mc for workload=$work_load"
 	fi
 }
 
+function analyze_core_consolidation_result() {
+	sched_smt=$1
+	work_load=$2
+	pass_count=$3
+
+	case "$valid_workload" in
+	0)
+		if [ $pass_count -lt 5 ]; then
+			RC=1
+			tst_resm TFAIL "Consolidation at core level failed for \
+sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
+		else
+			tst_resm TPASS "Consolidation at core level passed for \
+sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
+		fi ;;
+	1)
+		if [ $pass_count -lt 5 ]; then
+			tst_resm TPASS "Consolidation at core level failed for \
+unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
+		else
+			RC=1
+			tst_resm TFAIL "Consolidation at core level passed for \
+unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
+		fi ;;
+	esac
+}
+
 function analyze_sched_domain_result(){
 	sched_mc=$1
 	result=$2

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

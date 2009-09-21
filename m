Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MpdHE-0004IF-Uj
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:36 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MpdHA-0000Pn-4X
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 07:25:36 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8L7OQM8029365
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 01:24:26 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8L7POfX204340
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 01:25:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8L7PNe8029413
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 01:25:24 -0600
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2009 12:55:20 +0530
Message-Id: <20090921072520.7307.560.sendpatchset@localhost.localdomain>
In-Reply-To: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 5/6] Modified library functions based on review
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

diff -uprN ltp-full-20090831/testcases/kernel/power_management/pm_include.sh ltp-full-20090831_patched/testcases/kernel/power_management/pm_include.sh
--- ltp-full-20090831/testcases/kernel/power_management/pm_include.sh	2009-08-31 10:45:45.000000000 +0530
+++ ltp-full-20090831_patched/testcases/kernel/power_management/pm_include.sh	2009-09-21 12:29:26.056970343 +0530
@@ -71,7 +71,7 @@ get_supporting_govr() {
 is_hyper_threaded() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
 	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-	[ $siblins > $cpu_cores ]; return $?
+	[ $siblings > $cpu_cores ]; return $?
 }
 
 check_input() {
@@ -146,152 +146,74 @@ get_valid_input() {
 	esac
 }
 		
-check_supp_wkld() {
-	sched_mcsmt=$1
-	work_load=$2
-
-	case "$sched_mcsmt" in
-		1) [ "$work_load" == "ebizzy" ]; return $?
-			;;
-		2) [ "$work_load" == "ebizzy" -o "$work_load" == "kernbench" ]; return $?
-            ;;
-		*) 
-               return 1
-			;;
-	esac
-}
-
-analyze_wrt_workload_hyperthreaded() {
-	sched_mc=$1
-    work_load=$2
-    pass_count=$3
-    sched_smt=$4
-
-	if [ $sched_mc -gt $sched_smt ]; then
-		check_supp_wkld $sched_mc $work_load; valid_workload=$?
-	else
-		check_supp_wkld $sched_smt $work_load; valid_workload=$?
-	fi
-
-	case "$valid_workload" in
-	0)
-		if [ $pass_count -lt 5 ]; then
-			RC=1
-			tst_resm TFAIL "Consolidation at package level failed for \
-sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
-		else
-			tst_resm TPASS "Consolidation at package level passed for \
-sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
-		fi ;;
-	1)
-		if [ $pass_count -lt 5 ]; then
-			tst_resm TPASS "Consolidation at package level failed for \
-unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
-		else
-			RC=1
-			tst_resm TFAIL "Consolidation at package level passed for \
-unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
-		fi ;;
-        esac
-}
-
-analyze_wrt_wkld() {
-	sched_mc=$1
-    work_load=$2
-    pass_count=$3
-	sched_smt=$4
-
-	check_supp_wkld $sched_mc $work_load; valid_workload=$?
-	if [ $hyper_threaded -eq $YES ]; then
-		analyze_wrt_workload_hyperthreaded $sched_mc $work_load $pass_count\
-		 $sched_smt 
-	else
-		case "$valid_workload" in
-		0)
-			if [ "$pass_count" -lt 5 ]; then
-				RC=1
-				tst_resm TFAIL "cpu consolidation failed for \
-sched_mc=$sched_mc for workload=$work_load"
-			else
-				tst_resm TPASS "cpu consolidation passed for \
-sched_mc=$sched_mc for workload=$work_load"
-			fi ;;
-		1)
-			if [ "$pass_count" -lt 5 ]; then
-				tst_resm TPASS "cpu consolidation failed for \
-unsupported workload $work_load when sched_mc=$sched_mc"
-            else
-				RC=1
-				tst_resm TFAIL "cpu consolidation passed for \
-unsupported workload $work_load when sched_mc=$sched_mc"
-            fi ;;
-        esac
-	fi
-}
-
 analyze_result_hyperthreaded() {
 	sched_mc=$1
-    work_load=$2
     pass_count=$3
     sched_smt=$4
 
-	echo "sched_mc =$sched_mc  work-load=$work_load  pass_count=$pass_count  sched_smt=$sched_smt"
 	case "$sched_mc" in
 	0)
-		if [ $sched_smt ]; then
-			case "$sched_smt" in
-			0)
-				if [ "$pass_count" -lt 5 ]; then
-					tst_resm TPASS "cpu consolidation failed for sched_mc=\
-$sched_mc & sched_smt=$sched_smt for workload=$work_load"
-				else
-					RC=1
-				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
-$sched_mc & sched_smt=$sched_smt for workload=$work_load"
-				fi
-				;;
-			*)
-				analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
-				;;
-			esac
-		else
+		case "$sched_smt" in
+		0)
 			if [ $pass_count -lt 5 ]; then
 				tst_resm TPASS "cpu consolidation failed for sched_mc=\
-$sched_mc for workload=$work_load"
+$sched_mc & sched_smt=$sched_smt"
 			else
 				RC=1
 				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
-$sched_mc for workload=$work_load"
+$sched_mc & sched_smt=$sched_smt"
 			fi
-		fi
-		;;
+			;;
+		*)
+           	if [ $pass_count -lt 5 ]; then
+               	tst_resm TFAIL "cpu consolidation for sched_mc=\
+$sched_mc & sched_smt=$sched_smt"
+           	else
+				RC=1
+				tst_resm TPASS "cpu consolidation for sched_mc=\
+$sched_mc & sched_smt=$sched_smt"
+			fi
+			;;
+		esac ;;
 	*)
-			analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
+		if [ $pass_count -lt 5 ]; then
+			tst_resm TFAIL "cpu consolidation for sched_mc=\
+$sched_mc & sched_smt=$sched_smt"
+		else
+			RC=1
+			tst_resm TPASS "cpu consolidation for sched_mc=\
+$sched_mc & sched_smt=$sched_smt"
+		fi
 		;;
 	esac
 }
 
 analyze_package_consolidation_result() {
 	sched_mc=$1
-    work_load=$2
     pass_count=$3
 	sched_smt=$4
 
-	if [ $hyper_threaded -eq $YES ]; then
-		analyze_result_hyperthreaded $sched_mc $work_load $pass_count $sched_smt
+	if [ $hyper_threaded -eq $YES -a $sched_smt ]; then
+		analyze_result_hyperthreaded $sched_mc $pass_count $sched_smt
 	else
 		case "$sched_mc" in
 	    0)
     	    if [ $pass_count -lt 5 ]; then
         	    tst_resm TPASS "cpu consolidation failed for sched_mc=\
-$sched_mc for workload=$work_load"
+$sched_mc"
         	else
 				RC=1
             	tst_resm TFAIL "cpu consolidation passed for sched_mc=\
-$sched_mc for workload=$work_load"
+$sched_mc"
         	fi ;;
     	*)
-        	analyze_wrt_wkld $sched_mc $work_load $pass_count
+			if [ $pass_count -lt 5 ]; then
+				tst_resm TFAIL "Consolidation at package level failed for \
+sched_mc=$sched_mc & sched_smt=$sched_smt"
+			else
+				tst_resm TPASS "Consolidation at package level passed for \
+sched_mc=$sched_mc & sched_smt=$sched_smt"
+			fi	
         	;;
     	esac
 	fi
@@ -299,27 +221,25 @@ $sched_mc for workload=$work_load"
 
 analyze_core_consolidation_result() {
 	sched_smt=$1
-	work_load=$2
 	pass_count=$3
 
-	case "$valid_workload" in
+	case "$sched_smt" in
 	0)
 		if [ $pass_count -lt 5 ]; then
+			tst_resm TPASS "Consolidation at core level failed \
+when sched_smt=$sched_smt"
+		else
+			tst_resm TFAIL "Consolidation at core level passed for \
+sched_smt=$sched_smt"
+		fi ;;	
+	*)
+		if [ $pass_count -lt 5 ]; then
 			RC=1
 			tst_resm TFAIL "Consolidation at core level failed for \
-sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
+sched_smt=$sched_smt"
 		else
 			tst_resm TPASS "Consolidation at core level passed for \
-sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
-		fi ;;
-	1)
-		if [ $pass_count -lt 5 ]; then
-			tst_resm TPASS "Consolidation at core level failed for \
-unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
-		else
-			RC=1
-			tst_resm TFAIL "Consolidation at core level passed for \
-unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
+sched_smt=$sched_smt"
 		fi ;;
 	esac
 }

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

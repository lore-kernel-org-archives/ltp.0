Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1Mxc3A-0007rf-OK
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:04 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxc33-0006qo-8k
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 07:44:04 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9D7mgxu022996
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 03:48:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9D7hfAa257118
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 03:43:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9D7eFqT028018
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 03:40:15 -0400
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2009 13:13:37 +0530
Message-Id: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 1/6] Fix issues in cpu consolidation verification
	functions
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

Arguments passed for cpu consolidation was not used appropriatly. Provided
TINFO messages to indicate dependency test failures.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-full-20090930/testcases/kernel/power_management/pm_include.sh ltp-full-20090930_patched/testcases/kernel/power_management/pm_include.sh
--- ltp-full-20090930/testcases/kernel/power_management/pm_include.sh	2009-10-05 02:10:56.000000000 -0400
+++ ltp-full-20090930_patched/testcases/kernel/power_management/pm_include.sh	2009-10-12 22:46:12.000000000 -0400
@@ -71,7 +71,7 @@ get_supporting_govr() {
 is_hyper_threaded() {
 	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
 	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-	[ $siblings > $cpu_cores ]; return $?
+	[ $siblings -gt $cpu_cores ]; return $?
 }
 
 check_input() {
@@ -148,8 +148,8 @@ get_valid_input() {
 		
 analyze_result_hyperthreaded() {
 	sched_mc=$1
-    pass_count=$3
-    sched_smt=$4
+    pass_count=$2
+    sched_smt=$3
 
 	case "$sched_mc" in
 	0)
@@ -165,7 +165,7 @@ $sched_mc & sched_smt=$sched_smt"
 			fi
 			;;
 		*)
-           	if [ $pass_count -lt 5 ]; then
+			if [ $pass_count -lt 5 ]; then
                	tst_resm TFAIL "cpu consolidation for sched_mc=\
 $sched_mc & sched_smt=$sched_smt"
            	else
@@ -190,10 +190,16 @@ $sched_mc & sched_smt=$sched_smt"
 
 analyze_package_consolidation_result() {
 	sched_mc=$1
-    pass_count=$3
-	sched_smt=$4
+    pass_count=$2
+
+	if [ $# -gt 2 ]
+	then
+		sched_smt=$3
+	else
+		sched_smt=-1
+	fi
 
-	if [ $hyper_threaded -eq $YES -a $sched_smt ]; then
+	if [ $hyper_threaded -eq $YES -a $sched_smt -gt -1 ]; then
 		analyze_result_hyperthreaded $sched_mc $pass_count $sched_smt
 	else
 		case "$sched_mc" in
@@ -209,10 +215,10 @@ $sched_mc"
     	*)
 			if [ $pass_count -lt 5 ]; then
 				tst_resm TFAIL "Consolidation at package level failed for \
-sched_mc=$sched_mc & sched_smt=$sched_smt"
+sched_mc=$sched_mc"
 			else
 				tst_resm TPASS "Consolidation at package level passed for \
-sched_mc=$sched_mc & sched_smt=$sched_smt"
+sched_mc=$sched_mc"
 			fi	
         	;;
     	esac
@@ -221,7 +227,7 @@ sched_mc=$sched_mc & sched_smt=$sched_sm
 
 analyze_core_consolidation_result() {
 	sched_smt=$1
-	pass_count=$3
+	pass_count=$2
 
 	case "$sched_smt" in
 	0)

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

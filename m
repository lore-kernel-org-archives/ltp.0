Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1NNsEO-0007VC-18
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:12 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NNsEG-0007g8-IR
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:12 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBOI8AgJ002095
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:08:10 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBOIFkEp108738
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:15:47 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBOIFjj8014997
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:15:46 -0700
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 24 Dec 2009 23:45:42 +0530
Message-Id: <20091224181542.12571.16299.sendpatchset@localhost.localdomain>
In-Reply-To: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 2/4]Reusable functions modified to learn topology from
	sysfs
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

Patch to learn topology of system through sysfs.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/power_management/pm_include.sh ltp-intermediate-20091209.fixes/testcases/kernel/power_management/pm_include.sh
--- ltp-intermediate-20091209.orig/testcases/kernel/power_management/pm_include.sh	2009-12-09 13:18:25.000000000 +0530
+++ ltp-intermediate-20091209.fixes/testcases/kernel/power_management/pm_include.sh	2009-12-24 23:17:37.798995821 +0530
@@ -69,9 +69,24 @@ get_supporting_govr() {
 }
 
 is_hyper_threaded() {
-	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
-	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-	[ $siblings -gt $cpu_cores ]; return $?
+	entries=`cat /sys/devices/system/cpu/cpu0/topology/thread_siblings`
+	count=`echo $entries | awk -F"," '{ print NF }'`
+	cpucount=0
+	for ((i=1;i<=$count;i++))
+	do
+        
+    	cpumask=`echo $entries | awk -v x=$i 'BEGIN{FS=","} {print $x}'`
+		while [ $cpumask -gt 0 ]
+		do
+			((cpucount=cpucount+1))
+			((cpumask=$cpumask>>1))
+		done
+	done
+	if [ $cpucount -gt 1 ]; then
+		return 0
+	else
+		return 1
+	fi
 }
 
 check_input() {
@@ -110,26 +125,38 @@ is_multi_socket() {
 	[ $no_of_sockets -gt 1 ] ; return $?
 }
 
+get_core_sibling_count() {
+	entries=`cat /sys/devices/system/cpu/cpu0/topology/core_siblings`
+	count=`echo $entries | awk -F"," '{ print NF }'`
+	cpucount=0
+	for ((i=1;i<=$count;i++))
+	do
+		cpumask=`echo $entries | awk -v x=$i 'BEGIN{FS=","} {print $x}'`
+		while [ $cpumask -gt 0 ]
+		do
+			((cpucount=cpucount+1))
+			((cpumask=$cpumask>>1))
+		done
+	done
+	echo $cpucount
+}
+
 is_multi_core() {
-	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
-	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-	if [ $siblings -eq $cpu_cores ]; then
-		[ $cpu_cores -gt 1 ]; return $?
-	else
-		: $(( num_of_cpus = siblings / cpu_cores ))
-		[ $num_of_cpus -gt 1 ]; return $?
+	sibling_cnt=$(get_core_sibling_count)
+    if [ $sibling_cnt -gt 1 ]; then
+		return 0
+    else
+		return 1
 	fi
 }		
 
 is_dual_core() {
-	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
-        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
-        if [ $siblings -eq $cpu_cores ]; then
-                [ $cpu_cores -eq 2 ]; return $?
-        else
-                : $(( num_of_cpus = siblings / cpu_cores ))
-                [ $num_of_cpus -eq 2 ]; return $?
-        fi
+	sibling_cnt=$(get_core_sibling_count)
+	if [ $sibling_cnt -eq 2 ]; then
+		return 0
+	else
+		return 1
+	fi
 }
 
 get_kernel_version() {

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

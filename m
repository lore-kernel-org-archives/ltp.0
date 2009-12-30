Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NPpjh-0005hK-47
	for ltp-list@lists.sourceforge.net; Wed, 30 Dec 2009 04:00:37 +0000
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NPpjc-0001yl-BL
	for ltp-list@lists.sourceforge.net; Wed, 30 Dec 2009 04:00:36 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBU40O3U021616
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Dec 2009 15:00:24 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBU40NQe1491022
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Dec 2009 15:00:24 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBU40N1U014606
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Dec 2009 15:00:23 +1100
Message-ID: <4B3AD054.5090608@linux.vnet.ibm.com>
Date: Wed, 30 Dec 2009 09:30:20 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4B388C81.80903@linux.vnet.ibm.com>
	<4B39C9F4.1030708@cn.fujitsu.com>
In-Reply-To: <4B39C9F4.1030708@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------040003040106000208050507"
Subject: Re: [LTP] [PATCH 2/2] Added check for memory controller (
 functional, regression & stress )
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: risrajak@in.ibm.com, LTP <ltp-list@lists.sourceforge.net>, iranna.ankad@in.ibm.com

This is a multi-part message in MIME format.
--------------040003040106000208050507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/2009 02:50 PM, Li Zefan wrote:
>> commit fe4599d210be37a7d1bb2d6a5523b9e29bbd87e1
>> Author: Rishikesh K Rajak<rishikesh@rishikesh.in.ibm.com>
>> Date:   Mon Dec 28 15:11:54 2009 +0530
>>
>>      Added check for regression and funcitonal memcg test
>>
>>      
> You should add your Signed-off-by.
>    

Sending a fresh patch with signed-off added. Also combined both the 
patches in one & ported to latest intermediate ltp release.



--------------040003040106000208050507
Content-Type: text/plain;
 name="memcg-enbale-disable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="memcg-enbale-disable.patch"

Description:
	The current implementation of memory controller in ltp checks only
for kernel support, this patch check for memcg functionality enable or
disable through /proc/cgroups.

Signed-off By : Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
---
Index: ltp-intermediate-20091209.orig/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
===================================================================
--- ltp-intermediate-20091209.orig.orig/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh	2009-12-09 13:18:49.000000000 +0530
+++ ltp-intermediate-20091209.orig/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh	2009-12-30 09:24:48.000000000 +0530
@@ -20,6 +20,8 @@
 ##                                                                            ##
 ## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
 ## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
+##						<risrajak@linux.vnet.ibm.com  ##
 ##                                                                            ##
 ################################################################################
 
@@ -28,14 +30,15 @@
 export TST_TOTAL=38
 export TST_COUNT=0
 
-grep -w memory /proc/cgroups 2>&1 > /dev/null
-if [ $? -ne 0 ]; then
-	echo "WARNING:";
-	echo "Kernel does not support for memory resource controller";
-	echo "Skipping all memcgroup testcases....";
-	exit 0
+if [ ! "grep -w memory /proc/cgroups | cut -f4" == "1" ]
+then
+        echo "WARNING:";
+        echo "Either Kernel does not support for memory resource controller or feature not enabled";
+        echo "Skipping all memcgroup testcases....";
+        exit 0
 fi
 
+
 TEST_PATH=$PWD
 
 PASS=0
Index: ltp-intermediate-20091209.orig/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
===================================================================
--- ltp-intermediate-20091209.orig.orig/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh	2009-12-09 13:18:50.000000000 +0530
+++ ltp-intermediate-20091209.orig/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh	2009-12-30 09:21:40.000000000 +0530
@@ -19,6 +19,8 @@
 ## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
 ##                                                                            ##
 ## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak                 ##
+##                                              <risrajak@linux.vnet.ibm.com  ##
 ##                                                                            ##
 ################################################################################
 
@@ -33,6 +35,14 @@
 	exit 0
 fi
 
+if [ ! "grep -w memory /proc/cgroups | cut -f4" == "1" ]
+then
+        echo "WARNING:";
+        echo "Either Kernel does not support for memory resource controller or feature not enabled";
+        echo "Skipping all memcgroup testcases....";
+        exit 0
+fi
+
 tst_kvercmp 2 6 30
 if [ $? -eq 0 ]; then
 	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
Index: ltp-intermediate-20091209.orig/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
===================================================================
--- ltp-intermediate-20091209.orig.orig/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	2009-12-09 13:18:49.000000000 +0530
+++ ltp-intermediate-20091209.orig/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	2009-12-30 09:21:51.000000000 +0530
@@ -20,6 +20,8 @@
 ##                                                                            ##
 ## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
 ## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak                 ##
+##                                              <risrajak@linux.vnet.ibm.com  ##
 ##                                                                            ##
 ################################################################################
 
@@ -28,12 +30,12 @@
 export TST_TOTAL=2
 export TST_COUNT=0
 
-grep -w memory /proc/cgroups 2>&1 > /dev/null
-if [ $? -ne 0 ]; then
-	echo "WARNING:";
-	echo "Kernel does not support for memory resource controller";
-	echo "Skipping all memcgroup testcases....";
-	exit 0
+if [ ! "grep -w memory /proc/cgroups | cut -f4" == "1" ]
+then
+        echo "WARNING:";
+        echo "Either Kernel does not support for memory resource controller or feature not enabled";
+        echo "Skipping all memcgroup testcases....";
+        exit 0
 fi
 
 RUN_TIME=$(( 60 * 60 ))
Index: ltp-intermediate-20091209.orig/testcases/kernel/controllers/test_controllers.sh
===================================================================
--- ltp-intermediate-20091209.orig.orig/testcases/kernel/controllers/test_controllers.sh	2009-12-09 13:18:51.000000000 +0530
+++ ltp-intermediate-20091209.orig/testcases/kernel/controllers/test_controllers.sh	2009-12-30 09:23:32.000000000 +0530
@@ -33,19 +33,26 @@
 #  20/12/07  Sudhir Kumar <sudhirkumarmalik@in.ibm.com>   Created this test      #
 #  02/03/09  Miao Xie     <miaox@cn.fujitsu.com>          Add cpuset testset     #
 #  07/07/09  Shi Weihua   <shiwh@cn.fujitsu.com>      Add cpu testset of Fujitsu #
+#  30/12/09  Rishikesh    <risrajak@linux.vnet.ibm.com> Added enable/disable     #
 #                                                                                #
 ##################################################################################
 
 if [ -f /proc/cgroups ]
 then
 	CPU_CONTROLLER=`grep -w cpu /proc/cgroups | cut -f1`;
+	CPU_CONTROLLER_VALUE=`grep -w cpu /proc/cgroups | cut -f4`;
 	MEM_CONTROLLER=`grep -w memory /proc/cgroups | cut -f1`;
+	MEM_CONTROLLER_VALUE=`grep -w memory /proc/cgroups | cut -f4`;
 	IOTHROTTLE_CONTROLLER=`grep -w blockio /proc/cgroups | cut -f1`;
+	IOTHROTTLE_CONTROLLER_VALUE=`grep -w blockio /proc/cgroups | cut -f4`;
 	FREEZER=`grep -w freezer /proc/cgroups | cut -f1`;
+	FREEZER_VALUE=`grep -w freezer /proc/cgroups | cut -f4`;
 	CPUSET_CONTROLLER=`grep -w cpuset /proc/cgroups | cut -f1`
+	CPUSET_CONTROLLER_VALUE=`grep -w cpuset /proc/cgroups | cut -f4`
 	CPUACCOUNT_CONTROLLER=`grep -w cpuacct /proc/cgroups | cut -f1`
+	CPUACCOUNT_CONTROLLER_VALUE=`grep -w cpuacct /proc/cgroups | cut -f4`
 
-	if [ "$CPU_CONTROLLER" = "cpu" ]
+	if [ "$CPU_CONTROLLER" = "cpu" ] && [ "$CPU_CONTROLLER_VALUE" = "1" ]
 	then
 		$LTPROOT/testcases/bin/run_cpuctl_test.sh 1;
 		$LTPROOT/testcases/bin/run_cpuctl_test.sh 3;
@@ -63,11 +70,11 @@
 		$LTPROOT/testcases/bin/run_cpuctl_test_fj.sh
 	else
 		echo "CONTROLLERS TESTCASES: WARNING";
-		echo "Kernel does not support for cpu controller";
+		echo "Either Kernel does not support for cpu controller or functionality is not enabled";
 		echo "Skipping all cpu controller testcases....";
 	fi;
 
-	if [ "$MEM_CONTROLLER" = "memory" ]
+	if [ "$MEM_CONTROLLER" = "memory" ] && [ "$MEM_CONTROLLER_VALUE" = "1" ]
 	then
 		$LTPROOT/testcases/bin/run_memctl_test.sh 1;
 		$LTPROOT/testcases/bin/run_memctl_test.sh 2;
@@ -75,28 +82,29 @@
 		$LTPROOT/testcases/bin/run_memctl_test.sh 4;
 	else
 		echo "CONTROLLERS TESTCASES: WARNING";
-		echo "Kernel does not support for memory controller";
+		echo "Either Kernel does not support for memory controller or functionality is not enabled";
 		echo "Skipping all memory controller testcases....";
 	fi
 
-	if [ "$IOTHROTTLE_CONTROLLER" = "blockio" ]
+	if [ "$IOTHROTTLE_CONTROLLER" = "blockio" ] && [ "$IOTHROTTLE_CONTROLLER_VALUE" = "1" ]
 	then
 		$LTPROOT/testcases/bin/run_io_throttle_test.sh;
 	else
 		echo "CONTROLLERS TESTCASES: WARNING";
-		echo "Kernel does not support blockio controller";
+		echo "Either Kernel does not support for io controller or functionality is not enabled";
 		echo "Skipping all block device I/O throttling testcases....";
 	fi
 
-	if [ "$FREEZER" = "freezer" ]
+	if [ "$FREEZER" = "freezer" ] && [ "$FREEZER_VALUE" = "1" ]
 	then
 		"$LTPROOT/testcases/bin/run_freezer.sh"
 	else
 		echo "CONTROLLERS TESTCASES: WARNING";
+		echo "Either Kernel does not support for freezer or functionality is not enabled";
 		echo "Kernel does not support freezer controller";
 		echo "Skipping all freezer testcases....";
 	fi
-	if [ "$CPUSET_CONTROLLER" = "cpuset" ]
+	if [ "$CPUSET_CONTROLLER" = "cpuset" ] && [ "$CPUSET_CONTROLLER_VALUE" = "1" ]
 	then
 		$LTPROOT/testcases/bin/run_cpuset_test.sh 1;
 		$LTPROOT/testcases/bin/run_cpuset_test.sh 2;
@@ -111,21 +119,22 @@
 		$LTPROOT/testcases/bin/run_cpuset_test.sh 11;
 	else
 		echo "CONTROLLERS TESTCASES: WARNING";
-		echo "Kernel does not support cpuset controller";
+		echo "Either Kernel does not support for cpuset controller or functionality is not enabled";
 		echo "Skipping all cpuset controller testcases....";
 	fi
-	if [ "$CPUACCOUNT_CONTROLLER" = "cpuacct" ]
+	if [ "$CPUACCOUNT_CONTROLLER" = "cpuacct" ] && [ "$CPUACCOUNT_CONTROLLER_VALUE" = "1" ]
         then
                 $LTPROOT/testcases/bin/run_cpuacct_test.sh 1;
                 $LTPROOT/testcases/bin/run_cpuacct_test.sh 2;
         else
                 echo "Could not start cpu accounting controller test";
+		echo "Either Kernel does not support for cpu accounting controller or functionality is not enabled";
                 echo "usage: run_cpuacct_test.sh $TEST_NUM ";
                 echo "Skipping the cpu accounting controller test...";
         fi
 else
 	echo "CONTROLLERS TESTCASES: WARNING"
-	echo "Kernel does not support for control groups";
+	echo "Kernel does not support any controller";
 	echo "Skipping all controllers testcases....";
 fi
 

--------------040003040106000208050507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--------------040003040106000208050507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040003040106000208050507--


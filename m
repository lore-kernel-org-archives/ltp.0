Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NPD7a-0007yl-8F
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2009 10:46:42 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NPD7V-0003vV-AD
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2009 10:46:42 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBSAguh0029239
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:42:56 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBSAkI681773686
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:46:18 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBSAkIH9020693
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:46:18 +1100
Message-ID: <4B388C75.3040104@linux.vnet.ibm.com>
Date: Mon, 28 Dec 2009 16:16:13 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080607000603050706040301"
Subject: [LTP] [PATCH 1/2]: Added check to test_controller.sh
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
To: LTP <ltp-list@lists.sourceforge.net>
Cc: iranna.ankad@in.ibm.com

This is a multi-part message in MIME format.
--------------080607000603050706040301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080607000603050706040301
Content-Type: text/plain;
 name="ltp-mem-enable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ltp-mem-enable.patch"

commit 0509a4c119d10b8d3e713cb1deaa9299f308c95a
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Mon Dec 28 14:30:41 2009 +0530

    Added check for enablement of controller

diff --git a/testcases/kernel/controllers/test_controllers.sh b/testcases/kernel/controllers/test_controllers.sh
index f3a1daa..0ad5f53 100755
--- a/testcases/kernel/controllers/test_controllers.sh
+++ b/testcases/kernel/controllers/test_controllers.sh
@@ -39,13 +39,19 @@
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
@@ -63,11 +69,11 @@ then
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
@@ -75,28 +81,29 @@ then
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
@@ -111,21 +118,22 @@ then
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

--------------080607000603050706040301
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
--------------080607000603050706040301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080607000603050706040301--


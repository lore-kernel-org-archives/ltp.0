Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NPD7b-0007Tm-VF
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2009 10:46:43 +0000
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NPD7V-0007Cn-Rc
	for ltp-list@lists.sourceforge.net; Mon, 28 Dec 2009 10:46:43 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBSAkUU2008623
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:46:30 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBSAgHRp1462432
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:42:17 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBSAkTLl020793
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Dec 2009 21:46:30 +1100
Message-ID: <4B388C81.80903@linux.vnet.ibm.com>
Date: Mon, 28 Dec 2009 16:16:25 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010806010901010000020004"
Subject: [LTP] [PATCH 2/2] Added check for memory controller ( functional,
 regression & stress )
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
Cc: risrajak@in.ibm.com, iranna.ankad@in.ibm.com

This is a multi-part message in MIME format.
--------------010806010901010000020004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010806010901010000020004
Content-Type: text/plain;
 name="ltp-mem-enable2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ltp-mem-enable2.patch"

commit fe4599d210be37a7d1bb2d6a5523b9e29bbd87e1
Author: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Date:   Mon Dec 28 15:11:54 2009 +0530

    Added check for regression and funcitonal memcg test

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 003af1c..303661c 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -28,8 +28,8 @@ export TCID="memcg_function_test"
 export TST_TOTAL=38
 export TST_COUNT=0
 
-grep -w memory /proc/cgroups 2>&1 > /dev/null
-if [ $? -ne 0 ]; then
+if [ `grep -w memory /proc/cgroups | cut -f4` == 0 ]
+then
 	echo "WARNING:";
 	echo "Kernel does not support for memory resource controller";
 	echo "Skipping all memcgroup testcases....";
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index 6bf7c88..0bc3d75 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -33,6 +33,15 @@ if [ "$USER" != root ]; then
 	exit 0
 fi
 
+if [ `grep -w memory /proc/cgroups | cut -f4` == 0 ]
+then
+        echo "WARNING:";
+        echo "Kernel does not support for memory resource controller";
+        echo "Skipping all memcgroup testcases....";
+        exit 0
+fi
+
+
 tst_kvercmp 2 6 30
 if [ $? -eq 0 ]; then
 	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 7244a16..c155bf1 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -28,14 +28,15 @@ export TCID="memcg_stress_test"
 export TST_TOTAL=2
 export TST_COUNT=0
 
-grep -w memory /proc/cgroups 2>&1 > /dev/null
-if [ $? -ne 0 ]; then
-	echo "WARNING:";
-	echo "Kernel does not support for memory resource controller";
-	echo "Skipping all memcgroup testcases....";
-	exit 0
+if [ `grep -w memory /proc/cgroups | cut -f4` == 0 ]
+then
+        echo "WARNING:";
+        echo "Kernel does not support for memory resource controller";
+        echo "Skipping all memcgroup testcases....";
+        exit 0
 fi
 
+
 RUN_TIME=$(( 60 * 60 ))
 
 cleanup()

--------------010806010901010000020004
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
--------------010806010901010000020004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010806010901010000020004--


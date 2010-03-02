Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1NmOIA-0001sW-Ml
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 09:21:26 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmOI9-0005fw-OZ
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 09:21:26 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o229B2Jc003520
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 04:11:02 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o229LKEG1871988
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 04:21:20 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o229LJB7004155
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 06:21:19 -0300
From: Sachin Sant <sachinp@in.ibm.com>
Date: Tue, 02 Mar 2010 14:51:16 +0530
Message-Id: <20100302092116.3409.1130.sendpatchset@localhost.localdomain>
Subject: [LTP] [PATCH] Fix memcg test scripts
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

Inspite of memcg kernel support being available, memcg_[functional|regression
|stress] test script fails to execute with message

"Either Kernel does not support for memory resource controller or feature not enabled"
"Skipping all memcgroup testcases...."

Fix the scripts to use proper if []; then .. fi statements.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh	2010-03-02 12:23:27.000000000 +0530
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh	2010-03-02 12:23:33.000000000 +0530
@@ -30,8 +30,7 @@ export TCID="memcg_function_test"
 export TST_TOTAL=38
 export TST_COUNT=0
 
-if [ ! "grep -w memory /proc/cgroups | cut -f4" == "1" ]
-then
+if [ "$(grep -w memory /proc/cgroups | cut -f4)" != "1" ]; then
         echo "WARNING:";
         echo "Either Kernel does not support for memory resource controller or feature not enabled";
         echo "Skipping all memcgroup testcases....";
diff -Naurp a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh	2010-03-02 12:23:27.000000000 +0530
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh	2010-03-02 12:23:33.000000000 +0530
@@ -35,8 +35,7 @@ if [ "$(id -ru)" != 0 ]; then
 	exit 0
 fi
 
-if [ "$(grep -w memory /proc/cgroups | cut -f4)" != "1" ]
-then
+if [ "$(grep -w memory /proc/cgroups | cut -f4)" != "1" ]; then
 	tst_resm TCONF "Either memory resource controller kernel support absent"
 	tst_resm TCONF "or feature is not enabled; skipping all memcgroup testcases."
         exit 0
diff -Naurp a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	2010-03-02 12:23:27.000000000 +0530
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	2010-03-02 12:23:33.000000000 +0530
@@ -30,8 +30,7 @@ export TCID="memcg_stress_test"
 export TST_TOTAL=2
 export TST_COUNT=0
 
-if [ ! "grep -w memory /proc/cgroups | cut -f4" == "1" ]
-then
+if [ "$(grep -w memory /proc/cgroups | cut -f4)" != "1" ]; then
         echo "WARNING:";
         echo "Either Kernel does not support for memory resource controller or feature not enabled";
         echo "Skipping all memcgroup testcases....";

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

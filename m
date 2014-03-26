Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WSohT-00051Q-AF
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 14:21:03 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSohD-0007Ev-G7
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 14:21:03 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2QEKfeX016860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 14:20:41 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2QEKeBS028480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 14:20:41 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2QEKeei004215
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 14:20:40 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 26 Mar 2014 18:21:03 +0400
Message-Id: <1395843663-8329-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] testcases/*.sh: use INT in "trap" instead of SIGINT
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
Cc: vasily.isaenko@oracle.com

Also replace "==" with "=" in rcutorture test.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/rcu/rcu_torture.sh |    4 ++--
 .../ftrace_stress_test/ftrace_stress_test.sh       |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/device-drivers/rcu/rcu_torture.sh b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
index 0ead720..65c4fe0 100755
--- a/testcases/kernel/device-drivers/rcu/rcu_torture.sh
+++ b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
@@ -66,7 +66,7 @@ modprobe rcutorture > /dev/null 2>&1 || \
 	tst_brkm TCONF "Test requires rcutorture module"
 rmmod rcutorture > /dev/null 2>&1
 
-trap cleanup SIGINT
+trap cleanup INT
 
 rcu_type="rcu rcu_sync rcu_expedited rcu_bh rcu_bh_sync rcu_bh_expedited \
           srcu srcu_sync srcu_expedited srcu_raw srcu_raw_sync sched \
@@ -95,7 +95,7 @@ for type in $rcu_type; do
 
 	# check module status in dmesg
 	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`
-	if [ "$result_str" == "SUCCESS" ]; then
+	if [ "$result_str" = "SUCCESS" ]; then
 		tst_resm TPASS "$type: completed"
 	else
 		tst_resm TFAIL "$type: $result_str, see dmesg"
diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
index b6a44d8..6a111e9 100755
--- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
+++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
@@ -160,7 +160,7 @@ test_wait()
 	}
 }
 
-trap clean_up_exit SIGINT
+trap clean_up_exit INT
 
 # Should be run by root user
 if [ `id -ru` != 0 ]; then
-- 
1.7.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

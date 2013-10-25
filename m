Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VZgZN-0006xx-Kg
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 12:32:49 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VZgZM-0004p6-SO
	for ltp-list@lists.sourceforge.net; Fri, 25 Oct 2013 12:32:49 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9PCWgRq003544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Oct 2013 12:32:43 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9PCWf4o016754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Oct 2013 12:32:42 GMT
Received: from abhmt119.oracle.com (abhmt119.oracle.com [141.146.116.71])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9PCWfG5020286
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Oct 2013 12:32:41 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 25 Oct 2013 16:32:35 +0400
Message-Id: <1382704355-27129-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] kernel/connectors: TCONF vs TBROK,
	and fix check for root
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

Fixed check for root the same way as in
08dcfbb5a4ebad9319c54935a600ab936708c6da.

If the test is run on unsupported kernels it
should return TCONF, not TBROK. Fixed this.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/connectors/pec/run_pec_test |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/connectors/pec/run_pec_test b/testcases/kernel/connectors/pec/run_pec_test
index 7577ffa..2729485 100755
--- a/testcases/kernel/connectors/pec/run_pec_test
+++ b/testcases/kernel/connectors/pec/run_pec_test
@@ -33,14 +33,14 @@ export TST_COUNT=1
 
 exit_status=0
 
-if [ "$USER" != root ]; then
-	tst_brkm TBROK ignored "Test must be run as root"
+if [ $(id -u) != 0 ]; then
+	tst_brkm TCONF ignored "Test must be run as root"
 	exit 0;
 fi
 
 grep cn_proc /proc/net/connector > /dev/null
 if [ $? -ne 0 ]; then
-	tst_brkm TBROK ignored "Process Event Connector is not supported or kernel is below 2.6.26"
+	tst_brkm TCONF ignored "Process Event Connector is not supported or kernel is below 2.6.26"
 	exit 0;
 fi
 
@@ -77,7 +77,7 @@ run_case()
 	fi
 
 	if [ $ret2 -eq 2 ]; then
-		tst_brkm TBROK NULL "connector may not be supported"
+		tst_brkm TCONF NULL "connector may not be supported"
 		exit 0
 	fi
 
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

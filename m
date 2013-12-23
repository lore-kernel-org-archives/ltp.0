Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vv7ON-0002ix-15
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 15:26:03 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vv7OM-0002Tl-4K
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 15:26:02 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBNFPt5X001850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:56 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBNFPsMN008872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:54 GMT
Received: from ubhmt102.oracle.com (ubhmt102.oracle.com [156.151.24.7])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBNFPrEa025176
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:54 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 23 Dec 2013 19:25:46 +0400
Message-Id: <1387812348-23017-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/3] runtest/stress.part3: fix cmd for the rpc01 test
	case
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

Patch 9a7031ab2778600249947882d9f00acc9bcc1310 fixed some paths in
the rpc01 test script, so we shouldn't set TCbin before calling.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/stress.part3 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/runtest/stress.part3 b/runtest/stress.part3
index eac28d0..caa9a60 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -884,7 +884,7 @@ hangup01 hangup01
 
 mc_cmds mc_cmds
 mc_opts export TCsrc=$LTPROOT/testcases/network/multicast/mc_opts; mc_opts
-rpc01 export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rpc01; rpc01
+rpc01 rpc01
 run_rpc_tests.sh export TCbin=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; run_rpc_tests.sh
 perf_lan perf_lan
 
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

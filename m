Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSI5-0003hE-44
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:21 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSI4-0003vw-Cf
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:21 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPEaf006469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:14 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPDSu017991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:13 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPD89017974
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:13 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:32 +0400
Message-Id: <1395757480-27424-7-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 06/14] Removed run_rpc_tests.sh from runtest/rpc,
	runtest/stress.part3
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

Building of the rpt-tirpc test suite depends on the libtirpc availability,
but runtest/rpc and runtest/stress.part3 contain only test cases, which
are built by default.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/rpc          |    1 -
 runtest/stress.part3 |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/runtest/rpc b/runtest/rpc
index c9e5f0d..b65268c 100644
--- a/runtest/rpc
+++ b/runtest/rpc
@@ -2,7 +2,6 @@
 #
 # PLEASE READ THE README FILE IN /rpc BEFORE RUNNING THESE.
 #
-run_rpc_tests.sh run_rpc_tests.sh
 rpc01 rpc01
 rpcinfo rpcinfo01
 rup rup01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 1453eb1..9c860c4 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -890,6 +890,5 @@ hangup01 hangup01
 mc_cmds mc_cmds
 mc_opts export TCsrc=$LTPROOT/testcases/network/multicast/mc_opts; mc_opts
 rpc01 rpc01
-run_rpc_tests.sh export TCbin=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; run_rpc_tests.sh
 perf_lan perf_lan
 
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

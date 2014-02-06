Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WBOJk-000725-Nr
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 12:44:32 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WBOJj-0006dx-Uz
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 12:44:32 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s16CiPn8030849
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Feb 2014 12:44:26 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s16CiOUD025262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Feb 2014 12:44:25 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s16CiOLJ029394
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Feb 2014 12:44:24 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  6 Feb 2014 16:44:16 +0400
Message-Id: <1391690656-23047-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140205114813.GA24916@rei.suse.cz>
References: <20140205114813.GA24916@rei.suse.cz>
Subject: [LTP] [PATCH] nfsstress: fix paths
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/stress.part1                      |    8 ++++----
 testcases/network/nfs/nfsstress/nfsstress |    6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/runtest/stress.part1 b/runtest/stress.part1
index d879aaf..529716c 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -194,10 +194,10 @@ nfs03 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs
 nfs03 export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs04
 nfs03 export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs04
 
-nfsstress export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
-nfsstress export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
-nfsstress export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
-nfsstress export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
+nfsstress export VERSION=2 SOCKET_TYPE=udp; nfsstress 20 50 1
+nfsstress export VERSION=2 SOCKET_TYPE=tcp; nfsstress 20 50 1
+nfsstress export VERSION=3 SOCKET_TYPE=udp; nfsstress 20 50 1
+nfsstress export VERSION=3 SOCKET_TYPE=tcp; nfsstress 20 50 1
 
 nfsx-linux export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; fsx.sh
 nfsx-linux export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; fsx.sh
diff --git a/testcases/network/nfs/nfsstress/nfsstress b/testcases/network/nfs/nfsstress/nfsstress
index 3e078d9..6e337d9 100755
--- a/testcases/network/nfs/nfsstress/nfsstress
+++ b/testcases/network/nfs/nfsstress/nfsstress
@@ -43,11 +43,9 @@ $trace_logic
 # Initialize local variables
 #-----------------------------------------------------------------------
 TC=${TC:=nfsstress}
-TCbin=${TCbin:=`pwd`}
-TCdat=${TCdat:=$TCbin}
+TCbin=${TCbin:=$LTPROOT/testcases/bin}
 TCsrc=${TCsrc:=$TCbin}
-TCtmp=${TCtmp:=$TCbin/$TC$$}
-TCdump=${TCdump:=$TCbin}
+TCtmp=${TCtmp:=$TMPDIR/$TC$$}
 RHOST=${RHOST:=`hostname|awk {'print $1'}`}
 export TCID=$TC
 export TST_TOTAL=1
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VvNqe-0005Pg-Mf
	for ltp-list@lists.sourceforge.net; Tue, 24 Dec 2013 09:00:20 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VvNqd-00052A-Tc
	for ltp-list@lists.sourceforge.net; Tue, 24 Dec 2013 09:00:20 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBO90DHE025910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Dec 2013 09:00:14 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBO90CHL003255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Dec 2013 09:00:13 GMT
Received: from ubhmt108.oracle.com (ubhmt108.oracle.com [156.151.24.13])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBO90CEl003240
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Dec 2013 09:00:12 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 24 Dec 2013 13:00:05 +0400
Message-Id: <1387875605-801-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] runtest/stress.part1: fix cmdline for nfsstress
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

TCbin is exported with an incorrect path therefore nfsstress
test cases fail.

Fixed with the correct path.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/stress.part1 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/runtest/stress.part1 b/runtest/stress.part1
index d879aaf..3b922f3 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -194,10 +194,10 @@ nfs03 export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs
 nfs03 export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfs04
 nfs03 export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfs04
 
-nfsstress export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
-nfsstress export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
-nfsstress export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
-nfsstress export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/network/nfs/nfsstress; nfsstress 20 50 1
+nfsstress export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfsstress 20 50 1
+nfsstress export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfsstress 20 50 1
+nfsstress export VERSION=3 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; nfsstress 20 50 1
+nfsstress export VERSION=3 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; nfsstress 20 50 1
 
 nfsx-linux export VERSION=2 SOCKET_TYPE=udp; export TCbin=$LTPROOT/testcases/bin; fsx.sh
 nfsx-linux export VERSION=2 SOCKET_TYPE=tcp; export TCbin=$LTPROOT/testcases/bin; fsx.sh
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

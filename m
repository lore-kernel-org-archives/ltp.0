Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VdsoL-0003yr-VP
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 02:25:38 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VdsoL-0005tX-5F
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 02:25:37 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA62PUPk026465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 02:25:31 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA62PTcX009635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 02:25:30 GMT
Received: from abhmt101.oracle.com (abhmt101.oracle.com [141.146.116.53])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA62PT5Z009630
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 02:25:29 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Wed,  6 Nov 2013 10:25:23 +0800
Message-Id: <1383704723-577-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] rpc01: fix $TCbin and $TCtmp
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

The values of TCbin and TCtmp should be swapped, and `rpc1' is in TCbin,
not TCtmp.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/rpc01 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index ef97a95..c16493c 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -36,9 +36,9 @@
 $trace_logic
 this_file=${0##*/}
 TC=${TC:=rpc01}
-TCbin=${TCbin:=`pwd`}
+TCbin=${TCbin:=$LTPROOT/testcases/bin}
 TCdat=${TCdat:=$TCbin/datafiles}
-TCtmp=${TCtmp:=$LTPROOT/testcases/bin}
+TCtmp=${TCtmp:=`pwd`}
 NUMLOOPS=${NUMLOOPS:=3}
 RHOST=${RHOST:=`hostname`}
 CLEANUP=${CLEANUP:="ON"}
@@ -68,7 +68,7 @@ do_test()
     do
       for FILE in $DATAFILES
       do
-	$TCtmp/rpc1 -s $RHOST -f $TCdat/$FILE
+	$TCbin/rpc1 -s $RHOST -f $TCdat/$FILE
 	[ $? -eq 0 ] || end_testcase "Fail on using $FILE"
       done
       COUNT=`expr $COUNT + 1`
-- 
1.8.4.2


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

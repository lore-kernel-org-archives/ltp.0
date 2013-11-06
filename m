Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vdvfh-0002vl-7X
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 05:28:53 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vdvfg-0008H9-F7
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 05:28:53 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA65SjHA021645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 05:28:46 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA65Sj1C002965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 05:28:45 GMT
Received: from abhmt114.oracle.com (abhmt114.oracle.com [141.146.116.66])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA65SiBm002956
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 05:28:45 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Wed,  6 Nov 2013 13:28:38 +0800
Message-Id: <1383715718-507-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1383704723-577-1-git-send-email-xu.simon@oracle.com>
References: <1383704723-577-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH V2] rpc01: fix $TCbin and $TCtmp and data file names
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
not TCtmp.  Also correct the file names 'file.1' and 'file.2' which do not
exist.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/rpc01 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index ef97a95..8594835 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -36,13 +36,13 @@
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
-DATAFILES=${DATAFILES:="file.1 file.2"}
+DATAFILES=${DATAFILES:="bin.med bin.sm"}
 
 #=============================================================================
 # FUNCTION NAME:        do_test
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

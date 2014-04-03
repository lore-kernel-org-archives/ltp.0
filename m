Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WVhWr-0003rr-1F
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 13:18:01 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WVhWn-00044q-2Y
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 13:18:00 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s33DHote030397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Apr 2014 13:17:51 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s33DHnNM003950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Apr 2014 13:17:50 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s33DHnjY007935
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Apr 2014 13:17:49 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  3 Apr 2014 17:17:44 +0400
Message-Id: <1396531064-16957-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1396530521-16789-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1396530521-16789-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2] numa01.sh: numademo fixes
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

1) numademo does not accept a 'msize' argument. I think it was an initial
typo mistake that numanode was invoked as
  numanode -c msize
instead of
  numanode -c ${msize}k

2) I think test07 should return TPASS if $x is 0 (not 1), because this test
verifies that after execution of `numanode` the OS updates interleave_hit
values of each of the nodes. And if a node doesn't get a minimum increase,
then it's a failure.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---

Just updated description 2)

 testcases/kernel/numa/numa01.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 19a8f71..5812ca3 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -577,7 +577,7 @@ test07()
         COUNTER=$[$COUNTER+1]
     done
 
-    numademo -c msize > $LTPTMP/demolog
+    numademo -c ${msize}k > $LTPTMP/demolog
     sleep 2s        #In RHEL collection of statistics takes more time.
 
     numastat > $LTPTMP/numalog
@@ -596,7 +596,7 @@ test07()
         fi
         COUNTER=$[$COUNTER+1]
     done
-    if [ $x -eq 1 ]
+    if [ $x -eq 0 ]
     then
         tst_resm TPASS "NUMADEMO policies  -TEST07 PASSED !!"
         return 0
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

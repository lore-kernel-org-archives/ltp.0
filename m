Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WVhO2-0007Qh-93
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 13:08:54 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WVhO1-0005Eq-Cj
	for ltp-list@lists.sourceforge.net; Thu, 03 Apr 2014 13:08:54 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s33D8lox024304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Apr 2014 13:08:47 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s33D8kWf007805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Apr 2014 13:08:47 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s33D8kvO007801
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Apr 2014 13:08:46 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  3 Apr 2014 17:08:41 +0400
Message-Id: <1396530521-16789-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] numa01.sh: numademo fixes
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

2) I think test07 should return TPASS if $x is 0 (not 1).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
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

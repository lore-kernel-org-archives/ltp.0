Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WQAi4-000765-DX
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 07:14:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WQAi1-0002lU-ES
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 07:14:44 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2J7EYEE018546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Mar 2014 07:14:35 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2J7EY57012203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Mar 2014 07:14:34 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2J7EYOJ007572
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Mar 2014 07:14:34 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 19 Mar 2014 11:15:00 +0400
Message-Id: <1395213300-518-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] lib/test.sh: replace LTP_TST_CNT with TST_COUNT
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

The tools/apicmds require TST_COUNT to be set.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index b857dc4..19b54da 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -22,7 +22,7 @@
 #
 
 export LTP_RET_VAL=0
-export LTP_TST_CNT=1
+export TST_COUNT=1
 
 # Exit values map
 tst_flag2mask()
@@ -45,11 +45,11 @@ tst_resm()
 	local mask=$?
 	LTP_RET_VAL=$((LTP_RET_VAL|mask))
 
-	echo "$TCID $LTP_TST_CNT $1 : $2"
+	echo "$TCID $TST_COUNT $1 : $2"
 
 	case "$1" in
 	TPASS|TFAIL)
-	LTP_TST_CNT=$((LTP_TST_CNT+1));;
+	TST_COUNT=$((TST_COUNT+1));;
 	esac
 }
 
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

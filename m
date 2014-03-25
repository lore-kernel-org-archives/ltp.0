Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSID-0003rZ-65
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:29 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSIC-0005wV-Er
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:29 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPMA3031117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:23 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPLdN005432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:22 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPLlY018315
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:21 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:39 +0400
Message-Id: <1395757480-27424-14-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 13/14] Removed runtest/rpctirpc and runtest/tirpc
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

These files are useless now. We should use:
 * runtest/rpc_tests - for TS-RPC
 * runtest/tirpc_tests - for TI-RPC
instead.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/rpctirpc |    5 -----
 runtest/tirpc    |    5 -----
 2 files changed, 0 insertions(+), 10 deletions(-)
 delete mode 100644 runtest/rpctirpc
 delete mode 100644 runtest/tirpc

diff --git a/runtest/rpctirpc b/runtest/rpctirpc
deleted file mode 100644
index 5748d63..0000000
--- a/runtest/rpctirpc
+++ /dev/null
@@ -1,5 +0,0 @@
-#DESCRIPTION:Transport Independant Remote Procedure Call
-#
-# PLEASE READ THE README FILE IN /rpc BEFORE RUNNING THESE.
-#
-run_tirpc_tests.sh export TCbin=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; run_tirpc_tests.sh
diff --git a/runtest/tirpc b/runtest/tirpc
deleted file mode 100644
index 5748d63..0000000
--- a/runtest/tirpc
+++ /dev/null
@@ -1,5 +0,0 @@
-#DESCRIPTION:Transport Independant Remote Procedure Call
-#
-# PLEASE READ THE README FILE IN /rpc BEFORE RUNNING THESE.
-#
-run_tirpc_tests.sh export TCbin=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; run_tirpc_tests.sh
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

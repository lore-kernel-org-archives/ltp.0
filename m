Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WuikT-0005aY-HW
	for ltp-list@lists.sourceforge.net; Wed, 11 Jun 2014 13:39:29 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WuikS-0008VZ-9L
	for ltp-list@lists.sourceforge.net; Wed, 11 Jun 2014 13:39:28 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s5BDdLZm022841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Jun 2014 13:39:22 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5BDdKGl016548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Jun 2014 13:39:21 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5BDdKxG015238
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Jun 2014 13:39:20 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 11 Jun 2014 17:39:50 +0400
Message-Id: <1402493990-3761-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network/nfsstat01: umount only if it was mounted
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

The test will mount (bind) export directory when nfs's version is 4,
so add the check before 'umount' in cleanup function.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfsstat01/nfsstat01 |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index 229e2c3..4a34d93 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -215,12 +215,15 @@ $trace_logic
 
    echo "Unmounting EXPORTDIR"
    /usr/sbin/exportfs -u $HOST:$EXPORTDIR
-   umount $EXPORTDIR
-   sleep 3
-   rm -rf $EXPORTDIR
+
    if [ "x$NFS_TYPE" = "xnfs4" ]; then
+       umount $EXPORTDIR
+       sleep 3
        rm -rf /export$EXPORTDIR
    fi
+
+   rm -rf $EXPORTDIR
+
 }
 
 #=============================================================================
-- 
1.7.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

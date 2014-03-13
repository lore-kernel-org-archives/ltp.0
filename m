Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WO4uU-0003FS-Ap
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 12:38:54 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WO4uT-00050D-9P
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 12:38:54 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2DCckWK024702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:47 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2DCckLm004449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:46 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2DCckwp004444
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:46 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Mar 2014 16:38:25 +0400
Message-Id: <1394714306-9678-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/3] isofs.sh: be more quiet
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
 testscripts/isofs.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
index 9031922..fd42a3c 100755
--- a/testscripts/isofs.sh
+++ b/testscripts/isofs.sh
@@ -131,7 +131,7 @@ for mkisofs_opt in \
 	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
 do
         echo "Running mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR  Command"
-	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR
+	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> /dev/null
 	if [ $? != 0 ]
 	then
 		rm -rf isofs.iso $MNT_POINT $TEMP_DIR
@@ -160,7 +160,7 @@ do
 			exit 1
 		fi
 		echo "Running ls -lR $MNT_POINT Command"
-		ls -lR $MNT_POINT
+		ls -lR $MNT_POINT > /dev/null
 		exportfs -i -o no_root_squash,rw *:$MNT_POINT
 		exportfs -u :$MNT_POINT
 		umount $MNT_POINT
-- 
1.7.9.5


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

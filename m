Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WO4uS-0001rO-KF
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 12:38:52 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WO4uR-000508-PW
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 12:38:52 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2DCcj4e003804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:46 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2DCcinB029607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:45 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s2DCci4r010191
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 12:38:44 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Mar 2014 16:38:24 +0400
Message-Id: <1394714306-9678-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/3] isofs.sh: use $TMPDIR for temporary directory
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

If $TMPDIR is not set, use /tmp.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testscripts/isofs.sh |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
index e6a3b09..9031922 100755
--- a/testscripts/isofs.sh
+++ b/testscripts/isofs.sh
@@ -60,21 +60,22 @@ NO_CLEANUP=""
   }
 
 #Initialize directory variables
-    MNT_POINT="/tmp/isofs_$$"
+    TMPDIR=${TMPDIR:-/tmp}
+    MNT_POINT="$TMPDIR/isofs_$$"
     COPY_DIR="/etc/"
-    TEMP_DIR="/tmp/for_isofs_test"
+    TEMP_DIR="$TMPDIR/for_isofs_test"
     MAKE_FILE_SYS_DIR=$TEMP_DIR$COPY_DIR
 
    while getopts :hnd: arg
       do  case $arg in
 	  d)
              COPY_DIR=$OPTARG
-    	     MAKE_FILE_SYS_DIR="/tmp/for_isofs_test"$COPY_DIR
+    	     MAKE_FILE_SYS_DIR=${TEMP_DIR}${COPY_DIR}
 	    ;;
 	  h)
 	    echo ""
             echo "n - The directories created will not be removed"
-            echo "d - Specify a directory to copy into /tmp"
+            echo "d - Specify a directory to copy into $TEMP_DIR"
 	    echo "h - Help options"
 	    echo ""
 	    usage
@@ -133,7 +134,7 @@ do
 	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR
 	if [ $? != 0 ]
 	then
-		rm -rf isofs.iso $MNT_POINT
+		rm -rf isofs.iso $MNT_POINT $TEMP_DIR
 		echo "FAILED: mkisofs -o isofs.iso $mkisofs_opt $MAKE_FILE_SYS_DIR failed"
 		exit 1
 	fi
@@ -154,7 +155,7 @@ do
 		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
 		if [ $? != 0 ]
 		then
-			rm -rf isofs.iso $MNT_POINT
+			rm -rf isofs.iso $MNT_POINT $TEMP_DIR
 			echo "FAILED: mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT failed"
 			exit 1
 		fi
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

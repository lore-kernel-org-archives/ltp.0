Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WS1kX-0004QV-HW
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 10:04:57 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WS1kV-0004gB-O3
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 10:04:57 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2OA4nQw000688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Mar 2014 10:04:49 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2OA4mI9024492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Mar 2014 10:04:48 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2OA4mC0028918
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Mar 2014 10:04:48 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 24 Mar 2014 14:04:39 +0400
Message-Id: <1395655481-12161-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <532C4201.3030605@oracle.com>
References: <532C4201.3030605@oracle.com>
Subject: [LTP] [PATCH V2 2/4] testscripts/isofs.sh: use the new shell
	interface
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
 testscripts/isofs.sh |  105 ++++++++++++++++++++++---------------------------
 1 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
index ec1f2fc..2bb2555 100755
--- a/testscripts/isofs.sh
+++ b/testscripts/isofs.sh
@@ -24,26 +24,34 @@
 # mounts the ISO9660 file system with different mount options.
 #
 
-USAGE="$0"
+TCID=isofs
+TST_TOTAL=77
+. test.sh
+
 NO_CLEANUP=""
 
 usage()
 {
-	echo "USAGE: $USAGE <optional> -n -h -d [directory name]"
+	echo "USAGE: $0 <optional> -n -h -d [directory name]"
 	exit
 }
 
-#Initialize directory variables
-MNT_POINT="/tmp/isofs_$$"
+cleanup()
+{
+	if [ "$NO_CLEANUP" = "no" ]; then
+		tst_resm TINFO "Temporary directory $PWD was not removed"
+	else
+		tst_rmdir
+	fi
+}
+
+
 COPY_DIR="/etc/"
-TEMP_DIR="/tmp/for_isofs_test"
-MAKE_FILE_SYS_DIR=$TEMP_DIR$COPY_DIR
 
 while getopts :hnd: arg; do
 	case $arg in
 	d)
 		COPY_DIR=$OPTARG
-		MAKE_FILE_SYS_DIR="/tmp/for_isofs_test"$COPY_DIR
 		;;
 	h)
 		echo ""
@@ -60,32 +68,22 @@ while getopts :hnd: arg; do
 	esac
 done
 
-##############################################################
-#
-# Make sure that uid=root is running this script.
-# Validate the command line arguments.
-#
-##############################################################
-
-if [ $UID != 0 ]
-then
-	echo "FAILED: Must have root access to execute this script"
-	exit 1
+if [ ! -e "$COPY_DIR" ]; then
+	tst_brkm TCONF "$COPY_DIR not found"
 fi
 
+tst_require_root
+
+tst_tmpdir
+TST_CLEANUP=cleanup
+
+MNT_POINT="$PWD/mnt"
+MAKE_FILE_SYS_DIR="$PWD/tmp/$COPY_DIR"
+
 mkdir -p -m 777 $MNT_POINT
 mkdir -p $MAKE_FILE_SYS_DIR
 
-
-if [ -e "$COPY_DIR" ]; then
-	cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
-else
-	echo "$COPY_DIR not found"
-	echo "use the -d option to copy a different directory into"
-	echo "/tmp to makethe ISO9660 file system with different"
-	echo "options"
-	usage
-fi
+cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
 
 # Make ISO9660 file system with different options.
 # Mount the ISO9660 file system with different mount options.
@@ -99,14 +97,17 @@ for mkisofs_opt in \
 	"-f -l -D -J -L -R" \
 	"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
 do
-	echo "Running mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR  Command"
+	rm -f isofs.iso
 	mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR
-	if [ $? != 0 ]
-	then
-		rm -rf isofs.iso $MNT_POINT
-		echo "FAILED: mkisofs -o isofs.iso $mkisofs_opt $MAKE_FILE_SYS_DIR failed"
-		exit 1
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS \
+			"mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
+	else
+		tst_resm TFAIL \
+			tst_resm TFAIL "mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR"
+		continue
 	fi
+
 	for mount_opt in \
 		"loop" \
 		"loop,norock" \
@@ -120,36 +121,24 @@ do
 		"loop,block=512,unhide,session=2"
 		# "loop,sbsector=32"
 	do
-		echo "Running mount -o $mount_opt isofs.iso $MNT_POINT Command"
 		mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT
-		if [ $? != 0 ]
-		then
-			rm -rf isofs.iso $MNT_POINT
-			echo "FAILED: mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT failed"
-			exit 1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				"mount -t iso9660 -o $mount_opt isofs.iso $MNT_POINT"
+			continue
 		fi
-		echo "Running ls -lR $MNT_POINT Command"
+
 		ls -lR $MNT_POINT
 		exportfs -i -o no_root_squash,rw *:$MNT_POINT
 		exportfs -u :$MNT_POINT
+
 		umount $MNT_POINT
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "umount $MNT_POINT"
+		fi
+
+		tst_resm TPASS "mount/umount with \"$mount_opt\" options"
 	done
-	rm -rf isofs.iso
 done
 
-#######################################################
-#
-# Just before exit, perform the cleanup.
-#
-#######################################################
-
-if [ "$NO_CLEANUP" == "no" ]; then
-	echo "$MAKE_FILE_SYS_DIR and $MNT_POINT were not removed"
-	echo "These directories will have to be removed manually"
-else
-	rm -rf $TEMP_DIR
-	rm -rf $MNT_POINT
-fi
-
-echo "PASSED: $0 passed!"
-exit 0
+tst_exit
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

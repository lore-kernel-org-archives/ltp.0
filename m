Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2GAV-0004Nf-Jc
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:03 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2GAS-0008QI-Vg
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:03 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t599ntWR011247
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t599nsfC027825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:55 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t599nsGw001516
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:54 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  9 Jun 2015 12:49:42 +0300
Message-Id: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/5] acl_test01: Fixes
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

Converted the test case to use tst_tmpdir instead of local juggling
with $TMP.

When we execute LTP, $PATH includes $LTPROOT/testcases/bin, so there
is no reason to set $TCbin explicitly. Therefore, removed $TCbin.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/admin_tools                 |    2 +-
 testcases/kernel/fs/acls/acl_test01 |   56 ++++++++++++++--------------------
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/runtest/admin_tools b/runtest/admin_tools
index 559757e..0a46468 100644
--- a/runtest/admin_tools
+++ b/runtest/admin_tools
@@ -6,4 +6,4 @@ cron_allow01 cron_allow01
 cron_dirs_checks01 cron_dirs_checks01
 at_deny01 at_deny01
 at_allow01 at_allow01
-acl_test01 export TCbin=$LTPROOT/testcases/bin;acl_test01
+acl_test01 acl_test01
diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index 328ff74..be88aa8 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -43,16 +43,13 @@ export TST_COUNT=1
 
 . test.sh
 
-TMP=${TMP:=/tmp}
-
 TEST_USER1="acltest1"
 TEST_USER1_GROUP="users"
 TEST_USER1_PASSWD="ltp_test_pass1"
-TEST_USER1_HOMEDIR="$TMP/tacl/mount-ext3/$TEST_USER1"
+TEST_USER1_HOMEDIR="mount-ext3/$TEST_USER1"
 
-FILE_ACL="$TMP/tacl/mount-ext3/test_file"
-FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
-TCbin=`pwd`
+FILE_ACL="mount-ext3/test_file"
+FILE_ACL_LINK="mount-ext3/test_file_link"
 
 COMMAND=$(command -v "getenforce" "setenforce" |wc -l)
 if [ $COMMAND -eq 2 ]; then
@@ -66,9 +63,6 @@ fi
 #-----------------------------------------------------------------------
 
 do_setup(){
-
-	tst_require_root
-
 	rm -f $FILE_ACL
 	rm -f $FILE_ACL_LINK
 
@@ -87,12 +81,12 @@ do_setup(){
 	rm -rf $TEST_USER1_HOMEDIR
 	userdel $TEST_USER1 > /dev/null 2>&1
 	sleep 1
-	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
+	useradd -d $(readlink -f $TEST_USER1_HOMEDIR) -m \
+	    -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
 
 	if [ $? -ne 0 ]; then
 		tst_brkm TBROK "Could not add test user $TEST_USER1."
 	fi
-
 }
 
 #-----------------------------------------------------------------------
@@ -100,13 +94,13 @@ do_setup(){
 #-----------------------------------------------------------------------
 
 do_cleanup() {
-	rm -rf $TEST_USER1_HOMEDIR
 	userdel $TEST_USER1 > /dev/null 2>&1
-	rm -f $FILE_ACL > /dev/null 2>&1
-	rm -f $FILE_ACL_LINK > /dev/null 2>&1
-	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
+
+	MOUNT_POINT=$(readlink -f "mount-ext3")
+	mount | grep $MOUNT_POINT && umount -d $MOUNT_POINT
 	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
-	rm -rf $TMP/tacl
+
+	tst_rmdir
 
 	# We set it back to Enforcing.
 	if [ "$SELINUX" = "Enforcing" ]; then
@@ -126,18 +120,15 @@ then
 else
 	tst_require_root
 
-	if ! ( test -d $TMP/tacl || mkdir -m 777 $TMP/tacl) ; then
-		tst_brkm TBROK "Failed to create $TMP/tacl directory."
-	fi
-
-	trap do_cleanup EXIT
+	tst_tmpdir
+	TST_CLEANUP=do_cleanup
 
 	#	The  following  commands  can  be  used as an example of using
 	#	a loopback device.
 
-	dd if=/dev/zero of=$TMP/tacl/blkext3 bs=1k count=10240 && chmod 777 $TMP/tacl/blkext3
+	dd if=/dev/zero of=blkext3 bs=1k count=10240 && chmod 777 blkext3
 	if [ $? -ne 0 ] ; then
-		tst_brkm TBROK "Failed to create $TMP/tacl/blkext3"
+		tst_brkm TBROK "Failed to create blkext3"
 	fi
 
 	# Avoid hardcoded loopback device values (-f tries to find the first
@@ -146,7 +137,7 @@ else
 		tst_brkm TCONF "[ losetup.1 ] Failed to find an available loopback device -- is the required support compiled in your kernel?"
 	fi
 
-	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
+	if ! losetup $LOOP_DEV blkext3 2>&1 > /dev/null; then
 		echo ""
 		tst_brkm TCONF "[ losetup.2 ] Failed to setup the device."
 	fi
@@ -154,8 +145,8 @@ else
 	mount | grep ext2
 	if [ $? -ne 0 ]; then
 		mkfs -t ext3 $LOOP_DEV #> /dev/null 2>&1
-		mkdir  -m 777 $TMP/tacl/mount-ext3
-		mount -t ext3 -o defaults,acl,user_xattr $LOOP_DEV $TMP/tacl/mount-ext3
+		mkdir -m 777 mount-ext3
+		mount -t ext3 -o defaults,acl,user_xattr $LOOP_DEV mount-ext3
 		if [ $? -ne 0 ]
 		then
 			tst_resm TCONF "[ mount ] Make sure that ACL (Access Control List)"
@@ -165,8 +156,8 @@ else
 	else
 
 		mkfs -t ext2 $LOOP_DEV
-		mkdir  -m 777 $TMP/tacl/mount-ext3
-		mount -t ext2 -o defaults,acl,user_xattr $LOOP_DEV $TMP/tacl/mount-ext3
+		mkdir -m 777 mount-ext3
+		mount -t ext2 -o defaults,acl,user_xattr $LOOP_DEV mount-ext3
 		if [ $? -ne 0 ]
 		then
 			tst_resm TCONF "FAILED: [ mount ] Make sure that ACL (Access Control List)"
@@ -188,7 +179,7 @@ then
 	setfacl -m u:$TEST_USER1:r $FILE_ACL
 
 	echo "Trying extended acls for files"
-	${TCbin}/acl_file_test $FILE_ACL
+	acl_file_test $FILE_ACL
 	if [ $? -ne 0 ]
 	then
 		tst_resm TFAIL "Extended acls for files."
@@ -197,7 +188,7 @@ then
 	fi
 
 	echo "Trying extended acls for file links"
-	${TCbin}/acl_link_test $FILE_ACL_LINK
+	acl_link_test $FILE_ACL_LINK
 	if [ $? -ne 0 ]
 	then
 		tst_resm TFAIL "Extended acls for links."
@@ -217,7 +208,7 @@ else
 	setfacl -mu:root:r $FILE_ACL
 
 	echo "Trying extended acls for files"
-	${TCbin}/acl_file_test $FILE_ACL
+	acl_file_test $FILE_ACL
 	if [ $? -ne 0 ]
 	then
 		tst_resm TFAIL "Extended acls for files."
@@ -226,7 +217,7 @@ else
 	fi
 
 	echo "Trying extended acls for file links"
-	${TCbin}/acl_link_test $FILE_ACL_LINK
+	acl_link_test $FILE_ACL_LINK
 	if [ $? -ne 0 ]
 	then
 		tst_resm TFAIL "Extended acls for links."
@@ -239,7 +230,6 @@ else
 
 	su $TEST_USER1 -c "$0"
 	echo ""
-	do_cleanup
 fi
 
 tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

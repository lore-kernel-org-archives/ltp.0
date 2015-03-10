Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1YVD9F-0005Xy-Bs
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 05:56:09 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVD9D-0006b8-E2
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 05:56:09 +0000
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Mar 2015 13:55:54 +0800
Message-Id: <1425966954-887-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH v2] fs/acls: fix some permission issue in the testcase
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

* Use 'test.sh'.

* Do some cleanup.

* Remove useless changes.

* Waive the consideration of SElinux Disabled and Permitive situation.

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/fs/acls/acl_test01 | 62 +++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index af65213..93f6d80 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -41,6 +41,8 @@ export TCID=acltest01
 export TST_TOTAL=5
 export TST_COUNT=1
 
+. test.sh
+
 TMP=${TMP:=/tmp}
 
 TEST_USER1="acltest1"
@@ -52,18 +54,28 @@ FILE_ACL="$TMP/tacl/mount-ext3/test_file"
 FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
 TCbin=`pwd`
 
+SELINUX=$(getenforce)
+
 #-----------------------------------------------------------------------
 # FUNCTION:  do_setup
 #-----------------------------------------------------------------------
 
 do_setup(){
 
+	tst_require_root
+
 	rm -f $FILE_ACL
 	rm -f $FILE_ACL_LINK
 
+	# We couldn't consider whether the SElinux is Disable or Permissive.
+	# We only set it to Permissive when it it Enforcing.
+	if [ "$SELINUX" = "Enforcing" ]; then
+		echo "set the SElinux to Permissive."
+		setenforce 0
+	fi
+
 	if [ "x$TEST_USER1_HOMEDIR" = "x" ]; then
-		echo "Could not find user $TEST_USER1's home directory."
-		exit 1
+		tst_brkm TCONF "Could not find user $TEST_USER1's home directory."
 	fi
 
 	# XXX (garrcoop): why is cleanup junk being done in setup??? Bad test!!!
@@ -73,8 +85,7 @@ do_setup(){
 	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
 
 	if [ $? -ne 0 ]; then
-		echo "Could not add test user $TEST_USER1."
-		exit 1
+		tst_brkm TCONF "Could not add test user $TEST_USER1."
 	fi
 
 }
@@ -91,6 +102,12 @@ do_cleanup() {
 	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
 	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
 	rm -rf $TMP/tacl
+
+	# We set it back to Enforcing.
+	if [ "$SELINUX" = "Enforcing" ]; then
+		echo "set the SElinux back to Enforcing."
+		setenforce 1
+	fi
 }
 
 #-----------------------------------------------------------------------
@@ -103,13 +120,11 @@ then
 	echo ""
 else
 	if [ $(id -ru) != 0 ]; then
-		tst_resm TCONF "must be root to execute this script"
-		exit 0
+		tst_brkm TCONF "Must be root to execute this script"
 	fi
 
 	if ! ( test -d $TMP/tacl || mkdir -m 777 $TMP/tacl) ; then
-		tst_resm TCONF "failed to create $TMP/tacl directory."
-		exit 1
+		tst_brkm TCONF "Failed to create $TMP/tacl directory."
 	fi
 
 	trap do_cleanup EXIT
@@ -119,21 +134,18 @@ else
 
 	dd if=/dev/zero of=$TMP/tacl/blkext3 bs=1k count=10240 && chmod 777 $TMP/tacl/blkext3
 	if [ $? -ne 0 ] ; then
-		tst_resm TCONF "Failed to create $TMP/tacl/blkext3"
-		exit 0
+		tst_brkm TCONF "Failed to create $TMP/tacl/blkext3"
 	fi
 
 	# Avoid hardcoded loopback device values (-f tries to find the first
 	# available loopback device name)!
 	if ! LOOP_DEV=$(losetup -f) || [ "x$LOOP_DEV" = x ]; then
-		tst_resm TCONF "[ losetup.1 ] Failed to find an available loopback device -- is the required support compiled in your kernel?"
-		exit 0
+		tst_brkm TCONF "[ losetup.1 ] Failed to find an available loopback device -- is the required support compiled in your kernel?"
 	fi
 
 	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
 		echo ""
-		tst_resm TCONF "[ losetup.2 ] Failed to setup the device."
-		exit 0
+		tst_brkm TCONF "[ losetup.2 ] Failed to setup the device."
 	fi
 
 	mount | grep ext2
@@ -180,20 +192,18 @@ then
 	${TCbin}/acl_file_test $FILE_ACL
 	if [ $? -ne 0 ]
 	then
-		EXIT_CODE=1
-		echo "Extended acls for files (FAILED)"
+		tst_brkm TFAIL "Extended acls for files."
 	else
-		echo "Extended acls for files (PASSED)"
+		tst_resm TPASS "Extended acls for files."
 	fi
 
 	echo "Trying extended acls for file links"
 	${TCbin}/acl_link_test $FILE_ACL_LINK
 	if [ $? -ne 0 ]
 	then
-		EXIT_CODE=1
-		echo "Extended acls for links (FAILED)"
+		tst_brkm TFAIL "Extended acls for links."
 	else
-		echo "Extended acls for links (PASSED)"
+		tst_resm TPASS "Extended acls for links."
 	fi
 else
 	do_setup
@@ -211,20 +221,18 @@ else
 	${TCbin}/acl_file_test $FILE_ACL
 	if [ $? -ne 0 ]
 	then
-		EXIT_CODE=1
-		echo "Extended acls for files (FAILED)"
+		tst_brkm TFAIL "Extended acls for files."
 	else
-		echo "Extended acls for files (PASSED)"
+		tst_resm TPASS "Extended acls for files."
 	fi
 
 	echo "Trying extended acls for file links"
 	${TCbin}/acl_link_test $FILE_ACL_LINK
 	if [ $? -ne 0 ]
 	then
-		EXIT_CODE=1
-		echo "Extended acls for links (FAILED)"
+		tst_brkm TFAIL "Extended acls for links."
 	else
-		echo "Extended acls for links (PASSED)"
+		tst_resm TPASS "Extended acls for links."
 	fi
 
 	chown $TEST_USER1 $FILE_ACL
@@ -235,4 +243,4 @@ else
 	do_cleanup
 fi
 
-exit $EXIT_CODE
+tst_exit
-- 
1.8.3.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

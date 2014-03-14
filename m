Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vlee@freedesktop.org>) id 1WOFnn-0000QV-TM
	for ltp-list@lists.sourceforge.net; Fri, 14 Mar 2014 00:16:43 +0000
Received: from gabe.freedesktop.org ([131.252.210.177])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WOFnk-0005Vi-Jn
	for ltp-list@lists.sourceforge.net; Fri, 14 Mar 2014 00:16:43 +0000
From: Vinson Lee <vlee@freedesktop.org>
Date: Thu, 13 Mar 2014 17:00:21 -0700
Message-Id: <1394755221-5354-1-git-send-email-vlee@freedesktop.org>
Subject: [LTP] [PATCH] Use absolute path for losetup.
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

From: Vinson Lee <vlee@twitter.com>

/sbin may not be in the default $PATH.

Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 runltp                                |  6 +++---
 testcases/kernel/fs/acl/tacl_xattr.sh |  2 +-
 testcases/kernel/fs/acls/acl_test01   |  6 +++---
 testcases/kernel/fs/mongo/test.sh     | 10 +++++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/runltp b/runltp
index 3c8b94e..673e2ef 100755
--- a/runltp
+++ b/runltp
@@ -952,13 +952,13 @@ create_block()
         return 1
     else
         ##search for an unused loop dev
-        LOOP_DEV=$(losetup -f)
+        LOOP_DEV=$(/sbin/losetup -f)
         if [ $? -ne 0 ]; then
             echo "no unused loop device is found"
             return 1
         else
             ##attach the created file to loop dev.
-            losetup $LOOP_DEV ${TMP}/test.img
+            /sbin/losetup $LOOP_DEV ${TMP}/test.img
             if [ $? -ne 0 ]; then
                 echo "losetup failed to create block device"
                 return 1
@@ -988,7 +988,7 @@ set_block_device()
 
 cleanup()
 {
-    [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
+    [ "$LOOP_DEV" ] && /sbin/losetup -d $LOOP_DEV
     rm -rf ${TMP}
 }
 
diff --git a/testcases/kernel/fs/acl/tacl_xattr.sh b/testcases/kernel/fs/acl/tacl_xattr.sh
index 99f6a95..5fd711b 100755
--- a/testcases/kernel/fs/acl/tacl_xattr.sh
+++ b/testcases/kernel/fs/acl/tacl_xattr.sh
@@ -80,7 +80,7 @@ fi
 dd if=/dev/zero of=tacl/blkext2 bs=1k count=10240
 chmod 777 tacl/blkext2
 
-losetup /dev/loop0 tacl/blkext2 2>&1 > /dev/null
+/sbin/losetup /dev/loop0 tacl/blkext2 2>&1 > /dev/null
 if [ $? != 0 ]
 then
 	echo ""
diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index af65213..9dfcee1 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -89,7 +89,7 @@ do_cleanup() {
 	rm -f $FILE_ACL > /dev/null 2>&1
 	rm -f $FILE_ACL_LINK > /dev/null 2>&1
 	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
-	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
+	[ "x$LOOP_DEV" != x ] && /sbin/losetup -d $LOOP_DEV
 	rm -rf $TMP/tacl
 }
 
@@ -125,12 +125,12 @@ else
 
 	# Avoid hardcoded loopback device values (-f tries to find the first
 	# available loopback device name)!
-	if ! LOOP_DEV=$(losetup -f) || [ "x$LOOP_DEV" = x ]; then
+	if ! LOOP_DEV=$(/sbin/losetup -f) || [ "x$LOOP_DEV" = x ]; then
 		tst_resm TCONF "[ losetup.1 ] Failed to find an available loopback device -- is the required support compiled in your kernel?"
 		exit 0
 	fi
 
-	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
+	if ! /sbin/losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
 		echo ""
 		tst_resm TCONF "[ losetup.2 ] Failed to setup the device."
 		exit 0
diff --git a/testcases/kernel/fs/mongo/test.sh b/testcases/kernel/fs/mongo/test.sh
index 5ec4e31..60f585d 100755
--- a/testcases/kernel/fs/mongo/test.sh
+++ b/testcases/kernel/fs/mongo/test.sh
@@ -57,13 +57,13 @@ reiserfs()
 cat > fs.sh <<EOF
 echo "performing mongo on reiserfs"
 dd if=/dev/zero of=reiserfs  bs=8k count=10240 > /dev/null 2>&1
-losetup /dev/loop0 reiserfs
+/sbin/losetup /dev/loop0 reiserfs
 mkdir -p $TEST_DIR
 ./mongo.pl LOG=/tmp/logfile1 file_size=10000 bytes=100000 fstype=reiserfs dev=/dev/loop0 dir=$TEST_DIR RUN   log=$LOG_DIR/reiserlog > /dev/null 2>&1
 
 echo "RESULTS LOGGED IN $LOG_DIR/reiserlog"
 export PATH=$PATH:/sbin
-losetup -d /dev/loop0
+/sbin/losetup -d /dev/loop0
 
 EOF
 }
@@ -76,12 +76,12 @@ cat >> fs.sh <<EOF
 echo "performing mongo on jfs file system"
 mkdir -p $TEST_DIR
 dd if=/dev/zero of=jfs  bs=8k count=10240 > /dev/null 2>&1
-losetup /dev/loop0 jfs
+/sbin/losetup /dev/loop0 jfs
 ./mongo.pl LOG=/tmp/logfile1 file_size=10000 bytes=100000 fstype=jfs dev=/dev/loop0 dir=$TEST_DIR   RUN log=$LOG_DIR/jfslog
 
 echo "RESULTS LOGGED IN $LOG_DIR/jfslog"
 export PATH=$PATH:/sbin
-losetup -d /dev/loop0
+/sbin/losetup -d /dev/loop0
 echo "rm -rf ./fs.sh" >> ./fs.sh 2>&1
 EOF
 }
@@ -105,5 +105,5 @@ echo "THIS MAY TAKE SOME MINUTES"
 sh fs.sh
 
 #performing cleanup
-#losetup -d /dev/loop0
+#/sbin/losetup -d /dev/loop0
 rm -rf $TEST_DIR
-- 
1.8.3.2


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

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1Mke8i-00004y-C8
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 13:20:12 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mke8X-0006ZP-VY
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 13:20:12 +0000
Message-ID: <4AA5085D.2060201@bull.net>
Date: Mon, 07 Sep 2009 15:19:25 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010201010504090100010509"
Subject: [LTP] acl_test01 TestCase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: jyoung5@us.ibm.com

This is a multi-part message in MIME format.
--------------010201010504090100010509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Subrata,

runltp can not run acl_test01 by default, we need a mounted partition 
 with ACL options.
 
 To have acl_test01 started by runltp (or manually) without any acl aware partition,
 
 if you agree I suggest the following patch: a kind of new setup and
  
 at the same time the activation of a non root user.
 
 regards,
 
 Jacky

-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


--------------010201010504090100010509
Content-Type: text/plain;
 name="envoi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="envoi"

--- acl_test01.ori	2009-09-01 16:12:53.000000000 +0200
+++ acl_test01	2009-09-01 16:12:39.000000000 +0200
@@ -24,17 +24,91 @@
 #
 #  HISTORY:
 #    03/03 Jerone Young  (jyoung5@us.ibm.com)
+#    09/08 Jacky Malcles changing the setup to have this TC started by runltp 
 #*********************************************************************
-export PATH=$PATH:/usr/sbin/
+#
+################################################################
+# 
+# Make sure that uid=root is running this script. 
+# Make sure that loop device is built into the kernel  
+# Make sure that ACL(Access Control List) and Extended Attribute are
+#     built into the kernel
+#
+#
+################################################################
 
 TEST_USER1="acltest1"
 TEST_USER1_GROUP="users"
 TEST_USER1_PASSWD="ltp_test_pass1"
-#ensure the test partition is ACL aware
-TEST_USER1_HOMEDIR="/tmp/$TEST_USER1"
+TEST_USER1_HOMEDIR="tacl/mount-ext3/$TEST_USER1"
+
+FILE_ACL="tacl/mount-ext3/test_file"
+FILE_ACL_LINK="tacl/mount-ext3/test_file_link"
+TCbin=`pwd`
+
+iam=`whoami`
+if [ "z$iam" = "z$TEST_USER1" ]
+then
+	echo ""
+else
+if [ $UID != 0 ]
+then
+        echo "FAILED: Must have root access to execute this script"
+        exit 1
+fi
+
+if [ ! -e tacl ]
+then
+        mkdir -m 777 tacl
+else
+        echo "FAILED: Directory tacl are exist"
+        exit 1
+fi
+
+#       The  following  commands  can  be  used as an example of using the loop
+#       device.
+
+dd if=/dev/zero of=tacl/blkext3 bs=1k count=10240
+chmod 777 tacl/blkext3
+#
+losetup /dev/loop0 tacl/blkext3 2>&1 > /dev/null
+if [ $? != 0 ]
+then
+        echo ""
+        echo "FAILED:  [ losetup ] Must have loop device support by kernel"
+        echo -e "\t to execute this script"
+        exit 1
+fi
+
+mount | grep ext2
+if [ $? != 0 ] 
+then
+        mkfs -t ext3 /dev/loop0 #> /dev/null 2>&1
+        mkdir  -m 777 tacl/mount-ext3
+        mount -t ext3 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext3
+        if [ $? != 0 ]
+        then
+                echo ""
+                echo "FAILED: [ mount ] Make sure that ACL (Access Control List)"
+                echo -e "\t and Extended Attribute are built into the kernel"
+                echo -e "\t Can not mount ext3 file system with acl and user_xattr options"
+                exit 1
+        fi
+else
+        mkfs -t ext2 /dev/loop0
+        mkdir  -m 777 tacl/mount-ext3
+        mount -t ext2 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext3
+        if [ $? != 0 ]
+        then
+                echo ""
+                echo "FAILED: [ mount ] Make sure that ACL (Access Control List)"
+                echo -e "\t and Extended Attribute are built into the kernel"
+                echo -e "\t Can not mount ext2 file system with acl and user_xattr options"
+                exit 1
+        fi
+fi
+fi
 
-FILE_ACL="/tmp/test_file"
-FILE_ACL_LINK="/tmp/test_file_link"
 
 #-----------------------------------------------------------------------
 # FUNCTION:  do_setup
@@ -55,7 +129,7 @@ do_setup(){
 	rm -rf $TEST_USER1_HOMEDIR 
 	userdel $TEST_USER1 > /dev/null 2>&1
 	sleep 1
-	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
+	useradd -d `pwd`/$TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh
 
 	if [ $? != 0 ]
 	then {
@@ -81,6 +155,9 @@ do_cleanup() {
 	userdel $TEST_USER1
 	rm -f $FILE_ACL > /dev/null 2>&1
 	rm -f $FILE_ACL_LINK > /dev/null 2>&1
+	umount -d tacl/mount-ext3
+	rm -rf tacl
+
 }
 
 #-----------------------------------------------------------------------
@@ -91,6 +168,7 @@ iam=`whoami`
 EXIT_CODE=0
 if [ "z$iam" = "z$TEST_USER1" ]
 then
+	echo ""
 	echo "TESTING ACLS FOR 2ND USER $iam"
 
 	#setup files for extended attributes
@@ -118,6 +196,7 @@ then
         fi
 else
 	do_setup
+	echo ""
 	echo "TESTING ACLS FOR USER $iam"
 
 	touch $FILE_ACL
@@ -150,11 +229,8 @@ else
 	chown $TEST_USER1 $FILE_ACL
 	chown $TEST_USER1 $FILE_ACL_LINK
 
-	if [ -z ${TCbin} ]
-	then
-   		export TCbin=$PWD
-	fi
-	
+	su $TEST_USER1 -c "$0"
+	echo ""
 	do_cleanup
 fi	
 

--------------010201010504090100010509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------010201010504090100010509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010201010504090100010509--


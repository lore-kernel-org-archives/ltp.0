Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NdQsC-0000IW-AM
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 16:17:36 +0000
Received: from mail-pz0-f173.google.com ([209.85.222.173])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NdQs9-0003uw-UM
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 16:17:36 +0000
Received: by pzk3 with SMTP id 3so1065400pzk.5
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Feb 2010 08:17:28 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 5 Feb 2010 08:17:26 -0800
Message-ID: <364299f41002050817x475bdfd7l8bed6440d8582f6f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] acl_test01 cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

acl_test01 today...
1. Should use $TMP.
2. Should use tst_resm today.
3. Should exit 0 on setup failure.
4. Doesn't cleanup in the event of a test failure.
5. Has a hardcoded loopback device instead of looking for the next
available one via losetup -f.
6. Other stylistic nits:
    a. [ $? != 0 ] -> [ $? -ne 0 ]
    b. Incorrect whitespace conventions / indentation issues.
    c. Etc...

This test will need to be enhanced [still] to support non-ext2 //
-ext3 filesystems (my kernel only supports ext4 fs's for instance...).

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: acls/acl_test01
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/acls/acl_test01,v
retrieving revision 1.7
diff -u -r1.7 acl_test01
--- acls/acl_test01	26 Oct 2009 14:49:23 -0000	1.7
+++ acls/acl_test01	5 Feb 2010 16:14:20 -0000
@@ -37,79 +37,21 @@
 #
 ################################################################

+export TCID=acltest01
+export TST_TOTAL=5
+export TST_COUNT=1
+
+TMP=${TMP:=/tmp}
+
 TEST_USER1="acltest1"
 TEST_USER1_GROUP="users"
 TEST_USER1_PASSWD="ltp_test_pass1"
-TEST_USER1_HOMEDIR="tacl/mount-ext3/$TEST_USER1"
+TEST_USER1_HOMEDIR="$TMP/tacl/mount-ext3/$TEST_USER1"

-FILE_ACL="tacl/mount-ext3/test_file"
-FILE_ACL_LINK="tacl/mount-ext3/test_file_link"
+FILE_ACL="$TMP/tacl/mount-ext3/test_file"
+FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
 TCbin=`pwd`

-iam=`whoami`
-if [ "z$iam" = "z$TEST_USER1" ]
-then
-	echo ""
-else
-if [ $(id -ru) != 0 ]
-then
-        echo "FAILED: Must have root access to execute this script"
-        exit 1
-fi
-
-if [ ! -e tacl ]
-then
-        mkdir -m 777 tacl
-else
-        echo "FAILED: Directory tacl are exist"
-        exit 1
-fi
-
-#       The  following  commands  can  be  used as an example of using the loop
-#       device.
-
-dd if=/dev/zero of=tacl/blkext3 bs=1k count=10240
-chmod 777 tacl/blkext3
-#
-losetup /dev/loop0 tacl/blkext3 2>&1 > /dev/null
-if [ $? != 0 ]
-then
-        echo ""
-        echo "FAILED:  [ losetup ] Must have loop device support by kernel"
-        printf "\t to execute this script\n"
-        exit 1
-fi
-
-mount | grep ext2
-if [ $? != 0 ]
-then
-        mkfs -t ext3 /dev/loop0 #> /dev/null 2>&1
-        mkdir  -m 777 tacl/mount-ext3
-        mount -t ext3 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext3
-        if [ $? != 0 ]
-        then
-                echo ""
-                echo "FAILED: [ mount ] Make sure that ACL (Access
Control List)"
-                printf "\t and Extended Attribute are built into the kernel\n"
-                printf "\t Can not mount ext3 file system with acl
and user_xattr options\n"
-                exit 1
-        fi
-else
-        mkfs -t ext2 /dev/loop0
-        mkdir  -m 777 tacl/mount-ext3
-        mount -t ext2 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext3
-        if [ $? != 0 ]
-        then
-                echo ""
-                echo "FAILED: [ mount ] Make sure that ACL (Access
Control List)"
-                printf "\t and Extended Attribute are built into the kernel\n"
-                printf "\t Can not mount ext2 file system with acl
and user_xattr options\n"
-                exit 1
-        fi
-fi
-fi
-
-
 #-----------------------------------------------------------------------
 # FUNCTION:  do_setup
 #-----------------------------------------------------------------------
@@ -119,23 +61,20 @@
 	rm -f $FILE_ACL
 	rm -f $FILE_ACL_LINK

-	if [ "$TEST_USER1_HOMEDIR" = "" ]
-	then {
-                echo "Could not find user $TEST_USER1's home directory."
-                exit 1
-        }
-        fi
+	if [ "x$TEST_USER1_HOMEDIR" = "x" ]; then
+		echo "Could not find user $TEST_USER1's home directory."
+		exit 1
+	fi

+	# XXX (garrcoop): why is cleanup junk being done in setup??? Bad test!!!
 	rm -rf $TEST_USER1_HOMEDIR
 	userdel $TEST_USER1 > /dev/null 2>&1
 	sleep 1
 	useradd -d `pwd`/$TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP
$TEST_USER1 -s /bin/sh

-	if [ $? != 0 ]
-	then {
+	if [ $? -ne 0 ]; then
 		echo "Could not add test user $TEST_USER1."
 		exit 1
-	}
 	fi

 }
@@ -145,19 +84,13 @@
 #-----------------------------------------------------------------------

 do_cleanup() {
-	if [ "$TEST_USER1_HOMEDIR" = "" ]
-	then {
-                echo "Could not remove home directory of the user $TEST_USER1."
-                exit 1
-        }
-        fi
-        rm -rf $TEST_USER1_HOMEDIR
-	userdel $TEST_USER1
+	rm -rf $TEST_USER1_HOMEDIR
+	userdel $TEST_USER1 > /dev/null 2>&1
 	rm -f $FILE_ACL > /dev/null 2>&1
 	rm -f $FILE_ACL_LINK > /dev/null 2>&1
-	umount -d tacl/mount-ext3
-	rm -rf tacl
-
+	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
+	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
+	rm -rf $TMP/tacl
 }

 #-----------------------------------------------------------------------
@@ -165,7 +98,75 @@
 #-----------------------------------------------------------------------

 iam=`whoami`
-EXIT_CODE=0
+if [ "z$iam" = "z$TEST_USER1" ]
+then
+	echo ""
+else
+	if [ $(id -ru) != 0 ]; then
+		tst_resm TCONF "must be root to execute this script"
+		exit 0
+	fi
+
+	if ! ( test -d $TMP/tacl || mkdir -m 777 $TMP/tacl) ; then
+		tst_resm TCONF "failed to create $TMP/tacl directory."
+		exit 1
+	fi
+
+	trap do_cleanup EXIT
+
+	#	The  following  commands  can  be  used as an example of using
+	#	a loopback device.
+
+	dd if=/dev/zero of=$TMP/tacl/blkext3 bs=1k count=10240 && chmod 777
$TMP/tacl/blkext3
+	if [ $? -ne 0 ] ; then
+		tst_resm TCONF "Failed to create $TMP/tacl/blkext3"
+		exit 0
+	fi
+
+	# Avoid hardcoded loopback device values (-f tries to find the first
+	# available loopback device name)!
+	if ! (LOOP_DEV=$(loop_dev -f) && [ "x$LOOP_DEV" = x ]); then
+		tst_resm TCONF "[ losetup.1 ] Failed to find an available loopback
device -- is the required support compiled in your kernel?"
+		exit 0
+	fi
+
+	if ! losetup $LOOP_DEV $TMP/tacl/blkext3 2>&1 > /dev/null; then
+		echo ""
+		tst_resm TCONF "[ losetup.2 ] Failed to setup the device."
+		exit 0
+	fi
+
+	mount | grep ext2
+	if [ $? -ne 0 ]; then
+		mkfs -t ext3 $LOOP_DEV #> /dev/null 2>&1
+		mkdir  -m 777 $TMP/tacl/mount-ext3
+		mount -t ext3 -o defaults,acl,user_xattr $LOOP_DEV $TMP/tacl/mount-ext3
+		if [ $? -ne 0 ]
+		then
+			echo ""
+			tst_resm TCONF "[ mount ] Make sure that ACL (Access Control List)"
+			printf "\t and Extended Attribute are built into the kernel\n"
+			printf "\t Can not mount ext3 file system with acl and user_xattr options\n"
+			exit 1
+		fi
+	else
+
+		mkfs -t ext2 $LOOP_DEV
+		mkdir  -m 777 $TMP/tacl/mount-ext3
+		mount -t ext2 -o defaults,acl,user_xattr $LOOP_DEV $TMP/tacl/mount-ext3
+		if [ $? -ne 0 ]
+		then
+			echo ""
+			tst_resm TCONF "FAILED: [ mount ] Make sure that ACL (Access Control List)"
+			printf "\t and Extended Attribute are built into the kernel\n"
+			printf "\t Can not mount ext2 file system with acl and user_xattr options\n"
+			exit 1
+		fi
+
+	fi
+
+fi
+
 if [ "z$iam" = "z$TEST_USER1" ]
 then
 	echo ""
@@ -177,7 +178,7 @@

 	echo "Trying extended acls for files"
 	${TCbin}/acl_file_test $FILE_ACL
-	if [ $? != 0 ]
+	if [ $? -ne 0 ]
 	then
 		EXIT_CODE=1
 		echo "Extended acls for files (FAILED)"
@@ -187,13 +188,13 @@

 	echo "Trying extended acls for file links"
 	${TCbin}/acl_link_test $FILE_ACL_LINK
-	if [ $? != 0 ]
-        then
-                EXIT_CODE=1
+	if [ $? -ne 0 ]
+	then
+		EXIT_CODE=1
 		echo "Extended acls for links (FAILED)"
 	else
 		echo "Extended acls for links (PASSED)"	
-        fi
+	fi
 else
 	do_setup
 	echo ""
@@ -208,17 +209,17 @@
 	
 	echo "Trying extended acls for files"
 	${TCbin}/acl_file_test $FILE_ACL
-	if [ $? != 0 ]
-    	then
-      	 	EXIT_CODE=1
+	if [ $? -ne 0 ]
+	then
+		EXIT_CODE=1
 		echo "Extended acls for files (FAILED)"
 	else
 		echo "Extended acls for files (PASSED)"
-    	fi
+	fi

 	echo "Trying extended acls for file links"	
 	${TCbin}/acl_link_test $FILE_ACL_LINK
-	if [ $? != 0 ]
+	if [ $? -ne 0 ]
 	then
 		EXIT_CODE=1
 		echo "Extended acls for links (FAILED)"

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

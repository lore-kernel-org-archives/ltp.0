Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1MlIBl-0000bb-K6
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 08:06:01 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MlIBg-0007uK-1Y
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 08:06:01 +0000
Message-ID: <4AA761D5.1090500@bull.net>
Date: Wed, 09 Sep 2009 10:05:41 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
MIME-Version: 1.0
References: <4AA5085D.2060201@bull.net>
	<1252474187.5006.2.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1252474187.5006.2.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------060200070403010806030601"
Subject: Re: [LTP] acl_test01 TestCase
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, jyoung5@us.ibm.com

This is a multi-part message in MIME format.
--------------060200070403010806030601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1




Subrata Modak a =E9crit :
> Hi Jacky,
>=20
> On Mon, 2009-09-07 at 15:19 +0200, Jacky Malcles wrote:
>> Subrata,
>>
>> runltp can not run acl_test01 by default, we need a mounted partition=20
>>  with ACL options.
>>
>>  To have acl_test01 started by runltp (or manually) without any acl
>> aware partition,
>>
>>  if you agree I suggest the following patch: a kind of new setup and
>>  =20
>>  at the same time the activation of a non root user.
>>
>>  regards,
>>
>>  Jacky
>>
>> --=20
>>  Jacky Malcles               B1-403   Email : Jacky.Malcles@bull.net
>>  Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
>>  Tel : 04.76.29.73.14
>>
>>
>>
>>
>>
>>
>>
>>
>> plain text
>> document
>> attachment
>> (envoi)
>=20
>=20
>=20
> Please Sign-off this patch, and, also create this patch from LTPROOT
> directory.
>=20
Hi Subrata,

I recreated from LTPROOT and signed of
hope it'll work,


> Regards--
> Subrata
>=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEVAwUBSqdh1HFYHhojb+kFAQKb4AgAkNLBuKjF1SRGZ0Oi+gqVUCBKOKPblDpW
QkY/LDS2slY+1dlTCwgodu/FRBqJQj9GnfUnGGG8twa+E3MD71OwCX/xHPO5HzZf
rt3rc+iP9Wapf3mRWbv2ZOzp7Qvd7X3t7wVHYwYDc6g41V0MD5cTcfQUWrb4/j1P
AQRNUjx6dnt7zV1JCPqi0K2qmTbhRnyqyTjdrQnPDgxx7Ion38l0TKGle2IsLovx
iV9pveV9WgJJNA9DMUaQV7bga/Uh6+oabucztUrNY01x8xv1XhailMZw1h7XnyOe
xpv+506OvEMacSPD81Hvz73CBo4z4ABKl9uOifdsBeqA/abKsId+ow=3D=3D
=3DEcrR
-----END PGP SIGNATURE-----

--------------060200070403010806030601
Content-Type: text/plain;
 name="envoitp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="envoitp"

--- ltp-full-20090831.orig/testcases/kernel/fs/acls/acl_test01	2009-08-31 07:15:46.000000000 +0200
+++ ltp-full-20090831/testcases/kernel/fs/acls/acl_test01	2009-09-09 09:02:48.000000000 +0200
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
 

--------------060200070403010806030601
Content-Type: application/octet-stream;
 name="envoitp.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="envoitp.sig"

iQEVAwUASqdh1HFYHhojb+kFAQIGyQf7Br3HQn73U01a0i9e6tv7Fs8+dXyH6kYO88Ok1TvR
igNT23ad8nfZh8xiPYqaQ8gQdEUMWdCJO/7EyYXvpnoHoA/e7dLwujjmU8jqKSpw9C+s5VDw
vUMnXVUozS5hHnNzN2tjfcnxMlrSjRithtNUgJsNMtVkPvhh6WugIT75gMueIC3om+ntWnBJ
NHTuO0Z6D3TP3+7AoL91B0NmSiZovcJVMnSNEoDO5IEAQPNvDDr1KfElMiJRDMtKN40ud8GI
nITF+CWTAKkmd4r3hUbSTTPaUi3sgcXATMiWqKujUfezouiMprRkc0uHiN9+dq/1Ij5yBK1Y
xuU9il36fSsTRw==
--------------060200070403010806030601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------060200070403010806030601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060200070403010806030601--


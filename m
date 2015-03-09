Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1YUuDi-0005rX-7J
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 09:43:30 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YUuDg-0001s4-HP
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 09:43:30 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t299hLxK020964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Mar 2015 05:43:21 -0400
Received: from dhcp-13-206.nay.redhat.com (dhcp12-104.nay.redhat.com
	[10.66.12.104] (may be forged))
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t299hHTL029389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Mar 2015 05:43:20 -0400
From: Li Wang <liwang@redhat.com>
Date: Mon,  9 Mar 2015 17:43:13 +0800
Message-Id: <1425894193-17523-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] fs/acls: fix some permission issue in the testcase
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

hi,

The acl_test01 failed with a series of permission issue when runing on RHEL:
	useradd: cannot set SELinux context for home directory
	/mnt/testarea/ltp-KIK01kZbbL/tacl/mount-ext3/acltest1
	Could not add test user acltest1.
	/dev/loop1 on /mnt/testarea/ltp-KIK01kZbbL/tacl/mount-ext3
	type ext3 (rw,relatime,seclabel,data=ordered)
	...

A proposal fixed patch and test results as below:

	TESTING ACLS FOR USER root
	Trying extended acls for files
	Extended acls for files (PASSED)
	Trying extended acls for file links
	Extended acls for links (PASSED)

	TESTING ACLS FOR 2ND USER acltest1
	Trying extended acls for files
	Extended acls for files (PASSED)
	Trying extended acls for file links
	Extended acls for links (PASSED)
	...

Thanks.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/fs/acls/acl_test01 | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index af65213..5aa5823 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -52,15 +52,30 @@ FILE_ACL="$TMP/tacl/mount-ext3/test_file"
 FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
 TCbin=`pwd`
 
+SESTATUS=`/usr/sbin/sestatus |grep "SELinux status"|awk '{print $3}'`
+if [ "$SESTATUS" = "enabled" ]; then
+	export SELINUX=`getenforce`
+else
+	export SELINUX="disabled"
+
+fi
+
 #-----------------------------------------------------------------------
 # FUNCTION:  do_setup
 #-----------------------------------------------------------------------
 
 do_setup(){
 
+	tst_require_root
+
 	rm -f $FILE_ACL
 	rm -f $FILE_ACL_LINK
 
+	if [ "$SELINUX" = "Enforcing" ]; then
+		echo "set the SElinux to Permissive."
+		setenforce 0
+	fi
+
 	if [ "x$TEST_USER1_HOMEDIR" = "x" ]; then
 		echo "Could not find user $TEST_USER1's home directory."
 		exit 1
@@ -91,6 +106,11 @@ do_cleanup() {
 	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
 	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
 	rm -rf $TMP/tacl
+
+	if [ "$SELNUX" = "Enforcing" ]; then
+		echo "set the SElinux to Enforcing."
+		setenforce 1
+	fi
 }
 
 #-----------------------------------------------------------------------
@@ -177,7 +197,7 @@ then
 	setfacl -m u:$TEST_USER1:r $FILE_ACL
 
 	echo "Trying extended acls for files"
-	${TCbin}/acl_file_test $FILE_ACL
+	$TMP/tacl/mount-ext3/acl_file_test $FILE_ACL
 	if [ $? -ne 0 ]
 	then
 		EXIT_CODE=1
@@ -187,7 +207,7 @@ then
 	fi
 
 	echo "Trying extended acls for file links"
-	${TCbin}/acl_link_test $FILE_ACL_LINK
+	$TMP/tacl/mount-ext3/acl_link_test $FILE_ACL_LINK
 	if [ $? -ne 0 ]
 	then
 		EXIT_CODE=1
@@ -227,6 +247,7 @@ else
 		echo "Extended acls for links (PASSED)"
 	fi
 
+	cp ${TCbin}/acl_link_test ${TCbin}/acl_file_test $TMP/tacl/mount-ext3/
 	chown $TEST_USER1 $FILE_ACL
 	chown $TEST_USER1 $FILE_ACL_LINK
 
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

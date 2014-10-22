Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Xgr1w-0005xG-P9
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 08:12:28 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xgr1u-0003H4-Me
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 08:12:28 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9M8CK3T007626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 08:12:21 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9M8CJaR015253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 08:12:20 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9M8CJr5012101
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 08:12:19 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 22 Oct 2014 12:12:12 +0400
Message-Id: <1413965532-19371-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] acl_test01: sync after removal of the loop device
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

If the test is executed on NFS, it may fail with:

/dev/loop0 on /tmpdir/tacl/mount-ext3 type ext3 (rw,acl,user_xattr)
loop: can't delete device /dev/loop0: No such device or address
rm: cannot remove `/tmpdir/tacl': Directory not empty
loop: can't delete device /dev/loop0: No such device or address
rm: cannot remove `/tmpdir/tacl/.nfs00000000000262fd00000115': Device or resource busy

I suppose that this happens because of kernel commit:

commit a1ecac3b0656a68259927c234e505804d33a7b83
Author: Dave Chinner <dchinner@redhat.com>
Date:   Fri Sep 28 10:42:23 2012 +0200

    loop: Make explicit loop device destruction lazy

To cope with this test case failure I introduced a 'sync'.
And 'losetup -d' seems to be unnecessary, because of 'umount -d' before it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/fs/acls/acl_test01 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index af65213..9568918 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -89,7 +89,7 @@ do_cleanup() {
 	rm -f $FILE_ACL > /dev/null 2>&1
 	rm -f $FILE_ACL_LINK > /dev/null 2>&1
 	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
-	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
+	sync
 	rm -rf $TMP/tacl
 }
 
-- 
1.7.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

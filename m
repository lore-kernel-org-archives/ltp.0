Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2GAV-0002Zl-OC
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:03 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2GAV-0001vU-0U
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:03 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t599nuV9011283
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t599nufH004514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:56 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t599nuGa018770
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:56 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  9 Jun 2015 12:49:44 +0300
Message-Id: <1433843386-31431-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/5] acl_test01: Hide unnecessary output
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

The output from 'grep' gives no value, so let's hide it.

'losetup -d' is also not needed, because the loop device is
detached by 'umount -d'. Therefore, removed 'losetup -d' to hide
warnings like:

loop: can't delete device /dev/loop1: No such device or address

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/fs/acls/acl_test01 |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index 0f050b9..4dc15ef 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -97,8 +97,7 @@ do_cleanup() {
 	userdel $TEST_USER1 > /dev/null 2>&1
 
 	MOUNT_POINT=$(readlink -f "mount-ext3")
-	mount | grep $MOUNT_POINT && umount -d $MOUNT_POINT
-	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
+	mount | grep -q $MOUNT_POINT && umount -d $MOUNT_POINT
 
 	tst_rmdir
 
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

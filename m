Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2GAa-0000cV-4b
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:08 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2GAY-0008QU-A0
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:08 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t599nxWB023001
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:50:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t599nxMm004646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:59 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t599nxSj017450
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:59 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  9 Jun 2015 12:49:46 +0300
Message-Id: <1433843386-31431-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1433843386-31431-4-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [RFC PATCH 5/5] acl_test01: Wait until the loop device is
	detached
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

If the test is executed on NFS, it may print:

rm: cannot remove `/mnt/ltp-xeJYpESVKz/acltest01.fCogoo4gn0': Directory not empty

It seems the following happen:

1. After 'unmount -d' 'acltest01.fCogoo4gn0/blkext3' is still in use by udev.
   See kernel commit a1ecac3b0656a68259927c234e505804d33a7b83
   ("loop: Make explicit loop device destruction lazy")

2. Due to the "NFS silly rename" feature, command 'rm -f acltest01.fCogoo4gn0/blkext3'
   renames 'blkext3' to '.nfs*'

3. The removal of 'acltest01.fCogoo4gn0' directory fails, because it
   still contains this '.nfs*' file.

Intorucing a wait cycle should fix this problem.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---

It's a follow up to:

http://sourceforge.net/p/ltp/mailman/message/32987268/

Indeed, 'sync' was wrong there.


 testcases/kernel/fs/acls/acl_test01 |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
index 4dc15ef..b4c2c70 100755
--- a/testcases/kernel/fs/acls/acl_test01
+++ b/testcases/kernel/fs/acls/acl_test01
@@ -99,6 +99,22 @@ do_cleanup() {
 	MOUNT_POINT=$(readlink -f "mount-ext3")
 	mount | grep -q $MOUNT_POINT && umount -d $MOUNT_POINT
 
+	# Cope with "NFS silly rename"
+	if [ $(tst_fs_type .) = "NFS" ]; then
+	    rm -f blkext3
+
+	    TIMEOUT=5
+	    while $(ls -la | grep -q .nfs); do
+		sleep 1
+
+		TIMEOUT=$(( $TIMEOUT - 1 ))
+		if [ $TIMEOUT -eq 0 ]; then
+		    tst_resm TBROK "The loop device is still in use"
+		    break
+		fi
+	    done
+	fi
+
 	tst_rmdir
 
 	# We set it back to Enforcing.
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

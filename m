Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1TByD9-0004yk-HK
	for ltp-list@lists.sourceforge.net; Thu, 13 Sep 2012 01:27:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TByD7-0005id-K8
	for ltp-list@lists.sourceforge.net; Thu, 13 Sep 2012 01:27:19 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q8D1R8us022208
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Sep 2012 09:27:11 +0800
Message-ID: <5051362C.8070402@cn.fujitsu.com>
Date: Thu, 13 Sep 2012 09:26:04 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010408090302000006010104"
Subject: [LTP] [PATCH] bind/03, 21 rbind/38,
 33:fix missing umount and error umount in these cases
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
To: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010408090302000006010104
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

The cases have the same problem that dirs are still in mount when their
targets are removed.for rbind/38,beside the problem above,there are two
error umount operations that umount dirs that are not in mount.
and all these result in making the test script trapped in a infinite loop.
To resolve these problems,all we need is just umount the mountpoints before
their targets are removed and delete the error umount operations.

--------------010408090302000006010104
Content-Transfer-Encoding: 7bit
Content-Type: text/x-patch;
 name="0001-fix-BindMounts-problems.patch"
Content-Disposition: attachment; filename="0001-fix-BindMounts-problems.patch"

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com> 
---
 testcases/kernel/fs/fs_bind/bind/test03  |    1 +
 testcases/kernel/fs/fs_bind/bind/test21  |    1 +
 testcases/kernel/fs/fs_bind/rbind/test33 |    1 +
 testcases/kernel/fs/fs_bind/rbind/test38 |    5 ++---
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/fs_bind/bind/test03 b/testcases/kernel/fs/fs_bind/bind/test03
index 10b678a..5989a3a 100755
--- a/testcases/kernel/fs/fs_bind/bind/test03
+++ b/testcases/kernel/fs/fs_bind/bind/test03
@@ -98,6 +98,7 @@ trap '' ERR
 	umount share2
 	umount share2
 	umount parent1
+	umount parent2
 	
 	rm -rf parent* share*
 	cleanup
diff --git a/testcases/kernel/fs/fs_bind/bind/test21 b/testcases/kernel/fs/fs_bind/bind/test21
index 741161f..ab0bf88 100755
--- a/testcases/kernel/fs/fs_bind/bind/test21
+++ b/testcases/kernel/fs/fs_bind/bind/test21
@@ -93,6 +93,7 @@ trap '' ERR
 	umount dir1
 	umount dir2
 	umount dir3
+	umount dir4
 	
 	rm -rf dir*
 	
diff --git a/testcases/kernel/fs/fs_bind/rbind/test33 b/testcases/kernel/fs/fs_bind/rbind/test33
index 8247747..9ccc53b 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test33
+++ b/testcases/kernel/fs/fs_bind/rbind/test33
@@ -93,6 +93,7 @@ trap '' ERR
 	umount dir1
 	umount dir2
 	umount dir3
+	umount dir4
 	
 	rm -rf dir*
 	
diff --git a/testcases/kernel/fs/fs_bind/rbind/test38 b/testcases/kernel/fs/fs_bind/rbind/test38
index c06f072..c3f46fb 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test38
+++ b/testcases/kernel/fs/fs_bind/rbind/test38
@@ -82,11 +82,10 @@ trap '' ERR
 	umount parent1/child1
 	umount parent2/child1
 	umount parent2/child1
-	umount parent2 
+	umount parent2/child2
+	umount parent2
 	umount share1
 	umount share1
-	umount share2
-	umount share2
 	
 	rm -rf parent* share*
 	cleanup
-- 
1.7.1


--------------010408090302000006010104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------010408090302000006010104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010408090302000006010104--


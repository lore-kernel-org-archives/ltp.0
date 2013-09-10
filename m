Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1VJE5G-0002ww-IK
	for ltp-list@lists.sourceforge.net; Tue, 10 Sep 2013 02:53:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VJE5E-00056X-PQ
	for ltp-list@lists.sourceforge.net; Tue, 10 Sep 2013 02:53:42 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r8A2rWMl022361
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Sep 2013 10:53:32 +0800
Message-ID: <522E89AE.5080707@cn.fujitsu.com>
Date: Tue, 10 Sep 2013 10:53:34 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] runltp: bigger the supplied block device
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


To make a xfs filesystem, we need the device gets at least 4096 blocks.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 runltp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runltp b/runltp
index e86f5c7..63c625f 100755
--- a/runltp
+++ b/runltp
@@ -955,8 +955,8 @@ main()

 create_block()
 {
-    #create a block device with ext4 filesystem.
-    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=10240
+    #create a block device
+    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=20480
     if [ $? -ne 0 ]; then
         echo "Failed to create loopback device image, please check disk space and re-run"
         return 1
-- 
1.8.1

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

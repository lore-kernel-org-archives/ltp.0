Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VkXNM-00014c-EE
	for ltp-list@lists.sourceforge.net; Sun, 24 Nov 2013 10:57:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VkXNK-00082V-Qc
	for ltp-list@lists.sourceforge.net; Sun, 24 Nov 2013 10:57:16 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rAOAv7Sn015829
	for <ltp-list@lists.sourceforge.net>; Sun, 24 Nov 2013 18:57:07 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date: Sun, 24 Nov 2013 18:56:01 +0800
Message-Id: <1385290561-24404-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: [LTP] [PATCH] runltp: suppress the out message when creating loop
	device
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
To: LTP <ltp-list@lists.sourceforge.net>

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 runltp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runltp b/runltp
index 63c625f..e6fc34a 100755
--- a/runltp
+++ b/runltp
@@ -956,7 +956,7 @@ main()
 create_block()
 {
     #create a block device
-    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=20480
+    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=20480 &>/dev/null
     if [ $? -ne 0 ]; then
         echo "Failed to create loopback device image, please check disk space and re-run"
         return 1
-- 
1.8.5.rc3


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XgwSk-0002ma-El
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 14:00:30 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XgwSh-0007qV-Rb
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 14:00:30 +0000
From: Zorro Lang <zlang@redhat.com>
Date: Wed, 22 Oct 2014 21:09:34 +0800
Message-Id: <1413983374-8784-1-git-send-email-zlang@redhat.com>
Subject: [LTP] [Patch V2] ext4-new-features: modify
	ext4_get_inode_version.sh not know $EXT4_DEV definition
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
To: wangxg.fnst@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

ext4_get_inode_version.sh use $EXT4_DEV, but it really doesn't know what is $EXT4_DEV.
That cause other cases which use ext4_get_inode_version.sh to fail.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 testcases/kernel/fs/ext4-new-features/ext4_funcs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
index 0ae534a..b51e942 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4_funcs.sh
@@ -45,7 +45,7 @@ ext4_setup()
 	if [ -z "$LTP_BIG_DEV" ];then
 		tst_brkm TCONF "tests need a big block device(5G-10G)"
 	else
-		EXT4_DEV=$LTP_BIG_DEV
+		export EXT4_DEV=$LTP_BIG_DEV
 	fi
 
 	tst_tmpdir
-- 
1.9.3


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

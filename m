Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Z5nwf-0007mD-Tx
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 04:30:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z5nwe-0003KK-On
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 04:30:25 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5J4Sg2P030126
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2015 12:28:42 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 19 Jun 2015 12:32:15 +0800
Message-ID: <1434688335-29172-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] df/df01.sh: Fix 'mkfs.xfs' error.
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
To: ltp-list@lists.sourceforge.net

'runltp' use a loop device. If we want to 'mkfs.xfs' the loop device,
we need to specify '-f(force)' option, if not 'mkfs.xfs' would go
wrong. The mean of '-f' option is different between 'xfs' and others.
So we only add the option for 'xfs'.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/commands/df/df01.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index fe573e5..2b7b804 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -32,7 +32,11 @@ setup()
 
 	tst_acquire_device
 
-	ROD_SILENT mkfs.${FS_TYPE} ${TST_DEVICE}
+	if [ ${FS_TYPE} = "xfs" ]; then
+		ROD_SILENT mkfs.${FS_TYPE} -f ${TST_DEVICE}
+	else
+		ROD_SILENT mkfs.${FS_TYPE} ${TST_DEVICE}
+	fi
 
 	ROD_SILENT mkdir -p mntpoint
 
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

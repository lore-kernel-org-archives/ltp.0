Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YnkJa-0002pd-2g
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:59:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YnkJY-0008Rx-Od
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 08:59:26 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 30 Apr 2015 16:58:06 +0800
Message-ID: <1430384287-16073-3-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55418B02.3080104@huawei.com>
	<1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] commands/fileutils/mv: Remove 00_Descriptions.txt
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
To: cuibixuan@huawei.com
Cc: ltp-list@lists.sourceforge.net

I do *not* think this file is necessary, So remove it.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/commands/fileutils/mv/00_Descriptions.txt | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 testcases/commands/fileutils/mv/00_Descriptions.txt

diff --git a/testcases/commands/fileutils/mv/00_Descriptions.txt b/testcases/commands/fileutils/mv/00_Descriptions.txt
deleted file mode 100644
index 6d52868..0000000
--- a/testcases/commands/fileutils/mv/00_Descriptions.txt
+++ /dev/null
@@ -1,3 +0,0 @@
-test01
-	mv <dir1> <dir2> will move dir1 to dir2 and all its contents.
-
-- 
1.8.3.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

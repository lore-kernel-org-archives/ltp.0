Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1Ypybf-0008AK-2B
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 12:39:19 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YpybZ-0002X1-8K
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 12:39:19 +0000
Message-ID: <554A0B45.1070609@huawei.com>
Date: Wed, 6 May 2015 20:38:29 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <1430915809-168531-1-git-send-email-cuibixuan@huawei.com>
In-Reply-To: <1430915809-168531-1-git-send-email-cuibixuan@huawei.com>
Subject: [LTP]  [PATCH 2/2] gzip/gzip01: Remove 00_Descriptions.txt
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhanyongming@huawei.com, zhuyanpeng@huawei.com

Remove 00_Descriptions.txt file.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/commands/gzip/00_Descriptions.txt |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)
 delete mode 100644 testcases/commands/gzip/00_Descriptions.txt

diff --git a/testcases/commands/gzip/00_Descriptions.txt b/testcases/commands/gzip/00_Descriptions.txt
deleted file mode 100644
index 2a14182..0000000
--- a/testcases/commands/gzip/00_Descriptions.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-gzip01
-	Test that gzip -r will travel directories and compress all the files available.
-
-gunzip01
-	Test that gunzip -r will travel directories and uncompress all the files available.
-
-- 
1.6.0.2

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

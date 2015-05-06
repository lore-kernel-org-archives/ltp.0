Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Yptja-0004mn-CB
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YptjY-0002S6-D8
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:10 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t467PhuW004574
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 15:25:43 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 6 May 2015 15:26:12 +0800
Message-ID: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/5] kernel/syscalls/mmap: remove unused cleanup()
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

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mmap/mmap02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap02.c b/testcases/kernel/syscalls/mmap/mmap02.c
index b7972f1..829f333 100644
--- a/testcases/kernel/syscalls/mmap/mmap02.c
+++ b/testcases/kernel/syscalls/mmap/mmap02.c
@@ -148,7 +148,6 @@ static void setup(void)
 		free(tst_buff);
 		tst_brkm(TFAIL | TERRNO, cleanup,
 			 "writing to %s failed", TEMPFILE);
-		cleanup();
 	}
 
 	/* Free the memory allocated for test buffer */
-- 
1.9.3


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

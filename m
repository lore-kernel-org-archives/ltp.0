Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YsUi9-0004E4-T2
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsUi8-0007W4-O1
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:25 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4DBIvVU004320
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 19:18:57 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 13 May 2015 19:19:42 +0800
Message-ID: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/5] lib/safe_file_ops: fix typo
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

s/assigment/assignment/g
s/supressed/suppressed/g

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 lib/safe_file_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 683c4eb..a46939a 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -35,8 +35,8 @@
 
 /*
  * Count number of expected assigned conversions. Any conversion starts with '%'.
- * The '%%' matches % and no assigment is done. The %*x matches as x would do but
- * the assigment is supressed.
+ * The '%%' matches % and no assignment is done. The %*x matches as x would do but
+ * the assignment is suppressed.
  *
  * NOTE: This is not 100% correct for complex scanf strings, but will do for
  *       all of our intended usage.
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

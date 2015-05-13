Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YsUiG-0005Qx-VU
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsUiG-0002ox-2a
	for ltp-list@lists.sourceforge.net; Wed, 13 May 2015 11:20:32 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4DBJ71K004335
	for <ltp-list@lists.sourceforge.net>; Wed, 13 May 2015 19:19:07 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 13 May 2015 19:19:46 +0800
Message-ID: <1431515986-22287-5-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1431515986-22287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 5/5] network/nfs/nfsstress: fix printf format
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

format string requires 2 parameters but only 1 is given

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/network/nfs/nfsstress/make_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfsstress/make_tree.c b/testcases/network/nfs/nfsstress/make_tree.c
index 7b18da3..4163988 100644
--- a/testcases/network/nfs/nfsstress/make_tree.c
+++ b/testcases/network/nfs/nfsstress/make_tree.c
@@ -319,7 +319,8 @@ static int init_compile(int what_todo,	/* do a compile or clean             */
 				return 1;
 			}
 
-			dprt("pid[%d]: init_compile(): status = %d\n", status);
+			dprt("pid[%d]: init_compile(): status = %d\n",
+			     gettid(), status);
 			dprt("we are here %d\n", __LINE__);
 			return status;
 		}
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

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Ys3g8-0004DX-1Y
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 06:28:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ys3g7-00081I-6k
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 06:28:32 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4C6R509022495
	for <ltp-list@lists.sourceforge.net>; Tue, 12 May 2015 14:27:05 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Tue, 12 May 2015 14:27:28 +0800
Message-ID: <1431412049-24348-4-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1431412049-24348-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 4/5] kernel/syscalls/fallocate: adjust fclose's
	position
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

It will encounter resource leak for fp,
while fopen succeeds and the pointer para is NULL.
so need to move fclose out of if-block.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
index 1c33d0c..bd2d373 100644
--- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
@@ -30,8 +30,13 @@ int is_cmdline_para(const char *para)
 				return 1;
 			}
 		}
-		fclose(fp);
 	}
+	/* If fopen succeeds and the pointer para is NULL,
+	 * It won't enter the above if-block.
+	 * so need to close fp here.
+	 */
+	if (fp != NULL)
+		fclose(fp);
 
 	return 0;
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

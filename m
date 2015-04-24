Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YlSiA-0005Tk-LG
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlSi9-0007kc-It
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:22 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O1k3fC025617
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 09:46:03 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 09:46:38 +0800
Message-ID: <1429840001-4970-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/5] kernel/fs/doio/growfiles: add parameter for printf
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

printf format string requires 1 parameter but only 0 are given.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/fs/doio/growfiles.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index a656978..09e7f35 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -677,7 +677,7 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			Upanic_on_error++;
-			printf("%s: Will call upanic after writes\n");
+			printf("%s%s: Will call upanic after writes\n", Progname, TagName);
 #else
 			printf
 			    ("%s%s: --P is illegal option on non-cray system\n",
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

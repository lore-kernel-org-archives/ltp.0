Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YqZ1K-0007em-PM
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 03:32:14 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqZ1I-0008L1-Tk
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 03:32:14 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t483UlHY024570
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 11:30:47 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 8 May 2015 11:31:35 +0800
Message-ID: <1431055895-11411-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <20150507132127.GD28637@rei.suse.de>
References: <20150507132127.GD28637@rei.suse.de>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 3/5] kernel/mem/hugetlb/lib: Don't allocate memory
	for getpwnam()
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

No need to allocate memory for a pointer,
which just used to store getpwnam()'s return.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/mem/hugetlb/lib/libipc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/lib/libipc.c b/testcases/kernel/mem/hugetlb/lib/libipc.c
index 21fd8da..1f16f22 100644
--- a/testcases/kernel/mem/hugetlb/lib/libipc.c
+++ b/testcases/kernel/mem/hugetlb/lib/libipc.c
@@ -85,10 +85,6 @@ int getuserid(char *user)
 {
 	struct passwd *ent;
 
-	ent = malloc(sizeof(struct passwd));
-	if (ent == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc ent");
-
 	ent = getpwnam(user);
 	if (ent == NULL)
 		tst_brkm(TBROK | TERRNO, cleanup, "getpwnam");
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

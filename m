Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Yptje-0002p3-9n
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:14 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yptjb-0006uT-Nh
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:14 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t467Pnnj004589
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 15:25:49 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 6 May 2015 15:26:14 +0800
Message-ID: <1430897176-16486-3-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/5] kernel/mem/hugetlb/lib: Don't allocate memory for
	getpwnam()
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

It requests to declare a pointer to for getpwnam() returns,
not to allocate memory for it.
This patch does the same as 2c0c4b3.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/mem/hugetlb/lib/libipc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/lib/libipc.c b/testcases/kernel/mem/hugetlb/lib/libipc.c
index 21fd8da..cfcde6b 100644
--- a/testcases/kernel/mem/hugetlb/lib/libipc.c
+++ b/testcases/kernel/mem/hugetlb/lib/libipc.c
@@ -83,11 +83,7 @@ int getipckey(void)
  */
 int getuserid(char *user)
 {
-	struct passwd *ent;
-
-	ent = malloc(sizeof(struct passwd));
-	if (ent == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc ent");
+	struct passwd *ent = NULL;
 
 	ent = getpwnam(user);
 	if (ent == NULL)
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

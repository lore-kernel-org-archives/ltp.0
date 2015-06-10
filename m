Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a7X-00057v-R1
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:08:19 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a7W-0005gW-JS
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:08:19 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP01BBAVTA56A0@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:07:58 +0900 (KST)
Date: Wed, 10 Jun 2015 07:04:55 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <872703134.810591433919895920.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 4/8] utils/ffsb_fc.c: remove explicit NULL check
	before free
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

No need of NULL check before free

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 utils/ffsb-6.0-rc2/ffsb_fc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/utils/ffsb-6.0-rc2/ffsb_fc.c b/utils/ffsb-6.0-rc2/ffsb_fc.c
index 60b6313..c383a6a 100644
--- a/utils/ffsb-6.0-rc2/ffsb_fc.c
+++ b/utils/ffsb-6.0-rc2/ffsb_fc.c
@@ -99,8 +99,7 @@ void fc_set_num_totalthreads(ffsb_config_t * fc, int num)
 
 void fc_set_callout(ffsb_config_t * fc, char *callout)
 {
-	if (fc->callout)
-		free(fc->callout);
+	free(fc->callout);
 	fc->callout = ffsb_strdup(callout);
 }
 
-- 
1.7.9.5

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

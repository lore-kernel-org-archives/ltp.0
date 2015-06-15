Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UNg-0002jf-1g
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:24:52 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UNe-0004Bt-Ka
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:24:52 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ00VBPML607C0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:24:42 +0900 (KST)
Date: Mon, 15 Jun 2015 13:24:42 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <784527626.1047711434374682757.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 5/7] pan/reporter.c: remove unnecessary malloc type
	cast
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

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 pan/reporter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pan/reporter.c b/pan/reporter.c
index 7b4a1e0..b9ec482 100644
--- a/pan/reporter.c
+++ b/pan/reporter.c
@@ -100,7 +100,7 @@ static int scanner_reporter(SYM tags)
 	 * extract tag names from data
 	 */
 	ntags = NTAGS_START;
-	taglist = (char **)malloc(sizeof(char *) * ntags);
+	taglist = malloc(sizeof(char *) * ntags);
 	tagcount = 0;
 
 	tl = taglist;
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

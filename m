Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a5s-0004Fr-Tj
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:06:36 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a5r-0005dM-Lb
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:06:36 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP02QYXVQL3BB0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:06:21 +0900 (KST)
Date: Wed, 10 Jun 2015 07:03:20 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1441805139.810381433919800264.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 1/8] tools:proc/ksym.c: remove explicit NULL check
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
 tools/top-LTP/proc/ksym.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/top-LTP/proc/ksym.c b/tools/top-LTP/proc/ksym.c
index 19c5f27..559edca 100644
--- a/tools/top-LTP/proc/ksym.c
+++ b/tools/top-LTP/proc/ksym.c
@@ -289,8 +289,7 @@ open_again:
 	close(fd);
 	return;
 hell:
-	if (buf)
-		free(buf);
+	free(buf);
 	*bufp = NULL;
 	*roomp = 0;		/* this function will never work again */
 	total = 0;
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

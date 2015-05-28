Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1Yxpgh-0004AM-Vu
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:44:59 +0000
Received: from [203.254.224.25] (helo=mailout2.samsung.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Yxpgg-0006M5-EX
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:44:59 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NP100F5WMI74QD0@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 28 May 2015 13:44:31 +0900 (KST)
Date: Thu, 28 May 2015 04:44:31 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <388214473.190591432788271460.JavaMail.weblogic@epmlwas05c>
Subject: [LTP]  [PATCH]: Fix memory leak by freeing buf
Reply-To: manjeet.p@samsung.com
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
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, Yogesh Narayan Gaur <yn.gaur@samsung.com>

From: Manjeet Pawar <manjeet.p@samsung.com>
Subject: [PATCH] pan/ltp-pan.c: free buf before function return to avoid memory leak

This patch avoid memory leak by freeing the buf before the slurp() function return

Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
---
 pan/ltp-pan.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 4c1e9de..905ff89 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -1279,6 +1279,7 @@ static char *slurp(char *file)
 	if (read(fd, buf, sbuf.st_size) != sbuf.st_size) {
 		fprintf(stderr, "pan(%s): slurp failed.  errno:%d  %s\n",
 			panname, errno, strerror(errno));
+		free(buf);
 		return NULL;
 	}
 	buf[sbuf.st_size] = '\0';
-- 
1.7.9.5


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

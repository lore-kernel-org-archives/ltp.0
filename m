Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a6M-00053T-N6
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:07:06 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a6L-0003ln-Hg
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:07:06 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP02ODIVRFCCC0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:06:51 +0900 (KST)
Date: Wed, 10 Jun 2015 07:03:44 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1135147130.810421433919824565.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 2/8] tools:proc/alloc.c: remove explicit NULL check
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
 tools/top-LTP/proc/alloc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/top-LTP/proc/alloc.c b/tools/top-LTP/proc/alloc.c
index c8cad61..a06fd71 100644
--- a/tools/top-LTP/proc/alloc.c
+++ b/tools/top-LTP/proc/alloc.c
@@ -12,8 +12,7 @@
 void *xcalloc(void *pointer, int size)
 {
 	void *ret;
-	if (pointer)
-		free(pointer);
+	free(pointer);
 	if (!(ret = calloc(1, size))) {
 		fprintf(stderr, "xcalloc: allocation error, size = %d\n", size);
 		exit(1);
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

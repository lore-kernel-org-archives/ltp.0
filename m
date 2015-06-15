Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UM4-0002do-Ba
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:23:12 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UM2-0003OT-DU
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:23:12 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ029XPMIFDU30@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:23:03 +0900 (KST)
Date: Mon, 15 Jun 2015 13:23:03 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1772976838.1047631434374583253.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 1/7] pan/zoolib.c: remove unnecessary type cast for
	malloc
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
 pan/zoolib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pan/zoolib.c b/pan/zoolib.c
index afdc706..0ac7852 100644
--- a/pan/zoolib.c
+++ b/pan/zoolib.c
@@ -377,7 +377,7 @@ char *cat_args(int argc, char **argv)
 		size++;
 	}
 
-	if ((cmd = (char *)malloc(size)) == NULL) {
+	if ((cmd = malloc(size)) == NULL) {
 		snprintf(zoo_error, ZELEN,
 			 "Malloc Error, %s/%d", __FILE__, __LINE__);
 		return NULL;
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

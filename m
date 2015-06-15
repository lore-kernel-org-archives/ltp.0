Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UOO-0002A0-2h
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:25:36 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UOM-0006fA-Kr
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:25:36 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ02AW7MMG7D30@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:25:28 +0900 (KST)
Date: Mon, 15 Jun 2015 13:25:07 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1820755031.1047751434374707901.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 6/7] pan/symbol.c: remove unnecessary malloc type cast
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
 pan/symbol.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pan/symbol.c b/pan/symbol.c
index ca9964a..3752114 100644
--- a/pan/symbol.c
+++ b/pan/symbol.c
@@ -86,7 +86,7 @@ SYM newsym(void)
 {
 	SYM h;
 
-	if ((h = (SYM) malloc(sizeof(struct symh))) == NULL) {
+	if ((h = malloc(sizeof(struct symh))) == NULL) {
 		sym_error = "sym header malloc failed!";
 		return (NULL);
 	}
@@ -101,7 +101,7 @@ static struct sym *mknode(struct sym *next, char *key, void *data)
 {
 	struct sym *n;
 
-	if ((n = (struct sym *)malloc(sizeof(struct sym))) == NULL) {
+	if ((n = malloc(sizeof(struct sym))) == NULL) {
 		sym_error = "sym node malloc failed!";
 		return (NULL);
 	}
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UMS-00023b-9x
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:23:36 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UMR-0006bk-9M
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:23:36 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ02ASHMJ3CE30@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:23:27 +0900 (KST)
Date: Mon, 15 Jun 2015 13:23:27 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1582945054.1047651434374607658.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 2/7] pan/splitstr.c: remove unnecessary malloc type
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
 pan/splitstr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pan/splitstr.c b/pan/splitstr.c
index fbcd697..39b4698 100644
--- a/pan/splitstr.c
+++ b/pan/splitstr.c
@@ -88,7 +88,7 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
 	/*
 	 * set aside an initial char ** array for string array.
 	 */
-	arg_array = (char **)malloc(sizeof(char *) * max_toks);
+	arg_array = malloc(sizeof(char *) * max_toks);
 
 	if (arg_array == NULL) {
 		if (argcount != NULL)
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

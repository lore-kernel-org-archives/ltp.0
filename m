Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UNF-00026R-Br
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:24:25 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UNE-0003Qf-6k
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:24:25 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ019VHMKHA7A0@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:24:17 +0900 (KST)
Date: Mon, 15 Jun 2015 13:24:16 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1941085741.1047691434374656917.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 4/7] pan/ltp-bump.c: remove unnecessary malloc type
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
 pan/ltp-bump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pan/ltp-bump.c b/pan/ltp-bump.c
index 5966c2e..b6d676f 100644
--- a/pan/ltp-bump.c
+++ b/pan/ltp-bump.c
@@ -53,7 +53,7 @@ int main(int argc, char **argv)
 	while ((c = getopt(argc, argv, "a:s:12")) != -1) {
 		switch (c) {
 		case 'a':
-			active = (char *)malloc(strlen(optarg) + 1);
+			active = malloc(strlen(optarg) + 1);
 			strcpy(active, optarg);
 			break;
 		case 's':
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

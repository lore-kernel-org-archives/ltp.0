Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UOV-00061L-38
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:25:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UOU-0006wd-2b
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:25:43 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ0049TMMADVD0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:25:22 +0900 (KST)
Date: Mon, 15 Jun 2015 13:25:34 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1983588051.1047771434374734551.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 7/7] lib/random_range.c: remove unnecessary malloc
	type cast
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
 lib/random_range.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/random_range.c b/lib/random_range.c
index 1d88dd2..510a4a1 100644
--- a/lib/random_range.c
+++ b/lib/random_range.c
@@ -121,7 +121,7 @@ int parse_ranges(char *str, int defmin, int defmax, int defmult,
 	}
 
 	tmpstr = strdup(str);
-	ranges = (struct range *)malloc((ncommas + 1) * sizeof(struct range));
+	ranges = malloc((ncommas + 1) * sizeof(struct range));
 	rp = ranges;
 
 	tok = strtok(tmpstr, ",");
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

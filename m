Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1YxpbL-0000Hg-Bd
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:39:27 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YxpbJ-0005aQ-IV
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:39:27 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NP1001C9M9DESD0@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 28 May 2015 13:39:13 +0900 (KST)
Date: Thu, 28 May 2015 04:39:12 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1767962182.190171432787952596.JavaMail.weblogic@epmlwas05c>
Subject: [LTP]  [PATCH]: Fix Invalid number of character
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
Subject: [PATCH] lib/dataascii.c: Fix Invalid number of character in dataascii

This patch adds curly brace in if condition to check buffer

Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
---
 lib/dataascii.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dataascii.c b/lib/dataascii.c
index 1214ba6..2a196bf 100644
--- a/lib/dataascii.c
+++ b/lib/dataascii.c
@@ -119,7 +119,7 @@ int main(int ac, char **ag)
 	char *errmsg;
 
 	buffer = malloc(size);
-	if (buffer == NULL)
+	if (buffer == NULL){
 		perror("malloc");
 		exit(2);
 	}
-- 
1.7.9.5

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

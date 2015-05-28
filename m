Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1YxpW5-0003ke-1D
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:34:01 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YxpW2-0004yk-SG
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:34:01 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NP1033GGLZR4VA0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 28 May 2015 13:33:27 +0900 (KST)
Date: Thu, 28 May 2015 04:33:32 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1814027454.189791432787612391.JavaMail.weblogic@epmlwas05c>
Subject: [LTP]  [PATCH]: Add check for realloc() failure case
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
Subject: [PATCH] testcases/kernel/fs/fsstress/fsstress.c:  Add check for realloc() failure case

This patch add check for realloc failure case and exit from the testcase if realloc fails.

Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 2243280..ce74f99 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -330,8 +330,12 @@ int main(int argc, char **argv)
 			process_freq(optarg);
 			break;
 		case 'i':
-			ilist = realloc(ilist, ++ilistlen * sizeof(*ilist));
-			ilist[ilistlen - 1] = strtol(optarg, &p, 16);
+			if(realloc(ilist, ++ilistlen * sizeof(*ilist)) != NULL)
+				ilist[ilistlen - 1] = strtol(optarg, &p, 16);
+			else{
+				fprintf(stderr, "realloc: New memory allocation failed \n");
+				exit(1);
+			}
 			break;
 		case 'l':
 			loops = atoi(optarg);
-- 
1.7.9.5


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

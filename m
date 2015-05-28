Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1YxpYi-0000CA-HP
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:36:44 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YxpYg-0005Cw-KZ
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:36:44 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NP1000MUM4YCHD0@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 28 May 2015 13:36:34 +0900 (KST)
Date: Thu, 28 May 2015 04:36:27 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1124984645.189951432787787528.JavaMail.weblogic@epmlwas05c>
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
Subject: [PATCH] testcases/network/nfs/nfs_fsstress/fsstress.c: Add check for realloc() failure case 

This patch add check for realloc failure case and exit from the testcase if realloc fails.

Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
---
 testcases/network/nfs/nfs_fsstress/fsstress.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_fsstress/fsstress.c b/testcases/network/nfs/nfs_fsstress/fsstress.c
index ac91262..208c2dc 100644
--- a/testcases/network/nfs/nfs_fsstress/fsstress.c
+++ b/testcases/network/nfs/nfs_fsstress/fsstress.c
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

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1YxSKA-0006Px-EC
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 03:48:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YxSK8-0007RD-D6
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 03:48:10 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NOZ02ZA1P7W4060@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 27 May 2015 12:47:56 +0900 (KST)
Date: Wed, 27 May 2015 03:47:48 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1815411283.124861432698468787.JavaMail.weblogic@epmlwas05a>
Subject: [LTP] [PATCH]: Fix dprt() function call by adding gettid()
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
To: ltp-list@lists.sourceforge.net, Yogesh Narayan Gaur <yn.gaur@samsung.com>

From: Manjeet Pawar <manjeet.p@samsung.com>

This patch adds missing gettid() function call in dprt

Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Reviewed-by: Yogesh Gaur <yn.gaur@samsung.com>
---
 testcases/network/nfs/nfsstress/make_tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfsstress/make_tree.c b/testcases/network/nfs/nfsstress/make_tree.c
index 7b18da3..99252ae 100644
--- a/testcases/network/nfs/nfsstress/make_tree.c
+++ b/testcases/network/nfs/nfsstress/make_tree.c
@@ -319,7 +319,7 @@ static int init_compile(int what_todo,	/* do a compile or clean             */
 				return 1;
 			}
 
-			dprt("pid[%d]: init_compile(): status = %d\n", status);
+			dprt("pid[%d]: init_compile(): status = %d\n", gettid(), status);
 			dprt("we are here %d\n", __LINE__);
 			return status;
 		}
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

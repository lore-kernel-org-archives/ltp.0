Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4M6-0007Kg-03
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:24:42 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4M5-0008GS-7L
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:24:41 +0000
Message-ID: <4F030192.8030107@imgtec.com>
Date: Tue, 3 Jan 2012 13:24:34 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040802010308020600060501"
Subject: [LTP] [PATCH 19/21] nfs/nfsstress/make_tree: Fix erroneous cast to
 void pointer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--------------040802010308020600060501
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------040802010308020600060501
Content-Type: text/plain;
	name="0019-nfs-nfsstress-make_tree-Fix-erroneous-cast-to-void-p.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0019-nfs-nfsstress-make_tree-Fix-erroneous-cast-to-void-p.pa";
	filename*1="tch"

From 3c4f375b923af0ddc64257afbecf1dd2c8efef17 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 15:17:34 +0000
Subject: [PATCH 19/21] nfs/nfsstress/make_tree: Fix erroneous cast to void pointer

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/network/nfs/nfsstress/make_tree.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfsstress/make_tree.c b/testcases/network/nfs/nfsstress/make_tree.c
index 02d0304..c51e75e 100644
--- a/testcases/network/nfs/nfsstress/make_tree.c
+++ b/testcases/network/nfs/nfsstress/make_tree.c
@@ -202,7 +202,7 @@
 #define PTHREAD_EXIT(val)    do {\
 			exit_val = val; \
                         dprt("pid[%d]: exiting with %d\n", gettid(),exit_val); \
-			pthread_exit((void *)exit_val); \
+			pthread_exit((void *)&exit_val); \
 				} while (0)
 
 #define OPT_MISSING(prog, opt)   do{\
@@ -846,4 +846,4 @@ main(int	argc,		/* number of input parameters		      */
         }
     }
     return(0);
-}
\ No newline at end of file
+}
-- 
1.7.1


--------------040802010308020600060501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------040802010308020600060501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040802010308020600060501--



Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1Yxpdb-00041X-08
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:41:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YxpdY-0005tJ-VX
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:41:46 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NP1007IIMDCNA00@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 28 May 2015 13:41:36 +0900 (KST)
Date: Thu, 28 May 2015 04:41:36 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1230732671.190411432788096392.JavaMail.weblogic@epmlwas05c>
Subject: [LTP]  [PATCH]: Fix memory leaks and remove redundant code
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
Subject: [PATCH] lib/self_exec.c: free args before returning from function to avoid memory leaks and remove redundant code in self_exec()

This patch free args before returning from function to avoid memory leaks and remove redundant code in self_exec()

Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
---
 lib/self_exec.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/self_exec.c b/lib/self_exec.c
index 06af313..e8f1ee6 100644
--- a/lib/self_exec.c
+++ b/lib/self_exec.c
@@ -117,6 +117,7 @@ void maybe_run_child(void (*child) (), char *fmt, ...)
 				}
 				if (j != i) {
 					va_end(ap);
+					free(args);
 					return;
 				}
 				break;
@@ -144,7 +145,7 @@ void maybe_run_child(void (*child) (), char *fmt, ...)
 		}
 
 		va_end(ap);
-
+		free(args);
 		if (chdir(child_dir) < 0)
 			tst_brkm(TBROK, NULL,
 				 "Could not change to %s for child", child_dir);
@@ -170,8 +171,7 @@ int self_exec(char *argv0, char *fmt, ...)
 	}
 
 	arg = strdup(tmp_cwd);
-
-	if ((arg = strdup(tmp_cwd)) == NULL) {
+	if (arg == NULL) {
 		tst_resm(TBROK, "Could not produce self_exec string");
 		return -1;
 	}
-- 
1.7.9.5

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

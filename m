Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1YxpSr-0004ph-IO
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:30:41 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YxpSp-0005uB-Km
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2015 04:30:41 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NP100EQKLUVDXC0@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 28 May 2015 13:30:31 +0900 (KST)
Date: Thu, 28 May 2015 04:30:31 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <947582411.189461432787431522.JavaMail.weblogic@epmlwas05c>
Subject: [LTP]  [PATCH]: Add check for realloc failure case
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
Subject: [PATCH] pan/splitstr.c: Add check for realloc failure case

This patch adds check for realloc failure case and free arg_string before returning from splitstr() to avoid memory leaks

Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
---
 pan/splitstr.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pan/splitstr.c b/pan/splitstr.c
index 4706323..8804b15 100644
--- a/pan/splitstr.c
+++ b/pan/splitstr.c
@@ -93,6 +93,7 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
 	if (arg_array == NULL) {
 		if (argcount != NULL)
 			*argcount = 0;
+		free(arg_string);
 		return (NULL);
 	}
 
@@ -110,9 +111,13 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
 		cur_tok = strtok(NULL, separator);
 		if (num_toks == max_toks) {
 			max_toks += 20;
-			arg_array =
-			    (char **)realloc((void *)arg_array,
-					     sizeof(char *) * max_toks);
+			if((arg_array = realloc((void *)arg_array,sizeof(char *) * max_toks)) == NULL){
+				fprintf(stderr, "realloc: New memory allocation failed \n");
+				free(arg_array);
+				free(arg_string);
+				exit(1);
+			}
+
 		}
 	}
 	arg_array[num_toks] = NULL;
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

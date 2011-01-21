Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cristian@regolo.cc>) id 1PgNfD-0005tD-Dt
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 20:32:55 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgNfC-000424-6p
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 20:32:55 +0000
Received: from regolo (93-46-29-194.ip105.fastwebnet.it [93.46.29.194])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id 1CAC464
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 21:32:48 +0100 (CET)
Date: Fri, 21 Jan 2011 21:32:43 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110121213243.68c293fc@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Remove misused variable: fixes an array out-of-bounds
 access.
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
To: ltp-list@lists.sourceforge.net

Hi,

this should fix an out-of-bounds access by removing the useless
variable.


Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/fs/inode/inode02.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
index 8566c9a..05d5c7a 100644
--- a/testcases/kernel/fs/inode/inode02.c
+++ b/testcases/kernel/fs/inode/inode02.c
@@ -80,7 +80,6 @@ int  nchild;
 FILE *list_stream=NULL;
 int  list_id;
 int  file_id;
-char slash[1];
 
 int increment_name(), get_next_name(), mode(), escrivez(), massmurder();
 int max_depth, max_breadth, file_length;
@@ -249,9 +248,6 @@ int tree()
 	int len;
 	int status;
 
-	slash[0] = '/';
-	slash[1] = '\0';
-
 	/********************************/
 	/*				*/
 	/*  make the root directory for */
@@ -285,8 +281,7 @@ int tree()
 	/****************************************/
 
 	strcpy(path_list_string, path_string);
-	strcat(path_list_string, slash);
-	strcat(path_list_string, "path_list");
+	strcat(path_list_string, "/path_list");
 	list_id = creat(path_list_string, FILE_MODE);
 	if (list_id == -1) {
 		fprintf(temp,"\nThe path_list file '%s' cannot be created, errno=%d\n",
@@ -423,7 +418,7 @@ int level;    	/* the tree depth variable */
 		for (i = 0; i <= max_breadth; i++) {
 			get_next_name();
 			strcpy(new_string, string);
-			strcat(new_string, slash);
+			strcat(new_string, "/");
 			strcat(new_string, name);
 
 			/****************************************/
@@ -900,4 +895,4 @@ instress()
         tst_resm(TINFO, "System resource may be too low, fork() malloc()"
                                 " etc are likely to fail.\n");
         return 1;
-}
\ No newline at end of file
+}
-- 
1.7.2.3


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <njoly@lanfeust.sis.pasteur.fr>) id 1WsRbn-0001q3-6H
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 06:57:07 +0000
Received: from mail-interne2.pasteur.fr ([157.99.64.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WsRbl-0004Wh-Rf
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 06:57:07 +0000
From: Nicolas Joly <njoly@pasteur.fr>
Date: Thu,  5 Jun 2014 08:33:48 +0200
Message-Id: <1401950028-7214-1-git-send-email-njoly@pasteur.fr>
Subject: [LTP] [PATCH] lstat/lstat03.c: Fix broken file type check
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>
---
 testcases/kernel/syscalls/lstat/lstat03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index d48d1ab..2d8716c 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 		 */
 		if ((stat_buf.st_uid != user_id) ||
 		    (stat_buf.st_gid != group_id) ||
-		    (!(stat_buf.st_mode && S_IFLNK)) ||
+		    (!(stat_buf.st_mode & S_IFLNK)) ||
 		    (stat_buf.st_size != strlen(TESTFILE))) {
 			tst_resm(TFAIL, "Functionality of lstat(2) on "
 				 "'%s' Failed", SFILE);
-- 
1.9.0


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

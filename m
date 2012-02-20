Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RzQuR-00039K-G4
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 10:55:55 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RzQuN-0004w4-Jt
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 10:55:55 +0000
Received: by daln34 with SMTP id n34so5707300dal.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Feb 2012 02:55:45 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 20 Feb 2012 18:55:00 +0800
Message-Id: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 1/2] mm/lib: change count_numa() behavior
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
To: Zhouping Liu <zliu@redhat.com>, LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


this patch fixes two problems.

1) avoid using functions from numactl package, so compilation would pass
w/ and w/o numactl development package installed.

2) count_numa() functions now has a parameter, which stores the array of
each nodes on the system. This is because some systems doesn't have
continuous nodes or the node sequence does not start from zero, when we
want to test specific node, we should make sure the node does exist.
Thus, an array for node numbers is necessary. Follow-up patches will
update count_numa() with new parameters accordingly.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/include/mem.h |    2 +-
 testcases/kernel/mem/lib/mem.c     |   12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0001-mm-lib-change-count_numa-behavior.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-lib-change-count_numa-behavior.patch"

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index f86efab..d0d2507 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -58,7 +58,7 @@ void umount_mem(char *path, char *path_new);
 void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
 
 /* general function */
-long count_numa(void);
+long count_numa(long nodes[]);
 int  path_exist(const char *path, ...);
 long read_meminfo(char *item);
 void set_sys_tune(char *sys_file, long tune, int check);
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 6bfe0c1..c7188c2 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -707,16 +707,14 @@ void mount_mem(char *name, char *fs, char *options, char *path, char *path_new)
 
 /* general functions */
 
-long count_numa(void)
+long count_numa(long nodes[])
 {
-	int nnodes = 0;
-	int max_node;
-	int i;
+	long nnodes, i;
 
-	max_node = numa_max_node();
-	for(i = 0; i <= max_node; i++)
+	nnodes = 0;
+	for (i = 0; i <= MAXNODES; i++)
 		if(path_exist(PATH_SYS_SYSTEM "/node/node%d", i))
-			nnodes++;
+			nodes[nnodes++] = i;
 
 	return nnodes;
 }

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--




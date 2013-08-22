Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VCPWw-0005z6-Dm
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 07:42:06 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VCPWu-0005gv-M3
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 07:42:06 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 22 Aug 2013 11:41:48 +0400
Message-Id: <1377157309-23572-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <52122141.3020005@oracle.com>
References: <52122141.3020005@oracle.com>
Subject: [LTP] [PATCH V3 2/3] syscalls/migrate_pages: fix nodemask memory
	allocation
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
Cc: vasily.isaenko@oracle.com

In accordance to man migrate_pages(), mbind() the bit mask size
should be rounded to the next multiple of sizeof(unsigned long).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../syscalls/migrate_pages/migrate_pages01.c       |    4 ++--
 .../syscalls/migrate_pages/migrate_pages02.c       |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index c23e8b0..9af4f14 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -247,8 +247,8 @@ static void setup(void)
 		tst_brkm(TBROK | TERRNO, NULL, "get_allowed_nodes_arr: %d",
 			 ret);
 
-	sane_max_node = get_max_node();
-	sane_nodemask_size = sane_max_node / 8 + 1;
+	sane_max_node = ALIGN(get_max_node(), sizeof(unsigned long)*8);
+	sane_nodemask_size = sane_max_node / 8;
 	sane_old_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
 	sane_new_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
 	memset(sane_old_nodes, 0, sane_nodemask_size);
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 49129e0..ba0e625 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -109,8 +109,8 @@ static int migrate_to_node(pid_t pid, int node)
 
 	tst_resm(TINFO, "pid(%d) migrate pid %d to node -> %d",
 		 getpid(), pid, node);
-	max_node = get_max_node();
-	nodemask_size = max_node / 8 + 1;
+	max_node = ALIGN(get_max_node(), sizeof(unsigned long)*8);
+	nodemask_size = max_node / 8;
 	old_nodes = SAFE_MALLOC(NULL, nodemask_size);
 	new_nodes = SAFE_MALLOC(NULL, nodemask_size);
 
-- 
1.7.1


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

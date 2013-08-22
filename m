Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VCPWx-0005Uh-HP
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 07:42:07 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VCPWv-0004Vy-RV
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 07:42:07 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 22 Aug 2013 11:41:49 +0400
Message-Id: <1377157309-23572-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <52122141.3020005@oracle.com>
References: <52122141.3020005@oracle.com>
Subject: [LTP] [PATCH V3 3/3] lib/numa_helper.c: fix nodemask_size
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

Now nodemask_size is rounded up to the next
multiple of sizeof(unsigned long).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/lib/numa_helper.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 4157816..ab294f0 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -60,7 +60,7 @@ unsigned long get_max_node(void)
 #if HAVE_NUMA_H
 static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
 {
-	unsigned long nodemask_size = max_node / 8 + 1;
+	unsigned long nodemask_size = max_node / 8;
 	int i;
 	char fn[64];
 	struct stat st;
@@ -76,7 +76,7 @@ static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
 static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 {
 #if MPOL_F_MEMS_ALLOWED
-	unsigned long nodemask_size = max_node / 8 + 1;
+	unsigned long nodemask_size = max_node / 8;
 	memset(nodemask, 0, nodemask_size);
 	/*
 	 * avoid numa_get_mems_allowed(), because of bug in getpol()
@@ -164,8 +164,8 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 		*nodes = NULL;
 
 #if HAVE_NUMA_H
-	unsigned long max_node = get_max_node();
-	unsigned long nodemask_size = max_node / 8 + 1;
+	unsigned long max_node = ALIGN(get_max_node(), sizeof(unsigned long)*8);
+	unsigned long nodemask_size = max_node / 8;
 
 	nodemask = malloc(nodemask_size);
 	if (nodes)
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

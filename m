Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VBMiU-0007Fp-Q0
	for ltp-list@lists.sourceforge.net; Mon, 19 Aug 2013 10:29:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VBMiR-0006nQ-Jw
	for ltp-list@lists.sourceforge.net; Mon, 19 Aug 2013 10:29:42 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 19 Aug 2013 14:29:24 +0400
Message-Id: <1376908164-10045-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] syscalls/migrate_pages: fix nodemask memory allocation
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
should be rounded to next multiple of sizeof(unsigned long).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../syscalls/migrate_pages/migrate_pages01.c       |    5 ++++-
 .../syscalls/migrate_pages/migrate_pages02.c       |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index c23e8b0..9981c0c 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -248,7 +248,10 @@ static void setup(void)
 			 ret);
 
 	sane_max_node = get_max_node();
-	sane_nodemask_size = sane_max_node / 8 + 1;
+	sane_nodemask_size = sane_max_node / (sizeof(unsigned long)*8);
+	sane_nodemask_size += sane_max_node % (sizeof(unsigned long)*8) == 0 ?
+				0 : 1;
+	sane_nodemask_size *= sizeof(unsigned long);
 	sane_old_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
 	sane_new_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
 	memset(sane_old_nodes, 0, sane_nodemask_size);
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 49129e0..2b30b1f 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -110,7 +110,10 @@ static int migrate_to_node(pid_t pid, int node)
 	tst_resm(TINFO, "pid(%d) migrate pid %d to node -> %d",
 		 getpid(), pid, node);
 	max_node = get_max_node();
-	nodemask_size = max_node / 8 + 1;
+	nodemask_size = max_node / (sizeof(unsigned long)*8);
+	nodemask_size += max_node % (sizeof(unsigned long)*8) == 0 ?
+			0 : 1;
+	nodemask_size *= sizeof(unsigned long);
 	old_nodes = SAFE_MALLOC(NULL, nodemask_size);
 	new_nodes = SAFE_MALLOC(NULL, nodemask_size);
 
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

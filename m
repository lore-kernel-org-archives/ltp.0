Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TOpeV-0006fq-9Y
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 12:56:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TOpeR-00025p-Ek
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 12:56:43 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9ICuXMC015808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Oct 2012 08:56:33 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q9ICuVXa003245
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Oct 2012 08:56:32 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Oct 2012 14:56:22 +0200
Message-Id: <8027d11d6c5c4817de919817f6bbb2b76a342845.1350564702.git.jstancek@redhat.com>
In-Reply-To: <cover.1350564702.git.jstancek@redhat.com>
References: <cover.1350564702.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/3 v2] numa_helper: export get_max_node()
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

Allow tests to use get_max_node().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/include/numa_helper.h |    1 +
 testcases/kernel/lib/numa_helper.c     |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
index 463019a..0be7a28 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -30,6 +30,7 @@
 #define NH_MEMS (1 << 0)
 #define NH_CPUS (1 << 1)
 
+unsigned long get_max_node();
 int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
 int get_allowed_nodes(int flag, int count, ...);
 void nh_dump_nodes();
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index aa98522..32d81a9 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -37,10 +37,10 @@
 #include "numa_helper.h"
 #include "linux_syscall_numbers.h"
 
-#if HAVE_NUMA_H
-static unsigned long get_max_node()
+unsigned long get_max_node()
 {
 	unsigned long max_node = 0;
+#if HAVE_NUMA_H
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	max_node = NUMA_NUM_NODES;
 	/*
@@ -53,9 +53,11 @@ static unsigned long get_max_node()
 #else
 	max_node = numa_max_possible_node() + 1;
 #endif
+#endif /* HAVE_NUMA_H */
 	return max_node;
 }
 
+#if HAVE_NUMA_H
 static void get_nodemask_allnodes(nodemask_t *nodemask,
 	unsigned long max_node)
 {
-- 
1.7.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

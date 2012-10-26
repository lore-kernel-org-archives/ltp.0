Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TRk0e-0005Kd-CP
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 13:31:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TRk0a-0002FC-J1
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 13:31:36 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9QDVRZJ017920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Oct 2012 09:31:27 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q9QDVOfM016952
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Oct 2012 09:31:26 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 26 Oct 2012 15:31:15 +0200
Message-Id: <ec297ec37d42b978b26dc407dabd62225e62b7f8.1351256774.git.jstancek@redhat.com>
In-Reply-To: <cover.1351256774.git.jstancek@redhat.com>
References: <cover.1351256774.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v3 1/3] numa_helper: export get_max_node()
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

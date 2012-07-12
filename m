Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SpK5y-00077F-1c
	for ltp-list@lists.sourceforge.net; Thu, 12 Jul 2012 14:10:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SpK5t-00084Q-Us
	for ltp-list@lists.sourceforge.net; Thu, 12 Jul 2012 14:10:17 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6CEA8et025258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Jul 2012 10:10:08 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q6CEA6Jw005050
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Jul 2012 10:10:07 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Jul 2012 16:09:47 +0200
Message-Id: <0fbd4f879e0452245a9b4dc3ba7abc878d4161bd.1342102159.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] numa_helper: fix compatibility with older libnuma
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

numa_helper relied on functions that do not exist
in old libnuma (<1), which caused that it couldn't be
compiled on old distros, for example RHEL 5.3.

Old libnuma and kernel also do not support MPOL_F_MEMS_ALLOWED,
in which case it will assume that any node with memory > 0 can
be used.

This patch adds compatibility for older versions, I tested it with:
numactl-0.9.8-7.el5
numactl-2.0.3-9.el6
numactl-2.0.7-6.el7

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/numa/lib/Makefile      |    2 +-
 testcases/kernel/syscalls/numa/lib/numa_helper.c |   52 +++++++++++++++++-----
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/numa/lib/Makefile b/testcases/kernel/syscalls/numa/lib/Makefile
index d4a6f41..ba2fb48 100644
--- a/testcases/kernel/syscalls/numa/lib/Makefile
+++ b/testcases/kernel/syscalls/numa/lib/Makefile
@@ -20,7 +20,7 @@ top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= -I../../../include
+CPPFLAGS		+= -I../../../include $(NUMA_CPPFLAGS)
 LIB			:= libnuma_helper.a
 
 include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.c b/testcases/kernel/syscalls/numa/lib/numa_helper.c
index 855ee2c..20b06ca 100644
--- a/testcases/kernel/syscalls/numa/lib/numa_helper.c
+++ b/testcases/kernel/syscalls/numa/lib/numa_helper.c
@@ -53,46 +53,74 @@ int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes)
 {
 #if HAVE_NUMA_H
 	int i;
-	struct bitmask *allowed_nodemask = NULL;
+	nodemask_t *allowed_nodemask = NULL;
+	unsigned long max_node;
+
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+	max_node = NUMA_NUM_NODES;
+	/*
+	 * NUMA_NUM_NODES is not reliable, libnuma >=2 is looking
+	 * at /proc/self/status to figure out correct number.
+	 * If buffer is not large enough get_mempolicy will fail with EINVAL.
+	 */
+	if (max_node < 1024)
+		max_node = 1024;
+#else
+	max_node = numa_max_possible_node() + 1;
 #endif
+#endif /* HAVE_NUMA_H */
+
 	*num_allowed_nodes = 0;
 	if (allowed_nodes)
 		*allowed_nodes = NULL;
 
-#if HAVE_NUMA_H && HAVE_MPOL_CONSTANTS
-	if ((allowed_nodemask = numa_allocate_nodemask()) == NULL)
+#if HAVE_NUMA_H
+	if ((allowed_nodemask = malloc(max_node/8+1)) == NULL)
 		return -1;
+	nodemask_zero(allowed_nodemask);
 
 	if (allowed_nodes) {
-		*allowed_nodes = malloc(sizeof(int)*allowed_nodemask->size);
-		if (*allowed_nodes == NULL)
+		*allowed_nodes = malloc(sizeof(int)*max_node);
+		if (*allowed_nodes == NULL) {
+			free(allowed_nodemask);
 			return -1;
+		}
 	}
 
+#if MPOL_F_MEMS_ALLOWED
 	/*
 	 * avoid numa_get_mems_allowed(), because of bug in getpol()
 	 * utility function in older versions:
 	 * http://www.spinics.net/lists/linux-numa/msg00849.html
 	 */
-	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->maskp,
-		allowed_nodemask->size, 0, MPOL_F_MEMS_ALLOWED) < 0) {
-		numa_bitmask_free(allowed_nodemask);
+	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->n,
+		max_node, 0, MPOL_F_MEMS_ALLOWED) < 0) {
+		free(allowed_nodemask);
 		if (allowed_nodes) {
 			free(*allowed_nodes);
 			*allowed_nodes = NULL;
 		}
 		return -2;
 	}
+#else
+	/*
+	 * old libnuma/kernel don't have MPOL_F_MEMS_ALLOWED, so let's assume
+	 * that we can use any node with memory > 0
+	 */
+	for (i = 0; i < max_node; i++)
+		if (numa_node_size64(i, NULL) > 0)
+			nodemask_set(allowed_nodemask, i);
 
-	for (i = 0; i <	allowed_nodemask->size; i++) {
-		if (numa_bitmask_isbitset(allowed_nodemask, i)) {
+#endif /* MPOL_F_MEMS_ALLOWED */
+	for (i = 0; i < max_node; i++) {
+		if (nodemask_isset(allowed_nodemask, i)) {
 			if (allowed_nodes)
 				(*allowed_nodes)[*num_allowed_nodes] = i;
 			(*num_allowed_nodes)++;
 		}
 	}
-	numa_bitmask_free(allowed_nodemask);
-#endif
+	free(allowed_nodemask);
+#endif /* HAVE_NUMA_H */
 	return 0;
 }
 
-- 
1.7.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

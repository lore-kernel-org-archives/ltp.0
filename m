Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzM2U-00008A-Ob
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:10 +0000
Received: from mail-gg0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzM2T-0006Mg-2t
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:10 +0000
Received: by ggmq1 with SMTP id q1so73976ggm.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 23:16:03 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  9 Aug 2012 14:15:37 +0800
Message-Id: <5e7d255d57f150875e06b3a2e42d05d9fe03d95f.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH resend 1/6] numa_helper: add flag to
	get_allowed_nodes()
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
To: LTP List <ltp-list@lists.sourceforge.net>

From: Jan Stancek <jstancek@redhat.com>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


add flag, so testcases can request nodes with available
memory/cpus or both.

Also add small debug function.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/numa/lib/numa_helper.c |  211 ++++++++++++++++------
 testcases/kernel/syscalls/numa/lib/numa_helper.h |    8 +-
 2 files changed, 162 insertions(+), 57 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0001-numa_helper-add-flag-to-get_allowed_nodes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-numa_helper-add-flag-to-get_allowed_nodes.patch"

diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.c b/testcases/kernel/syscalls/numa/lib/numa_helper.c
index d50cb41..aa98522 100644
--- a/testcases/kernel/syscalls/numa/lib/numa_helper.c
+++ b/testcases/kernel/syscalls/numa/lib/numa_helper.c
@@ -27,6 +27,7 @@
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
 
@@ -36,26 +37,10 @@
 #include "numa_helper.h"
 #include "linux_syscall_numbers.h"
 
-/*
- * get_allowed_nodes_arr - get number and array of available nodes
- * @num_allowed_nodes: pointer where number of available nodes will be stored
- * @allowed_nodes: array of available node ids, this is MPOL_F_MEMS_ALLOWED
- *                 node bitmask compacted (without holes), so that each field
- *                 contains node number. If NULL only num_allowed_nodes is
- *                 returned, otherwise it cotains new allocated array,
- *                 which caller is responsible to free.
- * RETURNS:
- *     0 on success
- *    -1 on allocation failure
- *    -2 on get_mempolicy failure
- */
-int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes)
-{
 #if HAVE_NUMA_H
-	int i;
-	nodemask_t *allowed_nodemask = NULL;
-	unsigned long max_node;
-
+static unsigned long get_max_node()
+{
+	unsigned long max_node = 0;
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	max_node = NUMA_NUM_NODES;
 	/*
@@ -68,61 +53,150 @@ int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes)
 #else
 	max_node = numa_max_possible_node() + 1;
 #endif
-#endif /* HAVE_NUMA_H */
+	return max_node;
+}
 
-	*num_allowed_nodes = 0;
-	if (allowed_nodes)
-		*allowed_nodes = NULL;
+static void get_nodemask_allnodes(nodemask_t *nodemask,
+	unsigned long max_node)
+{
+	unsigned long nodemask_size = max_node/8+1;
+	int i;
+	char fn[64];
+	struct stat st;
 
-#if HAVE_NUMA_H
-	allowed_nodemask = malloc(max_node/8+1);
-	if (allowed_nodemask == NULL)
-		return -1;
-	nodemask_zero(allowed_nodemask);
-
-	if (allowed_nodes) {
-		*allowed_nodes = malloc(sizeof(int)*max_node);
-		if (*allowed_nodes == NULL) {
-			free(allowed_nodemask);
-			return -1;
-		}
+	memset(nodemask, 0, nodemask_size);
+	for (i = 0; i < max_node; i++) {
+		sprintf(fn, "/sys/devices/system/node/node%d", i);
+		if (stat(fn, &st) == 0)
+			nodemask_set(nodemask, i);
 	}
+}
 
+static int filter_nodemask_mem(nodemask_t *nodemask, unsigned long max_node)
+{
 #if MPOL_F_MEMS_ALLOWED
+	unsigned long nodemask_size = max_node/8+1;
+	memset(nodemask, 0, nodemask_size);
 	/*
 	 * avoid numa_get_mems_allowed(), because of bug in getpol()
 	 * utility function in older versions:
 	 * http://www.spinics.net/lists/linux-numa/msg00849.html
 	 */
-	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->n,
-		max_node, 0, MPOL_F_MEMS_ALLOWED) < 0) {
-		free(allowed_nodemask);
-		if (allowed_nodes) {
-			free(*allowed_nodes);
-			*allowed_nodes = NULL;
-		}
+	if (syscall(__NR_get_mempolicy, NULL, nodemask->n,
+		max_node, 0, MPOL_F_MEMS_ALLOWED) < 0)
 		return -2;
-	}
 #else
+	int i;
 	/*
 	 * old libnuma/kernel don't have MPOL_F_MEMS_ALLOWED, so let's assume
 	 * that we can use any node with memory > 0
 	 */
-	for (i = 0; i < max_node; i++)
-		if (numa_node_size64(i, NULL) > 0)
-			nodemask_set(allowed_nodemask, i);
-
+	for (i = 0; i < max_node; i++) {
+		if (!nodemask_isset(nodemask, i))
+			continue;
+		if (numa_node_size64(i, NULL) <= 0)
+			nodemask_clr(nodemask, i);
+	}
 #endif /* MPOL_F_MEMS_ALLOWED */
+	return 0;
+}
+
+static int cpumask_has_cpus(char *cpumask, size_t len)
+{
+	int j;
+	for (j = 0; j < len; j++)
+		if (cpumask[j] == '\0')
+			return 0;
+		else if ((cpumask[j] > '0' && cpumask[j] <= '9') ||
+			(cpumask[j] >= 'a' && cpumask[j] <= 'f'))
+			return 1;
+	return 0;
+
+}
+
+static void filter_nodemask_cpu(nodemask_t *nodemask, unsigned long max_node)
+{
+	char *cpumask = NULL;
+	char fn[64];
+	FILE *f;
+	size_t len;
+	int i, ret;
+
 	for (i = 0; i < max_node; i++) {
-		if (nodemask_isset(allowed_nodemask, i)) {
-			if (allowed_nodes)
-				(*allowed_nodes)[*num_allowed_nodes] = i;
-			(*num_allowed_nodes)++;
+		if (!nodemask_isset(nodemask, i))
+			continue;
+		sprintf(fn, "/sys/devices/system/node/node%d/cpumap", i);
+		f = fopen(fn, "r");
+		if (f) {
+			ret = getdelim(&cpumask, &len, '\n', f);
+			if ((ret > 0) && (!cpumask_has_cpus(cpumask, len)))
+				nodemask_clr(nodemask, i);
+			fclose(f);
 		}
 	}
-	free(allowed_nodemask);
+	free(cpumask);
+}
 #endif /* HAVE_NUMA_H */
-	return 0;
+
+/*
+ * get_allowed_nodes_arr - get number and array of available nodes
+ * @num_nodes: pointer where number of available nodes will be stored
+ * @nodes: array of available node ids, this is MPOL_F_MEMS_ALLOWED
+ *                 node bitmask compacted (without holes), so that each field
+ *                 contains node number. If NULL only num_nodes is
+ *                 returned, otherwise it cotains new allocated array,
+ *                 which caller is responsible to free.
+ * RETURNS:
+ *     0 on success
+ *    -1 on allocation failure
+ *    -2 on get_mempolicy failure
+ */
+int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
+{
+	int ret = 0;
+#if HAVE_NUMA_H
+	int i;
+	nodemask_t *nodemask = NULL;
+#endif
+	*num_nodes = 0;
+	if (nodes)
+		*nodes = NULL;
+
+#if HAVE_NUMA_H
+	unsigned long max_node = get_max_node();
+	unsigned long nodemask_size = max_node/8+1;
+
+	nodemask = malloc(nodemask_size);
+	if (nodes)
+		*nodes = malloc(sizeof(int)*max_node);
+
+	do {
+		if (nodemask == NULL ||	(nodes && (*nodes == NULL))) {
+			ret = -1;
+			break;
+		}
+
+		/* allow all nodes at start, then filter based on flags */
+		get_nodemask_allnodes(nodemask, max_node);
+		if ((flag & NH_MEMS) == NH_MEMS) {
+			ret = filter_nodemask_mem(nodemask, max_node);
+			if (ret < 0)
+				break;
+		}
+		if ((flag & NH_CPUS) == NH_CPUS)
+			filter_nodemask_cpu(nodemask, max_node);
+
+		for (i = 0; i <	max_node; i++) {
+			if (nodemask_isset(nodemask, i)) {
+				if (nodes)
+					(*nodes)[*num_nodes] = i;
+				(*num_nodes)++;
+			}
+		}
+	} while (0);
+	free(nodemask);
+#endif
+	return ret;
 }
 
 /*
@@ -135,7 +209,7 @@ int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes)
  *    -2 on get_mempolicy failure
  *    -3 on not enough allowed nodes
  */
-int get_allowed_nodes(int count, ...)
+int get_allowed_nodes(int flag, int count, ...)
 {
 	int ret;
 	int i, *nodep;
@@ -143,7 +217,7 @@ int get_allowed_nodes(int count, ...)
 	int num_nodes = 0;
 	int *nodes = NULL;
 
-	ret = get_allowed_nodes_arr(&num_nodes, &nodes);
+	ret = get_allowed_nodes_arr(flag, &num_nodes, &nodes);
 	if (ret < 0)
 		return ret;
 
@@ -163,3 +237,30 @@ int get_allowed_nodes(int count, ...)
 
 	return ret;
 }
+
+static void print_node_info(int flag)
+{
+	int *allowed_nodes = NULL;
+	int i, ret, num_nodes;
+
+	ret = get_allowed_nodes_arr(flag, &num_nodes, &allowed_nodes);
+	printf("nodes (flag=%d): ", flag);
+	if (ret == 0) {
+		for (i = 0; i < num_nodes; i++)
+			printf("%d ", allowed_nodes[i]);
+		printf("\n");
+	} else
+		printf("error(%d)\n", ret);
+	free(allowed_nodes);
+}
+
+/*
+ * nh_dump_nodes - dump info about nodes to stdout
+ */
+void nh_dump_nodes()
+{
+	print_node_info(0);
+	print_node_info(NH_MEMS);
+	print_node_info(NH_CPUS);
+	print_node_info(NH_MEMS | NH_CPUS);
+}
diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.h b/testcases/kernel/syscalls/numa/lib/numa_helper.h
index 6bfc58e..463019a 100644
--- a/testcases/kernel/syscalls/numa/lib/numa_helper.h
+++ b/testcases/kernel/syscalls/numa/lib/numa_helper.h
@@ -27,7 +27,11 @@
 #include <numaif.h>
 #endif
 
-int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes);
-int get_allowed_nodes(int count, ...);
+#define NH_MEMS (1 << 0)
+#define NH_CPUS (1 << 1)
+
+int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
+int get_allowed_nodes(int flag, int count, ...);
+void nh_dump_nodes();
 
 #endif

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--




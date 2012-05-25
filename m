Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SXqZS-0003UG-OO
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:12:30 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXqZO-0006B4-OI
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:12:30 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4P9CKbw021408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 May 2012 05:12:21 -0400
Message-ID: <4FBF4CF3.1020905@redhat.com>
Date: Fri, 25 May 2012 11:12:19 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010106020801090602010704"
Subject: [LTP] [PATCH 1/2] move_pages_support: use only allowed nodes
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
To: ltp-list@lists.sourceforge.net
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------010106020801090602010704
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Some setups can lack memory on arbitrary nodes, use only nodes
returned by get_mempolicy(..., MPOL_F_MEMS_ALLOWED).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/move_pages/move_pages_support.c       |   74 ++++++++++++++++----
 .../syscalls/move_pages/move_pages_support.h       |    1 +
 2 files changed, 62 insertions(+), 13 deletions(-)



--------------010106020801090602010704
Content-Type: text/x-patch;
	name="0001-move_pages_support-use-only-allowed-nodes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-move_pages_support-use-only-allowed-nodes.patch"

diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 320486f..83a841b 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -22,6 +22,7 @@
 #include <semaphore.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 #include "move_pages_support.h"
 
 long get_page_size()
@@ -98,6 +99,46 @@ int alloc_pages_on_nodes(void **pages, unsigned int num, int *nodes)
 }
 
 /*
+ * get_allowed_nodes - get number and array of available nodes
+ * @num_allowed_nodes: pointer where number of available nodes will be stored
+ * @allowed_nodes: array of available node ids, this is MPOL_F_MEMS_ALLOWED
+ *                 node bitmask compacted (without holes), so that each field
+ *                 contains node number. If NULL only num_allowed_nodes is
+ *                 returned, otherwise it cotains new allocated array,
+ *                 which caller is responsible to free.
+ */
+void get_allowed_nodes(int *num_allowed_nodes, int **allowed_nodes)
+{
+#if HAVE_NUMA_H
+	int i;
+	struct bitmask *allowed_nodemask = NULL;
+
+	*num_allowed_nodes = 0;
+	allowed_nodemask = numa_allocate_nodemask();
+	if (allowed_nodes)
+		*allowed_nodes = SAFE_MALLOC(NULL,
+			sizeof(int)*allowed_nodemask->size);
+	/*
+	 * avoid numa_get_mems_allowed(), because of bug in getpol()
+	 * utility function in older versions:
+	 * http://www.spinics.net/lists/linux-numa/msg00849.html
+	 */
+	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->maskp,
+		allowed_nodemask->size, 0, MPOL_F_MEMS_ALLOWED) < 0)
+		tst_resm(TFAIL|TERRNO, "get_mempolicy: MPOL_F_MEMS_ALLOWED");
+
+	for (i = 0; i <	allowed_nodemask->size; i++) {
+		if (numa_bitmask_isbitset(allowed_nodemask, i)) {
+			if (allowed_nodes)
+				(*allowed_nodes)[*num_allowed_nodes] = i;
+			(*num_allowed_nodes)++;
+		}
+	}
+	numa_bitmask_free(allowed_nodemask);
+#endif
+}
+
+/*
  * alloc_pages_linear() - allocate pages in each NUMA node
  * @pages: array in which the page pointers will be stored
  * @num: no. of pages to allocate
@@ -114,16 +155,18 @@ int alloc_pages_linear(void **pages, unsigned int num)
 
 #if HAVE_NUMA_H
 	unsigned int i;
-	unsigned int n;
+	unsigned int n = 0;
+	int num_allowed_nodes;
+	int *allowed_nodes;
 
-	n = 0;
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
 	for (i = 0; i < num; i++) {
-		nodes[i] = n;
-
+		nodes[i] = allowed_nodes[n];
 		n++;
-		if (n > numa_max_node())
+		if (n >= num_allowed_nodes)
 			n = 0;
 	}
+	free(allowed_nodes);
 #endif
 
 	return alloc_pages_on_nodes(pages, num, nodes);
@@ -210,18 +253,19 @@ void verify_pages_linear(void **pages, int *status, unsigned int num)
 {
 #if HAVE_NUMA_H
 	unsigned int i;
-	unsigned int n;
+	unsigned int n = 0;
 	int nodes[num];
+	int num_allowed_nodes;
+	int *allowed_nodes;
 
-	n = 0;
-
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
 	for (i = 0; i < num; i++) {
-		nodes[i] = i;
-
+		nodes[i] = allowed_nodes[n];
 		n++;
-		if (n > numa_max_node())
+		if (n >= num_allowed_nodes)
 			n = 0;
 	}
+	free(allowed_nodes);
 
 	verify_pages_on_nodes(pages, status, num, nodes);
 #endif
@@ -381,10 +425,14 @@ void free_sem(sem_t * sem, int num)
 void check_config(unsigned int min_nodes)
 {
 #if HAVE_NUMA_H && HAVE_NUMAIF_H
+	int num_allowed_nodes;
+	get_allowed_nodes(&num_allowed_nodes, NULL);
+
 	if (numa_available() < 0) {
 		tst_brkm(TCONF, NULL, "NUMA support is not available");
-	} else if (numa_max_node() < (min_nodes - 1)) {
-		tst_brkm(TCONF, NULL, "atleast 2 NUMA nodes are required");
+	} else if (num_allowed_nodes < min_nodes) {
+		tst_brkm(TCONF, NULL, "at least %d allowed NUMA nodes"
+		    " are required", min_nodes);
 	} else if (tst_kvercmp(2, 6, 18) < 0) {
 		tst_brkm(TCONF, NULL, "2.6.18 or greater kernel required");
 	}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.h b/testcases/kernel/syscalls/move_pages/move_pages_support.h
index fd78572..a10293b 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.h
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.h
@@ -29,6 +29,7 @@
 #include <semaphore.h>
 
 long get_page_size();
+void get_allowed_nodes(int *num_allowed_nodes, int **allowed_nodes);
 
 void free_pages(void **pages, unsigned int num);
 


--------------010106020801090602010704
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
--------------010106020801090602010704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010106020801090602010704--


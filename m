Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SO2Nz-0005CF-2J
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 07:48:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SO2Nx-00073f-QU
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 07:48:07 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Sat, 28 Apr 2012 15:48:40 +0800
Message-Id: <66ac99257dc97775fbb2b44287874ad43d408b4c.1335599279.git.zliu@redhat.com>
In-Reply-To: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
References: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
In-Reply-To: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
References: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
Subject: [LTP] [PATCH 2/3] syscalls/move_pages: modified HAS_NUMA_H as
	HAVE_NUMA_H
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
To: LTP List <ltp-list@lists.sourceforge.net>

HAS_NUMA_H should be HAVE_NUMA_H, and most functions are defined
in numa.h and numaif.h, so added the include headers into
move_pages_support.h

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages_support.c |   12 ++++++------
 testcases/kernel/syscalls/move_pages/move_pages_support.h |    7 +++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 168805e..6bd95d3 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -37,7 +37,7 @@ long get_page_size()
 void free_pages(void **pages, unsigned int num)
 {
 
-#if HAS_NUMA_H
+#if HAVE_NUMA_H
 	int i;
 	size_t onepage = get_page_size();
 
@@ -112,7 +112,7 @@ int alloc_pages_linear(void **pages, unsigned int num)
 {
 	int nodes[num];
 
-#if HAS_NUMA_H
+#if HAVE_NUMA_H
 	unsigned int i;
 	unsigned int n;
 
@@ -208,7 +208,7 @@ verify_pages_on_nodes(void **pages, int *status, unsigned int num, int *nodes)
  */
 void verify_pages_linear(void **pages, int *status, unsigned int num)
 {
-#if HAS_NUMA_H
+#if HAVE_NUMA_H
 	unsigned int i;
 	unsigned int n;
 	int nodes[num];
@@ -257,7 +257,7 @@ void verify_pages_on_node(void **pages, int *status, unsigned int num, int node)
  */
 int alloc_shared_pages_on_node(void **pages, unsigned int num, int node)
 {
-#if HAS_NUMA_H
+#if HAVE_NUMA_H
 	char *shared;
 	unsigned int i;
 	int nodes[num];
@@ -380,7 +380,7 @@ void free_sem(sem_t * sem, int num)
  */
 void check_config(unsigned int min_nodes)
 {
-#if HAS_NUMA_H
+#if HAVE_NUMA_H && HAVE_NUMAIF_H
 	if (numa_available() < 0) {
 		tst_resm(TCONF, "NUMA support is not available");
 	} else if (numa_max_node() < (min_nodes - 1)) {
@@ -392,4 +392,4 @@ void check_config(unsigned int min_nodes)
 	tst_resm(TCONF, "NUMA support not provided");
 #endif
 	tst_exit();
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.h b/testcases/kernel/syscalls/move_pages/move_pages_support.h
index 4081625..fd78572 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.h
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.h
@@ -19,6 +19,13 @@
 #ifndef MOVE_PAGES_SUPPORT_H
 #define MOVE_PAGES_SUPPORT_H
 
+#include "config.h"
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
 #include <semaphore.h>
 
 long get_page_size();
-- 
1.7.10


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

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WehFq-0003Jm-UO
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 08:49:38 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WehFo-0005iG-NB
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 08:49:38 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3S8nQP2002311
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 16:49:26 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 28 Apr 2014 16:47:13 +0800
Message-ID: <1398674834-1643-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] kernel/mem/lib/mem.c: fix compilation warnings
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Functions declared in testcases/kernel/mem/include/_private.h is not
implemented and used, so delete it.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/mem/include/_private.h | 22 ----------------------
 testcases/kernel/mem/include/mem.h      |  2 +-
 testcases/kernel/mem/lib/mem.c          | 25 +++++++++++++++----------
 3 files changed, 16 insertions(+), 33 deletions(-)
 delete mode 100644 testcases/kernel/mem/include/_private.h

diff --git a/testcases/kernel/mem/include/_private.h b/testcases/kernel/mem/include/_private.h
deleted file mode 100644
index d34d417..0000000
--- a/testcases/kernel/mem/include/_private.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef __INTERNAL_H
-#define __INTERNAL_H
-/* Internal APIs */
-
-/* OOM */
-static int  _alloc_mem(long int length, int testcase);
-static void _test_alloc(int testcase, int lite);
-
-/* KSM */
-static void _check(char *path, long int value);
-static void _group_check(int run, int pages_shared, int pages_sharing,
-		int pages_volatile, int pages_unshared,
-		int sleep_millisecs, int pages_to_scan);
-static void _verify(char **memory, char value, int proc, int start, int end,
-		int start2, int end2);
-
-/* cpuset/memcg */
-static void _gather_cpus(char *cpus, long nd);
-
-/* shared */
-
-#endif /* __INTERNAL_H */
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 342166e..746164c 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -23,7 +23,7 @@ static inline void set_node(unsigned long *array, unsigned int node)
 
 static inline void clean_node(unsigned long *array)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < MAXNODES / BITS_PER_LONG; i++)
 		array[i] &= 0UL;
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 188a5ef..f145a2a 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -21,7 +21,6 @@
 #include "usctest.h"
 #include "safe_macros.h"
 #include "safe_file_ops.h"
-#include "_private.h"
 #include "mem.h"
 #include "numa_helper.h"
 
@@ -256,15 +255,15 @@ void write_memcg(void)
 	SAFE_FILE_PRINTF(NULL, MEMCG_PATH_NEW "/tasks", "%d", getpid());
 }
 
-static struct ksm_merge_data {
+struct ksm_merge_data {
 	char data;
-	int mergeable_size;
+	unsigned int mergeable_size;
 };
 
 static void ksm_child_memset(int child_num, int size, int total_unit,
 		 struct ksm_merge_data ksm_merge_data, char **memory)
 {
-	int i, j;
+	int i = 0, j;
 	int unit = size / total_unit;
 
 	tst_resm(TINFO, "child %d continues...", child_num);
@@ -280,7 +279,7 @@ static void ksm_child_memset(int child_num, int size, int total_unit,
 	}
 
 	for (j = 0; j < total_unit; j++) {
-		for (i = 0; i < unit * MB; i++)
+		for (i = 0; (unsigned int)i < unit * MB; i++)
 			memory[j][i] = ksm_merge_data.data;
 	}
 
@@ -358,7 +357,7 @@ static void stop_ksm_children(int *child, int num)
 
 static void resume_ksm_children(int *child, int num)
 {
-	int k, status;
+	int k;
 
 	tst_resm(TINFO, "resume all children.");
 	for (k = 0; k < num; k++) {
@@ -474,7 +473,11 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	int num_nodes, *nodes;
 	unsigned long length;
 	unsigned long pagesize;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
+#endif
 
 	ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
 	if (ret != 0)
@@ -620,7 +623,8 @@ static int alloc_transparent_hugepages(int nr_thps, int hg_aligned)
 static void khugepaged_scan_done(void)
 {
 	int changing = 1, count = 0, interval;
-	long old_pages_collapsed, old_max_ptes_none, old_pages_to_scan;
+	long old_pages_collapsed = 0, old_max_ptes_none = 0,
+		old_pages_to_scan = 0;
 	long pages_collapsed = 0, max_ptes_none = 0, pages_to_scan = 0;
 
 	/*
@@ -703,6 +707,7 @@ void test_transparent_hugepage(int nr_children, int nr_thps,
 		tst_resm(TCONF, "Not enough memory for testing");
 
 	hugepagesize = read_meminfo("Hugepagesize:");
+	tst_resm(TINFO, "The current Hugepagesize is %luMB", hugepagesize / KB);
 
 	pids = malloc(nr_children * sizeof(int));
 	if (pids == NULL)
@@ -853,7 +858,7 @@ void write_cpuset_files(char *prefix, char *filename, char *buf)
 		} else
 			tst_brkm(TBROK | TERRNO, cleanup, "open %s", path);
 	}
-	if (write(fd, buf, strlen(buf)) != strlen(buf))
+	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
 		tst_brkm(TBROK | TERRNO, cleanup, "write %s", path);
 	close(fd);
 }
@@ -902,7 +907,7 @@ void umount_mem(char *path, char *path_new)
 	if ((fd != -1) && (fp != NULL)) {
 		while (fgets(value, BUFSIZ, fp) != NULL)
 			if (write(fd, value, strlen(value) - 1)
-			    != strlen(value) - 1)
+			    != (ssize_t)strlen(value) - 1)
 				tst_resm(TWARN | TERRNO, "write %s", s);
 	}
 	if (fd != -1)
@@ -957,7 +962,7 @@ unsigned int get_a_numa_node(void (*cleanup_fn) (void))
 	ret = get_allowed_nodes(NH_MEMS | NH_CPUS, 1, &nd1);
 	switch (ret) {
 	case 0:
-		tst_resm(TINFO, "get node%lu.", nd1);
+		tst_resm(TINFO, "get node%u.", nd1);
 		return nd1;
 	case -3:
 		tst_brkm(TCONF, cleanup_fn, "requires a NUMA system that has "
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

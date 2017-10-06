From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Oct 2017 03:53:36 +0200
Subject: [LTP] [RFC PATCH 6/6] m4,
	kernel/lib: Detect libnuma presence in kernel libs
In-Reply-To: <20171006015336.29972-1-pvorel@suse.cz>
References: <20171006015336.29972-1-pvorel@suse.cz>
Message-ID: <20171006015336.29972-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes link problems when NUMA headers are available
but libnuma don't (e.g. on 32-bit cross build).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-numa.m4                                          |  6 +++++-
 .../cpuset/cpuset_syscall_test/cpuset_syscall_test.c    |  4 ++--
 testcases/kernel/hotplug/memory_hotplug/commands.c      |  2 +-
 testcases/kernel/hotplug/memory_hotplug/memtoy.c        |  9 ++++-----
 testcases/kernel/hotplug/memory_hotplug/segment.c       |  2 +-
 testcases/kernel/include/numa_helper.h                  |  2 +-
 testcases/kernel/lib/numa_helper.c                      | 14 +++++++-------
 testcases/kernel/mem/cpuset/cpuset01.c                  |  4 ++--
 testcases/kernel/mem/ksm/ksm02.c                        |  4 ++--
 testcases/kernel/mem/ksm/ksm04.c                        |  4 ++--
 testcases/kernel/mem/lib/mem.c                          |  6 +++---
 testcases/kernel/mem/vma/vma02.c                        | 17 ++++++-----------
 testcases/kernel/mem/vma/vma04.c                        | 16 +++++-----------
 .../kernel/syscalls/get_mempolicy/get_mempolicy01.c     |  4 ++--
 testcases/kernel/syscalls/mbind/mbind01.c               |  4 ++--
 .../kernel/syscalls/migrate_pages/migrate_pages02.c     |  2 +-
 .../kernel/syscalls/move_pages/move_pages_support.c     |  8 ++++----
 17 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index 30650cd00..efa30886a 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -23,7 +23,11 @@ dnl LTP_CHECK_SYSCALL_NUMA
 dnl ----------------------------
 dnl
 AC_DEFUN([LTP_CHECK_SYSCALL_NUMA],
-[dnl
+[
+AC_CHECK_LIB(numa,numa_available,[have_libnuma="yes"])
+if test "x$have_libnuma" = "xyes"; then
+	AC_DEFINE(HAVE_LIBNUMA,1,[define whether libnuma is installed])
+fi
 AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
 	LTP_SYSCALL_NUMA_HEADERS=yes
 	AC_CHECK_LIB(numa,numa_alloc_onnode,[have_numa_alloc_onnode="yes"])
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 371cbc751..36867ab0e 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -51,7 +51,7 @@
 char *TCID = "cpuset_syscall_test";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
 #include "../cpuset_lib/cpuset.h"
@@ -243,6 +243,6 @@ int main(int argc, char *argv[])
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't have required mempolicy support");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2");
 }
 #endif
diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index a9c618d82..bd23697a6 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -29,7 +29,7 @@
  */
 
 #include "config.h"
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
 #include <linux/mempolicy.h>
 #include <sys/types.h>
 #include <sys/time.h>
diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
index 1a96d914a..aa5cfdeb5 100644
--- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
+++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
@@ -24,8 +24,7 @@
 
 #include <stdio.h>
 #include "config.h"
-/* Shortcut because the test requires numa and mempolicy support. */
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
@@ -491,10 +490,10 @@ int main(int argc, char *argv[])
 	return 0;
 
 }
-#else /* ! (HAVE_NUMA_H && HAVE_NUMAIF_H) */
+#else /* HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H */
 int main(void)
 {
-	printf("System doesn't have required numa support.\n");
+	printf("test requires libnuma >= 2\n");
 	return 0;
 }
-#endif /* HAVE_NUMA_H && HAVE_NUMAIF_H */
+#endif
diff --git a/testcases/kernel/hotplug/memory_hotplug/segment.c b/testcases/kernel/hotplug/memory_hotplug/segment.c
index 62ccd81f9..1cb06a67f 100644
--- a/testcases/kernel/hotplug/memory_hotplug/segment.c
+++ b/testcases/kernel/hotplug/memory_hotplug/segment.c
@@ -28,7 +28,7 @@
  */
 
 #include "config.h"
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
 #include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
index b9d55f04d..39cf7aa23 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -36,4 +36,4 @@ int get_allowed_nodes(int flag, int count, ...);
 void nh_dump_nodes(void);
 int is_numa(void (*cleanup_fn)(void), int flag, int min_nodes);
 
-#endif
+#endif /* NUMA_HELPER_H */
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index dd080ee4e..d98cf3fa2 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -39,7 +39,7 @@
 unsigned long get_max_node(void)
 {
 	unsigned long max_node = 0;
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	max_node = NUMA_NUM_NODES;
 	/*
@@ -52,11 +52,11 @@ unsigned long get_max_node(void)
 #else
 	max_node = numa_max_possible_node() + 1;
 #endif
-#endif /* HAVE_NUMA_H */
+#endif /* HAVE_LIBNUMA && HAVE_NUMA_H */
 	return max_node;
 }
 
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H
 static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
 {
 	unsigned long nodemask_size = max_node / 8;
@@ -145,7 +145,7 @@ static void filter_nodemask_cpu(nodemask_t * nodemask, unsigned long max_node)
 	}
 	free(cpumask);
 }
-#endif /* HAVE_NUMA_H */
+#endif /* HAVE_LIBNUMA && HAVE_NUMA_H */
 
 /*
  * get_allowed_nodes_arr - get number and array of available nodes
@@ -163,7 +163,7 @@ static void filter_nodemask_cpu(nodemask_t * nodemask, unsigned long max_node)
 int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 {
 	int ret = 0;
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H
 	int i;
 	nodemask_t *nodemask = NULL;
 #endif
@@ -171,7 +171,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 	if (nodes)
 		*nodes = NULL;
 
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H
 	unsigned long max_node, nodemask_size;
 
 	if (numa_available() == -1)
@@ -209,7 +209,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 		}
 	} while (0);
 	free(nodemask);
-#endif
+#endif /* HAVE_LIBNUMA && HAVE_NUMA_H */
 	return ret;
 }
 
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 3d68cc07a..6fe5cdec9 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -30,7 +30,7 @@
 #include "mem.h"
 #include "numa_helper.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 volatile int end;
 static int *nodes;
@@ -187,5 +187,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 6fe75d380..b13d1e9c4 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -59,7 +59,7 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+#if HAVE_LIBNUMA &&  HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
 static void verify_ksm(void)
@@ -122,5 +122,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma and NUMA development packages");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 1c8bf20c2..027dfb2fe 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -59,7 +59,7 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
 static void verify_ksm(void)
@@ -126,5 +126,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma and NUMA development packages");
 #endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index dd82b08d2..5b431ebe9 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -164,7 +164,7 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 
 static void set_global_mempolicy(int mempolicy)
 {
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	int num_nodes, *nodes;
@@ -562,7 +562,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	unsigned long length;
 	unsigned long pagesize;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 #endif
@@ -588,7 +588,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 			tst_brk(TBROK|TERRNO, "madvise");
 #endif
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 		clean_node(nmask);
 		set_node(nmask, nodes[i]);
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index ae35b2a07..5e767d393 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -49,9 +49,9 @@
 char *TCID = "vma02";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
+	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+
 static unsigned long pagesize;
 static int opt_node;
 static char *opt_nodestr;
@@ -163,15 +163,10 @@ void usage(void)
 {
 	printf("  -n      Number of NUMA nodes\n");
 }
-#else /* libnuma v1 */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
-}
-#endif
-#else /* no NUMA */
+
+#else /* libnuma >= 2 */
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2");
 }
 #endif
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index 5e2cc91b7..36549e132 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -53,9 +53,9 @@
 char *TCID = "vma04";
 int TST_TOTAL = 5;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
+	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+
 static unsigned long pagesize;
 static int opt_node;
 static char *opt_nodestr;
@@ -325,15 +325,9 @@ static void usage(void)
 	printf("  -n      Number of NUMA nodes\n");
 }
 
-#else /* libnuma v1 */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
-}
-#endif
-#else /* no NUMA */
+#else /* libnuma >= 2 */
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2");
 }
 #endif
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index cca50288f..f3d76d29d 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -66,7 +66,7 @@
 char *TCID = "get_mempolicy01";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS
 
 #define MEM_LENGTH	(4 * 1024 * 1024)
 
@@ -348,6 +348,6 @@ static void setup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't have required numa support");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2");
 }
 #endif
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index be5470691..d498c0efe 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -26,7 +26,7 @@
 #include "numa_helper.h"
 #include "tst_test.h"
 
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
 	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 #define MEM_LENGTH (4 * 1024 * 1024)
@@ -234,5 +234,5 @@ static struct tst_test test = {
 };
 
 #else /* libnuma >= 2 */
-TST_TEST_TCONF("test requires libnuma >= 2.");
+TST_TEST_TCONF("test requires libnuma >= 2");
 #endif
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 6755a384d..e3e08d83c 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -65,7 +65,7 @@
 char *TCID = "migrate_pages02";
 int TST_TOTAL = 1;
 
-#if defined(__NR_migrate_pages) && HAVE_NUMA_H && HAVE_NUMAIF_H
+#if defined(__NR_migrate_pages) && HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H
 static const char nobody_uid[] = "nobody";
 static struct passwd *ltpuser;
 static int *nodes, nodeA, nodeB;
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index a488c88f0..4ab07c3c5 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -36,7 +36,7 @@ long get_page_size(void)
 void free_pages(void **pages, unsigned int num)
 {
 
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H
 	int i;
 	size_t onepage = get_page_size();
 
@@ -168,7 +168,7 @@ int alloc_pages_on_node(void **pages, unsigned int num, int node)
 void
 verify_pages_on_nodes(void **pages, int *status, unsigned int num, int *nodes)
 {
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H
 	unsigned int i;
 	int which_node;
 	int ret;
@@ -269,7 +269,7 @@ void verify_pages_on_node(void **pages, int *status, unsigned int num, int node)
  */
 int alloc_shared_pages_on_node(void **pages, unsigned int num, int node)
 {
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H
 	char *shared;
 	unsigned int i;
 	int nodes[num];
@@ -392,7 +392,7 @@ void free_sem(sem_t * sem, int num)
  */
 void check_config(unsigned int min_nodes)
 {
-#if HAVE_NUMA_H && HAVE_NUMAIF_H
+#if HAVE_LIBNUMA && HAVE_NUMA_H && HAVE_NUMAIF_H
 	int num_allowed_nodes;
 	int ret;
 
-- 
2.14.2


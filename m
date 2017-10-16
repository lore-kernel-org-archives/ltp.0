From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:42:03 +0200
Subject: [LTP] [PATCH v4 12/14] numa: Check for API >= v2 with autoconf
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-13-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

instead of more verbose check in C code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-numa.m4                                               | 12 ++++++++++--
 .../cpuset/cpuset_syscall_test/cpuset_syscall_test.c         |  3 +--
 testcases/kernel/hotplug/memory_hotplug/commands.c           |  2 +-
 testcases/kernel/hotplug/memory_hotplug/memtoy.c             |  3 ++-
 testcases/kernel/hotplug/memory_hotplug/segment.c            |  3 ++-
 testcases/kernel/lib/numa_helper.c                           | 12 ++++++------
 testcases/kernel/mem/cpuset/cpuset01.c                       |  3 ++-
 testcases/kernel/mem/ksm/ksm02.c                             |  3 +--
 testcases/kernel/mem/ksm/ksm04.c                             |  3 +--
 testcases/kernel/mem/ksm/ksm06.c                             |  3 +--
 testcases/kernel/mem/lib/mem.c                               |  6 +++---
 testcases/kernel/mem/oom/oom02.c                             |  2 +-
 testcases/kernel/mem/oom/oom03.c                             |  2 +-
 testcases/kernel/mem/oom/oom04.c                             |  2 +-
 testcases/kernel/mem/oom/oom05.c                             |  2 +-
 testcases/kernel/mem/vma/vma02.c                             |  2 +-
 testcases/kernel/mem/vma/vma04.c                             |  2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c    |  2 +-
 testcases/kernel/syscalls/mbind/mbind01.c                    |  2 +-
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c    |  3 +--
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c    |  3 +--
 testcases/kernel/syscalls/move_pages/move_pages_support.c    | 12 ++++++------
 22 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index f21e38858..547fa58a5 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -27,9 +27,17 @@ AC_DEFUN([LTP_CHECK_SYSCALL_NUMA], [
 	AC_CHECK_LIB(numa, numa_available, [have_libnuma=yes])
 	AC_CHECK_HEADERS([numa.h numaif.h], [], [have_numa_headers=no])
 
-	if test "x$have_libnuma" = "xyes" -a "x$have_numa_headers" != "xno"; then
+	AC_RUN_IFELSE([AC_LANG_PROGRAM([
+#include <numa.h>
+		], [
+#if LIBNUMA_API_VERSION < 2
+exit(1);
+#endif
+		])], [have_numa_headers_v2=yes])
+
+	if test "x$have_libnuma" = "xyes" -a "x$have_numa_headers" != "xno" -a "x$have_numa_headers_v2" = "xyes"; then
 		AC_SUBST(NUMA_LIBS, "-lnuma")
-		AC_DEFINE(HAVE_LIBNUMA, 1, [Define to 1 if you have libnuma and it's headers installed.])
+		AC_DEFINE(HAVE_NUMA_V2, 1, [Define to 1 if you have libnuma and it's headers version >= 2 installed.])
 
 		AC_CHECK_LIB(numa, numa_alloc_onnode, [
 			AC_DEFINE(HAVE_NUMA_ALLOC_ONNODE, 1, [Define to 1 if you have `numa_alloc_onnode' function.])
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 6a6c7a803..9e568a970 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -51,8 +51,7 @@
 char *TCID = "cpuset_syscall_test";
 int TST_TOTAL = 1;
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
-	&& defined(HAVE_LINUX_MEMPOLICY_H)
+#ifdef defined(HAVE_NUMA_V2) && defined(HAVE_LINUX_MEMPOLICY_H)
 
 #include "../cpuset_lib/cpuset.h"
 #include "../cpuset_lib/bitmask.h"
diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 54a79224d..886ee82f7 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -33,7 +33,7 @@
 #include <numa.h>
 #endif
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
index 40d08ef63..fe76fb9d8 100644
--- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
+++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
@@ -30,7 +30,8 @@
 #include <numa.h>
 #endif
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
+
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/hotplug/memory_hotplug/segment.c b/testcases/kernel/hotplug/memory_hotplug/segment.c
index a087eb2e1..73c718ce7 100644
--- a/testcases/kernel/hotplug/memory_hotplug/segment.c
+++ b/testcases/kernel/hotplug/memory_hotplug/segment.c
@@ -32,7 +32,8 @@
 #include <numa.h>
 #endif
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
+
 #include <sys/types.h>
 #include <sys/ipc.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 095285bb2..2eee8d35d 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -39,13 +39,13 @@
 unsigned long get_max_node(void)
 {
 	unsigned long max_node = 0;
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	max_node = numa_max_possible_node() + 1;
 #endif
 	return max_node;
 }
 
-#ifdef HAVE_LIBNUMA
+#ifdef HAVE_NUMA_V2
 static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
 {
 	unsigned long nodemask_size = max_node / 8;
@@ -134,7 +134,7 @@ static void filter_nodemask_cpu(nodemask_t * nodemask, unsigned long max_node)
 	}
 	free(cpumask);
 }
-#endif /* HAVE_LIBNUMA */
+#endif /* HAVE_NUMA_V2 */
 
 /*
  * get_allowed_nodes_arr - get number and array of available nodes
@@ -152,7 +152,7 @@ static void filter_nodemask_cpu(nodemask_t * nodemask, unsigned long max_node)
 int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 {
 	int ret = 0;
-#ifdef HAVE_LIBNUMA
+#ifdef HAVE_NUMA_V2
 	int i;
 	nodemask_t *nodemask = NULL;
 #endif
@@ -160,7 +160,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 	if (nodes)
 		*nodes = NULL;
 
-#ifdef HAVE_LIBNUMA
+#ifdef HAVE_NUMA_V2
 	unsigned long max_node, nodemask_size;
 
 	if (numa_available() == -1)
@@ -198,7 +198,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 		}
 	} while (0);
 	free(nodemask);
-#endif /* HAVE_LIBNUMA */
+#endif /* HAVE_NUMA_V2 */
 	return ret;
 }
 
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 4efb01f23..354b6fc32 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -33,7 +33,8 @@
 #include "mem.h"
 #include "numa_helper.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
+
 volatile int end;
 static int *nodes;
 static int nnodes;
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 801412fd7..e8ac8aa15 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -62,8 +62,7 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
-	&& HAVE_LINUX_MEMPOLICY_H
+#if defined(HAVE_NUMA_V2) && defined(HAVE_LINUX_MEMPOLICY_H)
 
 static void verify_ksm(void)
 {
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index bdce8b9fb..1070bfba1 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -62,8 +62,7 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
-	&& HAVE_LINUX_MEMPOLICY_H
+#if defined(HAVE_NUMA_V2) && defined(HAVE_LINUX_MEMPOLICY_H)
 
 static void verify_ksm(void)
 {
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 4763460cf..e0fa0270e 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -42,8 +42,7 @@
 #include "mem.h"
 #include "numa_helper.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
-	&& HAVE_LINUX_MEMPOLICY_H
+#if defined(HAVE_NUMA_V2) && defined(HAVE_LINUX_MEMPOLICY_H)
 
 static int run = -1;
 static int sleep_millisecs = -1;
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index c046c77c5..fc2f130f4 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -162,7 +162,7 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 	}
 }
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 static void set_global_mempolicy(int mempolicy)
 {
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
@@ -563,7 +563,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	unsigned long length;
 	unsigned long pagesize;
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 #endif
 
@@ -588,7 +588,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 			tst_brk(TBROK|TERRNO, "madvise");
 #endif
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 		clean_node(nmask);
 		set_node(nmask, nodes[i]);
 		/*
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 6bc08213f..45e64d370 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -33,7 +33,7 @@
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 static void verify_oom(void)
 {
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 29159d629..c4b90c190 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -33,7 +33,7 @@
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 static void verify_oom(void)
 {
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 39fedd2a8..7dbf9ce70 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -33,7 +33,7 @@
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 static void verify_oom(void)
 {
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 7095974c5..eb2453156 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -33,7 +33,7 @@
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 static void verify_oom(void)
 {
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index 99642e39e..33d000d01 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -49,7 +49,7 @@
 char *TCID = "vma02";
 int TST_TOTAL = 1;
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 static unsigned long pagesize;
 static int opt_node;
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index 030a92691..a5918bcb7 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -53,7 +53,7 @@
 char *TCID = "vma04";
 int TST_TOTAL = 5;
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 static unsigned long pagesize;
 static int opt_node;
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 90c4f9662..a1b9e4327 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -67,7 +67,7 @@
 char *TCID = "get_mempolicy01";
 int TST_TOTAL = 1;
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 #define MEM_LENGTH	(4 * 1024 * 1024)
 
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 291cf3e95..4eb7da698 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -30,7 +30,7 @@
 #include "numa_helper.h"
 #include "tst_test.h"
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 
 #define MEM_LENGTH (4 * 1024 * 1024)
 
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 6add4fa67..01409f300 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -55,8 +55,7 @@ option_t options[] = {
 	{NULL, NULL, NULL}
 };
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
-	&& defined(__NR_migrate_pages)
+#if defined(HAVE_NUMA_V2) && defined(__NR_migrate_pages)
 
 static unsigned long *sane_old_nodes;
 static unsigned long *sane_new_nodes;
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 480fbd20c..faf96b6b7 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -66,8 +66,7 @@
 char *TCID = "migrate_pages02";
 int TST_TOTAL = 1;
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
-	&& defined(__NR_migrate_pages)
+#if defined(HAVE_NUMA_V2) && defined(__NR_migrate_pages)
 
 static const char nobody_uid[] = "nobody";
 static struct passwd *ltpuser;
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 3fce8b77f..340a715fc 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -36,7 +36,7 @@ long get_page_size(void)
  */
 void free_pages(void **pages, unsigned int num)
 {
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	int i;
 	size_t onepage = get_page_size();
 
@@ -111,7 +111,7 @@ int alloc_pages_linear(void **pages, unsigned int num)
 {
 	int nodes[num];
 
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	unsigned int n = 0;
 	int num_allowed_nodes;
@@ -168,7 +168,7 @@ int alloc_pages_on_node(void **pages, unsigned int num, int node)
 void
 verify_pages_on_nodes(void **pages, int *status, unsigned int num, int *nodes)
 {
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	int which_node;
 	int ret;
@@ -214,7 +214,7 @@ verify_pages_on_nodes(void **pages, int *status, unsigned int num, int *nodes)
  */
 void verify_pages_linear(void **pages, int *status, unsigned int num)
 {
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	unsigned int i;
 	unsigned int n = 0;
 	int nodes[num];
@@ -269,7 +269,7 @@ void verify_pages_on_node(void **pages, int *status, unsigned int num, int node)
  */
 int alloc_shared_pages_on_node(void **pages, unsigned int num, int node)
 {
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	char *shared;
 	unsigned int i;
 	int nodes[num];
@@ -392,7 +392,7 @@ void free_sem(sem_t * sem, int num)
  */
 void check_config(unsigned int min_nodes)
 {
-#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#ifdef HAVE_NUMA_V2
 	int num_allowed_nodes;
 	int ret;
 
-- 
2.14.2


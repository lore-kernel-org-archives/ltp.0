From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:35 +0200
Subject: [LTP] [PATCH v3 18/18] m4,
	kernel/lib: Detect libnuma presence in kernel libs
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-19-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes link problems when NUMA headers are available
but libnuma not (e.g. on 32-bit cross build).

Dropped HAVE_MPOL_CONSTANTS definition as with dropping NUMA API v1 are
these constans allways available.

TODO:
* HAVE_LIBNUMA && HAVE_NUMA_H into one in m4
* remove HAVE_MPOL_CONSTANTS

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-numa.m4                                     | 40 +++++++++++-----------
 .../controllers/cpuset/cpuset_lib/libcpuset.c      |  1 +
 .../cpuset_syscall_test/cpuset_syscall_test.c      |  5 ++-
 testcases/kernel/hotplug/memory_hotplug/commands.c |  6 +++-
 testcases/kernel/hotplug/memory_hotplug/memtoy.c   | 13 ++++---
 testcases/kernel/hotplug/memory_hotplug/segment.c  |  6 +++-
 testcases/kernel/include/numa_helper.h             |  2 +-
 testcases/kernel/lib/numa_helper.c                 | 14 ++++----
 testcases/kernel/mem/cpuset/cpuset01.c             |  8 +++--
 testcases/kernel/mem/ksm/ksm02.c                   |  9 +++--
 testcases/kernel/mem/ksm/ksm04.c                   |  9 +++--
 testcases/kernel/mem/ksm/ksm06.c                   | 12 ++++---
 testcases/kernel/mem/lib/mem.c                     | 13 ++++---
 testcases/kernel/mem/oom/oom02.c                   |  9 +++--
 testcases/kernel/mem/oom/oom03.c                   | 10 ++++--
 testcases/kernel/mem/oom/oom04.c                   |  9 +++--
 testcases/kernel/mem/oom/oom05.c                   |  9 +++--
 testcases/kernel/mem/vma/vma02.c                   |  5 ++-
 testcases/kernel/mem/vma/vma04.c                   |  5 ++-
 .../syscalls/get_mempolicy/get_mempolicy01.c       |  7 ++--
 testcases/kernel/syscalls/mbind/mbind01.c          |  9 +++--
 .../syscalls/migrate_pages/migrate_pages01.c       |  8 +++--
 .../syscalls/migrate_pages/migrate_pages02.c       |  9 +++--
 .../syscalls/move_pages/move_pages_support.c       | 14 ++++----
 24 files changed, 137 insertions(+), 95 deletions(-)

diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index b9e9069b6..750c807b0 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -23,23 +23,23 @@ dnl LTP_CHECK_SYSCALL_NUMA
 dnl ----------------------------
 dnl
 AC_DEFUN([LTP_CHECK_SYSCALL_NUMA], [
-AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
-	LTP_SYSCALL_NUMA_HEADERS=yes
-	AC_CHECK_LIB(numa,numa_alloc_onnode,[have_numa_alloc_onnode="yes"])
-	if  test "x$have_numa_alloc_onnode" = "xyes"; then
-		AC_DEFINE(HAVE_NUMA_ALLOC_ONNODE,1,[define to 1 if you have 'numa_alloc_onnode' function])
-	fi
-	AC_CHECK_LIB(numa,numa_move_pages,[have_numa_move_pages="yes"])
-	if  test "x$have_numa_move_pages" = "xyes"; then
-		AC_DEFINE(HAVE_NUMA_MOVE_PAGES,1,[define to 1 if you have 'numa_move_pages' function])
-	fi
-]
-	AC_CHECK_LIB(numa,numa_available,[NUMA_LIBS="-lnuma"])
-dnl For testcases/kernel/controllers/cpuset, testcases/kernel/syscalls/get_mempolicy,
-dnl testcases/kernel/syscalls/mbind
-AC_CHECK_DECLS([MPOL_BIND, MPOL_DEFAULT, MPOL_F_ADDR, MPOL_F_MEMS_ALLOWED, MPOL_F_NODE, MPOL_INTERLEAVE, MPOL_PREFERRED],[have_mpol_constants="yes"],,[#include <numaif.h>])
-AC_SUBST(NUMA_LIBS)
-if test "x$have_mpol_constants" = "xyes"; then
-	AC_DEFINE(HAVE_MPOL_CONSTANTS,1,[define to 1 if you have all constants required to use mbind tests])
-fi
-)])
+	AC_CHECK_LIB(numa, numa_available, [
+		AC_SUBST(NUMA_LIBS, "-lnuma")
+		AC_CHECK_HEADERS([numa.h numaif.h], [
+			AC_DEFINE(HAVE_LIBNUMA, 1, [Define to 1 if you have libnuma and it's headers installed])
+		])
+		AC_CHECK_HEADERS([numa.h numaif.h linux/mempolicy.h], [
+			AC_CHECK_LIB(numa, numa_alloc_onnode, [
+				AC_DEFINE(HAVE_NUMA_ALLOC_ONNODE, 1, [Define to 1 if you have 'numa_alloc_onnode' function])
+			])
+
+			AC_CHECK_LIB(numa, numa_move_pages, [
+				AC_DEFINE(HAVE_NUMA_MOVE_PAGES, 1, [Define to 1 if you have 'numa_move_pages' function])
+			])
+		])
+	])
+
+	AC_CHECK_DECLS([MPOL_BIND, MPOL_DEFAULT, MPOL_F_ADDR, MPOL_F_MEMS_ALLOWED, MPOL_F_NODE, MPOL_INTERLEAVE, MPOL_PREFERRED], [
+		AC_DEFINE(HAVE_MPOL_CONSTANTS, 1, [Define to 1 if you have all constants required to use mbind tests])
+		], , [#include <numaif.h>])
+])
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
index b38289679..9b67e37c9 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c
@@ -50,6 +50,7 @@
 #include "test.h"
 #include "lapi/syscalls.h"
 #include "config.h"
+
 #if HAVE_LINUX_MEMPOLICY_H
 #include <linux/mempolicy.h>
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index c3ed1a502..0a13dd49f 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -51,8 +51,7 @@
 char *TCID = "cpuset_syscall_test";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS \
-	&& defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 #include "../cpuset_lib/cpuset.h"
 #include "../cpuset_lib/bitmask.h"
@@ -243,6 +242,6 @@ int main(int argc, char *argv[])
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't have required mempolicy support");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
 }
 #endif
diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 2264346c7..54a79224d 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -29,7 +29,11 @@
  */
 
 #include "config.h"
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
index 296788e30..40d08ef63 100644
--- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
+++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
@@ -23,11 +23,14 @@
  */
 
 #include <stdio.h>
+
 #include "config.h"
 #include "tst_res_flags.h"
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
 
-/* Shortcut because the test requires numa and mempolicy support. */
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/mman.h>
@@ -493,10 +496,10 @@ int main(int argc, char *argv[])
 	return 0;
 
 }
-#else /* ! (HAVE_NUMA_H && HAVE_NUMAIF_H) */
+#else
 int main(void)
 {
-	printf("System doesn't have required numa support.\n");
+	fprintf(stderr, "test requires libnuma >= 2 and it's development packages\n");
 	return TCONF;
 }
-#endif /* HAVE_NUMA_H && HAVE_NUMAIF_H */
+#endif
diff --git a/testcases/kernel/hotplug/memory_hotplug/segment.c b/testcases/kernel/hotplug/memory_hotplug/segment.c
index 62ccd81f9..a087eb2e1 100644
--- a/testcases/kernel/hotplug/memory_hotplug/segment.c
+++ b/testcases/kernel/hotplug/memory_hotplug/segment.c
@@ -28,7 +28,11 @@
  */
 
 #include "config.h"
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
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
index 8dc9d23a8..2717bf59d 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -39,13 +39,13 @@
 unsigned long get_max_node(void)
 {
 	unsigned long max_node = 0;
-#if HAVE_NUMA_H && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	max_node = numa_max_possible_node() + 1;
 #endif
 	return max_node;
 }
 
-#if HAVE_NUMA_H
+#ifdef HAVE_LIBNUMA
 static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
 {
 	unsigned long nodemask_size = max_node / 8;
@@ -63,7 +63,7 @@ static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
 
 static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 {
-#if MPOL_F_MEMS_ALLOWED
+#ifdef MPOL_F_MEMS_ALLOWED
 	unsigned long nodemask_size = max_node / 8;
 	memset(nodemask, 0, nodemask_size);
 	/*
@@ -134,7 +134,7 @@ static void filter_nodemask_cpu(nodemask_t * nodemask, unsigned long max_node)
 	}
 	free(cpumask);
 }
-#endif /* HAVE_NUMA_H */
+#endif /* HAVE_LIBNUMA */
 
 /*
  * get_allowed_nodes_arr - get number and array of available nodes
@@ -152,7 +152,7 @@ static void filter_nodemask_cpu(nodemask_t * nodemask, unsigned long max_node)
 int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 {
 	int ret = 0;
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA
 	int i;
 	nodemask_t *nodemask = NULL;
 #endif
@@ -160,7 +160,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 	if (nodes)
 		*nodes = NULL;
 
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA
 	unsigned long max_node, nodemask_size;
 
 	if (numa_available() == -1)
@@ -198,7 +198,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 		}
 	} while (0);
 	free(nodemask);
-#endif /* HAVE_NUMA_H */
+#endif /* HAVE_LIBNUMA */
 	return ret;
 }
 
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 3d68cc07a..d82188437 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -23,6 +23,9 @@
 #include "config.h"
 #include <stdio.h>
 #include <sys/wait.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
 #if HAVE_NUMAIF_H
 #include <numaif.h>
 #endif
@@ -30,8 +33,7 @@
 #include "mem.h"
 #include "numa_helper.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 volatile int end;
 static int *nodes;
 static int nnodes;
@@ -187,5 +189,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 6fe75d380..9b39f50d4 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -50,6 +50,9 @@
 #include <sys/stat.h>
 #include <errno.h>
 #include <fcntl.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
 #if HAVE_NUMAIF_H
 #include <numaif.h>
 #endif
@@ -59,8 +62,8 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
+	&& HAVE_LINUX_MEMPOLICY_H
 
 static void verify_ksm(void)
 {
@@ -122,5 +125,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 1c8bf20c2..5a3e32da7 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -50,6 +50,9 @@
 #include <sys/stat.h>
 #include <errno.h>
 #include <fcntl.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
 #if HAVE_NUMAIF_H
 #include <numaif.h>
 #endif
@@ -59,8 +62,8 @@
 #include "mem.h"
 #include "ksm_common.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
+	&& HAVE_LINUX_MEMPOLICY_H
 
 static void verify_ksm(void)
 {
@@ -126,5 +129,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 334a04834..eccbc994f 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -28,6 +28,9 @@
 #include <limits.h>
 #include <errno.h>
 #include <fcntl.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
 #if HAVE_NUMAIF_H
 #include <numaif.h>
 #endif
@@ -35,11 +38,12 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <limits.h>
-#include "numa_helper.h"
+
 #include "mem.h"
+#include "numa_helper.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
+	&& HAVE_LINUX_MEMPOLICY_H
 
 static int run = -1;
 static int sleep_millisecs = -1;
@@ -106,5 +110,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index dd82b08d2..c046c77c5 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -162,10 +162,9 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 	}
 }
 
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 static void set_global_mempolicy(int mempolicy)
 {
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 	int num_nodes, *nodes;
 	int ret;
@@ -203,8 +202,10 @@ static void set_global_mempolicy(int mempolicy)
 		if (set_mempolicy(mempolicy, nmask, MAXNODES) == -1)
 			tst_brk(TBROK|TERRNO, "set_mempolicy");
 	}
-#endif
 }
+#else
+static void set_global_mempolicy(int mempolicy LTP_ATTRIBUTE_UNUSED) { }
+#endif
 
 void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
 {
@@ -562,8 +563,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	unsigned long length;
 	unsigned long pagesize;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 #endif
 
@@ -588,8 +588,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 			tst_brk(TBROK|TERRNO, "madvise");
 #endif
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 		clean_node(nmask);
 		set_node(nmask, nodes[i]);
 		/*
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 3434a34ba..13ff50273 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -26,11 +26,14 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 static void verify_oom(void)
 {
@@ -72,5 +75,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index f883bc054..29159d629 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -20,16 +20,20 @@
  * the GNU General Public License for more details.
  */
 
+#include "config.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 static void verify_oom(void)
 {
@@ -85,5 +89,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index e4e70e26f..6b8275c7b 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -26,11 +26,14 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 static void verify_oom(void)
 {
@@ -94,5 +97,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index bdf5d1923..34a865d2b 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -26,11 +26,14 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+
 #include "numa_helper.h"
 #include "mem.h"
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 static void verify_oom(void)
 {
@@ -120,5 +123,5 @@ static struct tst_test test = {
 };
 
 #else /* no NUMA */
-	TST_TEST_TCONF("no NUMA development packages installed.");
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index 1492e1385..4a677addc 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -49,8 +49,7 @@
 char *TCID = "vma02";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
-	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 static unsigned long pagesize;
 static int opt_node;
@@ -167,6 +166,6 @@ void usage(void)
 #else /* no NUMA */
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
 }
 #endif
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index 905fbd3ad..16eecc33f 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -53,8 +53,7 @@
 char *TCID = "vma04";
 int TST_TOTAL = 5;
 
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
-	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 static unsigned long pagesize;
 static int opt_node;
@@ -328,6 +327,6 @@ static void usage(void)
 #else /* no NUMA */
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
 }
 #endif
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index daa5f5dcc..90c4f9662 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -57,6 +57,7 @@
 #if HAVE_NUMAIF_H
 #include <numaif.h>
 #endif
+
 #include "test.h"
 #include "lapi/syscalls.h"
 #include "include_j_h.h"
@@ -66,8 +67,7 @@
 char *TCID = "get_mempolicy01";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
-	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 #define MEM_LENGTH	(4 * 1024 * 1024)
 
@@ -311,9 +311,10 @@ static void setup(void)
 	TEST_PAUSE;
 	tst_tmpdir();
 }
+
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't have required numa support");
+	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
 }
 #endif
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index be5470691..82302a817 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -22,12 +22,15 @@
  */
 
 #include <errno.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
 
+#include "config.h"
 #include "numa_helper.h"
 #include "tst_test.h"
 
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
-	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 #define MEM_LENGTH (4 * 1024 * 1024)
 
@@ -234,5 +237,5 @@ static struct tst_test test = {
 };
 
 #else /* libnuma >= 2 */
-TST_TEST_TCONF("test requires libnuma >= 2.");
+TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
 #endif
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 32c78b29a..64d0215af 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -55,7 +55,9 @@ option_t options[] = {
 	{NULL, NULL, NULL}
 };
 
-#if defined(__NR_migrate_pages) && HAVE_NUMA_H && HAVE_NUMAIF_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
+	&& defined(__NR_migrate_pages)
+
 static unsigned long *sane_old_nodes;
 static unsigned long *sane_new_nodes;
 static int sane_nodemask_size;
@@ -252,7 +254,7 @@ static void cleanup(void)
 #else /* __NR_migrate_pages */
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages"
-		 " or libnuma is not available");
+	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages or "
+		 "libnuma or libnuma development packages are not available");
 }
 #endif
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 6755a384d..55b121eb0 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -45,6 +45,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <pwd.h>
+
 #include "config.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -65,7 +66,9 @@
 char *TCID = "migrate_pages02";
 int TST_TOTAL = 1;
 
-#if defined(__NR_migrate_pages) && HAVE_NUMA_H && HAVE_NUMAIF_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2 \
+	&& defined(__NR_migrate_pages)
+
 static const char nobody_uid[] = "nobody";
 static struct passwd *ltpuser;
 static int *nodes, nodeA, nodeB;
@@ -400,7 +403,7 @@ static void cleanup(void)
 #else /* __NR_migrate_pages */
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages"
-		 " or libnuma is not available");
+	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages or "
+		 "libnuma or libnuma development packages are not available");
 }
 #endif
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index a488c88f0..3fce8b77f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -16,6 +16,7 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include "config.h"
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <unistd.h>
@@ -35,8 +36,7 @@ long get_page_size(void)
  */
 void free_pages(void **pages, unsigned int num)
 {
-
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	int i;
 	size_t onepage = get_page_size();
 
@@ -111,7 +111,7 @@ int alloc_pages_linear(void **pages, unsigned int num)
 {
 	int nodes[num];
 
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	unsigned int i;
 	unsigned int n = 0;
 	int num_allowed_nodes;
@@ -168,7 +168,7 @@ int alloc_pages_on_node(void **pages, unsigned int num, int node)
 void
 verify_pages_on_nodes(void **pages, int *status, unsigned int num, int *nodes)
 {
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	unsigned int i;
 	int which_node;
 	int ret;
@@ -214,7 +214,7 @@ verify_pages_on_nodes(void **pages, int *status, unsigned int num, int *nodes)
  */
 void verify_pages_linear(void **pages, int *status, unsigned int num)
 {
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	unsigned int i;
 	unsigned int n = 0;
 	int nodes[num];
@@ -269,7 +269,7 @@ void verify_pages_on_node(void **pages, int *status, unsigned int num, int node)
  */
 int alloc_shared_pages_on_node(void **pages, unsigned int num, int node)
 {
-#if HAVE_NUMA_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	char *shared;
 	unsigned int i;
 	int nodes[num];
@@ -392,7 +392,7 @@ void free_sem(sem_t * sem, int num)
  */
 void check_config(unsigned int min_nodes)
 {
-#if HAVE_NUMA_H && HAVE_NUMAIF_H
+#if HAVE_LIBNUMA && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	int num_allowed_nodes;
 	int ret;
 
-- 
2.14.2


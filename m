From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 13:10:58 +0200
Subject: [LTP] [PATCH v5 04/12] numa: Drop NUMA API v1 support
In-Reply-To: <20171018111106.17215-1-pvorel@suse.cz>
References: <20171018111106.17215-1-pvorel@suse.cz>
Message-ID: <20171018111106.17215-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NOTE: there still some code using v1 API
(thus flag -DNUMA_VERSION1_COMPATIBILITY is needed)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../cpuset_syscall_test/cpuset_syscall_test.c      |  4 +--
 testcases/kernel/hotplug/memory_hotplug/commands.c | 12 +------
 testcases/kernel/lib/numa_helper.c                 | 15 ++-------
 testcases/kernel/mem/vma/vma02.c                   | 13 +++-----
 testcases/kernel/mem/vma/vma04.c                   | 12 ++-----
 .../syscalls/get_mempolicy/get_mempolicy01.c       | 38 ++--------------------
 6 files changed, 14 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 371cbc751..c3ed1a502 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -51,8 +51,8 @@
 char *TCID = "cpuset_syscall_test";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS \
+	&& defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 #include "../cpuset_lib/cpuset.h"
 #include "../cpuset_lib/bitmask.h"
diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index a9c618d82..7f271c341 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -29,7 +29,7 @@
  */
 
 #include "config.h"
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H
 #include <linux/mempolicy.h>
 #include <sys/types.h>
 #include <sys/time.h>
@@ -59,7 +59,6 @@
 #define MPOL_MF_WAIT    (1<<2)	/* Wait for existing pages to migrate */
 #endif
 
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
 static inline int nodemask_isset(nodemask_t * mask, int node)
 {
 	if ((unsigned)node >= NUMA_NUM_NODES)
@@ -75,7 +74,6 @@ static inline void nodemask_set(nodemask_t * mask, int node)
 	mask->n[node / (8 * sizeof(unsigned long))] |=
 	    (1UL << (node % (8 * sizeof(unsigned long))));
 }
-#endif
 
 static char *whitespace = " \t";
 
@@ -385,11 +383,7 @@ static int get_arg_nodeid_list(char *args, unsigned int *list)
 	int node, count = 0;
 
 	gcp = &glctx;
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
 	my_allowed_nodes = numa_get_membind_compat();
-#else
-	my_allowed_nodes = numa_get_membind();
-#endif
 	while (*args != '\0') {
 		if (!isdigit(*args)) {
 			fprintf(stderr, "%s:  expected digit for <node/list>\n",
@@ -447,11 +441,7 @@ static int get_current_nodeid_list(unsigned int *fromids)
 	int node;
 
 	gcp = &glctx;
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
 	my_allowed_nodes = numa_get_membind_compat();
-#else
-	my_allowed_nodes = numa_get_membind();
-#endif
 	for (node = 0; node <= max_node; ++node) {
 		if (nodemask_isset(&my_allowed_nodes, node))
 			*(fromids + nr_nodes++) = node;
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index dd080ee4e..8dc9d23a8 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -39,20 +39,9 @@
 unsigned long get_max_node(void)
 {
 	unsigned long max_node = 0;
-#if HAVE_NUMA_H
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	max_node = NUMA_NUM_NODES;
-	/*
-	 * NUMA_NUM_NODES is not reliable, libnuma >=2 is looking
-	 * at /proc/self/status to figure out correct number.
-	 * If buffer is not large enough get_mempolicy will fail with EINVAL.
-	 */
-	if (max_node < 1024)
-		max_node = 1024;
-#else
+#if HAVE_NUMA_H && defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 	max_node = numa_max_possible_node() + 1;
 #endif
-#endif /* HAVE_NUMA_H */
 	return max_node;
 }
 
@@ -209,7 +198,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
 		}
 	} while (0);
 	free(nodemask);
-#endif
+#endif /* HAVE_NUMA_H */
 	return ret;
 }
 
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index ae35b2a07..1492e1385 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -49,9 +49,9 @@
 char *TCID = "vma02";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
+	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+
 static unsigned long pagesize;
 static int opt_node;
 static char *opt_nodestr;
@@ -163,12 +163,7 @@ void usage(void)
 {
 	printf("  -n      Number of NUMA nodes\n");
 }
-#else /* libnuma v1 */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
-}
-#endif
+
 #else /* no NUMA */
 int main(void)
 {
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index 5e2cc91b7..905fbd3ad 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -53,9 +53,9 @@
 char *TCID = "vma04";
 int TST_TOTAL = 5;
 
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
+	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
+
 static unsigned long pagesize;
 static int opt_node;
 static char *opt_nodestr;
@@ -325,12 +325,6 @@ static void usage(void)
 	printf("  -n      Number of NUMA nodes\n");
 }
 
-#else /* libnuma v1 */
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
-}
-#endif
 #else /* no NUMA */
 int main(void)
 {
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index cca50288f..daa5f5dcc 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -66,7 +66,8 @@
 char *TCID = "get_mempolicy01";
 int TST_TOTAL = 1;
 
-#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS
+#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
+	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 
 #define MEM_LENGTH	(4 * 1024 * 1024)
 
@@ -221,13 +222,8 @@ static int do_test(struct test_case *tc)
 {
 	int ret, err, result, cmp_ok;
 	int policy, flags;
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	nodemask_t *nodemask, *getnodemask;
-	unsigned long maxnode = NUMA_NUM_NODES;
-#else
 	struct bitmask *nodemask = numa_allocate_nodemask();
 	struct bitmask *getnodemask = numa_allocate_nodemask();
-#endif
 	char *p = NULL;
 	unsigned long len = MEM_LENGTH;
 	int test_node = -1;
@@ -235,15 +231,7 @@ static int do_test(struct test_case *tc)
 	ret = get_allowed_nodes(NH_MEMS, 1, &test_node);
 	if (ret < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "get_allowed_nodes: %d", ret);
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	nodemask = malloc(sizeof(nodemask_t));
-	nodemask_zero(nodemask);
-	nodemask_set(nodemask, test_node);
-	getnodemask = malloc(sizeof(nodemask_t));
-	nodemask_zero(getnodemask);
-#else
 	numa_bitmask_setbit(nodemask, test_node);
-#endif
 	switch (tc->ttype) {
 	case DEFAULT:
 		flags = 0;
@@ -252,13 +240,8 @@ static int do_test(struct test_case *tc)
 			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
 				NULL, 0));
 		else
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
-				nodemask, maxnode));
-#else
 			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
 				nodemask->maskp, nodemask->size));
-#endif
 		if (TEST_RETURN < 0) {
 			tst_resm(TBROK | TERRNO, "set_mempolicy");
 			return -1;
@@ -275,13 +258,8 @@ static int do_test(struct test_case *tc)
 			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
 				NULL, 0, 0));
 		else
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
-				nodemask, maxnode, 0));
-#else
 			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
 				nodemask->maskp, nodemask->size, 0));
-#endif
 		if (TEST_RETURN < 0) {
 			tst_resm(TBROK | TERRNO, "mbind");
 			return -1;
@@ -299,30 +277,18 @@ static int do_test(struct test_case *tc)
 	}
 	errno = 0;
 	cmp_ok = 1;
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	TEST(ret = ltp_syscall(__NR_get_mempolicy, &policy, getnodemask,
-			   maxnode, p, flags));
-#else
 	TEST(ret = ltp_syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
 			   getnodemask->size, p, flags));
-#endif
 	err = TEST_ERRNO;
 	if (ret < 0)
 		goto TEST_END;
 
 	/* if policy == MPOL_DEFAULT, get_mempolicy doesn't return nodemask */
 	if (tc->policy == MPOL_DEFAULT)
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-		nodemask_zero(nodemask);
-	cmp_ok = (tc->policy == policy && (tc->from_node == NONE ||
-					   nodemask_equal(nodemask,
-							  getnodemask)));
-#else
 		numa_bitmask_clearall(nodemask);
 	cmp_ok = (tc->policy == policy && (tc->from_node == NONE ||
 					   numa_bitmask_equal(nodemask,
 							      getnodemask)));
-#endif
 TEST_END:
 	result = (err != tc->err) || !cmp_ok;
 	PRINT_RESULT_CMP(0, tc->ret, tc->err, ret, err, cmp_ok);
-- 
2.14.2


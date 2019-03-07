From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  7 Mar 2019 13:46:20 +0100
Subject: [LTP] [COMMITTED] PATCH 2/2] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <20190307124620.2465-1-chrubis@suse.cz>
References: <20190307124620.2465-1-chrubis@suse.cz>
Message-ID: <20190307124620.2465-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is initial attempt to replace numa.sh tests that despite having
been fixed several times have still many shortcommings that wouldn't
easy to fix. It's not finished nor 100% replacement at this point but it
should be pretty good start.

The main selling points of these testcases are:

The memory allocated for the testing is tracked exactly. We are using
get_mempolicy() with MPOL_F_NODE | MPOL_F_ADDR that returns the node ID on
which specified address is allocated on to count pages allocated per node after
we set desired memory policy.

We also check for free memory on each numa memory mode and skip nodes
that don't have sufficient amount of memory for a particular test. The
tests checks usuall for twice as much memory per each node in order to
allow for allocations to be "misplaced".

The tests for file based shared interleaved mappings are no longer
mapping a single small file but rather than that we accumulate statistic
for larger amount of files over longer period of time and we also allow
for small offset (currently 10%). We should probably also increase the
number of samples we take as currently it's about 5MB in total on x86
although I haven't managed to make this test fail so far. This also
fixes the test on Btrfs where the synthetic test that expects the pages
to be distributed exactly equally fails.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Michal Hocko <mhocko@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/numa                                  |   5 +
 .../kernel/syscalls/set_mempolicy/.gitignore  |   4 +
 .../kernel/syscalls/set_mempolicy/Makefile    |   7 +
 .../syscalls/set_mempolicy/set_mempolicy.h    |  21 +++
 .../syscalls/set_mempolicy/set_mempolicy01.c  | 120 +++++++++++++++
 .../syscalls/set_mempolicy/set_mempolicy02.c  | 119 +++++++++++++++
 .../syscalls/set_mempolicy/set_mempolicy03.c  | 113 ++++++++++++++
 .../syscalls/set_mempolicy/set_mempolicy04.c  | 142 ++++++++++++++++++
 8 files changed, 531 insertions(+)
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/.gitignore
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/Makefile
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c

diff --git a/runtest/numa b/runtest/numa
index 12aedbb4b..7885be90c 100644
--- a/runtest/numa
+++ b/runtest/numa
@@ -11,3 +11,8 @@ move_pages09 move_pages09
 move_pages10 move_pages10
 move_pages11 move_pages11
 move_pages12 move_pages12
+
+set_mempolicy01 set_mempolicy01
+set_mempolicy02 set_mempolicy02
+set_mempolicy03 set_mempolicy03
+set_mempolicy04 set_mempolicy04
diff --git a/testcases/kernel/syscalls/set_mempolicy/.gitignore b/testcases/kernel/syscalls/set_mempolicy/.gitignore
new file mode 100644
index 000000000..52ae73b52
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/.gitignore
@@ -0,0 +1,4 @@
+/set_mempolicy01
+/set_mempolicy02
+/set_mempolicy03
+/set_mempolicy04
diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
new file mode 100644
index 000000000..d273b432b
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
@@ -0,0 +1,7 @@
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS  += $(NUMA_LIBS)
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h
new file mode 100644
index 000000000..da6419e18
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h
@@ -0,0 +1,21 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef SET_MEMPOLICY_H__
+#define SET_MEMPOLICY_H__
+
+static inline void alloc_fault_count(struct tst_nodemap *nodes,
+                                     const char *file, size_t size)
+{
+	void *ptr;
+
+	ptr = tst_numa_map(file, size);
+	tst_numa_fault(ptr, size);
+	tst_nodemap_count_pages(nodes, ptr, size);
+	tst_numa_unmap(ptr, size);
+}
+
+#endif /* SET_MEMPOLICY_H__ */
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
new file mode 100644
index 000000000..d3c17bb9b
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -0,0 +1,120 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED.
+ *
+ * For each node with memory we set its bit in nodemask with set_mempolicy()
+ * and verify that memory has been allocated accordingly.
+ */
+
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_H
+# include <numa.h>
+# include <numaif.h>
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#ifdef HAVE_NUMA_H
+
+#include "set_mempolicy.h"
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+#define PAGES_ALLOCATED 16u
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void verify_mempolicy(unsigned int node, int mode)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int i;
+
+	numa_bitmask_setbit(bm, node);
+
+	TEST(set_mempolicy(mode, bm->maskp, bm->size+1));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+		        "set_mempolicy(%s) node %u",
+		        tst_numa_mode_name(mode), node);
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(%s) node %u",
+	        tst_numa_mode_name(mode), node);
+
+	numa_free_nodemask(bm);
+
+	const char *prefix = "child: ";
+
+	if (SAFE_FORK()) {
+		prefix = "parent: ";
+		tst_reap_children();
+	}
+
+	tst_nodemap_reset_counters(nodes);
+	alloc_fault_count(nodes, NULL, PAGES_ALLOCATED * page_size);
+	tst_nodemap_print_counters(nodes);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->map[i] == node) {
+			if (nodes->counters[i] == PAGES_ALLOCATED) {
+				tst_res(TPASS, "%sNode %u allocated %u",
+				        prefix, node, PAGES_ALLOCATED);
+			} else {
+				tst_res(TFAIL, "%sNode %u allocated %u, expected %u",
+				        prefix, node, nodes->counters[i],
+				        PAGES_ALLOCATED);
+			}
+			continue;
+		}
+
+		if (nodes->counters[i]) {
+			tst_res(TFAIL, "%sNode %u allocated %u, expected 0",
+			        prefix, i, nodes->counters[i]);
+		}
+	}
+}
+
+static void verify_set_mempolicy(unsigned int n)
+{
+	unsigned int i;
+	int mode = n ? MPOL_PREFERRED : MPOL_BIND;
+
+	for (i = 0; i < nodes->cnt; i++)
+		verify_mempolicy(nodes->map[i], mode);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_set_mempolicy,
+	.tcnt = 2,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_H */
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
new file mode 100644
index 000000000..e257c1c2c
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
@@ -0,0 +1,119 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_INTERLEAVE.
+ *
+ * The test tries different subsets of memory nodes, sets the mask with
+ * memopolicy, and checks that the memory was interleaved between the nodes
+ * accordingly.
+ */
+
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_H
+# include <numa.h>
+# include <numaif.h>
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#ifdef HAVE_NUMA_H
+
+#include "set_mempolicy.h"
+
+#define ALLOC_ON_NODE 8
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * ALLOC_ON_NODE * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void alloc_and_check(size_t size, unsigned int *exp_alloc)
+{
+	unsigned int i;
+	const char *prefix = "child: ";
+
+	if (SAFE_FORK()) {
+		prefix = "parent: ";
+		tst_reap_children();
+	}
+
+	tst_nodemap_reset_counters(nodes);
+	alloc_fault_count(nodes, NULL, size * page_size);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->counters[i] == exp_alloc[i]) {
+			tst_res(TPASS, "%sNode %u allocated %u",
+			        prefix, nodes->map[i], exp_alloc[i]);
+		} else {
+			tst_res(TFAIL, "%sNode %u allocated %u, expected %u",
+			        prefix, nodes->map[i], nodes->counters[i],
+			        exp_alloc[i]);
+		}
+	}
+}
+
+static void verify_set_mempolicy(unsigned int n)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int exp_alloc[nodes->cnt];
+	unsigned int alloc_per_node = n ? ALLOC_ON_NODE : 2;
+	unsigned int alloc_on_nodes = n ? 2 : nodes->cnt;
+	unsigned int alloc_total = alloc_per_node * alloc_on_nodes;
+	unsigned int i;
+
+	memset(exp_alloc, 0, sizeof(exp_alloc));
+
+	for (i = 0; i < alloc_on_nodes; i++) {
+		exp_alloc[i] = alloc_per_node;
+		numa_bitmask_setbit(bm, nodes->map[i]);
+	}
+
+	TEST(set_mempolicy(MPOL_INTERLEAVE, bm->maskp, bm->size+1));
+
+	tst_res(TINFO, "Allocating on nodes 1-%u - %u pages",
+	        alloc_on_nodes, alloc_total);
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+		        "set_mempolicy(MPOL_INTERLEAVE)");
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(MPOL_INTERLEAVE)");
+
+	numa_free_nodemask(bm);
+
+	alloc_and_check(alloc_total, exp_alloc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_set_mempolicy,
+	.tcnt = 2,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_H */
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
new file mode 100644
index 000000000..eb3e046f2
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -0,0 +1,113 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED backed by a
+ * file on each supported filesystem.
+ */
+
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_H
+# include <numaif.h>
+# include <numa.h>
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#define MNTPOINT "mntpoint"
+#define PAGES_ALLOCATED 16u
+
+#ifdef HAVE_NUMA_H
+
+#include "set_mempolicy.h"
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void verify_mempolicy(unsigned int node, int mode)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int i;
+
+	numa_bitmask_setbit(bm, node);
+
+	TEST(set_mempolicy(mode, bm->maskp, bm->size+1));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+		        "set_mempolicy(%s) node %u",
+		        tst_numa_mode_name(mode), node);
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(%s) node %u",
+	        tst_numa_mode_name(mode), node);
+
+	numa_free_nodemask(bm);
+
+	tst_nodemap_reset_counters(nodes);
+	alloc_fault_count(nodes, MNTPOINT "/numa-test-file", PAGES_ALLOCATED * page_size);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->map[i] == node) {
+			if (nodes->counters[i] == PAGES_ALLOCATED) {
+				tst_res(TPASS, "Node %u allocated %u",
+				        node, PAGES_ALLOCATED);
+			} else {
+				tst_res(TFAIL, "Node %u allocated %u, expected %u",
+				        node, nodes->counters[i], PAGES_ALLOCATED);
+			}
+			continue;
+		}
+
+		if (nodes->counters[i]) {
+			tst_res(TFAIL, "Node %u allocated %u, expected 0",
+			        node, nodes->counters[i]);
+		}
+	}
+}
+
+static void verify_set_mempolicy(unsigned int n)
+{
+	unsigned int i;
+	int mode = n ? MPOL_PREFERRED : MPOL_BIND;
+
+	for (i = 0; i < nodes->cnt; i++)
+		verify_mempolicy(nodes->map[i], mode);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_set_mempolicy,
+	.tcnt = 2,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_H */
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
new file mode 100644
index 000000000..60601e7c1
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -0,0 +1,142 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_INTERLEAVE on mmaped buffers backed
+ * by files.
+ *
+ * Apparently it takes a larger sample for the allocations to be correctly
+ * interleaved. The reason for this is that buffers for file metadata are
+ * allocated in batches in order not to loose performance. Also the pages
+ * cannot be interleaved completely evenly unless the number of pages is
+ * divideable by the number of nodes, which will not happen even if we tried
+ * hard since we do not have controll over metadata blocks for instance. Hence
+ * we cannot really expect to allocate a single file and have the memory
+ * interleaved precisely but it works well if we allocate statistic for a more
+ * than a few files.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_H
+# include <numa.h>
+# include <numaif.h>
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#define MNTPOINT "mntpoint"
+#define FILES 10
+
+#ifdef HAVE_NUMA_H
+
+#include "set_mempolicy.h"
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, 20 * FILES * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void alloc_and_check(void)
+{
+	unsigned int i, j;
+	char path[1024];
+	unsigned int total_pages = 0;
+	unsigned int sum_pages = 0;
+
+	tst_nodemap_reset_counters(nodes);
+
+	/*
+	 * The inner loop loops node->cnt times to ensure the sum could
+	 * be evenly distributed among the nodes.
+	 */
+	for (i = 1; i <= FILES; i++) {
+		for (j = 1; j <= nodes->cnt; j++) {
+			size_t size = 10 * i + j % 10;
+			snprintf(path, sizeof(path), MNTPOINT "/numa-test-file-%i-%i", i, j);
+			alloc_fault_count(nodes, path, size * page_size);
+			total_pages += size;
+		}
+	}
+
+	for (i = 0; i < nodes->cnt; i++) {
+		float treshold = 1.00 * total_pages / 60; /* five percents */
+		float min_pages = 1.00 * total_pages / 3 - treshold;
+		float max_pages = 1.00 * total_pages / 3 + treshold;
+
+		if (nodes->counters[i] > min_pages && nodes->counters[i] < max_pages) {
+			tst_res(TPASS, "Node %u allocated %u <%.2f,%.2f>",
+			        nodes->map[i], nodes->counters[i], min_pages, max_pages);
+		} else {
+			tst_res(TFAIL, "Node %u allocated %u, expected <%.2f,%.2f>",
+			        nodes->map[i], nodes->counters[i], min_pages, max_pages);
+		}
+
+		sum_pages += nodes->counters[i];
+	}
+
+	if (sum_pages != total_pages) {
+		tst_res(TFAIL, "Sum of nodes %u != allocated pages %u",
+		        sum_pages, total_pages);
+		return;
+	}
+
+	tst_res(TPASS, "Sum of nodes equals to allocated pages (%u)", total_pages);
+}
+
+static void verify_set_mempolicy(void)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int alloc_on_nodes = nodes->cnt;
+	unsigned int i;
+
+	for (i = 0; i < alloc_on_nodes; i++)
+		numa_bitmask_setbit(bm, nodes->map[i]);
+
+	TEST(set_mempolicy(MPOL_INTERLEAVE, bm->maskp, bm->size+1));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+		        "set_mempolicy(MPOL_INTERLEAVE)");
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(MPOL_INTERLEAVE)");
+
+	alloc_and_check();
+
+	numa_free_nodemask(bm);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_set_mempolicy,
+	.forks_child = 1,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.needs_checkpoints = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_H */
-- 
2.19.2


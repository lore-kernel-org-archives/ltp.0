From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Aug 2018 15:54:57 +0200
Subject: [LTP] [PATCH v2] syscalls: Add set_mempolicy numa tests.
Message-ID: <20180823135457.15806-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is initial attempt to replace numa.sh tests that despite having
been fixed several times have still many shortcommings that wouldn't be
easy to fix. It's not finished nor 100% replacement but I'm sending this
anyway because I would like to get feedback at this point.

The main selling points of these testcases are:

The memory allocated for the testing is tracked exactly. We are using
get_mempolicy() with MPOL_F_NODE | MPOL_F_ADDR that returns the node ID on
which specified address is allocated on to count pages allocated per node after
we set desired memory policy.

The tests for file based shared interleaved mappings are no longer
mapping a single small file but rather than that we accumulate statistic
for larger amount of files over longer period of time and we also allow
for small offset (currently 10%). We should probably also increase the
number of samples we take as currently it's about 5MB in total on x86
although I haven't managed to make this test fail so far. This also
fixes the test on Btrfs where the synthetic test that expects the pages
to be distributed exactly equally fails.

What is not finished is compilation without libnuma, that will fail
currently, but that is only a matter of adding a few ifdefs. And the
coverage is still lacking, ideas for interesting testcases are welcomed
as well.

I tested this testcases back to SLES11, which is basically the oldest
distribution we really care for and everything was working fine.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Michal Hocko <mhocko@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---
 include/tst_numa.h                                 |  76 ++++++++++++
 lib/tst_numa.c                                     | 138 +++++++++++++++++++++
 runtest/numa                                       |   5 +
 testcases/kernel/syscalls/set_mempolicy/.gitignore |   4 +
 testcases/kernel/syscalls/set_mempolicy/Makefile   |   7 ++
 .../kernel/syscalls/set_mempolicy/set_mempolicy.h  |  26 ++++
 .../syscalls/set_mempolicy/set_mempolicy01.c       | 107 ++++++++++++++++
 .../syscalls/set_mempolicy/set_mempolicy02.c       | 101 +++++++++++++++
 .../syscalls/set_mempolicy/set_mempolicy03.c       |  99 +++++++++++++++
 .../syscalls/set_mempolicy/set_mempolicy04.c       | 112 +++++++++++++++++
 10 files changed, 675 insertions(+)
 create mode 100644 include/tst_numa.h
 create mode 100644 lib/tst_numa.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/.gitignore
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/Makefile
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c

diff --git a/include/tst_numa.h b/include/tst_numa.h
new file mode 100644
index 0000000..9551681
--- /dev/null
+++ b/include/tst_numa.h
@@ -0,0 +1,76 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_NUMA_H__
+#define TST_NUMA_H__
+
+/**
+ * Numa nodemap.
+ */
+struct tst_nodemap {
+        /** Number of nodes in map */
+	unsigned int cnt;
+	/** Page allocation counters */
+	unsigned int *counters;
+	/** Array of numa ids */
+	unsigned int map[];
+};
+
+/**
+ * Clears numa counters. The counters are lazy-allocated on first call of this function.
+ *
+ * @nodes Numa nodemap.
+ */
+void tst_nodemap_reset_counters(struct tst_nodemap *nodes);
+
+/**
+ * Prints pages allocated per each node.
+ *
+ * @nodes Numa nodemap.
+ */
+void tst_nodemap_print_counters(struct tst_nodemap *nodes);
+
+/**
+ * Allocates the requested number of pages, using mmap(), faults them and adds
+ * the amount of pages allocated per node to the nodemap counters. We also make
+ * sure that only the newly allocated pages are accounted for correctly. The
+ * nodemap has to have counters initialized which happens on first counter
+ * reset.
+ *
+ * @nodes Nodemap with initialized counters.
+ * @path  If non-NULL the mapping is backed up by a file.
+ * @pages Number of pages to be allocated.
+ */
+void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
+                          unsigned int pages);
+
+/**
+ * Frees nodemap.
+ *
+ * @nodes Numa nodemap to be freed.
+ */
+void tst_nodemap_free(struct tst_nodemap *nodes);
+
+/**
+ * Bitflags for tst_get_nodemap() function.
+ */
+enum tst_numa_types {
+	TST_NUMA_ANY = 0x00,
+	TST_NUMA_MEM = 0x01,
+};
+
+/**
+ * Allocates and returns numa node map, which is an array of numa nodes which
+ * contain desired resources e.g. memory.
+ *
+ * @types Bitflags of enum tst_numa_types specifying desired resources.
+ *
+ * @return On success returns allocated and initialized struct tst_nodemap which contains
+ *         array of numa node ids that contains desired resources.
+ */
+struct tst_nodemap *tst_get_nodemap(int type);
+
+#endif /* TST_NUMA_H__ */
diff --git a/lib/tst_numa.c b/lib/tst_numa.c
new file mode 100644
index 0000000..fef358b
--- /dev/null
+++ b/lib/tst_numa.c
@@ -0,0 +1,138 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdio.h>
+#include <ctype.h>
+#include "config.h"
+#ifdef HAVE_NUMA_H
+# include <numa.h>
+# include <numaif.h>
+#endif
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_numa.h"
+
+static void inc_counter(unsigned int node, struct tst_nodemap *nodes)
+{
+	unsigned int i;
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->map[i] == node) {
+			nodes->counters[i]++;
+			break;
+		}
+	}
+}
+
+void tst_nodemap_print_counters(struct tst_nodemap *nodes)
+{
+	unsigned int i;
+
+	for (i = 0; i < nodes->cnt; i++) {
+		tst_res(TINFO, "Node %i allocated %u pages",
+		        nodes->map[i], nodes->counters[i]);
+	}
+}
+
+void tst_nodemap_reset_counters(struct tst_nodemap *nodes)
+{
+	size_t arr_size = sizeof(unsigned int) * nodes->cnt;
+
+	if (!nodes->counters)
+		nodes->counters = SAFE_MALLOC(arr_size);
+
+	memset(nodes->counters, 0, arr_size);
+}
+
+void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
+                          unsigned int pages)
+{
+	size_t page_size = getpagesize();
+	char *ptr;
+	int fd = -1;
+	int flags = MAP_PRIVATE|MAP_ANONYMOUS;
+	int node;
+	unsigned int i;
+
+	if (path) {
+		fd = SAFE_OPEN(path, O_CREAT | O_EXCL | O_RDWR, 0666);
+		SAFE_FTRUNCATE(fd, pages * page_size);
+		flags = MAP_SHARED;
+	}
+
+	ptr = SAFE_MMAP(NULL, pages  * page_size,
+	                PROT_READ|PROT_WRITE, flags, fd, 0);
+
+	if (path) {
+		SAFE_CLOSE(fd);
+		SAFE_UNLINK(path);
+	}
+
+	memset(ptr, 'a', pages * page_size);
+
+	for (i = 0; i < pages; i++) {
+		get_mempolicy(&node, NULL, 0, ptr + i * page_size, MPOL_F_NODE | MPOL_F_ADDR);
+		
+		if (node < 0 || (unsigned int)node >= nodes->cnt) {
+			tst_res(TWARN, "get_mempolicy(...) returned invalid node %i\n", node);
+			continue;
+		}
+
+		inc_counter(node, nodes);
+	}
+
+	SAFE_MUNMAP(ptr, pages * page_size);
+}
+
+void tst_nodemap_free(struct tst_nodemap *nodes)
+{
+	free(nodes->counters);
+	free(nodes);
+}
+
+#ifdef HAVE_NUMA_H
+
+struct tst_nodemap *tst_get_nodemap(int type)
+{
+	struct bitmask *membind;
+	struct tst_nodemap *nodes;
+	unsigned int i, cnt;
+
+	if (type & ~(TST_NUMA_MEM))
+		tst_brk(TBROK, "Invalid type %i\n", type);
+
+	membind = numa_get_membind();
+
+	cnt = 0;
+	for (i = 0; i < membind->size; i++) {
+		if (type & TST_NUMA_MEM && !numa_bitmask_isbitset(membind, i))
+			continue;
+
+		cnt++;
+	}
+
+	tst_res(TINFO, "Found %u NUMA memory nodes", cnt);
+
+	nodes = SAFE_MALLOC(sizeof(struct tst_nodemap)
+	                    + sizeof(unsigned int) * cnt);
+	nodes->cnt = cnt;
+	nodes->counters = NULL;
+
+	cnt = 0;
+	for (i = 0; i < membind->size; i++) {
+		if (type & TST_NUMA_MEM && !numa_bitmask_isbitset(membind, i))
+			continue;
+
+		nodes->map[cnt++] = i;
+	}
+
+	numa_bitmask_free(membind);
+
+	return nodes;
+}
+
+#endif
diff --git a/runtest/numa b/runtest/numa
index 12aedbb..7885be9 100644
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
index 0000000..c5e35a4
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/.gitignore
@@ -0,0 +1,4 @@
+/set_mempolicy01
+/set_mempolicy02
+set_mempolicy03
+set_mempolicy04
diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
new file mode 100644
index 0000000..d273b43
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
index 0000000..0539db0
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef SET_MEMPOLICY_H__
+#define SET_MEMPOLICY_H__
+
+static const char *mode_name(int mode)
+{
+	switch (mode) {
+	case MPOL_DEFAULT:
+		return "MPOL_DEFAULT";
+	case MPOL_BIND:
+		return "MPOL_BIND";
+	case MPOL_PREFERRED:
+		return "MPOL_PREFERRED";
+	//case MPOL_LOCAL:
+	//	return "MPOL_LOCAL";
+	default:
+		return "???";
+	}
+}
+
+#endif /* SET_MEMPOLICY_H__ */
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
new file mode 100644
index 0000000..6b7e317
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -0,0 +1,107 @@
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
+#include <numa.h>
+#include <numaif.h>
+#include "tst_test.h"
+#include "tst_numa.h"
+#include "set_mempolicy.h"
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+#define PAGES_ALLOCATED 16u
+
+void setup(void)
+{
+	nodes = tst_get_nodemap(TST_NUMA_MEM);
+
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+
+	page_size = getpagesize();
+}
+
+void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+void verify_mempolicy(unsigned int node, int mode)
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
+		        "set_mempolicy(%s) node %u", mode_name(mode), node);
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(%s) node %u", mode_name(mode), node);
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
+	tst_numa_alloc_parse(nodes, NULL, PAGES_ALLOCATED);
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
+			        prefix, node, nodes->counters[i]);
+		}
+	}
+}
+
+void verify_set_mempolicy(unsigned int n)
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
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
new file mode 100644
index 0000000..29873e3
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
@@ -0,0 +1,101 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_INTERLEAVE.
+ */
+
+#include <errno.h>
+#include <numa.h>
+#include <numaif.h>
+#include "tst_test.h"
+#include "tst_numa.h"
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+void setup(void)
+{
+	nodes = tst_get_nodemap(TST_NUMA_MEM);
+
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+
+	page_size = getpagesize();
+}
+
+void cleanup(void)
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
+	tst_numa_alloc_parse(nodes, NULL, size);
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
+void verify_set_mempolicy(unsigned int n)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int exp_alloc[nodes->cnt];
+	unsigned int alloc_per_node = n ? 8 : 2;
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
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
new file mode 100644
index 0000000..ffe62c1
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -0,0 +1,99 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED backed by a
+ * file.
+ */
+
+#include <errno.h>
+#include <numaif.h>
+#include <numa.h>
+#include "tst_test.h"
+#include "tst_numa.h"
+#include "set_mempolicy.h"
+
+#define MNTPOINT "mntpoint"
+#define PAGES_ALLOCATED 16u
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+void setup(void)
+{
+	nodes = tst_get_nodemap(TST_NUMA_MEM);
+
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+
+	page_size = getpagesize();
+}
+
+void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+void verify_mempolicy(unsigned int node, int mode)
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
+		        "set_mempolicy(%s) node %u", mode_name(mode), node);
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(%s) node %u", mode_name(mode), node);
+
+	numa_free_nodemask(bm);
+
+	tst_nodemap_reset_counters(nodes);
+	tst_numa_alloc_parse(nodes, MNTPOINT "/numa-test-file", PAGES_ALLOCATED);
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
+void verify_set_mempolicy(unsigned int n)
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
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
new file mode 100644
index 0000000..49419d5
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -0,0 +1,112 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_INTERLEAVE.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <numa.h>
+#include <numaif.h>
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#define MNTPOINT "mntpoint"
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+void setup(void)
+{
+	nodes = tst_get_nodemap(TST_NUMA_MEM);
+
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+
+	page_size = getpagesize();
+}
+
+void cleanup(void)
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
+	for (i = 1; i < 10; i++) {
+		for (j = 0; j < 3; j++) {
+			snprintf(path, sizeof(path), MNTPOINT "/numa-test-file-%i-%i", i, j);
+			tst_numa_alloc_parse(nodes, path, 10 * i + j);
+			total_pages += 10 * i + j;
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
+void verify_set_mempolicy(void)
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
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.needs_checkpoints = 1,
+};
-- 
2.12.3


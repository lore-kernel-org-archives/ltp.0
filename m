From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Aug 2018 17:23:08 +0200
Subject: [LTP] [PATCH] [RFC] [WORK-IN-PROGRESS] syscalls: Add set_mempolicy
	numa tests.
Message-ID: <20180809152308.18982-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is initial attempt to replace numa.sh tests that despite having
been fixed several times have still many shortcommings that wouldn't
easy to fix. It's not finished nor 100% replacement but I'm sending this
anyway because I would like to get feedback at this point.

The main selling points of these testcases are:

The memory allocated for the testing is tracked exactly. We make sure
that the mapping has separate record in /proc/$PID/numa_maps by mapping
a region, then unmapping hole at the start and at the end of the
mapping, then we fault the pages in the middle of the original mapping.
We carefuly avoid doing anything that would cause the mapping to expand
in the child process while the parent takes the measurements, even
opening a file with fopen() may cause buffers to be allocated which may
expand the mapping which is the reason we fork and take the measurements
in the parent after the child process has faulted the pages.

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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Michal Hocko <mhocko@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---
 include/tst_numa.h                                 |  71 +++++++
 lib/tst_numa.c                                     | 231 +++++++++++++++++++++
 runtest/numa                                       |   5 +
 testcases/kernel/syscalls/set_mempolicy/.gitignore |   4 +
 testcases/kernel/syscalls/set_mempolicy/Makefile   |   7 +
 .../kernel/syscalls/set_mempolicy/set_mempolicy.h  |  26 +++
 .../syscalls/set_mempolicy/set_mempolicy01.c       |  98 +++++++++
 .../syscalls/set_mempolicy/set_mempolicy02.c       |  91 ++++++++
 .../syscalls/set_mempolicy/set_mempolicy03.c       |  99 +++++++++
 .../syscalls/set_mempolicy/set_mempolicy04.c       | 112 ++++++++++
 10 files changed, 744 insertions(+)
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
index 000000000..08833e398
--- /dev/null
+++ b/include/tst_numa.h
@@ -0,0 +1,71 @@
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
+ * Allocates requested number of pages, using mmap(), faults them and parsers
+ * /proc/$PID/numa_maps and adds amount of pages allocated per node to the
+ * nodemap counters. We also make sure that only the newly allocated pages are
+ * accounted for correctly, which requires forking a separate process to
+ * allocate the memory and checkpoints to synchronize parent and child process.
+ * The nodemap has to have counters initialized which happens on first counter
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
index 000000000..2328c2814
--- /dev/null
+++ b/lib/tst_numa.c
@@ -0,0 +1,231 @@
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
+#endif
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_numa.h"
+
+static void store_val(unsigned int node, unsigned int val,
+                      struct tst_nodemap *nodes)
+{
+	unsigned int i;
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->map[i] == node) {
+			nodes->counters[i] += val;
+			break;
+		}
+	}
+
+//	tst_res(TINFO, "Node %u allocated %u pages", node, val);
+}
+
+static void parse_line(char *line, struct tst_nodemap *nodes)
+{
+	char *c;
+	int state = 0;
+	int node;
+	int val;
+
+	for (c = line; *c && *c != '\n'; c++) {
+
+		if (state == 0 && *c == 'N') {
+			state = 1;
+			continue;
+		}
+
+		if (state == 1) {
+			if (isdigit(*c)) {
+				node = *c - '0';
+				state = 2;
+			} else {
+				state = 0;
+			}
+			continue;
+		}
+
+		if (state == 2) {
+			if (isdigit(*c)) {
+				node *= 10;
+				node += *c - '0';
+			} else {
+				if (*c == '=') {
+					val = 0;
+					state = 3;
+				} else {
+					state = 0;
+				}
+			}
+			continue;
+		}
+
+		if (state == 3) {
+			if (isdigit(*c)) {
+				val *= 10;
+				val += *c - '0';
+			} else {
+				store_val(node, val, nodes);
+				state = 0;
+			}
+		}
+	}
+}
+
+static char *strip_newline(char *str)
+{
+	size_t i;
+
+	for (i = 0; str[i]; i++) {
+		if (str[i] == '\n') {
+			str[i] = 0;
+			break;
+		}
+	}
+
+	return str;
+}
+
+static void tst_parse_numa_maps(void *ptr, int pid, struct tst_nodemap *nodes)
+{
+	FILE *f;
+	char line[2048];
+	char fname[128];
+	void *p;
+
+	snprintf(fname, sizeof(fname), "/proc/%i/numa_maps", pid);
+
+	f = fopen(fname, "r");
+	if (!f)
+		tst_brk(TBROK | TERRNO, "open(/proc/self/numa_maps)");
+
+	while (fgets(line, sizeof(line), f)) {
+		sscanf(line, "%p", &p);
+		if (p == ptr) {
+			//tst_res(TINFO, "Parsing '%s'", strip_newline(line));
+			parse_line(line, nodes);
+			goto out;
+		}
+	}
+
+	tst_res(TWARN, "Mapping %p not found in numa_maps!", ptr);
+out:
+	fclose(f);
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
+
+	if (path) {
+		fd = SAFE_OPEN(path, O_CREAT | O_EXCL | O_RDWR, 0666);
+		SAFE_FTRUNCATE(fd, (pages+2) * page_size);
+		flags = MAP_SHARED;
+	}
+
+	ptr = SAFE_MMAP(NULL, (pages + 2) * page_size,
+	                PROT_READ|PROT_WRITE, flags, fd, 0);
+
+	if (path) {
+		SAFE_CLOSE(fd);
+		SAFE_UNLINK(path);
+	}
+
+	pid_t pid = SAFE_FORK();
+	if (pid) {
+		TST_CHECKPOINT_WAIT(0);
+		tst_parse_numa_maps(ptr + page_size, pid, nodes);
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_MUNMAP(ptr, (pages + 2) * page_size);
+		return;
+	}
+
+	/*
+	 * Force the mapping to have a separate vma and hence separate record
+	 * in numa_maps. We also have to be careful not to allocate anything
+	 * before we attempt to read the file, so we wait right after we fault
+         * these pages for parent to read the numa_maps.
+	 */
+	SAFE_MUNMAP(ptr, page_size);
+	ptr += page_size;
+	SAFE_MUNMAP(ptr + pages * page_size, page_size);
+
+	memset(ptr, 'a', pages * page_size);
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_MUNMAP(ptr, pages * page_size);
+	exit(0);
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
index 000000000..c5e35a405
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/.gitignore
@@ -0,0 +1,4 @@
+/set_mempolicy01
+/set_mempolicy02
+set_mempolicy03
+set_mempolicy04
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
index 000000000..0539db0b5
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
index 000000000..5e4d53713
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -0,0 +1,98 @@
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
+		tst_brk(TCONF, "Test requires@least two NUMA nodes");
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
+	tst_numa_alloc_parse(nodes, NULL, PAGES_ALLOCATED);
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
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
new file mode 100644
index 000000000..162ca18c5
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
@@ -0,0 +1,91 @@
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
+		tst_brk(TCONF, "Test requires@least two NUMA nodes");
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
+
+	tst_nodemap_reset_counters(nodes);
+	tst_numa_alloc_parse(nodes, NULL, size);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->counters[i] == exp_alloc[i]) {
+			tst_res(TPASS, "Node %u allocated %u",
+			        nodes->map[i], exp_alloc[i]);
+		} else {
+			tst_res(TFAIL, "Node %u allocated %u, expected %u",
+			        nodes->map[i], nodes->counters[i], exp_alloc[i]);
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
index 000000000..18d44495c
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
+		tst_brk(TCONF, "Test requires@least two NUMA nodes");
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
index 000000000..1fb28c7f8
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
+		tst_brk(TCONF, "Test requires@least two NUMA nodes");
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
2.13.6


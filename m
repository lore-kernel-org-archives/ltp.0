From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  7 Mar 2019 13:46:19 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/2] lib/tst_numa: Add library for NUMA
	related syscalls
Message-ID: <20190307124620.2465-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The library implements a nodemap, which is a map of nodes (array)
containing node ids for a subset of system nodes. Currently nodes can be
filtered based on memory requirements, which is needed for testing
memory related NUMA syscalls such as set_mempolicy() and membind() where
we usually need at least two memory nodes with free memory.

It also implements counters, so that we can precisely count, for a given
memory range, how much memory was allocated on each node in the map and
a few simple functions for mapping, faulting and unmapping memory.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Michal Hocko <mhocko@kernel.org>
CC: Jan Stancek <jstancek@redhat.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_numa.h | 112 ++++++++++++++++++++++++
 lib/tst_numa.c     | 214 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 326 insertions(+)
 create mode 100644 include/tst_numa.h
 create mode 100644 lib/tst_numa.c

diff --git a/include/tst_numa.h b/include/tst_numa.h
new file mode 100644
index 000000000..a4cd1be37
--- /dev/null
+++ b/include/tst_numa.h
@@ -0,0 +1,112 @@
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
+ * Returns a name for a mempolicy/mbind mode.
+ *
+ * @mode Numa mempolicy mode.
+ */
+const char *tst_numa_mode_name(int mode);
+
+/**
+ * Maps pages into memory, if path is NULL the mapping is anonymous otherwise is backed by the file.
+ *
+ * @path Path to a file, if not NULL mapping is file based.
+ * @size Mapping size.
+ */
+void *tst_numa_map(const char *path, size_t size);
+
+/*
+ * Writes to memory in order to get the pages faulted.
+ *
+ * @ptr Start of the mapping.
+ * @size Size of the mapping.
+ */
+static inline void tst_numa_fault(void *ptr, size_t size)
+{
+	memset(ptr, 'a', size);
+}
+
+/*
+ * Frees the memory.
+ *
+ * @ptr Start of the mapping.
+ * @size Size of the mapping.
+ */
+static inline void tst_numa_unmap(void *ptr, size_t size)
+{
+	SAFE_MUNMAP(ptr, size);
+}
+
+/**
+ * Check on which numa node resides each page of the mapping starting at ptr
+ * and continuing pages long and increases nodemap counters accordingly.
+ *
+ * @nodes Nodemap with initialized counters.
+ * @ptr   Pointer to start of a mapping.
+ * @size  Size of the mapping.
+ */
+void tst_nodemap_count_pages(struct tst_nodemap *nodes, void *ptr, size_t size);
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
+ * @type       Bitflags of enum tst_numa_types specifying desired resources.
+ * @min_mem_kb Minimal free RAM on memory nodes, if given node has less than
+ *             requested amount of free+buffers memory it's not included in
+ *             the resulting list of nodes.
+ *
+ * @return On success returns allocated and initialized struct tst_nodemap which contains
+ *         array of numa node ids that contains desired resources.
+ */
+struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
+
+#endif /* TST_NUMA_H__ */
diff --git a/lib/tst_numa.c b/lib/tst_numa.c
new file mode 100644
index 000000000..6bd23e949
--- /dev/null
+++ b/lib/tst_numa.c
@@ -0,0 +1,214 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdlib.h>
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
+void tst_nodemap_free(struct tst_nodemap *nodes)
+{
+	free(nodes->counters);
+	free(nodes);
+}
+
+#ifdef HAVE_NUMA_H
+
+const char *tst_numa_mode_name(int mode)
+{
+	switch (mode) {
+	case MPOL_DEFAULT:
+		return "MPOL_DEFAULT";
+	case MPOL_BIND:
+		return "MPOL_BIND";
+	case MPOL_PREFERRED:
+		return "MPOL_PREFERRED";
+	case MPOL_INTERLEAVE:
+		return "MPOL_INTERLEAVE";
+	default:
+		return "???";
+	}
+}
+
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
+void tst_nodemap_count_pages(struct tst_nodemap *nodes,
+                             void *ptr, size_t size)
+{
+	size_t page_size = getpagesize();
+	unsigned int i;
+	int node;
+	long ret;
+	unsigned int pages = (size + page_size - 1)/page_size;
+
+	for (i = 0; i < pages; i++) {
+		ret = get_mempolicy(&node, NULL, 0, ptr + i * page_size, MPOL_F_NODE | MPOL_F_ADDR);
+		if (ret < 0)
+			tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
+
+		if (node < 0 || (unsigned int)node >= nodes->cnt) {
+			tst_res(TWARN, "get_mempolicy(...) returned invalid node %i\n", node);
+			continue;
+		}
+
+		inc_counter(node, nodes);
+	}
+}
+
+void *tst_numa_map(const char *path, size_t size)
+{
+	char *ptr;
+	int fd = -1;
+	int flags = MAP_PRIVATE|MAP_ANONYMOUS;
+
+	if (path) {
+		fd = SAFE_OPEN(path, O_CREAT | O_EXCL | O_RDWR, 0666);
+		SAFE_FTRUNCATE(fd, size);
+		flags = MAP_SHARED;
+	}
+
+	ptr = SAFE_MMAP(NULL, size,
+	                PROT_READ|PROT_WRITE, flags, fd, 0);
+
+	if (path) {
+		SAFE_CLOSE(fd);
+		SAFE_UNLINK(path);
+	}
+
+	return ptr;
+}
+
+static int node_has_enough_memory(int node, size_t min_kb)
+{
+	char path[1024];
+	char buf[1024];
+	long mem_total = 0;
+	long mem_used = 0;
+
+	/* Make sure there is some space for kernel upkeeping as well */
+	min_kb += 4096;
+
+	snprintf(path, sizeof(path), "/sys/devices/system/node/node%i/meminfo", node);
+
+	if (access(path, F_OK)) {
+		tst_res(TINFO, "File '%s' does not exist! NUMA not enabled?", path);
+		return 0;
+	}
+
+	FILE *fp = fopen(path, "r");
+	if (!fp)
+		tst_brk(TBROK | TERRNO, "Failed to open '%s'", path);
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		long val;
+
+		if (sscanf(buf, "%*s %*i MemTotal: %li", &val) == 1)
+			mem_total = val;
+
+		if (sscanf(buf, "%*s %*i MemUsed: %li", &val) == 1)
+			mem_used = val;
+	}
+
+	fclose(fp);
+
+	if (!mem_total || !mem_used) {
+		tst_res(TWARN, "Failed to parse '%s'", path);
+		return 0;
+	}
+
+	if (mem_total - mem_used < (long)min_kb) {
+		tst_res(TINFO,
+		        "Not enough free RAM on node %i, have %likB needs %zukB",
+		        node, mem_total - mem_used, min_kb);
+		return 0;
+	}
+
+	return 1;
+}
+
+struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb)
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
+		if (type & TST_NUMA_MEM &&
+		    (!numa_bitmask_isbitset(membind, i) ||
+		     !node_has_enough_memory(i, min_mem_kb)))
+			continue;
+
+		nodes->map[cnt++] = i;
+	}
+
+	nodes->cnt = cnt;
+
+	numa_bitmask_free(membind);
+
+	return nodes;
+}
+
+#endif
-- 
2.19.2


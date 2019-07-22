From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jul 2019 17:03:16 +0200
Subject: [LTP] [PATCH v2] syscalls/mbind0{2,3,4}: Add basic mbind tests
Message-ID: <20190722150316.27395-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test is similar to the set_mempolicy() tests, but with mbind we are
actually binding memory to nodes after it was mapped.

mbind02: We are trying to get EIO with MPOL_MF_STRICT and page that was already
         faulted on wrong node. This actually fails for me on SLE12 SP4.

mbind03: We are moving pages with MPOL_MF_MOVE and MPOL_MF_MOVE_ALL and
         checking the result.

mbind04: We are applying memory policy before we fault the pages and check
         that the pages were faulted accordingly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                           |   3 +
 testcases/kernel/syscalls/mbind/.gitignore |   3 +
 testcases/kernel/syscalls/mbind/mbind.h    |  26 ++++
 testcases/kernel/syscalls/mbind/mbind02.c  | 103 ++++++++++++++++
 testcases/kernel/syscalls/mbind/mbind03.c  | 123 +++++++++++++++++++
 testcases/kernel/syscalls/mbind/mbind04.c  | 132 +++++++++++++++++++++
 6 files changed, 390 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mbind/mbind.h
 create mode 100644 testcases/kernel/syscalls/mbind/mbind02.c
 create mode 100644 testcases/kernel/syscalls/mbind/mbind03.c
 create mode 100644 testcases/kernel/syscalls/mbind/mbind04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 67dfed661..0114b002b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -628,6 +628,9 @@ lstat02_64 lstat02_64
 mallopt01 mallopt01
 
 mbind01 mbind01
+mbind02 mbind02
+mbind03 mbind03
+mbind04 mbind04
 
 memset01 memset01
 memcmp01 memcmp01
diff --git a/testcases/kernel/syscalls/mbind/.gitignore b/testcases/kernel/syscalls/mbind/.gitignore
index 64139f75c..b78d20264 100644
--- a/testcases/kernel/syscalls/mbind/.gitignore
+++ b/testcases/kernel/syscalls/mbind/.gitignore
@@ -1 +1,4 @@
 /mbind01
+/mbind02
+/mbind03
+/mbind04
diff --git a/testcases/kernel/syscalls/mbind/mbind.h b/testcases/kernel/syscalls/mbind/mbind.h
new file mode 100644
index 000000000..62e749bca
--- /dev/null
+++ b/testcases/kernel/syscalls/mbind/mbind.h
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef MBIND_H__
+#define MBIND_H__
+
+static inline const char *mbind_flag_name(unsigned flag)
+{
+	switch (flag) {
+	case 0:
+		return "0";
+	case MPOL_MF_STRICT:
+		return "MPOL_MF_STRICT";
+	case MPOL_MF_MOVE:
+		return "MPOL_MF_MOVE";
+	case MPOL_MF_MOVE_ALL:
+		return "MPOL_MF_MOVE_ALL";
+	default:
+		return "???";
+	}
+}
+
+#endif /* MBIND_H__ */
diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
new file mode 100644
index 000000000..5352c34ee
--- /dev/null
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -0,0 +1,103 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing mbind() EIO error.
+ *
+ * We first fault a allocated page, then attempt to mbind it to a different node.
+ *
+ * This is a regression test for:
+ *
+ * a7f40cfe3b7a mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified
+ *
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
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void verify_policy(int mode)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int i;
+	void *ptr;
+	unsigned long size = page_size;
+	int node = 0;
+
+	ptr = tst_numa_map(NULL, size);
+	tst_nodemap_reset_counters(nodes);
+	tst_numa_fault(ptr, size);
+	tst_nodemap_count_pages(nodes, ptr, size);
+	tst_nodemap_print_counters(nodes);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (!nodes->counters[i]) {
+			node = nodes->map[i];
+			tst_res(TINFO, "Attempting to bind to node %i", node);
+			numa_bitmask_setbit(bm, node);
+			break;
+		}
+	}
+
+	TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, MPOL_MF_STRICT));
+
+	if (TST_RET) {
+		tst_res(TPASS | TTERRNO,
+		        "mbind(%s, MPOL_MF_STRICT) node %u",
+		        tst_numa_mode_name(mode), node);
+	} else {
+		tst_res(TFAIL, "mbind(%s, MPOL_MF_STRICT) node %u succeded",
+		        tst_numa_mode_name(mode), node);
+	}
+
+	tst_numa_unmap(ptr, size);
+	numa_free_nodemask(bm);
+}
+
+static void verify_mbind(unsigned int n)
+{
+	int mode = n ? MPOL_PREFERRED : MPOL_BIND;
+
+	verify_policy(mode);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_mbind,
+	.tcnt = 2,
+	.forks_child = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_H */
diff --git a/testcases/kernel/syscalls/mbind/mbind03.c b/testcases/kernel/syscalls/mbind/mbind03.c
new file mode 100644
index 000000000..f0622b07f
--- /dev/null
+++ b/testcases/kernel/syscalls/mbind/mbind03.c
@@ -0,0 +1,123 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing mbind() MPOL_MF_MOVE and MPOL_MF_MOVE_ALL.
+ *
+ * If one of these flags is passed along with the policy kernel attempts to
+ * move already faulted pages to match the requested policy.
+ */
+
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_H
+# include <numa.h>
+# include <numaif.h>
+# include "mbind.h"
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#ifdef HAVE_NUMA_H
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires@least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void verify_policy(int mode, unsigned flag)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int i;
+	void *ptr;
+	unsigned long size = page_size;
+	unsigned int node = 0;
+
+	ptr = tst_numa_map(NULL, size);
+	tst_nodemap_reset_counters(nodes);
+	tst_numa_fault(ptr, size);
+	tst_nodemap_count_pages(nodes, ptr, size);
+	tst_nodemap_print_counters(nodes);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (!nodes->counters[i]) {
+			node = nodes->map[i];
+			tst_res(TINFO, "Attempting to move to node %i", node);
+			numa_bitmask_setbit(bm, node);
+			break;
+		}
+	}
+
+	TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, flag));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+		        "mbind(%s, %s) node %u",
+		        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
+		goto exit;
+	} else {
+		tst_res(TPASS, "mbind(%s, %s) node %u succeded",
+		        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
+	}
+
+	tst_nodemap_reset_counters(nodes);
+	tst_nodemap_count_pages(nodes, ptr, size);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->map[i] == node) {
+			if (nodes->counters[i] == 1) {
+				tst_res(TPASS, "Node %u allocated %u", node, 1);
+			} else {
+				tst_res(TFAIL, "Node %u allocated %u, expected %u",
+				        node, nodes->counters[i], 0);
+			}
+			continue;
+		}
+
+		if (nodes->counters[i]) {
+			tst_res(TFAIL, "Node %u allocated %u, expected 0",
+			        i, nodes->counters[i]);
+		}
+	}
+
+exit:
+	tst_numa_unmap(ptr, size);
+	numa_free_nodemask(bm);
+}
+
+void verify_mbind(unsigned int n)
+{
+	int mode = n ? MPOL_PREFERRED : MPOL_BIND;
+
+	verify_policy(mode, MPOL_MF_MOVE);
+	verify_policy(mode, MPOL_MF_MOVE_ALL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_mbind,
+	.tcnt = 2,
+	.forks_child = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_H */
diff --git a/testcases/kernel/syscalls/mbind/mbind04.c b/testcases/kernel/syscalls/mbind/mbind04.c
new file mode 100644
index 000000000..28fbc356b
--- /dev/null
+++ b/testcases/kernel/syscalls/mbind/mbind04.c
@@ -0,0 +1,132 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing mbind() with MPOL_BIND and MPOL_PREFERRED.
+ *
+ * For each node with memory we set its bit in nodemask with set_mempolicy()
+ * and verify that memory has been faulted accordingly.
+ */
+
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_H
+# include <numa.h>
+# include <numaif.h>
+# include "mbind.h"
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#ifdef HAVE_NUMA_H
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
+static void verify_policy(unsigned int node, int mode, unsigned flag)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int i;
+	void *ptr;
+	unsigned long size = PAGES_ALLOCATED * page_size;
+
+	numa_bitmask_setbit(bm, node);
+
+	ptr = tst_numa_map(NULL, size);
+
+	TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, flag));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+		        "mbind(%s, %s) node %u",
+		        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
+		return;
+	}
+
+	tst_res(TPASS, "mbind(%s, %s) node %u",
+	        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
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
+	tst_numa_fault(ptr, size);
+	tst_nodemap_count_pages(nodes, ptr, size);
+	tst_numa_unmap(ptr, size);
+
+	int fail = 0;
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
+				fail = 1;
+			}
+			continue;
+		}
+
+		if (nodes->counters[i]) {
+			tst_res(TFAIL, "%sNode %u allocated %u, expected 0",
+			        prefix, i, nodes->counters[i]);
+			fail = 1;
+		}
+	}
+
+	if (fail)
+		tst_nodemap_print_counters(nodes);
+}
+
+static void verify_mbind(unsigned int n)
+{
+	unsigned int i;
+	int mode = n ? MPOL_PREFERRED : MPOL_BIND;
+
+	for (i = 0; i < nodes->cnt; i++) {
+		verify_policy(nodes->map[i], mode, 0);
+		verify_policy(nodes->map[i], mode, MPOL_MF_STRICT);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_mbind,
+	.tcnt = 2,
+	.forks_child = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_H */
-- 
2.21.0


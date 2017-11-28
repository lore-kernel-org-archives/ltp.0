From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 28 Nov 2017 18:07:55 +0800
Subject: [LTP] [PATCH] syscalls/migrate_pages03.c: Add new regression test
Message-ID: <1511863675-13716-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The bug has been fixed in kernel:
'4b0ece6fa016("mm: migrate: fix remove_migration_pte() for ksm pages")'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Jie Fei <feij.fnst@cn.fujitsu.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../syscalls/migrate_pages/migrate_pages03.c       | 176 +++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 14089ac..51885d4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -587,6 +587,7 @@ memcpy01 memcpy01
 
 migrate_pages01 migrate_pages01
 migrate_pages02 migrate_pages02
+migrate_pages03 migrate_pages03
 
 mlockall01 mlockall01
 mlockall02 mlockall02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 12a136e..27e30b2 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -538,6 +538,7 @@
 /memset/memset01
 /migrate_pages/migrate_pages01
 /migrate_pages/migrate_pages02
+/migrate_pages/migrate_pages03
 /mincore/mincore01
 /mincore/mincore02
 /mkdir/mkdir01
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
new file mode 100644
index 0000000..6d0b3c6
--- /dev/null
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
+ * Author(s): Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *            Jie Fei <feij.fnst@cn.fujitsu.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Description:
+ * This is a regression test for ksm page migration which is miscalculated.
+ *
+ * The kernel bug has been fixed by:
+ *
+ * commit 4b0ece6fa0167b22c004ff69e137dc94ee2e469e
+ * Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
+ * Date:   Fri Mar 31 15:11:44 2017 -0700
+ *
+ *     mm: migrate: fix remove_migration_pte() for ksm pages
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+
+#include "config.h"
+#include "lapi/syscalls.h"
+#include "lapi/mmap.h"
+#include "tst_test.h"
+#include "numa_helper.h"
+#include "migrate_pages_common.h"
+
+#if defined(HAVE_NUMA_V2) && defined(__NR_migrate_pages)
+
+#define KSM_RUN_PATH "/sys/kernel/mm/ksm/run"
+#define N_PAGES 20
+#define N_LOOPS 100
+#define TEST_NODES 2
+
+static int orig_ksm_value;
+static int restore_ksm_run;
+static unsigned int page_size;
+static void *test_pages[N_PAGES];
+static int node1, node2;
+static int num_nodes;
+static int *nodes;
+
+static void setup(void)
+{
+	int n, ret;
+
+	if (access(KSM_RUN_PATH, F_OK)) {
+		tst_brk(TCONF, "KSM configuration was not enabled");
+	} else {
+		SAFE_FILE_SCANF(KSM_RUN_PATH, "%d", &orig_ksm_value);
+		restore_ksm_run = 1;
+		SAFE_FILE_PRINTF(KSM_RUN_PATH, "%d", 1);
+	}
+
+	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes() failed");
+
+	if (num_nodes < TEST_NODES) {
+		tst_brk(TCONF, "requires NUMA with@least %d node",
+			TEST_NODES);
+	}
+
+	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes() failed");
+
+	page_size = getpagesize();
+
+	for (n = 0; n < N_PAGES; n++) {
+		test_pages[n] = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
+					  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		memset(test_pages[n], 0, page_size);
+		errno = 0;
+		if (madvise(test_pages[n], page_size, MADV_MERGEABLE)) {
+			if (errno == EINVAL) {
+				tst_brk(TCONF, "madvise() didn't support "
+					"MADV_MERGEABLE");
+			}
+
+			tst_brk(TBROK | TERRNO,
+				"madvise(MADV_MERGEABLE) failed");
+		}
+	}
+}
+
+static void cleanup(void)
+{
+	int n;
+
+	for (n = 0; n < N_PAGES; n++) {
+		if (test_pages[n])
+			SAFE_MUNMAP(test_pages[n], page_size);
+	}
+
+	if (restore_ksm_run)
+		SAFE_FILE_PRINTF(KSM_RUN_PATH, "%d", orig_ksm_value);
+}
+
+static void migrate_test(void)
+{
+	int i, loop, max_node;
+	int ret1, ret2;
+	unsigned long *old_nodes, *new_node1, *new_node2;
+	unsigned long nodemask_size;
+
+	max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long) * 8);
+	nodemask_size = max_node / 8;
+
+	old_nodes = SAFE_MALLOC(nodemask_size);
+	new_node1 = SAFE_MALLOC(nodemask_size);
+	new_node2 = SAFE_MALLOC(nodemask_size);
+	memset(old_nodes, 0, nodemask_size);
+	memset(new_node1, 0, nodemask_size);
+	memset(new_node2, 0, nodemask_size);
+
+	for (i = 0; i < num_nodes; i++)
+		set_bit(old_nodes, nodes[i], 1);
+	set_bit(new_node1, node1, 1);
+	set_bit(new_node2, node2, 1);
+
+	for (loop = 0; loop < N_LOOPS; loop++) {
+		ret1 = tst_syscall(__NR_migrate_pages, 0, max_node,
+				   old_nodes, new_node1);
+		ret2 = tst_syscall(__NR_migrate_pages, 0, max_node,
+				   old_nodes, new_node2);
+		if (ret1 < 0 || ret2 < 0) {
+			tst_res(TFAIL | TERRNO, "migrate_pages() failed");
+			free(old_nodes);
+			free(new_node1);
+			free(new_node2);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "migrate_pages() passed");
+
+	free(old_nodes);
+	free(new_node1);
+	free(new_node2);
+}
+
+static struct tst_test test = {
+	.min_kver = "2.6.32",
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = migrate_test,
+};
+
+#else
+	TST_TEST_TCONF("System doesn't support __NR_migrate_pages or libnuma "
+		       "or libnuma development packages are not available");
+#endif
-- 
1.8.3.1




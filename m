From: xiao yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 25 Dec 2017 18:37:31 +0800
Subject: [LTP] [PATCH v2] syscalls/migrate_pages03.c: Add new regression test
In-Reply-To: <20171130152005.GH2924@rei>
References: <20171130152005.GH2924@rei>
Message-ID: <1514198251-8249-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The bug has been fixed in kernel:
'4b0ece6fa016("mm: migrate: fix remove_migration_pte() for ksm pages")'

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../syscalls/migrate_pages/migrate_pages03.c       | 175 +++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 97fc643..ee8850f 100644
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
index 0000000..697ab55
--- /dev/null
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -0,0 +1,175 @@
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
+#ifdef HAVE_NUMA_V2
+#define KSM_PATH "/sys/kernel/mm/ksm/"
+#define N_PAGES 20
+#define N_LOOPS 600
+#define TEST_NODES 2
+
+static int orig_ksm_run = -1;
+static unsigned int page_size;
+static void *test_pages[N_PAGES];
+static int num_nodes, max_node;
+static int *nodes;
+static unsigned long *new_nodes[2];
+
+/* Wait at least two full scans to guarantee merging */
+static void wait_ksmd_full_scan(void)
+{
+	unsigned long exp_scans, get_scans;
+	int count = 0;
+
+	SAFE_FILE_SCANF(KSM_PATH "full_scans", "%lu", &get_scans);
+	exp_scans = get_scans + 3;
+	while (get_scans < exp_scans) {
+		sleep(1);
+		count++;
+		SAFE_FILE_SCANF(KSM_PATH "full_scans", "%lu", &get_scans);
+	}
+
+	tst_res(TINFO, "ksmd takes %ds to run two full scans", count);
+}
+
+static void setup(void)
+{
+	int n;
+	unsigned long nodemask_size;
+
+	if (access(KSM_PATH, F_OK))
+		tst_brk(TCONF, "KSM configuration was not enabled");
+
+	if (get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes) < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes() failed");
+
+	if (num_nodes < TEST_NODES) {
+		tst_brk(TCONF, "requires NUMA with@least %d node",
+			TEST_NODES);
+	}
+
+	max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long) * 8);
+	nodemask_size = max_node / 8;
+	new_nodes[0] = SAFE_MALLOC(nodemask_size);
+	new_nodes[1] = SAFE_MALLOC(nodemask_size);
+	memset(new_nodes[0], 0, nodemask_size);
+	memset(new_nodes[1], 0, nodemask_size);
+	set_bit(new_nodes[0], nodes[0], 1);
+	set_bit(new_nodes[1], nodes[1], 1);
+
+	page_size = getpagesize();
+
+	for (n = 0; n < N_PAGES; n++) {
+		test_pages[n] = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
+					  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		if (madvise(test_pages[n], page_size, MADV_MERGEABLE)) {
+			if (errno == EINVAL) {
+				tst_brk(TCONF | TERRNO, "madvise() didn't "
+					"support MADV_MERGEABLE");
+			}
+
+			tst_brk(TBROK | TERRNO,
+				"madvise(MADV_MERGEABLE) failed");
+		}
+
+		if (mbind(test_pages[n], page_size, MPOL_BIND, new_nodes[0],
+			  max_node, 0))
+			tst_brk(TBROK | TERRNO, "mbind(MPOL_BIND) failed");
+
+		memset(test_pages[n], 0, page_size);
+	}
+
+	SAFE_FILE_SCANF(KSM_PATH "run", "%d", &orig_ksm_run);
+	SAFE_FILE_PRINTF(KSM_PATH "run", "%d", 1);
+	wait_ksmd_full_scan();
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
+	free(new_nodes[0]);
+	free(new_nodes[1]);
+
+	if (orig_ksm_run != -1)
+		SAFE_FILE_PRINTF(KSM_PATH "run", "%d", orig_ksm_run);
+}
+
+static void migrate_test(void)
+{
+	int loop, i, ret;
+
+	for (loop = 0; loop < N_LOOPS; loop++) {
+		i = loop % 2;
+		ret = tst_syscall(__NR_migrate_pages, 0, max_node,
+				   new_nodes[i], new_nodes[i ? 0 : 1]);
+		if (ret < 0) {
+			tst_res(TFAIL | TERRNO, "migrate_pages() failed");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "migrate_pages() passed");
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
+	TST_TEST_TCONF("require libnuma >= 2 and it's development packages");
+#endif
-- 
1.8.3.1




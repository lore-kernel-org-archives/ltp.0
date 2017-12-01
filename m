From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 1 Dec 2017 11:48:28 +0800
Subject: [LTP] [PATCH 2/2] syscalls/move_pages13.c: Add new regression test
In-Reply-To: <1512100108-28359-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1512100108-28359-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1512100108-28359-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The bug has been fixed in kernel:
'c9d398fa2378("mm, hugetlb: use pte_present() instead
 of pmd_present() in follow_huge_pmd()")'

It is easily for RHEL7.4GA to trigger the bug, but hardly
for upstream kernel.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Jie Fei <feij.fnst@cn.fujitsu.com>
---
 runtest/numa                                       |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/move_pages/move_pages13.c      | 158 +++++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_pages/move_pages13.c

diff --git a/runtest/numa b/runtest/numa
index dcf4948..7757874 100644
--- a/runtest/numa
+++ b/runtest/numa
@@ -11,3 +11,4 @@ move_pages09 move_pages.sh 09
 move_pages10 move_pages.sh 10
 move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 04755 move_pages11 && move_pages.sh 11
 move_pages12 move_pages12
+move_pages13 move_pages13
diff --git a/runtest/syscalls b/runtest/syscalls
index 14089ac..904333a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -665,6 +665,7 @@ move_pages09 move_pages.sh 09
 move_pages10 move_pages.sh 10
 move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 04755 move_pages11 && move_pages.sh 11
 move_pages12 move_pages12
+move_pages13 move_pages13
 
 mprotect01 mprotect01
 mprotect02 mprotect02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 12a136e..bf99657 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -606,6 +606,7 @@
 /move_pages/move_pages10
 /move_pages/move_pages11
 /move_pages/move_pages12
+/move_pages/move_pages13
 /mprotect/mprotect01
 /mprotect/mprotect02
 /mprotect/mprotect03
diff --git a/testcases/kernel/syscalls/move_pages/move_pages13.c b/testcases/kernel/syscalls/move_pages/move_pages13.c
new file mode 100644
index 0000000..2f1554b
--- /dev/null
+++ b/testcases/kernel/syscalls/move_pages/move_pages13.c
@@ -0,0 +1,158 @@
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
+ * This is a regression test for the race condition, where move_pages()
+ * and soft offline are called on a single hugetlb page concurrently.
+ *
+ * This bug can crash the buggy kernel, and was fixed by:
+ *
+ * commit c9d398fa237882ea07167e23bcfc5e6847066518
+ * Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
+ * Date:   Fri Mar 31 15:11:55 2017 -0700
+ *
+ *     mm, hugetlb: use pte_present() instead of pmd_present() in follow_huge_pmd()
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "move_pages_support.h"
+#include "move_hugepages_support.h"
+#include "lapi/mmap.h"
+
+#ifdef HAVE_NUMA_V2
+
+#define LOOPS   2000
+#define TEST_PAGES	2
+#define TEST_NODES	2
+
+static int pgsz, hpsz;
+static long orig_hugepages = -1;
+static char path_hugepages_node1[PATH_MAX];
+static char path_hugepages_node2[PATH_MAX];
+static long orig_hugepages_node1 = -1;
+static long orig_hugepages_node2 = -1;
+static unsigned int node1, node2;
+static void *addr;
+
+static void do_test(void)
+{
+	int i, status;
+	void *test_addr;
+	pid_t pid = -1;
+
+	addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+
+	SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
+
+	pid = SAFE_FORK();
+	if (pid == 0)
+		do_hugepages_move(TEST_PAGES, hpsz, pgsz, addr, node1, node2);
+
+	for (i = 0; i < LOOPS; i++) {
+		test_addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz, PROT_READ | PROT_WRITE,
+				      MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+		if (test_addr != addr)
+			tst_brk(TBROK, "Failed to mmap@desired addr");
+
+		memset(test_addr, 0, TEST_PAGES * hpsz);
+
+		if (madvise(test_addr, TEST_PAGES * hpsz, MADV_SOFT_OFFLINE)) {
+			if (errno == EINVAL) {
+				tst_brk(TCONF, "madvise() didn't support "
+					"MADV_SOFT_OFFLINE");
+			}
+		}
+
+		SAFE_MUNMAP(test_addr, TEST_PAGES * hpsz);
+	}
+
+	if (i == LOOPS) {
+		SAFE_KILL(pid, SIGKILL);
+		SAFE_WAITPID(pid, &status, 0);
+		if (!WIFEXITED(status))
+			tst_res(TPASS, "Bug not reproduced");
+	}
+}
+
+static void setup(void)
+{
+	int memfree, ret;
+
+	check_config(TEST_NODES);
+
+	if (access(PATH_HUGEPAGES, F_OK))
+		tst_brk(TCONF, "Huge page not supported");
+
+	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
+
+	pgsz = (int)get_page_size();
+	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
+
+	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %d", &memfree);
+	tst_res(TINFO, "Free RAM %d kB", memfree);
+
+	if (4 * hpsz > memfree)
+		tst_brk(TBROK, "Not enough free RAM");
+
+	orig_hugepages_node1 = modify_node_nr_hgpgs(path_hugepages_node1, sizeof(path_hugepages_node1), node1, hpsz, 4);
+	orig_hugepages_node2 = modify_node_nr_hgpgs(path_hugepages_node2, sizeof(path_hugepages_node2), node2, hpsz, 4);
+
+	hpsz *= 1024;
+
+	if (orig_hugepages_node1 == -1 || orig_hugepages_node2 == -1) {
+		SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+		tst_res(TINFO, "Increasing global hugepages pool to %ld",
+			orig_hugepages + 8);
+		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 8);
+	}
+
+	alloc_free_huge_on_node(node1, 4L * hpsz, hpsz);
+	alloc_free_huge_on_node(node2, 4L * hpsz, hpsz);
+}
+
+static void cleanup(void)
+{
+	restore_orig_hgpgs_value(PATH_NR_HUGEPAGES, orig_hugepages);
+	restore_orig_hgpgs_value(path_hugepages_node1, orig_hugepages_node1);
+	restore_orig_hgpgs_value(path_hugepages_node2, orig_hugepages_node2);
+}
+
+static struct tst_test test = {
+	.min_kver = "2.6.33",
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_test,
+};
+
+#else
+	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+#endif
-- 
1.8.3.1




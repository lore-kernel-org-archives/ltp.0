From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 8 Feb 2017 17:19:51 +0800
Subject: [LTP] [PATCH v2] syscalls/move_pages12: Add new regression test
In-Reply-To: <58881C4D.1050905@cn.fujitsu.com>
References: <58881C4D.1050905@cn.fujitsu.com>
Message-ID: <1486545591-18866-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed by:
commit e66f17ff71772b209eed39de35aaa99ba819c93d
Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date:   Wed Feb 11 15:25:22 2015 -0800

    mm/hugetlb: take page table lock in follow_huge_pmd()

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/numa                                       |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/move_pages/move_pages12.c      | 165 +++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 testcases/kernel/syscalls/move_pages/move_pages12.c

diff --git a/runtest/numa b/runtest/numa
index 87f64da..dcf4948 100644
--- a/runtest/numa
+++ b/runtest/numa
@@ -10,3 +10,4 @@ move_pages08 move_pages.sh 08
 move_pages09 move_pages.sh 09
 move_pages10 move_pages.sh 10
 move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 04755 move_pages11 && move_pages.sh 11
+move_pages12 move_pages12
diff --git a/runtest/syscalls b/runtest/syscalls
index dc03c4c..48f6492 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -645,6 +645,7 @@ move_pages08 move_pages.sh 08
 move_pages09 move_pages.sh 09
 move_pages10 move_pages.sh 10
 move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 04755 move_pages11 && move_pages.sh 11
+move_pages12 move_pages12
 
 mprotect01 mprotect01
 mprotect02 mprotect02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 91dccef..bebaa89 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -589,6 +589,7 @@
 /move_pages/move_pages09
 /move_pages/move_pages10
 /move_pages/move_pages11
+/move_pages/move_pages12
 /mprotect/mprotect01
 /mprotect/mprotect02
 /mprotect/mprotect03
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
new file mode 100644
index 0000000..f0c5a9f
--- /dev/null
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright (c) 2016 Fujitsu Ltd.
+ *  Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
+ *  Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
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
+ * This is a regression test for the race condition between move_pages()
+ * and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
+ * for hugepages internally and tries to get its refcount without
+ * preventing concurrent freeing.
+ *
+ * This test can crash the buggy kernel, and the bug was fixed in:
+ *
+ *  commit e66f17ff71772b209eed39de35aaa99ba819c93d
+ *  Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
+ *  Date:   Wed Feb 11 15:25:22 2015 -0800
+ *
+ *  mm/hugetlb: take page table lock in follow_huge_pmd()
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "move_pages_support.h"
+
+#if HAVE_NUMA_MOVE_PAGES
+
+#define LOOPS	1000
+#define PATH_MEMINFO	"/proc/meminfo"
+#define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
+#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
+#define TEST_PAGES	2
+#define TEST_NODES	2
+
+static int pgsz, hpsz;
+static long orig_hugepages;
+static unsigned int node1, node2;
+static void *addr;
+
+static void do_child(void)
+{
+	int test_pages = TEST_PAGES * hpsz / pgsz;
+	int i, j;
+	int *nodes, *status;
+	void **pages;
+	pid_t ppid = getppid();
+
+	pages = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
+	nodes = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
+	status = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
+
+	for (i = 0; i < test_pages; i++)
+		pages[i] = addr + i * pgsz;
+
+	for (i = 0; ; i++) {
+		for (j = 0; j < test_pages; j++) {
+			if (i % 2 == 0)
+				nodes[j] = node1;
+			else
+				nodes[j] = node2;
+			status[j] = 0;
+		}
+
+		TEST(numa_move_pages(ppid, test_pages,
+			pages, nodes, status, MPOL_MF_MOVE_ALL));
+		if (TEST_RETURN) {
+			tst_res(TFAIL | TTERRNO, "move_pages failed");
+			break;
+		}
+	}
+
+	exit(0);
+}
+
+static void do_test(void)
+{
+	int i;
+	pid_t cpid = -1;
+	int status;
+
+	for (i = 0; i < LOOPS; i++) {
+		addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+
+		memset(addr, 0, TEST_PAGES * hpsz);
+
+		SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
+
+		if (i == 0) {
+			cpid = SAFE_FORK();
+			if (cpid == 0)
+				do_child();
+		}
+	}
+
+	if (i == LOOPS) {
+		SAFE_KILL(cpid, SIGKILL);
+		SAFE_WAITPID(cpid, &status, 0);
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
+	pgsz = (int)get_page_size();
+	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
+	hpsz *= 1024;
+
+	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %d", &memfree);
+	memfree *= 1024;
+	if (4 * hpsz > memfree)
+		tst_brk(TBROK, "RAM not enough");
+
+	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 4);
+
+	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
+}
+
+static void cleanup(void)
+{
+	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+}
+
+static struct tst_test test = {
+	.tid = "move_pages12",
+	.min_kver = "2.6.32",
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = do_test,
+};
+
+#else
+	tst_res(TCONF, "move_pages support not found");
+#endif
-- 
1.8.4.2




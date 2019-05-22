From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 May 2019 09:43:18 +0800
Subject: [LTP] [PATCH v4] syscalls/move_pages12: Add new regression test
In-Reply-To: <20190521134752.GB19326@rei.lan>
References: <20190521134752.GB19326@rei.lan>
Message-ID: <1558489398-15257-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The bug has been fixed in kernel: 'c9d398fa2378 ("mm, hugetlb:
use pte_present() instead of pmd_present() in follow_huge_pmd()").

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/move_pages/move_pages12.c | 103 ++++++++++++------
 1 file changed, 69 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 04fda8bef..569bbfbc2 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -1,35 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2016 Fujitsu Ltd.
+ *  Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  *  Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
  *  Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ *  Ported: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *  Ported: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
  */
 
 /*
- * This is a regression test for the race condition between move_pages()
- * and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
- * for hugepages internally and tries to get its refcount without
- * preventing concurrent freeing.
+ * Description:
  *
- * This test can crash the buggy kernel, and the bug was fixed in:
+ * Test #1:
+ *  This is a regression test for the race condition between move_pages()
+ *  and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
+ *  for hugepages internally and tries to get its refcount without
+ *  preventing concurrent freeing.
  *
- *  commit e66f17ff71772b209eed39de35aaa99ba819c93d
- *  Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
- *  Date:   Wed Feb 11 15:25:22 2015 -0800
+ *  This test can crash the buggy kernel, and the bug was fixed in:
+ *
+ *   commit e66f17ff71772b209eed39de35aaa99ba819c93d
+ *   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
+ *   Date:   Wed Feb 11 15:25:22 2015 -0800
+ *
+ *   mm/hugetlb: take page table lock in follow_huge_pmd()
+ *
+ *  Test #2:
+ *   This is a regression test for the race condition, where move_pages()
+ *   and soft offline are called on a single hugetlb page concurrently.
+ *
+ *   This bug can crash the buggy kernel, and was fixed by:
  *
- *  mm/hugetlb: take page table lock in follow_huge_pmd()
+ *   commit c9d398fa237882ea07167e23bcfc5e6847066518
+ *   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
+ *   Date:   Fri Mar 31 15:11:55 2017 -0700
+ *
+ *   mm, hugetlb: use pte_present() instead of pmd_present() in
+ *   follow_huge_pmd()
  */
 
 #include <errno.h>
@@ -49,9 +55,16 @@
 #define PATH_MEMINFO	"/proc/meminfo"
 #define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
 #define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
-#define TEST_PAGES	2
 #define TEST_NODES	2
 
+static struct tcase {
+	int tpages;
+	int offline;
+} tcases[] = {
+	{2, 0},
+	{2, 1},
+};
+
 static int pgsz, hpsz;
 static long orig_hugepages = -1;
 static char path_hugepages_node1[PATH_MAX];
@@ -61,9 +74,19 @@ static long orig_hugepages_node2 = -1;
 static unsigned int node1, node2;
 static void *addr;
 
-static void do_child(void)
+static int do_soft_offline(int tpgs)
+{
+	if (madvise(addr, tpgs * hpsz, MADV_SOFT_OFFLINE) == -1) {
+		if (errno != EINVAL)
+			tst_res(TFAIL | TTERRNO, "madvise failed");
+		return errno;
+	}
+	return 0;
+}
+
+static void do_child(int tpgs)
 {
-	int test_pages = TEST_PAGES * hpsz / pgsz;
+	int test_pages = tpgs * hpsz / pgsz;
 	int i, j;
 	int *nodes, *status;
 	void **pages;
@@ -96,34 +119,45 @@ static void do_child(void)
 	exit(0);
 }
 
-static void do_test(void)
+static void do_test(unsigned int n)
 {
 	int i;
 	pid_t cpid = -1;
 	int status;
 	unsigned int twenty_percent = (tst_timeout_remaining() / 5);
 
-	addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz, PROT_READ | PROT_WRITE,
+	addr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz, PROT_READ | PROT_WRITE,
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
 
-	SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
+	SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
 
 	cpid = SAFE_FORK();
 	if (cpid == 0)
-		do_child();
+		do_child(tcases[n].tpages);
 
 	for (i = 0; i < LOOPS; i++) {
 		void *ptr;
 
-		ptr = SAFE_MMAP(NULL, TEST_PAGES * hpsz,
+		ptr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz,
 			PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
 		if (ptr != addr)
 			tst_brk(TBROK, "Failed to mmap@desired addr");
 
-		memset(addr, 0, TEST_PAGES * hpsz);
+		memset(addr, 0, tcases[n].tpages * hpsz);
+
+		if (tcases[n].offline) {
+			if (do_soft_offline(tcases[n].tpages) == EINVAL) {
+				SAFE_KILL(cpid, SIGKILL);
+				SAFE_WAITPID(cpid, &status, 0);
+				SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
+				tst_res(TCONF,
+					"madvise() didn't support MADV_SOFT_OFFLINE");
+				return;
+			}
+		}
 
-		SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
+		SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
 
 		if (tst_timeout_remaining() < twenty_percent)
 			break;
@@ -266,7 +300,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = do_test,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcases),
 };
 
 #else
-- 
2.18.1




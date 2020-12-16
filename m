From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Dec 2020 11:10:12 +0100
Subject: [LTP] [PATCH 5/5] syscalls/move_pages12: Add one more kernel git
 hash
In-Reply-To: <20201216101012.14644-1-chrubis@suse.cz>
References: <20201216101012.14644-1-chrubis@suse.cz>
Message-ID: <20201216101012.14644-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Reformat the comment to asciidoc

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/move_pages/move_pages12.c | 52 ++++++++++++-------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index c906acbe3..d209426c7 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -7,16 +7,17 @@
  *  Ported: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
  */
 
-/*
- * Description:
+/*\
+ * [DESCRIPTION]
+ *
+ * *Test 1*
  *
- * Test #1:
- *  This is a regression test for the race condition between move_pages()
- *  and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
- *  for hugepages internally and tries to get its refcount without
- *  preventing concurrent freeing.
+ * This is a regression test for the race condition between move_pages()
+ * and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
+ * for hugepages internally and tries to get its refcount without
+ * preventing concurrent freeing.
  *
- *  This test can crash the buggy kernel, and the bug was fixed in:
+ * This test can crash the buggy kernel, and the bug was fixed in:
  *
  *   commit e66f17ff71772b209eed39de35aaa99ba819c93d
  *   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
@@ -24,25 +25,25 @@
  *
  *   mm/hugetlb: take page table lock in follow_huge_pmd()
  *
- *  Test #2:
- *   #2.1:
- *   This is a regression test for the race condition, where move_pages()
- *   and soft offline are called on a single hugetlb page concurrently.
+ * *Test 2.1*
  *
- *   This bug can crash the buggy kernel, and was fixed by:
+ * This is a regression test for the race condition, where move_pages()
+ * and soft offline are called on a single hugetlb page concurrently.
+ *
+ * This test can crash the buggy kernel, and was fixed by:
  *
  *   commit c9d398fa237882ea07167e23bcfc5e6847066518
  *   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
  *   Date:   Fri Mar 31 15:11:55 2017 -0700
  *
- *   mm, hugetlb: use pte_present() instead of pmd_present() in
- *   follow_huge_pmd()
+ *   mm, hugetlb: use pte_present() instead of pmd_present() in follow_huge_pmd()
+ *
+ * *Test 2.2*
  *
- *   #2.2:
- *   This is also a regression test for an race condition causing SIGBUS
- *   in hugepage migration/fault.
+ * This is also a regression test for an race condition causing SIGBUS
+ * in hugepage migration/fault.
  *
- *   This bug was fixed by:
+ * This bug was fixed by:
  *
  *   commit 4643d67e8cb0b3536ef0ab5cddd1cedc73fa14ad
  *   Author: Mike Kravetz <mike.kravetz@oracle.com>
@@ -50,7 +51,17 @@
  *
  *   hugetlbfs: fix hugetlb page migration/fault race causing SIGBUS
  *
- */
+ * *Test 2.3*
+ *
+ * The madvise() in the do_soft_online() was also triggering cases where soft
+ * online returned EIO when page migration failed, which was fixed in:
+ *
+ *    commit 3f4b815a439adfb8f238335612c4b28bc10084d8
+ *    Author: Oscar Salvador <osalvador@suse.de>
+ *    Date:   Mon Dec 14 19:11:51 2020 -0800
+ *
+ *    mm,hwpoison: return -EBUSY when migration fails
+\*/
 
 #include <errno.h>
 #include <unistd.h>
@@ -334,6 +345,7 @@ static struct tst_test test = {
 		{"linux-git", "e66f17ff7177"},
 		{"linux-git", "c9d398fa2378"},
 		{"linux-git", "4643d67e8cb0"},
+		{"linux-git", "3f4b815a439a"},
 		{}
 	}
 };
-- 
2.26.2


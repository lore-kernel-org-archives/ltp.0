From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Aug 2019 20:42:05 +0800
Subject: [LTP] [COMMITTED] [PATCH] move_pages12: add comment for a new
 regression
Message-ID: <20190826124205.14943-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages12.c      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 5d7afad8e..c2927fb86 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -25,6 +25,7 @@
  *   mm/hugetlb: take page table lock in follow_huge_pmd()
  *
  *  Test #2:
+ *   #2.1:
  *   This is a regression test for the race condition, where move_pages()
  *   and soft offline are called on a single hugetlb page concurrently.
  *
@@ -36,6 +37,19 @@
  *
  *   mm, hugetlb: use pte_present() instead of pmd_present() in
  *   follow_huge_pmd()
+ *
+ *   #2.2:
+ *   This is also a regression test for an race condition causing SIGBUS
+ *   in hugepage migration/fault.
+ *
+ *   This bug was fixed by:
+ *
+ *   commit 4643d67e8cb0b3536ef0ab5cddd1cedc73fa14ad
+ *   Author: Mike Kravetz <mike.kravetz@oracle.com>
+ *   Date:   Tue Aug 13 15:38:00 2019 -0700
+ *
+ *   hugetlbfs: fix hugetlb page migration/fault race causing SIGBUS
+ *
  */
 
 #include <errno.h>
-- 
2.20.1


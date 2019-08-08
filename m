From: =?unknown-8bit?b?6KOY56iA55+z56iA55+z?= <xishi.qiuxishi@alibaba-inc.com>
Date: Thu, 08 Aug 2019 10:24:33 +0800
Subject: [LTP] 
 =?utf-8?q?=5BPATCH=5D_hugetlbfs=3A_fix_hugetlb_page_migrat?=
 =?utf-8?q?ion/fault_race_causing_SIGBUS?=
Message-ID: <f7a64f0a-1ae0-4582-a293-b608bc8fed36.xishi.qiuxishi@alibaba-inc.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mike,

Do you mean the similar race is like the following?

migration clearing the pte
  page fault(before we return error, and now we return 0, then try page fault again, right?)
    migration writing a migration entry

Thanks,
Xishi Qiu


Li Wang discovered that LTP/move_page12 V2 sometimes triggers SIGBUS
in the kernel-v5.2.3 testing.  This is caused by a race between hugetlb
page migration and page fault.

If a hugetlb page can not be allocated to satisfy a page fault, the task
is sent SIGBUS.  This is normal hugetlbfs behavior.  A hugetlb fault
mutex exists to prevent two tasks from trying to instantiate the same
page.  This protects against the situation where there is only one
hugetlb page, and both tasks would try to allocate.  Without the mutex,
one would fail and SIGBUS even though the other fault would be successful.

There is a similar race between hugetlb page migration and fault.
Migration code will allocate a page for the target of the migration.
It will then unmap the original page from all page tables.  It does
this unmap by first clearing the pte and then writing a migration
entry.  The page table lock is held for the duration of this clear and
write operation.  However, the beginnings of the hugetlb page fault
code optimistically checks the pte without taking the page table lock.
If clear (as it can be during the migration unmap operation), a hugetlb
page allocation is attempted to satisfy the fault.  Note that the page
which will eventually satisfy this fault was already allocated by the
migration code.  However, the allocation within the fault path could
fail which would result in the task incorrectly being sent SIGBUS.

Ideally, we could take the hugetlb fault mutex in the migration code
when modifying the page tables.  However, locks must be taken in the
order of hugetlb fault mutex, page lock, page table lock.  This would
require significant rework of the migration code.  Instead, the issue
is addressed in the hugetlb fault code.  After failing to allocate a
huge page, take the page table lock and check for huge_pte_none before
returning an error.  This is the same check that must be made further
in the code even if page allocation is successful.

Reported-by: Li Wang <liwang@redhat.com>
Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Tested-by: Li Wang <liwang@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ede7e7f5d1ab..6d7296dd11b8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3856,6 +3856,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,

   page = alloc_huge_page(vma, haddr, 0);
   if (IS_ERR(page)) {
+   /*
+    * Returning error will result in faulting task being
+    * sent SIGBUS.  The hugetlb fault mutex prevents two
+    * tasks from racing to fault in the same page which
+    * could result in false unable to allocate errors.
+    * Page migration does not take the fault mutex, but
+    * does a clear then write of pte's under page table
+    * lock.  Page fault code could race with migration,
+    * notice the clear pte and try to allocate a page
+    * here.  Before returning error, get ptl and make
+    * sure there really is no pte entry.
+    */
+   ptl = huge_pte_lock(h, mm, ptep);
+   if (!huge_pte_none(huge_ptep_get(ptep))) {
+    ret = 0;
+    spin_unlock(ptl);
+    goto out;
+   }
+   spin_unlock(ptl);
    ret = vmf_error(PTR_ERR(page));
    goto out;
   }
-- 
2.20.1

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190808/c1fb00e9/attachment-0001.htm>

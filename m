From: Steven Price <steven.price@arm.com>
Date: Thu, 31 Oct 2019 17:22:43 +0000
Subject: [LTP] [mm] 9343f6818b: BUG:kernel_NULL_pointer_dereference,
 address
In-Reply-To: <20191031151510.GA16405@xsang-OptiPlex-9020>
References: <20191028135910.33253-13-steven.price@arm.com>
 <20191031151510.GA16405@xsang-OptiPlex-9020>
Message-ID: <20191031172241.GA54073@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 31, 2019 at 03:15:10PM +0000, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 9343f6818bb98cf0c982bfff6ed89b2c7176bcf9 ("[PATCH v14 12/22] mm: pagewalk: Allow walking without vma")
> url: https://github.com/0day-ci/linux/commits/Steven-Price/Generic-page-walk-and-ptdump/20191030-085205
> 
[...]
> 
> [   36.010874] BUG: kernel NULL pointer dereference, address: 0000000000000053
> [   36.012644] #PF: supervisor read access in kernel mode
> [   36.014074] #PF: error_code(0x0000) - not-present page
> [   36.015481] PGD 0 P4D 0 
> [   36.016433] Oops: 0000 [#1] SMP PTI
> [   36.017561] CPU: 1 PID: 2376 Comm: mmap12 Not tainted 5.4.0-rc5-00046-g9343f6818bb98 #1
> [   36.019340] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   36.021250] RIP: 0010:pagemap_pmd_range+0x5ae/0x7b0

So it looks like this has broken /proc/<pid>/pagemap because we can now
call the callbacks with a NULL vma if the region passed into
walk_page_range is (partially) outside the VMA range.

Somehow, in this situation, there is a region which has a PMD entry but
no corresponding VMA. So the pmd_entry callback is called but with
walk->vma==NULL.

The options for fixing this seem to be:
 a) Make the pagemap callback robust against a PMD entry without a VMA.
    For example treating it as a hole (as it would have been before this
    patch):

---8<---
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9442631fd4af..b6d819c4bbb2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1369,6 +1369,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	pte_t *pte, *orig_pte;
 	int err = 0;
 
+	if (!vma)
+		return pagemap_pte_hole(addr, end, walk);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
---8<---

 b) Provide a flag (or another function) for walk_page_range() which
    restores the previous behaviour. Only those users that want to walk
    ranges without VMAs would then need to deal with NULL-vma returns.

---8<---
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 12004b097eae..519258e8fffa 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -61,6 +61,7 @@ struct mm_walk {
 	const struct mm_walk_ops *ops;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
+	bool ignore_vma;
 	void *private;
 };

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 4139e9163aee..f2fccbc3cba8 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -38,7 +38,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	do {
 again:
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(*pmd)) {
+		if (pmd_none(*pmd) || (!walk->vma && walk->ignore_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, walk);
 			if (err)
@@ -89,7 +89,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	do {
  again:
 		next = pud_addr_end(addr, end);
-		if (pud_none(*pud)) {
+		if (pud_none(*pud) || (!walk->vma && !walk->ignore_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, walk);
 			if (err)
---8<---

I'm currently inclined towards the latter because I don't want to have
to try to audit all existing users in case there's anything similar
lurking in another user of walk_page_range().

Steve

